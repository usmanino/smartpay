import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:smartplay/controller/controller.dart';
import 'package:smartplay/core/styles.dart';
import 'package:smartplay/router/app_router.dart';
import 'package:smartplay/ui/home/view/home.dart';

class EnterPinScreen extends StatefulWidget {
  const EnterPinScreen({Key? key}) : super(key: key);

  @override
  State<EnterPinScreen> createState() => _EnterPinScreenState();
}

class _EnterPinScreenState extends State<EnterPinScreen> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  StreamController<ErrorAnimationType>? _errorController;
  final TextEditingController _pinController = TextEditingController();
  bool hasError = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _dialogKey = GlobalKey<State>();
  bool isPinEmpty = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.minBlockVertical! * 3,
                ),
                CustomAppBar(
                  hasBack: false,
                ),
                SizedBox(
                  height: SizeConfig.minBlockVertical! * 5,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Enter your PIN code',
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
                          SizedBox(
                            height: SizeConfig.minBlockVertical! * 9,
                          ),
                          Form(
                            key: _formState,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                PinCodeTextField(
                                  // enableActiveFill: true,
                                  validator: (value) {
                                    if (_pinController.text == '') {
                                      return "Field cannot be empty";
                                    }
                                  },
                                  appContext: context,
                                  pastedTextStyle: const TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  length: 5,
                                  obscureText: true,
                                  obscuringCharacter: '*',
                                  blinkWhenObscuring: true,
                                  animationType: AnimationType.fade,
                                  pinTheme: PinTheme(
                                    inactiveColor: kSecondaryColor,
                                    activeColor: kSecondaryColor,
                                    shape: PinCodeFieldShape.underline,
                                    borderRadius: BorderRadius.circular(5),
                                    fieldHeight: 50,
                                    fieldWidth: 40,
                                    // activeFillColor: Colors.transparent,
                                  ),
                                  cursorColor: Colors.black,
                                  animationDuration:
                                      const Duration(milliseconds: 300),
                                  //enableActiveFill: true,
                                  errorAnimationController: _errorController,
                                  controller: _pinController,
                                  keyboardType: TextInputType.number,
                                  onCompleted: (v) {
                                    _formState.currentState!.save();
                                  },

                                  onChanged: (val) {
                                    if (val.trim().length > 4) {
                                      setState(() {
                                        isPinEmpty = true;
                                      });
                                    } else {
                                      setState(() {
                                        isPinEmpty = false;
                                      });
                                    }
                                  },
                                  beforeTextPaste: (text) {
                                    return true;
                                  },
                                ),
                                SizedBox(
                                  height: SizeConfig.minBlockVertical! * 2,
                                ),
                                SizedBox(
                                  height: SizeConfig.minBlockVertical! * 5,
                                ),
                                isPinEmpty == false
                                    ? Container(
                                        width: SizeConfig.screenWidth,
                                        height: 56,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF424242),
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Create PIN',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                              color: kWhiteColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      )
                                    : SolidButton(
                                        text: "Create PIN",
                                        radius: 16,
                                        onPressed: () {
                                          Dialogs.showLoadingDialog(context,
                                              key: _dialogKey);
                                          displaySuccessMessage(
                                            success: 'Pin Entered Successful',
                                            context: _dialogKey,
                                            scaffoldKey: _scaffoldKey,
                                            popStack: false,
                                          );
                                          Timer(
                                            const Duration(seconds: 3),
                                            () {
                                              userProvider.checkUser();
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeScreen(),
                                                ),
                                              );
                                              // Navigator.pop(context);
                                              // showPopup();
                                            },
                                          );
                                        },
                                        color: kPrimaryColor,
                                      ),
                                SizedBox(
                                  height: SizeConfig.minBlockVertical! * 5,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, SmartScreen.login);
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      fontFamily: 'sf',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: kDangerColor,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
