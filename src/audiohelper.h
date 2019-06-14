#ifndef AUDIOHELPER_H
#define AUDIOHELPER_H

#include <QtCore/QObject>

class AudioHelper : public QObject
{
    Q_OBJECT

    Q_PROPERTY(bool silenceAudio READ silenceAudio NOTIFY silenceAudioChanged)

private:
    explicit AudioHelper(QObject *parent = nullptr);
    ~AudioHelper() noexcept override = default;

public:
    AudioHelper(const AudioHelper &) = delete;
    AudioHelper(AudioHelper &&) noexcept = delete;

    AudioHelper &operator=(const AudioHelper &) = delete;
    AudioHelper &operator=(AudioHelper &&) noexcept = delete;

    static AudioHelper &GetInstance();

    bool silenceAudio() const;

    Q_INVOKABLE void refresh();

signals:
    void silenceAudioChanged(bool silenceAudio);

private:
    bool SilenceAudio;
};

#endif // AUDIOHELPER_H
