import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'OtpPage.dart';
class Login extends StatefulWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController phoneController=TextEditingController();
  String verificationId="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      phoneController.text="+91";
    });
  }

  final GlobalKey<ScaffoldState> _scafoldKey=GlobalKey();
  var isLoading=false;
  FirebaseAuth _auth =FirebaseAuth.instance;
  handleOtp(phoneNumber)async{
    setState(() {
      isLoading=true;
    });
    if(phoneNumber!=""&&phoneNumber!=null&&phoneNumber.length==13){
    await _auth.verifyPhoneNumber(phoneNumber: phoneNumber,
     verificationCompleted:(phoneCredentials)async{
      setState(() {
       isLoading=false;
         });
   Navigator.of(context).push(MaterialPageRoute(builder: (_) => OtpPage(verificationId,_auth)));

     },
    
      verificationFailed:(verificationFailed)async{
        _scafoldKey.currentState?.showSnackBar(SnackBar(content:Text("verification Failed")));
        setState(() {
          isLoading=false;
        });

      },
       codeSent:(verificationid,resendingToken)async{
       setState(() {
         isLoading=false;
         verificationId=verificationid;
       });
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => OtpPage(verificationId,_auth)));

       },
        codeAutoRetrievalTimeout: (verificationId)async{

        });
    }
    else{
    _scafoldKey.currentState?.showSnackBar(SnackBar(content:Text("Please Write Valid number")));

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafoldKey,
              backgroundColor: Colors.white,
              // key: loginStore.loginScaffoldKey,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                child: Stack(
                                  children: <Widget>[
                                    Center(
                                      child: Container(
                                        height: 240,
                                        constraints: const BoxConstraints(
                                          maxWidth: 500
                                        ),
                                        margin: const EdgeInsets.only(top: 100),
                                        decoration: const BoxDecoration(color: Color(0xFFFC8019), borderRadius: BorderRadius.all(Radius.circular(30))),
                                      ),
                                    ),
                                    Center(
                                      child: Container(
                                          constraints: const BoxConstraints(maxHeight: 340),
                                          margin: const EdgeInsets.symmetric(horizontal: 8),
                                          child: Image.asset('assets/icons/pngwing.com.png')),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Text('SWIGGY',
                                      style: TextStyle(color: Color(0xFFFC8019), fontSize: 30, fontWeight: FontWeight.w900)))
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              Container(
                                  constraints: const BoxConstraints(
                                      maxWidth: 500
                                  ),
                                  margin: const EdgeInsets.symmetric(horizontal: 10),
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(children: <TextSpan>[
                                      TextSpan(text: 'We will send you an ', style: TextStyle(color:Colors.black)),
                                      TextSpan(
                                          text: 'One Time Password ', style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold)),
                                      TextSpan(text: 'on this mobile number', style: TextStyle(color: MyColors.primaryColor)),
                                    ]),
                                  )),
                              Container(
                                height: 40,
                                constraints: const BoxConstraints(
                                  maxWidth: 500
                                ),
                                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                child: CupertinoTextField(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(Radius.circular(4))
                                  ),
                                  controller: phoneController,
                                  clearButtonMode: OverlayVisibilityMode.editing,
                                  keyboardType: TextInputType.phone,
                                  maxLines: 1,
                                  placeholder: '+91...',
                                ),
                              ),
                              isLoading?CircularProgressIndicator(color:Color(0xFFFC8019),):Container(
                                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                constraints: const BoxConstraints(
                                    maxWidth: 500
                                ),
                                child: RaisedButton(
                                  onPressed: () {
                                    handleOtp(phoneController.text);
                              
                                  },
                                  color: Color(0xFFFC8019),
                                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14))),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Next',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                                            color: Color(0xFFFC8019),
                                          ),
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
         
  }
}

