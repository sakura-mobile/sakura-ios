#import <AVFoundation/AVFoundation.h>

#include "audiohelper.h"

AudioHelper::AudioHelper(QObject *parent) : QObject(parent)
{
    AVAudioSession *session = [AVAudioSession sharedInstance];

    SilenceAudio = session.secondaryAudioShouldBeSilencedHint;
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

    bool silence_audio = session.secondaryAudioShouldBeSilencedHint;

    if (SilenceAudio != silence_audio) {
        SilenceAudio = silence_audio;

        emit silenceAudioChanged(SilenceAudio);
    }
}
