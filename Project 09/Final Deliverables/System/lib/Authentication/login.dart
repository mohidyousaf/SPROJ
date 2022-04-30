import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:petswala/Authentication/signup.dart';
import 'package:petswala/Repository/channel_page.dart';
import 'package:petswala/Repository/networkHandler.dart';
import 'package:petswala/Repository/users_list_page.dart';
import 'package:petswala/bloc/login_bloc.dart';
import 'package:petswala/bloc/login_bloc.dart';
import 'package:petswala/themes/colors.dart';
import 'package:petswala/themes/fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

// This is the login page of our app where validation is added in every field for instance email should be valid that is done by using regex and similarly other constraints,
// the login button will be disabled unless all validations errors are solved and user name and password is correct.

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _client = StreamChatClient('pz93j7x2ygtm', logLevel: Level.INFO);
  NetworkHandler network = NetworkHandler();
  bool visible = true;
  bool a = false;
  bool circular = true;
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<LoginBloc>(context, listen: false);
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 138, 128, 1),
      body: Form(
        key: _formKey,
        child: GestureDetector(
          onTap: () {
            FocusNode currentfocus = FocusScope.of(context);
            if (!currentfocus.hasPrimaryFocus) {
              currentfocus.unfocus();
            }
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Sign Up.png'),
                alignment: Alignment.topLeft,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'WELCOME BACK',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color.fromRGBO(250, 250, 250, 1),
                          fontFamily: 'Roboto',
                          fontSize: 24,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.bold,
                          height: 1),
                    ),
                    SizedBox(height: 20),
                    StreamBuilder<String>(
                        stream: bloc.userName,
                        builder: (context, AsyncSnapshot<String> snapshot) {
                          return TextField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                hintText: 'Enter User Name',
                                labelText: 'User Name',
                                errorText: snapshot.error,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onChanged: (value) async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString('name', value);
                              print('user name updated ');
                              print(prefs.getString('name'));
                              bloc.changeUserName(value);
                            },
                          );
                        }),
                    SizedBox(height: 20),
                    StreamBuilder<String>(
                        stream: bloc.password,
                        builder: (context, AsyncSnapshot<String> snapshot) {
                          return TextField(
                            obscureText: visible,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 10),
                                fillColor: Colors.white,
                                filled: true,
                                hintText: 'Enter Password',
                                labelText: 'Password',
                                errorText: snapshot.error,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                suffix: IconButton(
                                  icon: visible
                                      ? Icon(Icons.visibility)
                                      : Icon(Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      visible = !visible;
                                    });
                                  },
                                )),
                            onChanged: (value) => {bloc.changePassword(value)},
                          );
                        }),
                    SizedBox(height: 20),
                    StreamBuilder<bool>(
                        stream: bloc.isValid,
                        builder: (context, snapshot) {
                          return GestureDetector(
                            onTap: snapshot.hasError
                                ? null
                                : () async {
                                    FocusNode currentfocus =
                                        FocusScope.of(context);
                                    if (!currentfocus.hasPrimaryFocus) {
                                      currentfocus.unfocus();
                                    }
                                    setState(() {
                                      circular = false;
                                    });
                                    var temp = await bloc.submit();
                                    print(temp.text);
                                    if (temp.val) {
                                      setState(() {
                                        circular = true;
                                      });
                                      // StreamChatClient client = await getChatClient();
                                      // Channel channel = await navigateToChannel(client, 'adilslam7', 'mohid');
                                      // Navigator.of(context).push(
                                      // MaterialPageRoute(builder: (context) => ChatNavigator(client: client),
                                      //           settings: RouteSettings(name: '/channel',arguments: channel)),);
                                      String page = '';
                                      if (temp.text == "Simple User"){
                                        page = '/home';
                                      }
                                      else if (temp.text == "Shelter"){
                                        page = '/shelterHome';
                                      }
                                      else if (temp.text == "Vet"){
                                        page = '/vetHome';
                                      }
                                      else if (temp.text == "Seller"){
                                        page = '/sellerHome';
                                      }
                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.setString('type', temp.text);
                                      Navigator.pushNamed(context, page);
                                    } else {
                                      setState(() {
                                        circular = true;
                                      });
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Dialog(
                                              alignment: Alignment.bottomCenter,
                                              backgroundColor: Colors.white24,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Container(
                                                height: 70,
                                                width: 50,
                                                child: Center(
                                                  child: Text(
                                                      'User Name or Password not correct',
                                                      style: AppFont.bodySmall(
                                                          AppColor.white)),
                                                ),
                                              ),
                                            );
                                          });
                                    }
                                  },
                            child: circular
                                ? Container(
                                    width: 300,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                      color: snapshot.hasError
                                          ? Colors.grey
                                          : Color.fromRGBO(85, 68, 119, 1),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 20),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          'Sign In',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 1),
                                              fontFamily: 'Lato',
                                              fontSize: 15,
                                              letterSpacing: 1.25,
                                              fontWeight: FontWeight.normal,
                                              height: 1),
                                        ),
                                      ],
                                    ),
                                  )
                                : CircularProgressIndicator(),
                          );
                        }),
                    SizedBox(height: 20),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(text: 'Don\'t have an account?'),
                      WidgetSpan(child: SizedBox(width: 5)),
                      TextSpan(
                          text: 'Register',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // ignore: todo
                              //TODO: NAVIAGTE
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()));
                            })
                    ])),
                    SizedBox(height: 36),
                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            primary: AppColor.primary_light,
                            onPrimary: AppColor.black,
                            minimumSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onPressed: () async {
                          var user = await signIn();
                          if (user != null)
                            Navigator.pushNamed(context, '/boarding');
                        },
                        icon: Image.asset('assets/Google.png'),
                        label: Text('Sign up with Google'))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future signIn() async {
  final user = await GoogleSignInApi.login();
  print(user.displayName);
  Map<String, String> data = {
    'name': user.displayName,
    'email': user.email,
    'password': ''
  };

  print(data);
  NetworkHandler nw = NetworkHandler();
  nw.post('user/register', data);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('name', user.displayName);
  await GoogleSignInApi.logout();
  return user;
}

class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn();
  static Future<GoogleSignInAccount> login() => _googleSignIn.signIn();
  static Future logout() => _googleSignIn.disconnect();
}
