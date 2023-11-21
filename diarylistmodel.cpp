#include "diarylistmodel.h"

diaryListModel::diaryListModel(QObject *parent)
    : QSqlQueryModel{parent}
{
    this->updateModel("2023","0","1");
}

QVariant diaryListModel::data(const QModelIndex & index, int role) const {

    int columnId = role - Qt::UserRole - 1;

    QModelIndex modelIndex = this->index(index.row(), columnId);

    return QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
}

QHash<int, QByteArray> diaryListModel::roleNames() const {

    QHash<int, QByteArray> roles;
    roles[IdRole] = "id";
    roles[Diary] = "diary";

    return roles;
}

void diaryListModel::updateModel(QString year, QString month, QString day)
{
    this->setQuery("SELECT ID, diary FROM Diary WHERE "
                   "year = " + year + " AND "
                   "month = " + month + " AND "
                   "day = " + day);
}

int diaryListModel::getId(int row)
{
    return this->data(this->index(row, 0), IdRole).toInt();
}
