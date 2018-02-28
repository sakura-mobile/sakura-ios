#ifndef UUIDCREATOR_H
#define UUIDCREATOR_H

#include <QObject>

class UuidCreator : public QObject
{
    Q_OBJECT
public:
    explicit UuidCreator(QObject *parent = nullptr);
    Q_INVOKABLE QString createUuid();


};

#endif // UUIDCREATOR_H
