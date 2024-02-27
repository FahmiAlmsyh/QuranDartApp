import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:quran_app/models/abangku_model.dart';
import 'package:quran_app/models/ayah_model.dart';
import 'package:quran_app/models/doa_model.dart';
import 'package:quran_app/models/dzikirtab_model.dart';
import 'package:quran_app/models/surah_model.dart';
import 'package:http/http.dart' as http;

class QuranRepository {
  Future<List<Surah>> getListSurah() async {
    String data = await rootBundle.loadString('assets/data/list-surah.json');
    return surahFromJson(data);
  }

  Future<List<Doa>> getListDoaTab() async {
    String data = await rootBundle.loadString('assets/data/list-doaitem.json');
    return doaTabFromJson(data);
  }

  // Future<List<DzikirTab>> getListDzikirTab() async {
  //   String data =
  //       await rootBundle.loadString('assets/data/list-tabdzikir.json');
  //   return dzikirTabFromJson(data);
  // }

  Future<List<Abangku>> getListAbangku() async {
    String data = await rootBundle.loadString('assets/data/list-abangku.json');
    return abangkuFromJson(data);
  }

  Future<DzikirTab> getListDzikirTab(String id_dzikir) async {
    String data =
        await rootBundle.loadString('assets/data/list-tabdzikir.json');
    final List<dynamic> listDzikir = jsonDecode(data);
    Map<String, dynamic>? detailDzikir = listDzikir.firstWhere(
      (element) => element['nomor'] == id_dzikir,
      orElse: () => null,
    );

    if (listDzikir != null) {
      return DzikirTab.fromJson(detailDzikir!);
    } else {
      throw Exception("error");
    }
  }

  Future<AyahModel> getListAyah(String id_surah) async {
    // var response = await Dio().get("https://equran.id/api/surat/$id_surah");

    String url = "https://equran.id/api/surat/$id_surah";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return AyahModel.fromJson(body);
    }
    throw Exception("Error");
  }
}
