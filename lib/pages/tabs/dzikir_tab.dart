import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/models/abangku_model.dart';
import 'package:quran_app/pages/detail_dzikir.dart';
import 'package:quran_app/viewmodels/abangku_viewmodel.dart';

class TabDzikir extends StatelessWidget {
  const TabDzikir({super.key});

  @override
  Widget build(BuildContext context) {
    final AbangkuViewModel _viewmodel = AbangkuViewModel();
    return FutureBuilder(
      future: _viewmodel.getListAbangku(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("No data"));
        } else {
          return ListView.separated(
            itemBuilder: (context, index) => _itemList(
                context: context, dzikirTab: snapshot.data!.elementAt(index)),
            separatorBuilder: (context, index) => Divider(
              color: Colors.grey.withOpacity(0.1),
              height: 1,
            ),
            itemCount: snapshot.data!.length,
          );
        }
      },
    );
  }
}

Widget _itemList({required BuildContext context, required Abangku dzikirTab}) =>
    InkWell(
      onTap: () {
        Navigator.pushNamed(context, DetailDzikir.routeName, arguments: {
          "id_dzikir": dzikirTab.nomor.toString(),
          "title_dzikir": dzikirTab.title.toString()
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Stack(
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xff53E88B), Color(0xff15BE77)],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                dzikirTab.title.toString(),
                style: GoogleFonts.redHatDisplay(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
