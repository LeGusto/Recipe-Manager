#include <QtQml/qqmlprivate.h>
#include <QtCore/qdir.h>
#include <QtCore/qurl.h>
#include <QtCore/qhash.h>
#include <QtCore/qstring.h>

namespace QmlCacheGeneratedCode {
namespace _qt_qml_Recipe_0x2d_Manager_Main_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_Recipe_0x2d_Manager_Signup_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_Recipe_0x2d_Manager_Login_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_Recipe_0x2d_Manager_Start_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_Recipe_0x2d_Manager_Recipes_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_Recipe_0x2d_Manager_StyledTextField_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_Recipe_0x2d_Manager_RecipeCreator_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_Recipe_0x2d_Manager_ViewRecipe_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_Recipe_0x2d_Manager_ButtonStyled1_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_Recipe_0x2d_Manager_Settings_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}
namespace _qt_qml_Recipe_0x2d_Manager_NavButton_qml { 
    extern const unsigned char qmlData[];
    extern const QQmlPrivate::AOTCompiledFunction aotBuiltFunctions[];
    const QQmlPrivate::CachedQmlUnit unit = {
        reinterpret_cast<const QV4::CompiledData::Unit*>(&qmlData), &aotBuiltFunctions[0], nullptr
    };
}

}
namespace {
struct Registry {
    Registry();
    ~Registry();
    QHash<QString, const QQmlPrivate::CachedQmlUnit*> resourcePathToCachedUnit;
    static const QQmlPrivate::CachedQmlUnit *lookupCachedUnit(const QUrl &url);
};

Q_GLOBAL_STATIC(Registry, unitRegistry)


Registry::Registry() {
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/Recipe-Manager/Main.qml"), &QmlCacheGeneratedCode::_qt_qml_Recipe_0x2d_Manager_Main_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/Recipe-Manager/Signup.qml"), &QmlCacheGeneratedCode::_qt_qml_Recipe_0x2d_Manager_Signup_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/Recipe-Manager/Login.qml"), &QmlCacheGeneratedCode::_qt_qml_Recipe_0x2d_Manager_Login_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/Recipe-Manager/Start.qml"), &QmlCacheGeneratedCode::_qt_qml_Recipe_0x2d_Manager_Start_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/Recipe-Manager/Recipes.qml"), &QmlCacheGeneratedCode::_qt_qml_Recipe_0x2d_Manager_Recipes_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/Recipe-Manager/StyledTextField.qml"), &QmlCacheGeneratedCode::_qt_qml_Recipe_0x2d_Manager_StyledTextField_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/Recipe-Manager/RecipeCreator.qml"), &QmlCacheGeneratedCode::_qt_qml_Recipe_0x2d_Manager_RecipeCreator_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/Recipe-Manager/ViewRecipe.qml"), &QmlCacheGeneratedCode::_qt_qml_Recipe_0x2d_Manager_ViewRecipe_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/Recipe-Manager/ButtonStyled1.qml"), &QmlCacheGeneratedCode::_qt_qml_Recipe_0x2d_Manager_ButtonStyled1_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/Recipe-Manager/Settings.qml"), &QmlCacheGeneratedCode::_qt_qml_Recipe_0x2d_Manager_Settings_qml::unit);
    resourcePathToCachedUnit.insert(QStringLiteral("/qt/qml/Recipe-Manager/NavButton.qml"), &QmlCacheGeneratedCode::_qt_qml_Recipe_0x2d_Manager_NavButton_qml::unit);
    QQmlPrivate::RegisterQmlUnitCacheHook registration;
    registration.structVersion = 0;
    registration.lookupCachedQmlUnit = &lookupCachedUnit;
    QQmlPrivate::qmlregister(QQmlPrivate::QmlUnitCacheHookRegistration, &registration);
}

Registry::~Registry() {
    QQmlPrivate::qmlunregister(QQmlPrivate::QmlUnitCacheHookRegistration, quintptr(&lookupCachedUnit));
}

const QQmlPrivate::CachedQmlUnit *Registry::lookupCachedUnit(const QUrl &url) {
    if (url.scheme() != QLatin1String("qrc"))
        return nullptr;
    QString resourcePath = QDir::cleanPath(url.path());
    if (resourcePath.isEmpty())
        return nullptr;
    if (!resourcePath.startsWith(QLatin1Char('/')))
        resourcePath.prepend(QLatin1Char('/'));
    return unitRegistry()->resourcePathToCachedUnit.value(resourcePath, nullptr);
}
}
int QT_MANGLE_NAMESPACE(qInitResources_qmlcache_appRecipe_Manager)() {
    ::unitRegistry();
    return 1;
}
Q_CONSTRUCTOR_FUNCTION(QT_MANGLE_NAMESPACE(qInitResources_qmlcache_appRecipe_Manager))
int QT_MANGLE_NAMESPACE(qCleanupResources_qmlcache_appRecipe_Manager)() {
    return 1;
}
