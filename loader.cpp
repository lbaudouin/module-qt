#include "loader.h"

#include <QFile>
#include <QJsonObject>
#include <QTextStream>

#include <QDebug>

Loader::Loader(QObject *parent) : QObject(parent)
{

}

QJsonArray Loader::getPath()
{
    QString path = "robot.csv";
    QJsonArray out;
    QFile file(path);
    if(file.open(QFile::ReadOnly)){


        QTextStream str(&file);
        while (!str.atEnd()) {
            QString line = str.readLine();
            QStringList values = line.split(";",QString::SkipEmptyParts);

            if(values.size()==3){
                QJsonObject o;
                o.insert("x", values.at(0).toDouble());
                o.insert("y", values.at(1).toDouble());
                o.insert("s", values.at(2).toDouble());
                out << o;
            }
        }


    }else{
        qDebug() << "Failed to load file: " << path;
    }
    return out;
}
