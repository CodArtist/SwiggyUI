
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'mobile_screen.dart';



class OtpPage extends StatefulWidget {
  // const OtpPage({Key key}) : super(key: key);
  var verificationId;
  FirebaseAuth _auth;
 OtpPage(this.verificationId,this._auth);
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {

  String text = '';
  var isLoading=false;

  void _onKeyboardTap(String value) {
    setState(() {
      text = text + value;
    });
  }

  Widget otpNumberWidget(int position) {
    try {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))
        ),
        child: Center(child: Text(text[position], style: TextStyle(color: Colors.black),)),
      );
    } catch (e) {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))
        ),
      );
    }
  }


signInUsingOtp()async{
PhoneAuthCredential phoneAuthCredentials= await PhoneAuthProvider.credential(verificationId: widget.verificationId, smsCode:text);
try{
final authCredentials=await widget._auth.signInWithCredential(phoneAuthCredentials);
if(authCredentials?.user!=null){
  setState(() {
    isLoading=false;
  });
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => MobileScreen()));


}

}on FirebaseAuthException catch(e){
 _scafoldKey.currentState?.showSnackBar(SnackBar(content:Text("erroe occured")));

}

}

  final GlobalKey<ScaffoldState> _scafoldKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
              backgroundColor: Colors.white,
              key:_scafoldKey,
              appBar: AppBar(
                leading: IconButton(
                  icon: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: MyColors.primaryColorLight.withAlpha(20),
                    ),
                    child: Icon(Icons.arrow_back_ios, color: MyColors.primaryColor, size: 16,),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                elevation: 0,
                backgroundColor: Colors.white,
                brightness: Brightness.light,
              ),
              body: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Text('Enter 6 digits verification code sent to your number', style: TextStyle(color: Colors.black, fontSize: 26, fontWeight: FontWeight.w500))
                                ),
                                Container(
                                  constraints: const BoxConstraints(
                                      maxWidth: 500
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      otpNumberWidget(0),
                                      otpNumberWidget(1),
                                      otpNumberWidget(2),
                                      otpNumberWidget(3),
                                      otpNumberWidget(4),
                                      otpNumberWidget(5),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                         isLoading?CircularProgressIndicator(color:Color(0xFFFC8019)) :Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            constraints: const BoxConstraints(
                                maxWidth: 500
                            ),
                            child: RaisedButton(
                              onPressed: () {
                                setState(() {
                                  isLoading=true;
                                });
                                signInUsingOtp();
                                // loginStore.validateOtpAndLogin(context, text);
                              },
                              color:  Color(0xFFFC8019),
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(14))
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('Confirm', style: TextStyle(color: Colors.white),),
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                                        color:  Color(0xFFFC8019),
                                      ),
                                      child: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16,),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          NumericKeyboard(
                            onKeyboardTap: _onKeyboardTap,
                            textColor: MyColors.primaryColorLight,
                            rightIcon: Icon(
                              Icons.backspace,
                              color: MyColors.primaryColorLight,
                            ),
                            rightButtonFn: () {
                              setState(() {
                                text = text.substring(0, text.length - 1);
                              });
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          
  }
}


class MyColors {
  static const Color primaryColor = Color(0xFF503E9D);
  static const Color primaryColorLight = Color(0xFF6252A7);
}