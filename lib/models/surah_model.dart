import 'dart:convert';

List<Surah> surahFromJson(String str) =>
    List<Surah>.from(jsonDecode(str).map((x) => Surah.fromJson(x)));

class Surah {
  int nomor;
  String nama;
  String nama_latin;
  int jumlah_ayat;
  String tempat_turun;
  String arti;
  String deskripsi;
  String audio;

  Surah(
      {required this.nomor,
      required this.nama,
      required this.nama_latin,
      required this.jumlah_ayat,
      required this.tempat_turun,
      required this.arti,
      required this.deskripsi,
      required this.audio});

  // nyocokin sama class yang kita punya

  factory Surah.fromJson(Map<String, dynamic> json) => Surah(
      nomor: json['nomor'],
      nama: json['nama'],
      nama_latin: json['nama_latin'],
      jumlah_ayat: json['jumlah_ayat'],
      tempat_turun: json['tempat_turun'].toUpperCase(),
      arti: json['arti'],
      deskripsi: json['deskripsi'],
      audio: json['audio']);
}
