#ifndef APPCORE_H
#define APPCORE_H

#include <QObject>
#include <QNetworkAccessManager>
#include "authhandler.h"
#include "databasehandler.h"
#include "usersession.h"

class AppCore : public QObject {
    Q_OBJECT
    Q_PROPERTY(DatabaseHandler* dbHandler MEMBER m_dbHandler CONSTANT)
    Q_PROPERTY(AuthHandler* authHandler MEMBER m_authHandler CONSTANT)
    Q_PROPERTY(UserSession* userSession MEMBER m_userSession CONSTANT)

private:

signals:
    void authenticationChanged();

public:
    explicit AppCore(QObject *parent = nullptr);

private:
    QNetworkAccessManager *networkManager;
    AuthHandler *m_authHandler;
    DatabaseHandler *m_dbHandler;
    UserSession *m_userSession;
};

#endif // APPCORE_H
