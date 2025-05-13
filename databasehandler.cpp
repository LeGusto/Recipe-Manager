#include "databasehandler.h"
#include <QNetworkRequest>
#include <QJsonDocument>
#include <QJsonObject>

// ADD COOLDOWN FOR SUBMISSIOSN

DatabaseHandler::DatabaseHandler(QNetworkAccessManager *manager, QObject *parent)
    : QObject(parent), networkManager(manager) {}

void DatabaseHandler::putData(const QString &path, const QVariantMap &data)
{
    QUrl url(baseUrl + "/" + path + ".json?auth=" + authToken);
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    QJsonDocument doc = QJsonDocument::fromVariant(data);
    QNetworkReply *reply = networkManager->put(request, doc.toJson());

    connect(reply, &QNetworkReply::finished, [=]() {
        if(reply->error() == QNetworkReply::NoError) {
            emit uploadDone(reply->readAll());
        } else {
            QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());
            QJsonObject errorObj = doc.object()["error"].toObject();
            QString errorMsg = errorObj["message"].toString();
            emit uploadFail(errorMsg);
        }
        reply->deleteLater();
    });
}

void DatabaseHandler::fetchRecipes()
{
    QUrl url(baseUrl + "/Recipes/" + userId + ".json?auth=" + authToken);
    QNetworkRequest request(url);

    QNetworkReply *reply = networkManager->get(request);

    connect(reply, &QNetworkReply::finished, [=]() {
        if(reply->error() == QNetworkReply::NoError) {
            QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());
            QVariantMap data = doc.toVariant().toMap();

            m_recipes.clear();
            for (const auto &key : data.keys()) {
                QVariantMap recipe = data[key].toMap();
                recipe["id"] = key;
                m_recipes.append(recipe);
            }

            emit recipesFetched(m_recipes);
        } else {
            QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());
            QJsonObject errorObj = doc.object()["error"].toObject();
            QString errorMsg = errorObj["message"].toString();
            emit uploadFail(errorMsg);
        }
        reply->deleteLater();
    });
}

void DatabaseHandler::deleteRecipe(const QString &recipeName)
{
    QUrl url(baseUrl + "/Recipes/" + userId + "/" + recipeName + ".json?auth=" + authToken);
    QNetworkRequest request(url);

    QNetworkReply *reply = networkManager->deleteResource(request);

    connect(reply, &QNetworkReply::finished, [=]() {
        if(reply->error() == QNetworkReply::NoError) {
            emit recipeDeleted(recipeName);
        } else {
            QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());
            QJsonObject errorObj = doc.object()["error"].toObject();
            QString errorMsg = errorObj["message"].toString();
            emit uploadFail(errorMsg);
        }
        reply->deleteLater();
    });
}

void DatabaseHandler::addRecipe(const QVariantMap &data)
{
    putData("Recipes/" + userId + "/" + data["Name"].toString(), data);
    data["id"] = data["Name"].toString();
    m_recipes.append(data);
}
