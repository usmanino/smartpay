import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:smartplay/controller/user_provider.dart';
import 'package:smartplay/core/styles.dart';
import 'package:smartplay/router/app_router.dart';
import 'package:smartplay/ui/auth/forgetpassword/view/forget_password.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _dialogKey = GlobalKey<State>();

  bool isPassWordEmpty = true;
  bool isEmailEmpty = true;

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
                        'Passsword Recovery',
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
                        'Enter your registered email below to receive password instructions',
                        style: TextStyle(
                          fontFamily: 'sf',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: kDarkColor,
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
                            InputBox(
                              controller: _emailController,
                              onChanged: (val) {
                                if (val.trim().isEmpty) {
                                  setState(() {
                                    isEmailEmpty = true;
                                    print(isEmailEmpty);
                                  });
                                } else {
                                  setState(() {
                                    isEmailEmpty = false;
                                    print(isEmailEmpty);
                                  });
                                }
                              },
                              validator: (value) {
                                Pattern pattern =
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                RegExp myReg = RegExp(pattern.toString());
                                if (value!.trim().isEmpty) {
                                  return 'Email cannot be empty';
                                }
                                if (value.trim().length < 4) {
                                  return 'Invalid email supplied';
                                }
                                if (!myReg.hasMatch(value.trim())) {
                                  return 'Invalid email supplied';
                                }
                                return null;
                              },
                              fillColor: Colors.grey.withOpacity(0.1),
                              hintText: 'Email',
                              inputType: TextInputType.emailAddress,
                              enabledColor: Colors.transparent,
                              focusedColor: kSecondaryColor,
                            ),
                            SizedBox(
                              height: SizeConfig.minBlockVertical! * 5,
                            ),
                            SizedBox(
                              height: SizeConfig.minBlockVertical! * 2,
                            ),
                            SizedBox(
                              height: SizeConfig.minBlockVertical! * 3,
                            ),
                            isEmailEmpty == true
                                ? Container(
                                    width: SizeConfig.screenWidth,
                                    height: 56,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF424242),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Send verification code',
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
                                    text: "Send verification code",
                                    radius: 16,
                                    onPressed: () {
                                      if (_formState.currentState!.validate()) {
                                        _formState.currentState!.save();
                                        String email = _emailController.text;
                                        if (email.trim().isEmpty) {
                                          // ignore: void_checks
                                          return error(
                                            error: 'Fields cannot be empty',
                                          );
                                        }
                                        String pattern =
                                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                        RegExp myReg = RegExp(pattern);
                                        if (email.trim().length < 5) {
                                          // ignore: void_checks
                                          return error(
                                            error:
                                                'Email Address cannot be this short',
                                          );
                                        }
                                        if (!myReg.hasMatch(email.trim())) {
                                          // ignore: void_checks
                                          return error(
                                            error: 'Email supplied not valid',
                                          );
                                        }
                                      }
                                      Dialogs.showLoadingDialog(context,
                                          key: _dialogKey);

                                      Timer(Duration(seconds: 1), () {
                                        displaySuccessMessage(
                                          success: 'OTP sent successfull',
                                          context: _dialogKey,
                                          scaffoldKey: _scaffoldKey,
                                          popStack: true,
                                        );
                                      });

                                      Timer(
                                        const Duration(seconds: 3),
                                        () {
                                          Navigator.pop(context);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => OtpScreen(
                                                email: _emailController.text,
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                      // End validation here
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

  error({String? error = ''}) {
    displayErrorMessage(
      error: error!,
      context: _dialogKey,
      scaffoldKey: _scaffoldKey,
      popStack: false,
    );
    return;
  }
}

class SocialButton extends StatelessWidget {
  final String image;
  final GestureTapCallback onPress;
  const SocialButton({Key? key, required this.image, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: SizeConfig.screenWidth,
        height: 56,
        decoration: BoxDecoration(
          border: Border.all(
            color: kPrimaryColor,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(
            16,
          ),
        ),
        child: InkWell(
          onTap: onPress,
          child: Center(
            child: SvgPicture.asset(
              image,
            ),
          ),
        ),
      ),
    );
  }
}
