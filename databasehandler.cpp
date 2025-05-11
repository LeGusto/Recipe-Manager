#include "databasehandler.h"
#include <QNetworkRequest>
#include <QJsonDocument>
#include <QJsonObject>

DatabaseHandler::DatabaseHandler(QObject *parent)
    : QObject(parent)
{
    networkManager = new QNetworkAccessManager(this);
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

void DatabaseHandler::fetchRecipes()
{
QUrl url(baseUrl + "/Recipes.json");
    QNetworkRequest request(url);

    QNetworkReply *reply = networkManager->get(request);

    connect(reply, &QNetworkReply::finished, [=]() {
        if(reply->error() == QNetworkReply::NoError) {
            QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());
            QVariantMap data = doc.toVariant().toMap();

            QVariantList recipes;
            for (const auto &key : data.keys()) {
                QVariantMap recipe = data[key].toMap();
                recipe["id"] = key;
                recipes.append(recipe);
            }

            emit recipesFetched(recipes);
        } else {
            emit uploadFail(reply->errorString());
        }
        reply->deleteLater();
    });
}

void DatabaseHandler::deleteRecipe(const QString &recipeName)
{
    QUrl url(baseUrl + "/Recipes/" + recipeName + ".json");
    QNetworkRequest request(url);

    QNetworkReply *reply = networkManager->deleteResource(request);

    connect(reply, &QNetworkReply::finished, [=]() {
        if(reply->error() == QNetworkReply::NoError) {
            emit recipeDeleted(recipeName);
        } else {
            emit uploadFail("Delete failed: " + reply->errorString());
        }
        reply->deleteLater();
    });
}
