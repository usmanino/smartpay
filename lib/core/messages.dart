import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartplay/core/styles.dart';

void displayErrorMessage({
  required String error,
  required dynamic context,
  required scaffoldKey,
  bool popStack = true,
}) {
  //ExtendedNavigator.of(context).pop();
  popStack
      ? Navigator.of(context?.currentContext, rootNavigator: true).pop()
      : null;
  scaffoldKey.currentState.showSnackBar(
    SnackBar(
      backgroundColor: kBlackColor,
      content: Text(
        error,
        style: GoogleFonts.roboto(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      duration: const Duration(milliseconds: 3000),
      behavior: SnackBarBehavior.floating,
    ),
  );
}

void displaySuccessMessage({
  required String success,
  required context,
  required scaffoldKey,
  bool popStack = true,
}) {
  popStack
      ? Navigator.of(context?.currentContext, rootNavigator: true).pop()
      : null;
  scaffoldKey.currentState.showSnackBar(
    SnackBar(
      backgroundColor: kSuccessColor,
      content: Text(
        success,
        style: GoogleFonts.roboto(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      duration: const Duration(milliseconds: 5000),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
