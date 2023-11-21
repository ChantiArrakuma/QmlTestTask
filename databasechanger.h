#ifndef DATABASECHANGER_H
#define DATABASECHANGER_H

#include <QObject>
#include <QtSql>
#include <QVector>
#include <QtCharts>

class DataBaseChanger : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString m READ m WRITE setM)
public:
    explicit DataBaseChanger(QObject *parent = nullptr);
    QString m() {
        return _m;
    };

    Q_INVOKABLE void inDB(const QString &tableName,
                          const QStringList &columnNames,
                          const QStringList &columnValues);
    Q_INVOKABLE void delALL(const QString &tableName);
    Q_INVOKABLE void delVal(const QString &tableName,
                            const QStringList &tableKeys,
                            const QStringList &tableKeysValue);
    Q_INVOKABLE void changeValueInTable(const QString &tableName,
                                         const QStringList &tableColumns,
                                         const QStringList &tableNewValues,
                                         const QStringList &tableKeys,
                                         const QStringList &tableKeyValues);
    Q_INVOKABLE QVector<QVector<QString>> allTableValuesInVector(const QString &tableName);\
    Q_INVOKABLE QStringList tableValues(const QString &tableName,
                                             const QStringList &tableColumns,
                                             const QStringList &tableKeys,
                                             const QStringList &tableKeysValue);

    void dropAnyTable(const QString &tableName);

public slots:
    void setM(const QString& s) {
        _m = s;
    };

    int rowCount(){
            QSqlQuery query;
            int n = 1;
            query.exec("SELECT ID, diary FROM Diary");
            while(query.next()){
                n++;
            }
            return n-1;
    }

private:
    QString _m;
    QStringListModel a;

signals:

};

#endif // DATABASECHANGER_H
