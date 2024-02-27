import 'dart:convert';

List<Abangku> abangkuFromJson(String str) =>
    List<Abangku>.from(jsonDecode(str).map((x) => Abangku.fromJson(x)));

class Abangku {
  String? nomor;
  String? title;
  String? description;

  Abangku({this.nomor, this.title});

  Abangku.fromJson(Map<String, dynamic> json) {
    nomor = json['nomor'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nomor'] = this.nomor;
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}
