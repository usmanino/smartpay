import 'dart:async';

import 'package:country_list_pick/country_list_pick.dart';
import 'package:device_name/device_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:smartplay/controller/controller.dart';
import 'package:smartplay/core/styles.dart';
import 'package:smartplay/router/app_router.dart';
import 'package:smartplay/ui/createpin/view/create_pin_screen.dart';

class ContryScreen extends StatefulWidget {
  final String? email;
  final String? fname;
  final String? pass;
  final String? pin;

  const ContryScreen({Key? key, this.email, this.fname, this.pass, this.pin})
      : super(key: key);

  @override
  State<ContryScreen> createState() =>
      _ContryScreenState(email: email, fname: fname, pass: pass, pin: pin);
}

class _ContryScreenState extends State<ContryScreen> {
  final String? email;
  final String? fname;
  final String? pass;
  final String? pin;

  _ContryScreenState({this.email, this.fname, this.pass, this.pin});

  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _dialogKey = GlobalKey<State>();
  var getCode;
  final deviceName = DeviceName();
  final identifier = 'iPhone13,4';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: SizeConfig.minBlockVertical! * 3,
            ),
            CustomAppBar(
              hasBack: true,
            ),
            SizedBox(
              height: SizeConfig.minBlockVertical! * 5,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Country of Residence',
                        style: TextStyle(
                          fontFamily: 'sf',
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: kPrimaryColor,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.minBlockVertical!,
                      ),
                      Text(
                        'Please select all the countries that you’re a tax recident in',
                        style: TextStyle(
                          fontFamily: 'sf',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.minBlockVertical! * 9,
                      ),
                      Form(
                        key: _formState,
                        child: Column(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              height: 56,
                              width: SizeConfig.screenWidth,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              //padding: EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CountryListPick(
                                    appBar: AppBar(
                                      leading: InkResponse(
                                        radius: 30,
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(30.0)),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: kPrimaryColor,
                                                width: 0.2),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(7.0),
                                            child: Icon(
                                              Icons.navigate_before,
                                              color: kPrimaryColor,
                                              size: 30,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    onChanged: (code) {
                                      getCode = code?.code;
                                    },
                                    theme: CountryTheme(
                                      labelColor: kPrimaryColor,
                                      alphabetTextColor: kPrimaryColor,
                                      alphabetSelectedTextColor: kPrimaryColor,
                                      isShowFlag: true,
                                      isShowTitle: true,
                                      isShowCode: false,
                                      isDownIcon: false,
                                      showEnglishName: true,
                                    ),
                                    initialSelection: '+234',
                                  ),
                                  const Icon(
                                    Icons.keyboard_arrow_down,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.minBlockVertical! * 2,
                            ),
                            SizedBox(
                              height: SizeConfig.minBlockVertical! * 5,
                            ),
                            SolidButton(
                              text: "Confirm",
                              radius: 16,
                              onPressed: () {
                                if (_formState.currentState!.validate()) {
                                  _formState.currentState!.save();
                                  Dialogs.showLoadingDialog(context,
                                      key: _dialogKey);
                                  userProvider
                                      .register(
                                    full_name: fname ?? '',
                                    email: email ?? '',
                                    country: getCode ?? 'NG',
                                    password: pass ?? '',
                                    device_name:
                                        deviceName.ios(identifier).toString(),
                                  )
                                      .then((value) {
                                    if (value.data == null ||
                                        value.success == false) {
                                      if (value.success == false) {
                                        print(value.data);
                                        Timer(const Duration(seconds: 1), () {
                                          displayErrorMessage(
                                            error: value.message!,
                                            context: _dialogKey,
                                            scaffoldKey: _scaffoldKey,
                                            popStack: true,
                                          );
                                        });
                                      }
                                    } else {
                                      if (value.success == true) {
                                        print(value.data);
                                        displaySuccessMessage(
                                          success: value.message!,
                                          context: _dialogKey,
                                          scaffoldKey: _scaffoldKey,
                                          popStack: true,
                                        );
                                        Timer(const Duration(seconds: 2), () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CreatePinScreen(
                                                fname: fname,
                                              ),
                                            ),
                                          );
                                        });
                                      }
                                    }
                                  });
                                }
                              },
                              color: kPrimaryColor,
                            ),
                            SizedBox(
                              height: SizeConfig.minBlockVertical! * 3,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
