#ifndef DATABASEHANDLER_H
#define DATABASEHANDLER_H

#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QObject>

class DatabaseHandler : public QObject
{
    Q_OBJECT
public:
    explicit DatabaseHandler(QObject *parent = nullptr);

    Q_INVOKABLE void putData(const QString &path, const QVariantMap &data);


public slots:
    void networkReplyReadyRead();

signals:
    void uploadDone(const QString &response);
    void uploadFail(const QString &error);

private:
    QNetworkAccessManager *networkManager = nullptr;
    QNetworkReply *networkReply = nullptr;
    QString baseUrl = "";
};

#endif // DATABASEHANDLER_H
