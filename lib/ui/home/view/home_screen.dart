import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:smartplay/controller/controller.dart';
import 'package:smartplay/core/size_config.dart';
import 'package:smartplay/core/styles.dart';
import 'package:smartplay/services/network_services.dart';
import 'package:smartplay/ui/auth/login/view/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _dialogKey = GlobalKey<State>();

  @override
  void initState() {
    // TODO: implement initState
  }
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.minBlockVertical! * 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Welcome ${userProvider.user.full_name}",
                    style: TextStyle(
                      fontFamily: 'sf',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  InkResponse(
                    onTap: () async {
                      Dialogs.showLoadingDialog(context, key: _dialogKey);
                      await userProvider.logout();
                      print(userProvider.status == UserStatus.authenticated);
                      Timer(const Duration(seconds: 3), () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      });
                    },
                    child: const Icon(
                      Icons.logout,
                      color: kDangerColor,
                    ),
                  )
                ],
              ),
              SizedBox(height: SizeConfig.minBlockVertical! * 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email : ${userProvider.user.email}'),
                  SizedBox(height: SizeConfig.minBlockVertical! * 3),
                  Text('Country : ${userProvider.user.country}'),
                  SizedBox(height: SizeConfig.minBlockVertical! * 3),
                  Text(
                    'secret message : ${userProvider.setTok = userProvider.tok.toString()}',
                    style: TextStyle(
                      fontSize: 12.sp,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
