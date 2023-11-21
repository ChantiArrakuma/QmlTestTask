#include "metriclistmodel.h"
#include <QDebug>

MetricListModel::MetricListModel(QObject *parent)
    : QSqlQueryModel{parent}
{
    this->updateModel();
}

QVariant MetricListModel::data(const QModelIndex & index, int role) const {

    int columnId = role - Qt::UserRole - 1;

    QModelIndex modelIndex = this->index(index.row(), columnId);

    return QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
}

QHash<int, QByteArray> MetricListModel::roleNames() const {

    QHash<int, QByteArray> roles;
    roles[IdRole] = "MetricName";
    roles[SvgSource] = "SvgSource";
    roles[Color] = "Color";

    return roles;
}

void MetricListModel::updateModel()
{
    this->setQuery("SELECT name, svgSource, color FROM Metric");
}

int MetricListModel::getId(int row)
{
    return this->data(this->index(row, 0), IdRole).toInt();
}
