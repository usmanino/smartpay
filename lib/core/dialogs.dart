import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartplay/core/styles.dart';

const iOSLocalizedLabels = false;

class Dialogs {
  static Future<void> showLoadingDialog(BuildContext context,
      {GlobalKey? key}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => true,
          child: Container(
            //  color: kWhiteColor,
            child: SimpleDialog(
              key: key ?? const Key('0'),
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              children: <Widget>[
                (Platform.isIOS)
                    ? Center(
                        child: Theme(
                          data: ThemeData(
                            cupertinoOverrideTheme: const CupertinoThemeData(),
                          ),
                          child: const CupertinoActivityIndicator(
                            radius: 20,
                            animating: true,
                          ),
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: kPrimaryColor,
                          strokeWidth: 1.3,
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
