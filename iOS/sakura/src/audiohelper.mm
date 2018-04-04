#import <AVFoundation/AVFoundation.h>

#include "audiohelper.h"

AudioHelper::AudioHelper(QObject *parent) : QObject(parent)
{
    Initialized  = false;
    SilenceAudio = true;
}

AudioHelper::~AudioHelper()
{
}

bool AudioHelper::silenceAudio() const
{
    return SilenceAudio;
}

void AudioHelper::initialize()
{
    if (!Initialized) {
        AVAudioSession *session = [AVAudioSession sharedInstance];

        SilenceAudio = session.secondaryAudioShouldBeSilencedHint;

        emit silenceAudioChanged(SilenceAudio);

        Initialized = true;
    }
}

void AudioHelper::refresh()
{
    if (Initialized) {
        AVAudioSession *session = [AVAudioSession sharedInstance];

        SilenceAudio = session.secondaryAudioShouldBeSilencedHint;

        emit silenceAudioChanged(SilenceAudio);
    }
}
