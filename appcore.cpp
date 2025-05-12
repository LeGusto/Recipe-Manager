#include "appcore.h"

AppCore::AppCore(QObject *parent) : QObject(parent),
    networkManager(new QNetworkAccessManager(this)),
    m_authHandler(new AuthHandler(networkManager, this)),
    m_dbHandler(new DatabaseHandler(networkManager, this)),
    m_userSession(new UserSession(this))
{
    connect(m_authHandler, &AuthHandler::userSignedIn, this, [this](const QString& userId, const QString& email) {
        m_userSession->persistSession(userId, email, m_authHandler->getRefreshToken());
        m_dbHandler->setAuthToken(m_authHandler->getIdToken());
        m_dbHandler->setUserId(userId);
        emit authenticationChanged();
    });

    connect(m_authHandler, &AuthHandler::logoutCompleted, this, [this]() {
        m_userSession->clearSession();
        m_dbHandler->setAuthToken("");
        m_dbHandler->setUserId("");
        emit authenticationChanged();
    });

    connect(m_userSession, &UserSession::sessionAboutToExpire, this, [this]() {
        m_authHandler->refreshToken(m_userSession->refreshToken());
    });

    connect(m_userSession, &UserSession::sessionExpired, this, [this]() {
        emit authenticationChanged();
    });
}
