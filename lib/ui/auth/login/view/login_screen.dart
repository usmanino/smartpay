import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:smartplay/controller/user_provider.dart';
import 'package:smartplay/core/styles.dart';
import 'package:smartplay/router/app_router.dart';
import 'package:device_name/device_name.dart';
import 'package:smartplay/ui/home/view/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _dialogKey = GlobalKey<State>();

  bool isPassWordEmpty = true;
  bool isEmailEmpty = true;
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
                        'Hi There! 👋',
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
                        'Welcome back, Sign in to your account',
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
                            InputBox(
                              controller: _passwordController,
                              onChanged: (val) {
                                if (val.trim().isEmpty &&
                                    val.trim().length < 6) {
                                  setState(() {
                                    isPassWordEmpty = true;
                                    print(isPassWordEmpty);
                                  });
                                } else {
                                  setState(() {
                                    isPassWordEmpty = false;
                                    print(isPassWordEmpty);
                                  });
                                }
                              },
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return 'Password cannot be empty';
                                }
                                if (value.trim().length < 6) {
                                  return 'Password cannot be less than 6 characters';
                                }
                                return null;
                              },
                              suriconColor: Colors.grey,
                              enableSurfix: true,
                              isPassword: userProvider.isLoginObsecure,
                              suricon: userProvider.isLoginObsecure
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              onIconClick: () => userProvider.issecure(),
                              fillColor: Colors.grey.withOpacity(0.1),
                              hintText: 'Password',
                              inputType: TextInputType.emailAddress,
                              enabledColor: Colors.transparent,
                              focusedColor: kSecondaryColor,
                            ),
                            SizedBox(
                              height: SizeConfig.minBlockVertical! * 2,
                            ),
                            TextButton(
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  fontFamily: 'sf',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: kSecondaryColor,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, SmartScreen.forgetpassword);
                              },
                            ),
                            SizedBox(
                              height: SizeConfig.minBlockVertical! * 3,
                            ),
                            isPassWordEmpty == true || isEmailEmpty == true
                                ? Container(
                                    width: SizeConfig.screenWidth,
                                    height: 56,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF424242),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Sign In',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                          color: kWhiteColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  )
                                : SolidButton(
                                    text: "Sign In",
                                    radius: 16,
                                    onPressed: () {
                                      if (_formState.currentState!.validate()) {
                                        _formState.currentState!.save();
                                        String email = _emailController.text;
                                        String pass = _passwordController.text;

                                        if (email.trim().isEmpty ||
                                            pass.trim().isEmpty) {
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
                                        } else if (pass.trim().length < 5) {
                                          // ignore: void_checks
                                          return;
                                        }
                                        if (!myReg.hasMatch(email.trim())) {
                                          // ignore: void_checks
                                          return error(
                                            error: 'Email supplied not valid',
                                          );
                                        }
                                        // End validation here

                                        Dialogs.showLoadingDialog(context,
                                            key: _dialogKey);
                                        userProvider
                                            .login(
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                          device_name: deviceName
                                              .ios(identifier)
                                              .toString(),
                                        )
                                            .then((value) {
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
                                          } else {
                                            if (value.success == true) {
                                              print(value.data);
                                              displaySuccessMessage(
                                                success: value.message!,
                                                context: _dialogKey,
                                                scaffoldKey: _scaffoldKey,
                                                popStack: true,
                                              );
                                              Timer(const Duration(seconds: 2),
                                                  () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        HomeScreen(),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: SizeConfig.minBlockHorizontal! * 35,
                                  height: 0.2,
                                  color: kInActiveColor,
                                ),
                                const Text(
                                  'OR',
                                  style: TextStyle(
                                    fontFamily: 'sf',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: kPrimaryColor,
                                  ),
                                ),
                                Container(
                                  width: SizeConfig.minBlockHorizontal! * 35,
                                  height: 0.2,
                                  color: kInActiveColor,
                                ),
                                SizedBox(
                                  height: SizeConfig.minBlockVertical! * 3,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.minBlockVertical! * 3,
                            ),
                            Row(
                              children: [
                                SocialButton(
                                  image: 'assets/svgs/google.svg',
                                  onPress: () {},
                                ),
                                SizedBox(
                                  width: SizeConfig.minBlockHorizontal! * 5,
                                ),
                                SocialButton(
                                  image: 'assets/svgs/apple.svg',
                                  onPress: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don’t have an account?',
                  style: TextStyle(
                    fontFamily: 'sf',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      SmartScreen.signup,
                    );
                  },
                  child: Text(
                    ' Sign Up',
                    style: TextStyle(
                      fontFamily: 'sf',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: kSecondaryColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.minBlockVertical! * 2,
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
