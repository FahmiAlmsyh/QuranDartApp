import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/pages/home_screen.dart';
import 'package:quran_app/theme.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = '/splash_screen';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Quran Application",
                style: GoogleFonts.redHatDisplay(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: primary,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                "Learn Quran and\nRecite once everyday",
                textAlign: TextAlign.center,
                style: GoogleFonts.redHatDisplay(
                  color: Color(0xff62C27B),
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 450,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: SvgPicture.asset('assets/svg/splash.svg'),
                  ),
                  Positioned(
                    bottom: -24,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(25),
                        onTap: () {
                          Navigator.pushNamed(context, HomeScreen.routeName);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 14),
                          decoration: BoxDecoration(
                              color: orange,
                              borderRadius: BorderRadius.circular(25)),
                          child: Text(
                            "Get Started",
                            style: GoogleFonts.redHatDisplay(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
