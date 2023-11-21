#ifndef DIARYLISTMODEL_H
#define DIARYLISTMODEL_H

#include <QSqlQueryModel>
#include <QObject>

class diaryListModel : public QSqlQueryModel
{
    Q_OBJECT
public:
    enum Roles{
        IdRole = Qt::UserRole + 1,
        Diary,
    };
    explicit diaryListModel(QObject *parent = nullptr);
    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

protected:
    QHash<int, QByteArray> roleNames() const;

public slots:
    void updateModel(QString year, QString month, QString day); // void updateModel()
    int getId(int row);
};

#endif // DIARYLISTMODEL_H
