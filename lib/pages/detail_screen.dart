import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/models/ayah_model.dart';
import 'package:quran_app/viewmodels/ayah_viewmodel.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = '/detail';
  final String? id_surah;
  final String? surah_title;
  const DetailScreen(
      {super.key, required this.id_surah, required this.surah_title});

  @override
  Widget build(BuildContext context) {
    final AyahViewModel _viewModel = AyahViewModel();
    return Scaffold(
        appBar: AppBar(title: Text(surah_title ?? '')),
        body: FutureBuilder(
            future: _viewModel.getListAyah(id_surah ?? ''),
            builder: (context, AsyncSnapshot<AyahModel> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("Error: ${snapshot.error}"),
                );
              } else if (snapshot.hasData) {
                return ListView.separated(
                    itemBuilder: (context, index) => _itemList(
                        context: context,
                        ayat: snapshot.data!.ayat!.elementAt(index)),
                    separatorBuilder: (context, index) => Divider(
                          color: Colors.grey.withOpacity(0.1),
                          height: 1,
                        ),
                    itemCount: snapshot.data!.ayat!.length);
              } else {
                return const Center(
                  child: Text("No data available"),
                );
              }
            }));
  }
}

Widget _itemList({required BuildContext context, required Ayat ayat}) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
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
                    ayat.nomor.toString(),
                    style: GoogleFonts.redHatDisplay(
                        fontWeight: FontWeight.w500, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  ayat.ar.toString(),
                  style: GoogleFonts.amiri(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
                Text(
                  ayat.idn.toString(),
                  style: GoogleFonts.redHatDisplay(
                      color: Colors.grey,
                      fontWeight: FontWeight.w300,
                      fontSize: 12),
                )
              ],
            ),
          ),
          // Text(
          //   ayat.idn.toString(),
          //   style: GoogleFonts.redHatDisplay(
          //       color: Colors.grey,
          //       fontWeight: FontWeight.w800,
          //       fontSize: 18),
          // )
        ],
      ),
    );
