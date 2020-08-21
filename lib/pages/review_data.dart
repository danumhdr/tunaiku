import 'package:flutter/material.dart';
import 'package:tunaiku/model/model_data.dart';

class ReviewPage extends StatefulWidget {
  static const routeName = '/register';
  final DataModel_1 model1;
  final DataModel_2 model2;
  @override
  State<StatefulWidget> createState() {
    return _ReviewPage();
  }

  ReviewPage(this.model1, this.model2);
}

class _ReviewPage extends State<ReviewPage> {
  double iconSize = 40;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Review Data"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                child: Table(
                  children: [
                    TableRow(children: [
                      Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.centerLeft,
                          width: 70,
                          child: Text('KTP')),
                      Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.centerLeft,
                          width: 70,
                          child: Text(widget.model1.ktp)),
                    ]),
                    TableRow(children: [
                      Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.centerLeft,
                          width: 70,
                          child: Text('Nama')),
                      Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.centerLeft,
                          width: 70,
                          child: Text(widget.model1.nama)),
                    ]),
                    TableRow(children: [
                      Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.centerLeft,
                          width: 70,
                          child: Text('Tanggal Lahir')),
                      Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.centerLeft,
                          width: 70,
                          child: Text(widget.model1.tgllahir)),
                    ]),
                    TableRow(children: [
                      Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.centerLeft,
                          width: 70,
                          child: Text('Pendidikan')),
                      Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.centerLeft,
                          width: 70,
                          child: Text(widget.model1.pendidikan)),
                    ]),
                    TableRow(children: [
                      Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.centerLeft,
                          width: 70,
                          child: Text('Rekening')),
                      Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.centerLeft,
                          width: 70,
                          child: Text(widget.model1.bank)),
                    ]),
                    TableRow(children: [
                      Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.centerLeft,
                          width: 70,
                          child: Text('Alamat')),
                      Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.centerLeft,
                          width: 70,
                          child: Text(widget.model2.alamat)),
                    ]),
                    TableRow(children: [
                      Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.centerLeft,
                          width: 70,
                          child: Text('No')),
                      Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.centerLeft,
                          width: 70,
                          child: Text(widget.model2.norum)),
                    ]),
                    TableRow(children: [
                      Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.centerLeft,
                          width: 70,
                          child: Text('Jenis')),
                      Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.centerLeft,
                          width: 70,
                          child: Text(widget.model2.typerum)),
                    ]),
                    TableRow(children: [
                      Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.centerLeft,
                          width: 70,
                          child: Text('Provinsi')),
                      Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.centerLeft,
                          width: 70,
                          child: Text(widget.model2.provname)),
                    ]),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
