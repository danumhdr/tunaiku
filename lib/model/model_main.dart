import 'dart:convert';

MainModel mainModelFromJson(String str) => MainModel.fromJson(json.decode(str));

String mainModelToJson(MainModel data) => json.encode(data.toJson());

class MainModel {
  List<Province> provinsi;

  MainModel({
    this.provinsi,
  });

  factory MainModel.fromJson(Map<String, dynamic> json) => MainModel(
        provinsi: List<Province>.from(
            json["provinsi"].map((x) => Province.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "provinsi": List<dynamic>.from(provinsi.map((x) => x.toJson())),
      };
}

class Province {
  int id;
  String nama;

  Province({this.id, this.nama});

  factory Province.fromJson(Map<String, dynamic> json) => Province(
        id: json["id"],
        nama: json["nama"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
      };
}
