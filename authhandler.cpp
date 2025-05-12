#include "authhandler.h"
#include <QJsonDocument>
#include <QJsonObject>
#include <QNetworkReply>

AuthHandler::AuthHandler(QNetworkAccessManager *manager, QObject *parent) : QObject(parent), networkManager(manager) {}

void AuthHandler::signUp(const QString &email, const QString &password) {
    QUrl url("https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=" + apiKey);
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    QJsonObject json;
    json["email"] = email;
    json["password"] = password;
    json["returnSecureToken"] = true;

    QNetworkReply *reply = networkManager->post(request, QJsonDocument(json).toJson());

    connect(reply, &QNetworkReply::finished, [=]() {
        if (reply->error() == QNetworkReply::NoError) {
            QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());
            idToken = doc.object()["idToken"].toString();
            m_refreshToken = doc.object()["refreshToken"].toString();
            QString userId = doc.object()["localId"].toString();

            emit signUpCompleted();
        } else {
            QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());
            QJsonObject errorObj = doc.object()["error"].toObject();
            QString errorMsg = errorObj["message"].toString();
            int errorCode = errorObj["code"].toInt();

            if (errorCode == 400) {
                if (errorMsg.contains("EMAIL_EXISTS")) {
                    emit signUpFailed("This email already has an account");
                } else {
                    emit signUpFailed("Unknown Error");
                }
            } else {
                emit signInFailed("Network Error");
            }
        }
        reply->deleteLater();
    });
}

void AuthHandler::signIn(const QString &email, const QString &password) {
    QUrl url("https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=" + apiKey);
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    QJsonObject json;
    json["email"] = email;
    json["password"] = password;
    json["returnSecureToken"] = true;

    QNetworkReply *reply = networkManager->post(request, QJsonDocument(json).toJson());

    connect(reply, &QNetworkReply::finished, [=]() {
        if (reply->error() == QNetworkReply::NoError) {
            QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());
            idToken = doc.object()["idToken"].toString();
            m_refreshToken = doc.object()["refreshToken"].toString();
            QString userId = doc.object()["localId"].toString();

            emit userSignedIn(userId, email);
        } else {
            QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());
            QJsonObject errorObj = doc.object()["error"].toObject();
            QString errorMsg = errorObj["message"].toString();
            int errorCode = errorObj["code"].toInt();

            if (errorCode == 400) {
                if (errorMsg.contains("INVALID_EMAIL") ||
                    errorMsg.contains("MISSING_PASSWORD") ||
                    errorMsg.contains("INVALID_LOGIN_CREDENTIALS")) {
                    emit signInFailed("Invalid email or password");
                } else {
                    emit signInFailed("Unknown Error");
                }
            } else {
                emit signInFailed("Network Error");
            }
        }
        reply->deleteLater();
    });
}

void AuthHandler::logout()
{
    idToken = "";
    m_refreshToken = "";

    emit logoutCompleted();
}

void AuthHandler::refreshToken(const QString& refreshToken) {
    QUrl url("https://securetoken.googleapis.com/v1/token?key=" + apiKey);
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    QJsonObject json;
    json["grant_type"] = "refresh_token";
    json["refresh_token"] = refreshToken;

    QNetworkReply* reply = networkManager->post(request, QJsonDocument(json).toJson());

    connect(reply, &QNetworkReply::finished, [=]() {
        if (reply->error() == QNetworkReply::NoError) {
            QJsonDocument doc = QJsonDocument::fromJson(reply->readAll());
            idToken = doc.object()["id_token"].toString();
            QString newRefreshToken = doc.object()["refresh_token"].toString();
            emit tokenRefreshed(idToken, newRefreshToken);
        } else {
            QString error = reply->errorString();
            qDebug() << "Refresh error:" << error << " Response:" << reply->readAll();
            emit errorOccurred("Token refresh failed");
        }
        reply->deleteLater();
    });
}
