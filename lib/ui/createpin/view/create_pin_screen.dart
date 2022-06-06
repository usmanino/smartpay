import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:smartplay/controller/controller.dart';
import 'package:smartplay/core/styles.dart';
import 'package:smartplay/router/app_router.dart';
import 'package:smartplay/ui/home/view/home.dart';

class CreatePinScreen extends StatefulWidget {
  final String? fname;
  const CreatePinScreen({Key? key, this.fname}) : super(key: key);

  @override
  State<CreatePinScreen> createState() => _CreatePinScreenState(fname: fname);
}

class _CreatePinScreenState extends State<CreatePinScreen> {
  final String? fname;

  _CreatePinScreenState({
    this.fname,
  });

  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  StreamController<ErrorAnimationType>? _errorController;
  final TextEditingController _pinController = TextEditingController();
  bool hasError = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _dialogKey = GlobalKey<State>();
  bool isPinEmpty = false;

  bool isPopup = false;

  showPopup() {
    setState(() {
      isPopup = true;
    });
  }

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
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Set your PIN code',
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
                            'We use state-of-the-art security measures to protect your information at all times',
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                            success: 'Pin Create Successful',
                                            context: _dialogKey,
                                            scaffoldKey: _scaffoldKey,
                                            popStack: false,
                                          );
                                          Timer(
                                            const Duration(seconds: 3),
                                            () {
                                              Navigator.pop(context);
                                              showPopup();
                                            },
                                          );
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
          isPopup
              ? Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  // margin: const EdgeInsets.symmetric(
                  //     vertical: 100.0, horizontal: 30.0),
                  padding: const EdgeInsets.symmetric(
                      vertical: 30.0, horizontal: 20.0),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('assets/images/cong.png'),
                      SizedBox(
                        height: SizeConfig.minBlockVertical! * 5.0,
                      ),
                      Text(
                        "Congratulations",
                        style: GoogleFonts.poppins(
                          color: kPrimaryColor,
                          fontSize: 24.0.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.minBlockVertical! * 2.0,
                      ),
                      Text(
                        "Hey ${fname.toString()}, your account has been successfully created 👋 ",
                        style: GoogleFonts.poppins(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(),
                      SolidButton(
                        text: "Proceed to home",
                        radius: 16,
                        onPressed: () {
                          Dialogs.showLoadingDialog(context, key: _dialogKey);

                          Timer(
                            const Duration(seconds: 3),
                            () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                              );
                            },
                          );
                        },
                        color: kPrimaryColor,
                      ),
                      SizedBox(
                        height: SizeConfig.minBlockVertical! * 2.0,
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
