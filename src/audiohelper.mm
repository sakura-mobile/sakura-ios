#import <AVFoundation/AVFoundation.h>

#include "audiohelper.h"

AudioHelper::AudioHelper(QObject *parent) : QObject(parent)
{
    AVAudioSession *session = [AVAudioSession sharedInstance];

    SilenceAudio = session.secondaryAudioShouldBeSilencedHint;
}

AudioHelper::~AudioHelper()
{
}

bool AudioHelper::silenceAudio() const
{
    return SilenceAudio;
}

void AudioHelper::refresh()
{
    AVAudioSession *session = [AVAudioSession sharedInstance];

    SilenceAudio = session.secondaryAudioShouldBeSilencedHint;

    emit silenceAudioChanged(SilenceAudio);
}
