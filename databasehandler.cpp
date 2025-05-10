#include "databasehandler.h"
#include <QNetworkRequest>
#include <QJsonDocument>
#include <QJsonObject>

DatabaseHandler::DatabaseHandler(QObject *parent)
    : QObject(parent)
{
    networkManager = new QNetworkAccessManager(this);

    networkReply = networkManager->get(QNetworkRequest(QUrl(baseUrl + "/Recipes.json")));
    connect(networkReply, &QNetworkReply::readyRead, this, &DatabaseHandler::networkReplyReadyRead);
}

void DatabaseHandler::putData(const QString &path, const QVariantMap &data)
{
    QUrl url(baseUrl + "/" + path + ".json");
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    QJsonDocument doc = QJsonDocument::fromVariant(data);
    QNetworkReply *reply = networkManager->put(request, doc.toJson());

    connect(reply, &QNetworkReply::finished, [=]() {
        if(reply->error() == QNetworkReply::NoError) {
            emit uploadDone(reply->readAll());
        } else {
            emit uploadFail(reply->errorString());
        }
        reply->deleteLater();
    });
}

void DatabaseHandler::networkReplyReadyRead()
{
    qDebug() << networkReply->readAll();
}
