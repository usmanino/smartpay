import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:smartplay/controller/controller.dart';
import 'package:smartplay/core/styles.dart';
import 'package:smartplay/router/app_router.dart';
import 'package:smartplay/ui/auth/contry/view/contry.dart';

class VerificationScreen extends StatefulWidget {
  final String? email;
  final String? fname;
  final String? pass;
  final String? token;
  const VerificationScreen(
      {Key? key, this.email, this.fname, this.pass, this.token})
      : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState(
      email: email, fname: fname, pass: pass, token: token);
}

class _VerificationScreenState extends State<VerificationScreen> {
  final String? email;
  final String? fname;
  final String? pass;
  final String? token;

  _VerificationScreenState({this.email, this.fname, this.pass, this.token});

  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  StreamController<ErrorAnimationType>? _errorController;
  final TextEditingController _pinController = TextEditingController();

  bool hasError = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _dialogKey = GlobalKey<State>();
  // bool isPinEmpty = false;

  @override
  void initState() {
    super.initState();
    _pinController.text = token.toString();
  }

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
                        'Verify it’s you',
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
                        'We send a code to ${email.toString()}. Enter it here to verify your identity',
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
                              enableActiveFill: true,

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
                                activeFillColor: Colors.grey.withOpacity(0.1),
                                selectedFillColor: Colors.grey.withOpacity(0.1),
                                inactiveFillColor: Colors.grey.withOpacity(0.1),
                                inactiveColor: Colors.transparent,
                                activeColor: kSecondaryColor,
                                shape: PinCodeFieldShape.box,
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

                              onChanged: (val) {},
                              beforeTextPaste: (text) {
                                return true;
                              },
                            ),
                            SizedBox(
                              height: SizeConfig.minBlockVertical! * 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Resend Code',
                                  style: TextStyle(
                                    fontFamily: 'sf',
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: kSecondaryColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.minBlockVertical! * 5,
                            ),
                            // isPinEmpty == false
                            //     ? Container(
                            //         width: SizeConfig.screenWidth,
                            //         height: 56,
                            //         decoration: BoxDecoration(
                            //           color: const Color(0xFF424242),
                            //           borderRadius: BorderRadius.circular(16),
                            //         ),
                            //         child: Center(
                            //           child: Text(
                            //             'Confirm',
                            //             textAlign: TextAlign.center,
                            //             style: GoogleFonts.poppins(
                            //               color: kWhiteColor,
                            //               fontSize: 16,
                            //               fontWeight: FontWeight.w700,
                            //             ),
                            //           ),
                            //         ),
                            //       )
                            //     :
                            SolidButton(
                              text: "Confirm",
                              radius: 16,
                              onPressed: () {
                                if (_formState.currentState!.validate()) {
                                  _formState.currentState!.save();
                                  Dialogs.showLoadingDialog(context,
                                      key: _dialogKey);
                                  userProvider
                                      .verifyToken(
                                    email: email ?? '',
                                    token: _pinController.text,
                                  )
                                      .then((value) {
                                    if (value.data == null ||
                                        value.success == false) {
                                      if (value.success == false) {
                                        print("Is False");
                                        Timer(Duration(seconds: 1), () {
                                          displayErrorMessage(
                                            error: value.message!,
                                            context: _dialogKey,
                                            scaffoldKey: _scaffoldKey,
                                            popStack: true,
                                          );
                                        });

                                        print(value.message! + '=======');
                                      }
                                    } else {
                                      Timer(
                                        const Duration(seconds: 3),
                                        () {
                                          Navigator.pop(context);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ContryScreen(
                                                fname: fname,
                                                email: email,
                                                pass: pass,
                                                pin: _pinController.text,
                                              ),
                                            ),
                                          );
                                        },
                                      );
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
