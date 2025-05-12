#ifndef USERSESSION_H
#define USERSESSION_H

#include <QObject>
#include <QSettings>
#include <QTimer>

class UserSession : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isLoggedIn READ isLoggedIn NOTIFY sessionChanged)
    Q_PROPERTY(QString userId READ userId NOTIFY sessionChanged)
    Q_PROPERTY(QString userEmail READ userEmail NOTIFY sessionChanged)

public:
    explicit UserSession(QObject *parent = nullptr);

    Q_INVOKABLE void persistSession(const QString &userId, const QString &email, const QString &refreshToken);
    Q_INVOKABLE void clearSession();
    Q_INVOKABLE bool hasActiveSession() const;

    QString userId() const;
    QString userEmail() const;
    QString refreshToken() const;
    bool isLoggedIn() const;

    Q_INVOKABLE void startSessionTimer();
    Q_INVOKABLE void stopSessionTimer();

signals:
    void sessionChanged();
    void sessionAboutToExpire();
    void sessionExpired();

private slots:
    void handleSessionTimeout();

private:
    QSettings m_settings;
    QTimer m_sessionTimer;
    static const int SESSION_TIMEOUT_MS = 3540000;
    static const int WARNING_TIMEOUT_MS = 3300000;
};

#endif // USERSESSION_H
