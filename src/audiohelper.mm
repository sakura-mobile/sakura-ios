#import <AVFoundation/AVFoundation.h>

#include <cstdlib>

#include "audiohelper.h"

AudioHelper::AudioHelper(QObject *parent) : QObject(parent)
{
    AVAudioSession *session = [AVAudioSession sharedInstance];

    if (@available(iOS 8, *)) {
        SilenceAudio = session.secondaryAudioShouldBeSilencedHint;
    } else {
        abort();
    }
}

AudioHelper &AudioHelper::GetInstance()
{
    static AudioHelper instance;

    return instance;
}

bool AudioHelper::silenceAudio() const
{
    return SilenceAudio;
}

void AudioHelper::refresh()
{
    AVAudioSession *session = [AVAudioSession sharedInstance];

    if (@available(iOS 8, *)) {
        bool silence_audio = session.secondaryAudioShouldBeSilencedHint;

        if (SilenceAudio != silence_audio) {
            SilenceAudio = silence_audio;

            emit silenceAudioChanged(SilenceAudio);
        }
    } else {
        abort();
    }
}
