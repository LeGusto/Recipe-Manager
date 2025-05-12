#ifndef AUTHHANDLER_H
#define AUTHHANDLER_H

#include <QObject>
#include <QNetworkAccessManager>

class AuthHandler : public QObject {
    Q_OBJECT
public:
    explicit AuthHandler(QNetworkAccessManager *manager, QObject *parent = nullptr);
    Q_INVOKABLE void signUp(const QString &email, const QString &password);
    Q_INVOKABLE void signIn(const QString &email, const QString &password);
    Q_INVOKABLE void logout();
    Q_INVOKABLE void refreshToken(const QString& refreshToken);
    Q_INVOKABLE QString getIdToken() const { return idToken; }
    Q_INVOKABLE QString getRefreshToken() const { return m_refreshToken; }


signals:
    void userSignedIn(const QString &userId, const QString &email);
    void signInFailed(const QString &error);
    void signUpCompleted();
    void signUpFailed(const QString &error);
    void errorOccurred(const QString &error);
    void tokenRefreshed(const QString &idToken, const QString &refreshToken);
    void logoutCompleted();
    void logoutFailed(const QString& error);

private:
    QNetworkAccessManager *networkManager;
    QString apiKey = qEnvironmentVariable("FIREBASE_API_KEY");
    QString idToken = "";
    QString m_refreshToken = "";
};

#endif // AUTHHANDLER_H
