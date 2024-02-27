import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/models/dzikirtab_model.dart';
import 'package:quran_app/viewmodels/dzikiritem_viewmodel.dart';

class DetailDzikir extends StatelessWidget {
  static const routeName = '/detail_dzikir';
  final String id_dzikir;
  final String dzikir_title;
  const DetailDzikir({Key? key, required this.id_dzikir, required this.dzikir_title});

  @override
  Widget build(BuildContext context) {
    final DzikirTabItemViewModel _viewmodel = DzikirTabItemViewModel();
    return Scaffold(
        appBar: AppBar(
          title: Text(dzikir_title),
        ),
        body: FutureBuilder(
          future: _viewmodel.getListDzikirTab(id_dzikir),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: Text("data gak masuk"));
            }
            return ListView.separated(
              itemBuilder: (context, index) => _itemList(
                  context: context,
                  dzikirItem: snapshot.data!.dzikir!.elementAt(index)),
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey.withOpacity(0.1),
                height: 1,
              ),
              itemCount: snapshot.data!.dzikir!.length,
            );
          },
        ));
  }
}

Widget _itemList({
  required BuildContext context,
  required DzikirItem dzikirItem,
}) =>
    Padding(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100, // Atur lebar container sesuai kebutuhan Anda
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    dzikirItem.title.toString(),
                    style: GoogleFonts.redHatDisplay(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dzikirItem.arabic.toString(),
                  style: GoogleFonts.redHatDisplay(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                Text(
                  dzikirItem.translation,
                  style: GoogleFonts.redHatDisplay(
                    color: Colors.grey,
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                    height: 8), // Tambahkan jarak antara teks dan catatan
                Text(
                  dzikirItem.notes,
                  style: GoogleFonts.redHatDisplay(
                    color: Colors.grey,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
