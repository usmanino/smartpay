import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:smartplay/controller/controller.dart';
import 'package:smartplay/core/styles.dart';
import 'package:smartplay/router/app_router.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({Key? key}) : super(key: key);

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _cpassController = TextEditingController();
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _dialogKey = GlobalKey<State>();

  bool isPassWordEmpty1 = true;
  bool isPassWordEmpty2 = true;

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
                            'Create New Password',
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
                            'Please, enter a new password below different from the previous password',
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
                                  controller: _passController,
                                  onChanged: (val) {
                                    if (val.trim().isEmpty &&
                                        val.trim().length < 6) {
                                      setState(() {
                                        isPassWordEmpty1 = true;
                                      });
                                    } else {
                                      setState(() {
                                        isPassWordEmpty1 = false;
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
                                  hintText: 'password',
                                  inputType: TextInputType.text,
                                  enabledColor: Colors.transparent,
                                  focusedColor: kSecondaryColor,
                                ),
                                SizedBox(
                                  height: SizeConfig.minBlockVertical! * 5,
                                ),
                                InputBox(
                                  controller: _cpassController,
                                  onChanged: (val) {
                                    if (val.trim().isEmpty &&
                                        val.trim().length < 6) {
                                      setState(() {
                                        isPassWordEmpty2 = true;
                                      });
                                    } else {
                                      setState(() {
                                        isPassWordEmpty2 = false;
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
                                  hintText: 'Confirm password',
                                  inputType: TextInputType.text,
                                  enabledColor: Colors.transparent,
                                  focusedColor: kSecondaryColor,
                                ),
                                SizedBox(
                                  height: SizeConfig.minBlockVertical! * 2,
                                ),
                                SizedBox(
                                  height: SizeConfig.minBlockVertical! * 3,
                                ),
                                isPassWordEmpty1 == true ||
                                        isPassWordEmpty2 == true
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
                                            'Create new password',
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
                                        text: "Create new password",
                                        radius: 16,
                                        onPressed: () {
                                          Dialogs.showLoadingDialog(
                                            context,
                                            key: _dialogKey,
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
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.minBlockVertical! * 2,
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
                      Image.asset('assets/images/lock.png'),
                      SizedBox(
                        height: SizeConfig.minBlockVertical! * 5.0,
                      ),
                      Text(
                        "New Password Created",
                        style: GoogleFonts.poppins(
                          color: kPrimaryColor,
                          fontSize: 20.0.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: SizeConfig.minBlockVertical! * 2.0,
                      ),
                      Text(
                        "Hey Anabel, your password has been successfuly updated.",
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
                              Navigator.pushReplacementNamed(
                                  context, SmartScreen.login);
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
