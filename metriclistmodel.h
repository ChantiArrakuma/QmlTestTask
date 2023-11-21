#ifndef METRICLISTMODEL_H
#define METRICLISTMODEL_H

#include <QSqlQueryModel>
#include <QObject>
#include <QWidget>

class MetricListModel : public QSqlQueryModel
{
    Q_OBJECT
public:
    enum Roles{
        IdRole = Qt::UserRole + 1,
        SvgSource,
        Color
    };
    explicit MetricListModel(QObject *parent = nullptr);
    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

protected:
    QHash<int, QByteArray> roleNames() const;

public slots:
    void updateModel();
    int getId(int row);
};

#endif // METRICLISTMODEL_H
