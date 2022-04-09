import 'package:disease_detection/models/http_exception.dart';
import 'package:disease_detection/provider/auth_provider.dart';
import 'package:disease_detection/utilities/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  void showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              backgroundColor: Theme.of(context).backgroundColor,
              title: Text(
                'An Error Occurred!',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              content: Text(
                message,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    'Okay',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            ));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      // SignUp
      await Provider.of<Auth>(context, listen: false)
          .signUp(_authData['email'], _authData['password']);
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'Not vaild email';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find email';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password';
      }
      showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage = 'Please try again later';
      showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 3;

  double getBiglDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 7 / 8;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(
        children: <Widget>[
          Positioned(
            right: -getSmallDiameter(context) / 3,
            top: -getSmallDiameter(context) / 3,
            child: Container(
              width: getSmallDiameter(context),
              height: getSmallDiameter(context),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).colorScheme.secondary
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            ),
          ),
          Positioned(
            left: -getBiglDiameter(context) / 4,
            top: -getBiglDiameter(context) / 4,
            child: Container(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: size.width * 0.1, top: size.height * 0.1),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        // fontFamily: "Pacifico",
                        fontSize: 40,
                        color: Theme.of(context).hintColor),
                  ),
                ),
              ),
              width: getBiglDiameter(context),
              height: getBiglDiameter(context),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).colorScheme.secondary
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            ),
          ),
          Positioned(
            right: -getBiglDiameter(context) / 2,
            bottom: -getBiglDiameter(context) / 2,
            child: Container(
              width: getBiglDiameter(context),
              height: getBiglDiameter(context),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.background),
            ),
          ),
          Hero(
              tag: 'SignUp',
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ListView(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).hintColor,
                          //border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.fromLTRB(20, 300, 20, 10),
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 25),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration: InputDecoration(
                                icon: Icon(
                                  Icons.email,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade100)),
                                labelText: "Email",
                                enabledBorder: InputBorder.none,
                                labelStyle: const TextStyle(color: Colors.grey),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty || !value.contains('@')) {
                                  return 'Invalid email!';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _authData['email'] = value!;
                              },
                            ),
                            TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.vpn_key,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade100)),
                                  labelText: "Password",
                                  enabledBorder: InputBorder.none,
                                  labelStyle:
                                      const TextStyle(color: Colors.grey)),
                              controller: _passwordController,
                              validator: (value) {
                                if (value!.isEmpty || value.length < 5) {
                                  return 'Password is too short!';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _authData['password'] = value!;
                              },
                            ),
                            TextFormField(
                                obscureText: true,
                                decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.vpn_key,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade100)),
                                    labelText: "Confirm Password",
                                    enabledBorder: InputBorder.none,
                                    labelStyle:
                                        const TextStyle(color: Colors.grey)),
                                validator: (value) {
                                  if (value != _passwordController.text) {
                                    return 'Passwords do not match!';
                                  }
                                  return null;
                                })
                          ],
                        ),
                      ),
                    ),
                    // Align(
                    //     alignment: Alignment.centerRight,
                    //     child: Container(
                    //         margin: const EdgeInsets.fromLTRB(0, 0, 20, 10),
                    //         child: Text(
                    //           "FORGOT PASSWORD?",
                    //           style: TextStyle(
                    //               color:
                    //                   Theme.of(context).colorScheme.secondary,
                    //               fontSize: 11),
                    //         ))),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: 40,
                            child: _isLoading
                                ? CircularProgressIndicator(
                                    color: Theme.of(context).primaryColor,
                                  )
                                : Container(
                                    child: Material(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(20),
                                        splashColor: Colors.amber,
                                        onTap: () {
                                          _submit();
                                        },
                                        child: const Center(
                                          child: Text(
                                            "SIGN UP",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        gradient: LinearGradient(
                                            colors: [
                                              Theme.of(context).primaryColor,
                                              Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter)),
                                  ),
                          ),
                          // FloatingActionButton(
                          //   onPressed: () {},
                          //   mini: true,
                          //   elevation: 0,
                          //   child: const Image(
                          //     image: AssetImage("assets/facebook2.png"),
                          //   ),
                          // ),
                          // FloatingActionButton(
                          //   onPressed: () {},
                          //   mini: true,
                          //   elevation: 0,
                          //   child: const Image(
                          //     image: AssetImage("assets/twitter.png"),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "ALREADY HAVE AN ACCOUNT ? ",
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(MyRoutes.signInScreenRoute);
                          },
                          child: Text(
                            'SIGN IN',
                            style: TextStyle(
                                fontSize: 11,
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}




// UI idea taken from flutterawesome.com