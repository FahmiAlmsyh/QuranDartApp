import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Tab itemtab({required String label}) => Tab(
        child: Text(
      label,
      style:
          GoogleFonts.redHatDisplay(fontSize: 16, fontWeight: FontWeight.w600),
    ));
