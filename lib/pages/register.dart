import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tunaiku/loc/bloc_main.dart';
import 'package:tunaiku/model/model_data.dart';
import 'package:tunaiku/model/model_main.dart';
import 'package:intl/intl.dart';
import 'package:tunaiku/pages/register_next.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = '/register';
  @override
  State<StatefulWidget> createState() {
    return _RegisterPage();
  }
}

class _RegisterPage extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  TextEditingController _date = new TextEditingController();
  String _valEdu, provinc;
  List education = ["SD", "SMP", "SMA", "S1", "S2", "S3"];
  MediaQueryData queryData;
  DataModel_1 model = DataModel_1();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        var myFormat = DateFormat('dd-MM-yyyy');
        _date.text = myFormat.format(selectedDate).toString();
      });
  }

  @override
  void initState() {
    super.initState();
    bloc.getUser();
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Page"),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<MainModel>(
            stream: bloc.subject.stream,
            builder: (context, AsyncSnapshot<MainModel> snapshot) {
              if (snapshot.hasData) {
                return formdata(snapshot.data, context);
              } else if (snapshot.hasError) {
                return _buildErrorWidget(snapshot.error);
              } else {
                return _buildLoadingWidget();
              }
            }),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text("Loading data from API..."), CircularProgressIndicator()],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error"),
      ],
    ));
  }

  Widget formdata(MainModel data, BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(16),
              ],
              decoration: InputDecoration(labelText: 'KTP'),
              onSaved: (String value) {
                model.ktp = value;
              },
              validator: (value) {
                if (value.isEmpty || value.length < 16) {
                  return 'Masukkan No KTP Anda';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              keyboardType: TextInputType.text,
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(10),
              ],
              decoration: InputDecoration(labelText: 'Nama Lengkap'),
              onSaved: (String value) {
                model.nama = value;
              },
              validator: (value) {
                if (value.isEmpty) {
                  return 'Masukkan Nama Lengkap Tanpa Angka';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(labelText: 'Nomor Rekening Anda'),
              onSaved: (String value) {
                model.bank = value;
              },
              validator: (value) {
                if (value.isEmpty || value.length < 8) {
                  return 'Masukkan Nomor Rekening Anda';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton(
              value: _valEdu,
              hint: Text("Pendidikan"),
              items: education.map((item) {
                return new DropdownMenuItem(
                  child: new Text(item),
                  value: item,
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _valEdu = value;
                  model.pendidikan = value;
                  print(_valEdu);
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                _selectDate(context);
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: AbsorbPointer(
                child: TextFormField(
                  controller: _date,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    hintText: 'Tanggal Lahir Anda',
                    prefixIcon: Icon(
                      Icons.dialpad,
                    ),
                  ),
                  onSaved: (String value) {
                    model.tgllahir = value;
                  },
                ),
              ),
            ),
          ),
          Container(
            width: queryData.size.width,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  if (_valEdu != null &&
                      _date.text != null &&
                      _date.text != "") {
                    _formKey.currentState.save();
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('Processing Data')));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterNextPage(model)),
                    );
                  } else {
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('Lengkapi Formulir Anda')));
                  }
                }
              },
              child: Text('Next'),
            ),
          ),
        ],
      ),
    );
  }
}
