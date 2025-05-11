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
    Q_INVOKABLE void fetchRecipes();
    Q_INVOKABLE void deleteRecipe(const QString &recipeName);

signals:
    void uploadDone(const QString &response);
    void uploadFail(const QString &error);
    void recipesFetched(const QVariantList &recipes);
    void recipeDeleted(const QString &recipeName);

private:
    QNetworkAccessManager *networkManager = nullptr;
    QNetworkReply *networkReply = nullptr;
    QString baseUrl = "";
};

#endif // DATABASEHANDLER_H
