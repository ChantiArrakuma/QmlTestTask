#include "databasechanger.h"

DataBaseChanger::DataBaseChanger(QObject *parent)
    : QObject{parent}
{
    QDir::currentPath();
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");

    db.setDatabaseName("./db2.sqlite");

    bool ok = db.open();
    if(!ok){
        return;
    }
    else
    {
        QSqlQuery query;

        query.exec("CREATE TABLE Diary ("
                   " ID INTEGER PRIMARY KEY,"
                   " diary varchar(3000),"
                   " year INTEGER,"
                   " month INTEGER,"
                   " day INTEGER"
                   ")");

        query.exec("CREATE TABLE Dates ("
                   " year INTEGER,"
                   " month INTEGER,"
                   " day INTEGER,"
                   " PRIMARY KEY (year, month, day)"
                   ")");

        query.exec("CREATE TABLE Metric ("
                   " name varchar(3000),"
                   " svgSource varchar(3000),"
                   " color varchar(3000),"
                   " PRIMARY KEY (name)"
                   ")");

        query.exec("CREATE TABLE MetricValues ("
                   " name varchar(3000),"
                   " value INTEGER,"
                   " year INTEGER,"
                   " month INTEGER,"
                   " day INTEGER,"
                   " hour INTEGER ,"
                   " minute INTEGER, "
                   " PRIMARY KEY (name, year, month, day, hour, minute))");

        QStringList columnName = {"name", "svgSource", "color"};
        QStringList columnValues;
        columnValues = QStringList{"'smileFace'","'./svg/smile.svg'", "'#05A5F0'"};
        this->inDB("Metric", columnName, columnValues);
        columnValues = QStringList{"'brainActivity'","'./svg/brainActivity.svg'","'#05EFF0'"};
        this->inDB("Metric", columnName, columnValues);
        columnValues = QStringList{"'health'","'./svg/health.svg'","'#0511F0'"};
        this->inDB("Metric", columnName, columnValues);
    }
}

void DataBaseChanger::inDB(const QString &tableName,
                           const QStringList &columnNames,
                           const QStringList &columnValues) {

    if(columnNames.length() != columnValues.length()) {
        return ;
    }

    QSqlQuery query;
    QString request;

    request = "INSERT INTO %1 (%2) VALUES (%3)";
    request = request.arg(tableName, columnNames.join(", "), columnValues.join(", "));

    query.exec(request);
}

void DataBaseChanger::delALL(const QString &tableName){
    QSqlQuery query;
    query.exec("DELETE * FROM " + tableName);
}

void DataBaseChanger::delVal(const QString &tableName,
                             const QStringList &tableKeys,
                             const QStringList &tableKeysValue){
    if(tableKeys.length() != tableKeysValue.length())
        return;
    int len = tableKeys.length();
    QSqlQuery query;
    QString request = "DELETE FROM " + tableName + " WHERE ";
    for(int i = 0; i != len - 1; i++){
        request += tableKeys[i] + "=" + tableKeysValue[i] + " AND ";
    }
    request += tableKeys[len - 1] + "=" + tableKeysValue[len - 1];
    query.exec(request);
}

void DataBaseChanger::changeValueInTable(const QString &tableName,
                                          const QStringList &tableColumns,
                                          const QStringList &tableNewValues,
                                          const QStringList &tableKeys,
                                          const QStringList &tableKeyValues) {
    if(tableColumns.length() != tableNewValues.length() || tableKeys.length() != tableKeyValues.length())
        return;

    QSqlQuery query;
    QString request = "UPDATE %1 SET %2 WHERE %3";
    QStringList values;
    QStringList keys;

    for(int i = 0; i != tableColumns.length(); i++){
        values.push_back(tableColumns[i]+ "=" + tableNewValues[i]);
    }
    for(int i = 0; i != tableKeys.length(); i++){
        keys.push_back(tableKeys[i]+ "=" + tableKeyValues[i]);
    }

    request = request.arg(tableName);
    request = request.arg(values.join(", "));
    request = request.arg(keys.join(", "));

    query.exec(request);
}

void DataBaseChanger::dropAnyTable(const QString &tableName){
    QSqlQuery query;
    query.exec("DROP TABLE " + tableName);
}

QVector<QVector<QString>> DataBaseChanger::allTableValuesInVector(const QString &tableName){
    QSqlQuery query;
    QVector<QString> ret;
    QVector<QVector<QString>> result;

    ret.clear();
    result.clear();
    query.exec("SELECT * FROM " + tableName);

    while(query.next()){
        for(int i = 0; query.value(i).toString() != ""; i++){
            ret.append(query.value(i).toString());
        }
        result.append(ret);
        ret.clear();
    }
    return result;
}

QStringList DataBaseChanger::tableValues(const QString &tableName,
                                              const QStringList &tableColumns,
                                              const QStringList &tableKeys,
                                              const QStringList &tableKeysValue){
    if(tableColumns.length() != tableColumns.length() || tableKeys.length() != tableKeysValue.length())
        return {};

    QSqlQuery query;
    QStringList ret;
    QString request;

    request = "SELECT %1 FROM %2";
    request = request.arg(tableColumns.join(", "));
    request = request.arg(tableName);

    if(tableKeys.length()) {
         request += " WHERE %3";
         QStringList keys;
         for(int i = 0; i != tableKeys.length(); i++){
             keys.push_back(tableKeys[i] + "='" + tableKeysValue[i] + "'");
         }
         request = request.arg(keys.join(" AND "));
    }

    query.exec(request);
    while(query.next()){
        for(int i = 0; query.value(i).toString() != ""; i++)
            ret.append(query.value(i).toString());
    }
    return ret;
}
