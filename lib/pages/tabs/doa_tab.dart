import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/models/doa_model.dart';
import 'package:quran_app/viewmodels/doa_viewmodel.dart';

class TabDoa extends StatelessWidget {
  const TabDoa({super.key});

  @override
  Widget build(BuildContext context) {
    final DoaViewModel _viewModel = DoaViewModel();
    return FutureBuilder(
        future: _viewModel.getListDoaTab(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text("No data"),
            );
          }
          return ListView.separated(
            itemBuilder: (context, index) => _itemList(
                context: context, dzikirItem: snapshot.data!.elementAt(index)),
            separatorBuilder: (context, index) => Divider(
              color: Colors.grey.withOpacity(0.1),
              height: 1,
            ),
            itemCount: snapshot.data!.length,
          );
        });
  }
}

Widget _itemList({
  required BuildContext context,
  required Doa dzikirItem,
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
                  dzikirItem.translation.toString(),
                  style: GoogleFonts.redHatDisplay(
                    color: Colors.grey,
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                    height: 8), // Tambahkan jarak antara teks dan catatan
                // Text(
                //   dzikirItem.notes.toString(),
                //   style: GoogleFonts.redHatDisplay(
                //     color: Colors.grey,
                //     fontWeight: FontWeight.w800,
                //     fontSize: 14,
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
