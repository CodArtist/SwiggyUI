import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swiggy_ui/views/tab_desktop/tab_screen.dart';

import 'shared/app_theme.dart';
import 'views/tab_desktop/desktop_screen.dart';
import 'views/mobile/mobile_screen.dart';
import 'widgets/responsive.dart';
import 'package:get/get.dart';
import 'views/mobile/Login.dart';
import 'package:firebase_core/firebase_core.dart';
void main()async{
 WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SwiggyUI',
      debugShowCheckedModeBanner: false,
      theme: appPrimaryTheme(),
      home: const Responsive(
        mobile:InitializeWidget(),
        tablet: TabScreen(),
        desktop: DesktopScreen(),
      ),
    );
  }
}

class InitializeWidget extends StatefulWidget {
  const InitializeWidget({ Key? key }) : super(key: key);

  @override
  _InitializeWidgetState createState() => _InitializeWidgetState();
}

class _InitializeWidgetState extends State<InitializeWidget> {
  var isLoading=true;
  late FirebaseAuth _auth;
  late final _user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth=FirebaseAuth.instance;
    _user=_auth.currentUser;
    setState(() {
      isLoading=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return isLoading?Scaffold(
      body: Center(child:CircularProgressIndicator(color:Color(0xFFFC8019))),
    ):_user==null?Login():MobileScreen();
    
  }
}