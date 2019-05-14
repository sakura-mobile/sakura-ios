#import <AVFoundation/AVFoundation.h>

#include "audiohelper.h"

AudioHelper::AudioHelper(QObject *parent) : QObject(parent)
{
    AVAudioSession *session = [AVAudioSession sharedInstance];

    if (@available(iOS 8, *)) {
        SilenceAudio = session.secondaryAudioShouldBeSilencedHint;
    } else {
        assert(0);
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
        SilenceAudio = session.secondaryAudioShouldBeSilencedHint;
    } else {
        assert(0);
    }

    emit silenceAudioChanged(SilenceAudio);
}
