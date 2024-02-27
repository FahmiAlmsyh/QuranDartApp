import 'dart:convert';

List<DzikirTab> dzikirTabFromJson(String str) =>
    List<DzikirTab>.from(jsonDecode(str).map((x) => DzikirTab.fromJson(x)));

class DzikirTab {
  final String nomor;
  final String title;
  final String description;
  final List<DzikirItem>? dzikir;

  DzikirTab({
    required this.nomor,
    required this.title,
    required this.description,
    required this.dzikir,
  });

  factory DzikirTab.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? dzikirJson = json['dzikir'];
    final List<DzikirItem> dzikir = dzikirJson != null
        ? List<DzikirItem>.from(
            dzikirJson.map((x) => DzikirItem.fromJson(x)))
        : []; // Handle null case by providing an empty list

    return DzikirTab(
      nomor: json['nomor'],
      title: json['title'],
      description: json['description'],
      dzikir: dzikir,
    );
  }
}

List<DzikirItem> dzikirItemFromJson(String str) =>
    List<DzikirItem>.from(jsonDecode(str).map((x) => DzikirItem.fromJson(x)));

class DzikirItem {
  final int nomor;
  final String title;
  final String arabic;
  final String latin;
  final String translation;
  final String notes;
  final String? fawaid;
  final String? source;

  DzikirItem({
    required this.nomor,
    required this.title,
    required this.arabic,
    required this.latin,
    required this.translation,
    required this.notes,
    this.fawaid,
    this.source,
  });

  factory DzikirItem.fromJson(Map<String, dynamic> json) => DzikirItem(
        nomor: json['nomor'],
        title: json['title'],
        arabic: json['arabic'],
        latin: json['latin'],
        translation: json['translation'],
        notes: json['notes'],
        fawaid: json['fawaid'],
        source: json['source'],
      );
}
