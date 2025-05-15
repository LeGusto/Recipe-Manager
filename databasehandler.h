#ifndef DATABASEHANDLER_H
#define DATABASEHANDLER_H

#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QObject>

class DatabaseHandler : public QObject
{
    Q_OBJECT
public:
    explicit DatabaseHandler(QNetworkAccessManager *manager, QObject *parent = nullptr);

    void setAuthToken(const QString &token) { authToken = token; }
    void setUserId(const QString ID) { userId = ID; }
    Q_INVOKABLE void putData(const QString &path, const QVariantMap &data);
    Q_INVOKABLE void fetchRecipes();
    Q_INVOKABLE void deleteRecipe(const QString &recipeName);
    Q_INVOKABLE void addRecipe(const QVariantMap &data);
    Q_PROPERTY(QVariantList recipes MEMBER m_recipes)

signals:
    void putDataSuccess(const QString &response);
    void putDataFail(const QString &error);
    void fetchRecipesSuccess(const QString &response);
    void fetchRecipesFail(const QString &error);
    void deleteRecipeSuccess(const QString &recipeName);
    void deleteRecipeFail(const QString &error);
    void addRecipeSuccess(const QString &recipeName);
    void addRecipeFail(const QString &error);

private:
    QNetworkAccessManager *networkManager = nullptr;
    QNetworkReply *networkReply = nullptr;
    QVariantList m_recipes;
    QString baseUrl = qEnvironmentVariable("FIREBASE_BASE_URL");
    QString authToken = "";
    QString userId = "";
};

#endif // DATABASEHANDLER_H
