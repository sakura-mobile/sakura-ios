#ifndef AUDIOHELPER_H
#define AUDIOHELPER_H

#include <QtCore/QObject>

class AudioHelper : public QObject
{
    Q_OBJECT

    Q_PROPERTY(bool silenceAudio READ silenceAudio NOTIFY silenceAudioChanged)

public:
    explicit AudioHelper(QObject *parent = nullptr);
    virtual ~AudioHelper();

    bool silenceAudio() const;

    Q_INVOKABLE void refresh();

signals:
    void silenceAudioChanged(bool silenceAudio);

private:
    bool SilenceAudio;
};

#endif // AUDIOHELPER_H
