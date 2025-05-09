#ifndef DATABASEHANDLER_H
#define DATABASEHANDLER_H

#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QObject>

class databaseHandler : public QObject
{
    Q_OBJECT
public:
    explicit databaseHandler(QObject *parent = nullptr);

public slots:
    void networkReplyReadyRead();

signals:


private:
    QNetworkAccessManager *networkManager = nullptr;
    QNetworkReply *networkReply = nullptr;
};

#endif // DATABASEHANDLER_H
