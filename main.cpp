#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickItem>
#include <diarylistmodel.h>
#include <metricListModel.h>
#include <databasechanger.h>
#include <QVector>
#include <QtCharts>

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    DataBaseChanger* myDataBaseChanger = new DataBaseChanger();

    diaryListModel* myModel = new diaryListModel();
    MetricListModel* myMetricModel = new MetricListModel();
    QQmlContext* rootQmlContext = engine.rootContext();

    rootQmlContext->setContextProperty("dataChanger", myDataBaseChanger);
    rootQmlContext->setContextProperty("myModel", myModel);
    rootQmlContext->setContextProperty("myMetricModel", myMetricModel);

    engine.load(url);

    return app.exec();
}
