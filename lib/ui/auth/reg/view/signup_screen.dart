import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:smartplay/controller/controller.dart';
import 'package:smartplay/core/styles.dart';
import 'package:smartplay/router/app_router.dart';
import 'package:smartplay/ui/auth/verification/view/verification.dart';
import 'package:device_name/device_name.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final _dialogKey = GlobalKey<State>();
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
                      RichText(
                        text: TextSpan(
                          text: 'Create a',
                          style: TextStyle(
                            fontFamily: 'sf',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: kPrimaryColor,
                          ),
                          children: [
                            TextSpan(
                              text: ' Smartpay',
                              style: TextStyle(
                                fontFamily: 'sf',
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                color: kSecondaryColor,
                              ),
                            ),
                            TextSpan(
                              text: ' account',
                              style: TextStyle(
                                fontFamily: 'sf',
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                color: kPrimaryColor,
                              ),
                            ),
                          ],
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InputBox(
                              controller: _fnameController,
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return 'Full name cannot be empty';
                                }
                                return null;
                              },
                              fillColor: Colors.grey.withOpacity(0.1),
                              hintText: 'Full name',
                              inputType: TextInputType.emailAddress,
                              enabledColor: Colors.transparent,
                              focusedColor: kSecondaryColor,
                            ),
                            SizedBox(
                              height: SizeConfig.minBlockVertical! * 5,
                            ),
                            InputBox(
                              controller: _emailController,
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
                              validator: (value) {
                                String pattern =
                                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                                RegExp regExp = RegExp(pattern);
                                if (value!.trim().isEmpty) {
                                  return 'Password cannot be empty';
                                }
                                if (value.trim().length < 6) {
                                  return 'Password cannot be less than 6 characters';
                                }
                                if (!regExp.hasMatch(value.trim())) {
                                  return 'The password must contain at least one uppercase and number and Special character';
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
                              height: SizeConfig.minBlockVertical! * 3,
                            ),
                            SolidButton(
                              text: "Sign Up",
                              radius: 16,
                              onPressed: () {
                                if (_formState.currentState!.validate()) {
                                  _formState.currentState!.save();
                                  String email = _emailController.text;
                                  String pass = _passwordController.text;
                                  String fname = _fnameController.text;
                                  if (email.trim().isEmpty ||
                                      pass.trim().isEmpty ||
                                      fname.trim().isEmpty) {
                                    // ignore: void_checks
                                    return error(
                                      error: 'Fields cannot be empty',
                                    );
                                  }
                                  Dialogs.showLoadingDialog(context,
                                      key: _dialogKey);
                                  userProvider
                                      .getToken(
                                    email: _emailController.text,
                                  )
                                      .then((value) {
                                    if (value.data == null ||
                                        value.success == false) {
                                      if (value.success == false) {
                                        print("Is False");
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
                                        print("Is True");
                                        displaySuccessMessage(
                                          success:
                                              'Your otp is : ${value.data.toString()}',
                                          context: _dialogKey,
                                          scaffoldKey: _scaffoldKey,
                                          popStack: true,
                                        );
                                        userProvider.setTokenId =
                                            value.data!['token'].toString();

                                        Timer(const Duration(seconds: 1), () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  VerificationScreen(
                                                fname: _fnameController.text,
                                                email: _emailController.text,
                                                pass: _passwordController.text,
                                                token: userProvider.getTokenId,
                                              ),
                                            ),
                                          );
                                        });
                                      }
                                    }
                                  });
                                }

                                // Navigator.pushNamed(
                                //   context,
                                //   SmartScreen.verification,
                                // );
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
                                  onPress: () async {
                                    print(
                                        'device name is ${deviceName.ios(identifier)}');
                                    // device name is iPhone 12 Pro Max

                                    // print(
                                    //     'device name is ${await deviceName.apple(identifier)}');
                                    // device name is iPhone 12 Pro Max
                                  },
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
                      SmartScreen.login,
                    );
                  },
                  child: Text(
                    ' Sign In',
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
