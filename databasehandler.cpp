#include "databasehandler.h"
#include <QNetworkRequest>

databaseHandler::databaseHandler(QObject *parent)
    : QObject(parent)
{
    networkManager = new QNetworkAccessManager(this);

    networkReply = networkManager->get(QNetworkRequest(QUrl("")));
    connect(networkReply, &QNetworkReply::readyRead, this, &databaseHandler::networkReplyReadyRead);
}

void databaseHandler::networkReplyReadyRead()
{
    qDebug() << networkReply->readAll();
}
