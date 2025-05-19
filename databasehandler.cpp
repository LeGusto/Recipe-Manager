#include "databasehandler.h"
#include <QNetworkRequest>
#include <QJsonDocument>
#include <QJsonObject>

// ADD COOLDOWN FOR SUBMISSIOSN

DatabaseHandler::DatabaseHandler(QNetworkAccessManager *manager, QObject *parent)
    : QObject(parent), networkManager(manager) {}

// Puts data in the database with the given path
void DatabaseHandler::putData(const QString &path, const QVariantMap &data)
{
    QUrl url(baseUrl + "/" + path + ".json?auth=" + authToken);
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    QJsonDocument doc = QJsonDocument::fromVariant(data);
    QNetworkReply *reply = networkManager->put(request, doc.toJson());

    connect(reply, &QNetworkReply::finished, [=]() {
        if(reply->error() == QNetworkReply::NoError) {
            emit putDataSuccess("OK");
        } else {
            QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());
            QJsonObject errorObj = doc.object()["error"].toObject();
            QString errorMsg = errorObj["message"].toString();
            emit putDataFail(errorMsg);
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

            emit fetchRecipesSuccess("OK");
        } else {
            QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());
            QJsonObject errorObj = doc.object()["error"].toObject();
            QString errorMsg = errorObj["message"].toString();
            emit fetchRecipesFail(errorMsg);
        }
        reply->deleteLater();
    });
}

// Deletes the recipe from the database and the recipe list (TODO for the recipe list)
void DatabaseHandler::deleteRecipe(const QString &recipeName)
{
    QUrl url(baseUrl + "/Recipes/" + userId + "/" + recipeName + ".json?auth=" + authToken);
    QNetworkRequest request(url);

    for (int i = 0; i < m_recipes.size(); ++i) {
        if (m_recipes[i].toMap()["Name"].toString() == recipeName) {
            m_recipes.removeAt(i);
            break;
        }
    }

    QNetworkReply *reply = networkManager->deleteResource(request);

    connect(reply, &QNetworkReply::finished, [=]() {
        if(reply->error() == QNetworkReply::NoError) {
            emit deleteRecipeSuccess("OK");
        } else {
            QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());
            QJsonObject errorObj = doc.object()["error"].toObject();
            QString errorMsg = errorObj["message"].toString();
            emit deleteRecipeFail(errorMsg);
        }
        reply->deleteLater();
    });
}

// Adds recipe to the database and the recipes property of dbHandler
void DatabaseHandler::addRecipe(const QVariantMap &data)
{

    putData("Recipes/" + userId + "/" + data["Name"].toString(), data);
    m_recipes.append(data);

    emit addRecipeSuccess("OK");
}
