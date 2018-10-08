#!/usr/bin/tclsh

set DEBUG_MODE 0
set DATA_DIR   ""
set AUTH_KEY   ""
set TOP_SIZE   25

if {[catch {
    lappend auto_path /home/project-web/sakuramobile/lib/tcllib1.18

    package require Tcl
    package require ncgi
    package require base64
    package require json::write

    proc base64_encode_safe {string} {
        return [string map {"/" "-" "+" "_"} [::base64::encode -maxlen 0 [encoding convertto utf-8 $string]]]
    }

    proc base64_decode_safe {string} {
        return [encoding convertfrom utf-8 [::base64::decode [string map {"-" "/" "_" "+"} $string]]]
    }

    proc return_error {error_text} {
        ::ncgi::header "application/json"

        puts [::json::write object "result" [::json::write string "error"] \
                                   "error"  [::json::write string $error_text]]
    }

    proc return_rating_set {updated {place 0}} {
        ::ncgi::header "application/json"

        set args [list "result" [::json::write string "success"] "updated" [::json::write string $updated]]

        if {$place > 0} {
            lappend args "place" [::json::write string $place]
        }

        puts [eval ::json::write object $args]
    }

    proc return_rating_get_yesterday {user_ratings} {
        ::ncgi::header "application/json"

        set args {}

        foreach rating $user_ratings {
            lappend args [::json::write object "rating_type" [::json::write string [lindex $rating 0]] "place" [::json::write string [lindex $rating 1]]]
        }

        puts [::json::write object "result" [::json::write string "success"] "ratings" [eval ::json::write array $args]]
    }

    proc return_rating_get_top_today {rating_top_today} {
        ::ncgi::header "application/json"

        set args {}

        foreach item $rating_top_today {
            lappend args [::json::write object "user_id" [::json::write string [lindex $item 0]] "user_name" [::json::write string [lindex $item 1]] "score" [::json::write string [lindex $item 2]]]
        }

        puts [::json::write object "result" [::json::write string "success"] "top" [eval ::json::write array $args]]
    }

    proc rating_read {date rating_type user_id ret_user_name ret_score} {
        global DATA_DIR

        upvar $ret_user_name loc_user_name
        upvar $ret_score     loc_score

        set dir "$DATA_DIR/ratings/$date/[base64_encode_safe $rating_type]"
        set pfx [base64_encode_safe $user_id]

        set versions_list [glob -directory $dir -nocomplain -tails -types f -- "$pfx.*.dat"]

        if {[llength $versions_list] > 0} {
            set latest_version [lindex [lsort -dictionary -decreasing $versions_list] 0]

            if {![catch {
                set         fd [open "$dir/$latest_version" "r"]
                fconfigure $fd -encoding utf-8

                set data [read -nonewline $fd]

                close $fd

                array set data_arr $data

                set loc_user_name $data_arr(user_name)
                set loc_score     $data_arr(score)
            }]} {
                return 1
            } else {
                catch {close $fd}

                return 0
            }
        } else {
            return 0
        }
    }

    proc rating_write {date rating_type user_id user_name score} {
        global DATA_DIR

        set dir "$DATA_DIR/ratings/$date/[base64_encode_safe $rating_type]"
        set pfx [base64_encode_safe $user_id]

        set versions_list [glob -directory $dir -nocomplain -tails -types f -- "$pfx.*.dat"]

        if {[llength $versions_list] > 0} {
            set latest_version [lindex [lsort -dictionary -decreasing $versions_list] 0]

            if {[regexp {\.(\d+)\.dat$} $latest_version dummy version_num]} {
                set version_num [expr $version_num + 1]
            } else {
                set version_num 1
            }
        } else {
            set version_num 1
        }

        if {![catch {
            file mkdir $dir

            set         fd [open "$dir/$pfx.$version_num.tmp" "w"]
            fconfigure $fd -encoding utf-8

            puts -nonewline $fd [list "user_name" $user_name "score" $score]

            close $fd

            file rename -- "$dir/$pfx.$version_num.tmp" "$dir/$pfx.$version_num.dat"

            foreach version $versions_list {
                file delete -- "$dir/$version"
            }
        }]} {
            return 1
        } else {
            catch {close $fd}

            return 0
        }
    }

    proc rating_get_top {date rating_type ret_top} {
        global DATA_DIR TOP_SIZE

        upvar $ret_top loc_top

        set dir "$DATA_DIR/ratings/$date/[base64_encode_safe $rating_type]"

        set files_list [glob -directory $dir -nocomplain -tails -types f -- "*.dat"]

        if {[llength $files_list] > 0} {
            set ratings_list {}

            foreach file $files_list {
                if {[catch {
                    set         fd [open "$dir/$file" "r"]
                    fconfigure $fd -encoding utf-8

                    set data [read -nonewline $fd]

                    close $fd

                    if {[regexp {^([^\.]+)\.(\d+)\.dat$} $file dummy user_id_base64 version_num]} {
                        array set data_arr $data

                        catch {
                            lappend ratings_list [list $user_id_base64 $version_num $data_arr(user_name) $data_arr(score)]
                        }

                        array unset data_arr
                    }
                } Err]} {
                    catch {close $fd}
                }
            }

            set ratings_list [lsort -integer -decreasing -index 1 $ratings_list]

            set ratings_list_tmp {}

            foreach item $ratings_list {
                if {[lsearch -exact -index 0 $ratings_list_tmp [lindex $item 0]] == -1} {
                    lappend ratings_list_tmp $item
                }
            }

            set ratings_list $ratings_list_tmp

            set ratings_list [lsort -integer -decreasing -index 3 $ratings_list]

            for {set i [expr $TOP_SIZE * 2]} {$i < [llength $ratings_list]} {incr i} {
                set item [lindex $ratings_list $i]

                catch {
                    file delete -- "$dir/[lindex $item 0].[lindex $item 1].dat"
                }
            }

            set loc_top {}

            for {set i 0} {$i < $TOP_SIZE && $i < [llength $ratings_list]} {incr i} {
                set item [lindex $ratings_list $i]

                lappend loc_top [list "user_id"   [base64_decode_safe [lindex $item 0]] \
                                      "user_name"                     [lindex $item 2] \
                                      "score"                         [lindex $item 3]]
            }

            return 1
        } else {
            return 0
        }
    }

    proc rating_get_types {date} {
        global DATA_DIR

        set dir "$DATA_DIR/ratings/$date"

        set rating_types {}

        foreach rating_type [glob -directory $dir -nocomplain -tails -types d -- "*"] {
            lappend rating_types [base64_decode_safe $rating_type]
        }

        return $rating_types
    }

    proc rating_clean {dates_to_retain} {
        global DATA_DIR

        set dir "$DATA_DIR/ratings"

        set dates_list [glob -directory $dir -nocomplain -tails -types d -- "*"]

        foreach date $dates_list {
            if {[lsearch -exact $dates_to_retain $date] == -1} {
                catch {
                    file delete -force -- "$dir/$date"
                }
            }
        }
    }

    ::ncgi::parse

    fconfigure stdout -encoding utf-8

    if {[string equal [::ncgi::value "key"] $AUTH_KEY]} {
        set today_date     [clock format       [clock seconds]          -timezone ":UTC" -format "%d.%m.%Y"]
        set yesterday_date [clock format [expr [clock seconds] - 86400] -timezone ":UTC" -format "%d.%m.%Y"]

        rating_clean [list $today_date $yesterday_date]

        if {[string equal [::ncgi::value "action"] "rating_set"]} {
            set req_user_id     [::ncgi::value "user_id"]
            set req_user_name   [::ncgi::value "user_name"]
            set req_rating_type [::ncgi::value "rating_type"]
            set req_score       [::ncgi::value "score"]

            if {![string equal $req_user_id     ""] && ![string equal              $req_user_name ""] &&
                ![string equal $req_rating_type ""] &&  [string is integer -strict $req_score]} {
                if {![rating_read $today_date $req_rating_type $req_user_id db_user_name db_score]} {
                    set db_score 0
                }

                if {$req_score > $db_score} {
                    if {[rating_write $today_date $req_rating_type $req_user_id $req_user_name $req_score]} {
                        set rating_top {}

                        if {[rating_get_top $today_date $req_rating_type rating_top]} {
                            set place 0

                            for {set i 0} {$i < [llength $rating_top]} {incr i} {
                                array set item_arr [lindex $rating_top $i]

                                if {[catch {set db_user_id $item_arr(user_id)}]} {
                                    set db_user_id ""
                                }

                                array unset item_arr

                                if {[string equal $req_user_id $db_user_id]} {
                                    set place [expr $i + 1]

                                    break
                                }
                            }

                            if {$place > 0} {
                                return_rating_set "true" $place
                            } else {
                                return_rating_set "false"
                            }
                        } else {
                            return_rating_set "false"
                        }
                    } else {
                        return_error "error writing rating"
                    }
                } else {
                    return_rating_set "false"
                }
            } else {
                return_error "invalid request parameters"
            }
        } elseif {[string equal [::ncgi::value "action"] "rating_get_yesterday"]} {
            set req_user_id [::ncgi::value "user_id"]

            if {![string equal $req_user_id ""]} {
                set user_ratings {}

                foreach db_rating_type [rating_get_types $yesterday_date] {
                    set rating_top {}

                    if {[rating_get_top $yesterday_date $db_rating_type rating_top]} {
                        set place 0

                        for {set i 0} {$i < [llength $rating_top]} {incr i} {
                            array set item_arr [lindex $rating_top $i]

                            if {[catch {set db_user_id $item_arr(user_id)}]} {
                                set db_user_id ""
                            }

                            array unset item_arr

                            if {[string equal $req_user_id $db_user_id]} {
                                set place [expr $i + 1]

                                break
                            }
                        }

                        if {$place > 0} {
                            lappend user_ratings [list $db_rating_type $place]
                        }
                    }
                }

                return_rating_get_yesterday $user_ratings
            } else {
                return_error "invalid request parameters"
            }
        } elseif {[string equal [::ncgi::value "action"] "rating_get_top_today"]} {
            set req_rating_type [::ncgi::value "rating_type"]

            if {![string equal $req_rating_type ""]} {
                set rating_top {}

                rating_get_top $today_date $req_rating_type rating_top

                set rating_top_today {}

                foreach item $rating_top {
                    array set item_arr $item

                    catch {
                        set db_user_id   $item_arr(user_id)
                        set db_user_name $item_arr(user_name)
                        set db_score     $item_arr(score)

                        lappend rating_top_today [list $db_user_id $db_user_name $db_score]
                    }

                    array unset item_arr
                }

                return_rating_get_top_today $rating_top_today
            } else {
                return_error "invalid request parameters"
            }
        } else {
            return_error "invalid action"
        }
    } else {
        return_error "authentication failed"
    }
} Err]} {
    if {$DEBUG_MODE} {
        puts "Content-type: text/plain"; puts ""
        puts $Err
    } else {
        set    fd [open "$DATA_DIR/error_log" "w"]
        puts  $fd $Err
        close $fd
    }
}
