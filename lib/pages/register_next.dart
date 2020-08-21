import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tunaiku/loc/bloc_main.dart';
import 'package:tunaiku/model/model_data.dart';
import 'package:tunaiku/model/model_main.dart';
import 'package:tunaiku/pages/review_data.dart';

class RegisterNextPage extends StatefulWidget {
  static const routeName = '/register';
  final DataModel_1 model1;
  @override
  State<StatefulWidget> createState() {
    return _RegisterNextPage();
  }

  RegisterNextPage(this.model1);
}

class _RegisterNextPage extends State<RegisterNextPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String _valProvince, provinc, _valType;
  List typehouse = ["Rumah", "Kantor"];
  MediaQueryData queryData;
  DataModel_2 model = DataModel_2();

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
      body: StreamBuilder<MainModel>(
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
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(100),
                ],
                decoration: InputDecoration(labelText: 'Alamat Domisili'),
                onSaved: (String value) {
                  model.alamat = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Masukkan Alamat Domisili';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton(
                value: _valType,
                hint: Text("Jenis"),
                items: typehouse.map((item) {
                  return new DropdownMenuItem(
                    child: new Text(item),
                    value: item,
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _valType = value;
                    model.typerum = value;
                    print(_valType);
                  });
                },
              ),
            ),
            Container(
              width: 80,
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: 'No'),
                onSaved: (String value) {
                  model.norum = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Masukkan No Rumah';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton(
                value: _valProvince,
                hint: Text("Pilih Provinsi"),
                items: data.provinsi.map((item) {
                  return new DropdownMenuItem(
                    child: new Text(item.nama),
                    value: item.nama,
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _valProvince = value;
                    model.prov = 1;
                    model.provname = _valProvince;
                  });
                },
              ),
            ),
            Container(
              width: queryData.size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(5.0),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Kembali'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5.0),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          if (_valProvince != null && _valType != null) {
                            // If the form is valid, display a Snackbar.
                            _formKey.currentState.save();
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text('Processing Data')));
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ReviewPage(widget.model1, model)),
                            );
                          } else {
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text('Lengkapi Formulir Anda')));
                          }
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
