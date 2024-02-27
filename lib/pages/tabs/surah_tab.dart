import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/models/surah_model.dart';
import 'package:quran_app/pages/detail_screen.dart';
import 'package:quran_app/viewmodels/surah_viewmodel.dart';

class TabSurah extends StatelessWidget {
  const TabSurah({super.key});

  @override
  Widget build(BuildContext context) {
    final SurahViewModel _viewmodel = SurahViewModel();
    return FutureBuilder<List<Surah>>(
        future: _viewmodel.getListSurah(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text("Tidak ada data"),
            );
          }
          return ListView.separated(
              itemBuilder: (context, index) => _itemList(
                  context: context, surah: snapshot.data!.elementAt(index)),
              separatorBuilder: (context, index) => Divider(
                    color: Colors.grey.withOpacity(0.1),
                    height: 1,
                  ),
              itemCount: snapshot.data!.length);
        });
  }
}

Widget _itemList({required BuildContext context, required Surah surah}) =>
    InkWell(
      onTap: () {
        Navigator.pushNamed(context, DetailScreen.routeName, arguments: {
          'id_surah': surah.nomor.toString(),
          'title_surah': surah.nama_latin.toString()
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Stack(
              children: [
                SvgPicture.asset('assets/svg/nomor_surah.svg'),
                SizedBox(
                  height: 36,
                  width: 36,
                  child: Center(
                    child: Text(
                      surah.nomor.toString(),
                      style: GoogleFonts.redHatDisplay(
                          fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    surah.nama_latin,
                    style: GoogleFonts.redHatDisplay(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                  Text(
                    "${surah.tempat_turun} - ${surah.jumlah_ayat}",
                    style: GoogleFonts.redHatDisplay(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  )
                ],
              ),
            ),
            Text(
              surah.nama,
              style: GoogleFonts.redHatDisplay(
                  color: Colors.grey,
                  fontWeight: FontWeight.w800,
                  fontSize: 18),
            )
          ],
        ),
      ),
    );
