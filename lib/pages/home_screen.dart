import 'dart:convert';

import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/components/tab_item.dart';
import 'package:quran_app/models/surah_model.dart';
import 'package:quran_app/pages/detail_screen.dart';
import 'package:quran_app/pages/tabs/doa_tab.dart';
import 'package:quran_app/pages/tabs/dzikir_tab.dart';
import 'package:quran_app/pages/tabs/surah_tab.dart';
import 'package:quran_app/theme.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home_screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchValue = '';
  final List<Surah> _suggestions = [];

  Future<List<Surah>> _fetchSuggestions(String searchValue) async {
    await Future.delayed(const Duration(milliseconds: 750));

    String jsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/data/list-surah.json');

    List<dynamic> jsonList = json.decode(jsonString);

    _suggestions.clear();
    _suggestions.addAll(jsonList.map((json) => Surah.fromJson(json)));

    return _suggestions.where((element) {
      return element.nama_latin
          .toLowerCase()
          .contains(searchValue.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      bottomNavigationBar: _bottomNavigationBar(),
      body: _body(),
    );
  }

  EasySearchBar _appBar() => EasySearchBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
          child: Text(
            'QuranApp',
            style: GoogleFonts.redHatDisplay(
                fontSize: 18, fontWeight: FontWeight.w600, color: primary),
          ),
        ),
        onSearch: (value) => setState(() => searchValue = value),
        asyncSuggestions: (value) async {
          List<Surah> sugesti = await _fetchSuggestions(value);
          return sugesti.map((surah) => surah.nama_latin).toList();
        },
        onSuggestionTap: (value) async {
          Surah chosenSurah = (await _fetchSuggestions(value))
              .firstWhere((surah) => surah.nama_latin == value);
          Navigator.pushNamed(
            context,
            DetailScreen.routeName,
            arguments: {
              'id_surah': chosenSurah.nomor.toString(),
              'nama_surah': chosenSurah.nama_latin.toString(),
            },
          );
        },
      );
}

Column _salam() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 8,
        ),
        Text(
          'Assalamualaikum',
          style: GoogleFonts.redHatDisplay(
              fontSize: 12, fontWeight: FontWeight.w600, color: primary),
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          "Fahm",
          style: GoogleFonts.redHatDisplay(
              fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Stack(
          children: [
            Container(
              height: 131,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomLeft,
                    colors: [Color(0xff53E88B), Color(0xff15BE77)]),
              ),
            ),
            Positioned(
                bottom: 0,
                right: 0,
                child: SvgPicture.asset('assets/svg/quran_banner.svg')),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/svg/clock.svg'),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Last Time",
                        style: GoogleFonts.redHatDisplay(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Text(
                    "Ibrahim",
                    style: GoogleFonts.redHatDisplay(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.white),
                  ),
                  Text(
                    "Ayah no: 35",
                    style: GoogleFonts.redHatDisplay(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  )
                ],
              ),
            )
          ],
        )
      ],
    );

BottomNavigationBarItem _bottomNavigationBarItem(
        {required String icon, required String label}) =>
    BottomNavigationBarItem(
        icon: SvgPicture.asset(
          icon,
          color: secondary,
        ),
        activeIcon: SvgPicture.asset(
          icon,
          color: primary,
        ),
        label: label);

BottomNavigationBar _bottomNavigationBar() => BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      items: [
        _bottomNavigationBarItem(
          icon: 'assets/svg/quran_icon.svg',
          label: 'Quran',
        ),
        _bottomNavigationBarItem(
          icon: 'assets/svg/doa_icon.svg',
          label: 'Doa',
        ),
        // _bottomNavigationBarItem(
        //   icon: 'assets/svg/bookmark_icon.svg',
        //   label: 'Bookmark',
        // )
      ],
    );

DefaultTabController _body() => DefaultTabController(
    length: 3,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: NestedScrollView(
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) => [
                    SliverToBoxAdapter(
                      child: _salam(),
                    ),
                    SliverAppBar(
                      pinned: true,
                      elevation: 0,
                      automaticallyImplyLeading: false,
                      shape: Border(
                          bottom: BorderSide(
                              width: 3, color: Colors.grey.withOpacity(0.1))),
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(0),
                        child: TabBar(
                            labelColor: primary,
                            indicatorColor: primary,
                            indicatorWeight: 3,
                            tabs: [
                              itemtab(label: "Surah"),
                              itemtab(label: "Dzikir"),
                              itemtab(label: "Doa"),
                            ]),
                      ),
                    ),
                  ],
          body: const TabBarView(
            children: [TabSurah(), TabDzikir(), TabDoa()],
          )),
    ));
