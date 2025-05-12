#include "usersession.h"
#include <QDebug>

UserSession::UserSession(QObject *parent)
    : QObject(parent),
    m_settings("YourCompany", "RecipeManager"),
    m_sessionTimer(this)
{
    m_sessionTimer.setSingleShot(true);
    connect(&m_sessionTimer, &QTimer::timeout, this, &UserSession::handleSessionTimeout);
}

void UserSession::persistSession(const QString &userId, const QString &email, const QString &refreshToken)
{
    m_settings.setValue("session/userId", userId);
    m_settings.setValue("session/email", email);
    m_settings.setValue("session/refreshToken", refreshToken);
    m_settings.sync();

    startSessionTimer();
    emit sessionChanged();
}

void UserSession::clearSession()
{
    m_settings.remove("session");
    stopSessionTimer();
    emit sessionChanged();
}

bool UserSession::hasActiveSession() const
{
    return !m_settings.value("session/userId").toString().isEmpty();
}

QString UserSession::userId() const
{
    return m_settings.value("session/userId").toString();
}

QString UserSession::userEmail() const
{
    return m_settings.value("session/email").toString();
}

QString UserSession::refreshToken() const
{
    return m_settings.value("session/refreshToken").toString();
}

bool UserSession::isLoggedIn() const
{
    return hasActiveSession();
}

void UserSession::startSessionTimer()
{
    m_sessionTimer.start(SESSION_TIMEOUT_MS);

    QTimer::singleShot(WARNING_TIMEOUT_MS, this, [this]() {
        emit sessionAboutToExpire();
    });
}

void UserSession::stopSessionTimer()
{
    m_sessionTimer.stop();
}

void UserSession::handleSessionTimeout()
{
    qDebug() << "Session expired";
    clearSession();
    emit sessionExpired();
}
