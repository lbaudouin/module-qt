#ifndef LOADER_H
#define LOADER_H

#include <QObject>
#include <QJsonArray>

class Loader : public QObject
{
    Q_OBJECT
public:
    explicit Loader(QObject *parent = nullptr);

signals:

public slots:
    QJsonArray getPath();
};

#endif // LOADER_H
