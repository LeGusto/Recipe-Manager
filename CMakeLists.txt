cmake_minimum_required(VERSION 3.16)

project(Recipe-Manager VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appRecipe-Manager
    main.cpp
)

qt_add_qml_module(appRecipe-Manager
    URI Recipe-Manager
    VERSION 1.0
    QML_FILES
        Main.qml
        QML_FILES Signup.qml
        QML_FILES Login.qml
        QML_FILES Start.qml
        QML_FILES Recipes.qml
        QML_FILES
        SOURCES
        SOURCES databasehandler.h databasehandler.cpp
        QML_FILES
        SOURCES authhandler.h authhandler.cpp
        SOURCES appcore.h appcore.cpp
        SOURCES usersession.h usersession.cpp
        QML_FILES StyledTextField.qml
        QML_FILES RecipeCreator.qml
        QML_FILES ViewRecipe.qml
        QML_FILES ButtonStyled1.qml
        QML_FILES Settings.qml
        RESOURCES
        RESOURCES
        SOURCES
        QML_FILES NavButton.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appRecipe-Manager PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appRecipe-Manager
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appRecipe-Manager
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appRecipe-Manager
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
