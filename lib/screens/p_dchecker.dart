import 'package:disease_detection/utilities/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/auth_provider.dart';

class PDChecker extends StatefulWidget {
  const PDChecker({Key? key}) : super(key: key);

  @override
  State<PDChecker> createState() => _PDCheckerState();
}

class _PDCheckerState extends State<PDChecker> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.pushNamed(context, MyRoutes.testFaceScreenRoute);
    } else {
      await prefs.setBool('seen', true);
      Navigator.pushNamed(context, MyRoutes.patientData);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Material(
      child: SafeArea(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(MyRoutes.mainFile);
                    Provider.of<Auth>(context, listen: false).logout();
                  },
                  child: Text(
                    'Logout',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.05),
                    textAlign: TextAlign.start,
                  )),
              FittedBox(
                fit: BoxFit.cover,
                child: Image.asset(
                  'assets/images/PDchecker.png',
                  height: size.height * 0.5,
                  width: size.width * 0.5,
                ),
              ),
              Text(
                'Who are you?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: size.height * 0.05,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: size.height * 0.09,
                      child: Container(
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            splashColor: Colors.amber,
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(MyRoutes.patientData);
                            },
                            child: const Center(
                              child: Text(
                                "PATIENT",
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
                                  Theme.of(context).colorScheme.secondary,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: size.height * 0.09,
                      child: Container(
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            splashColor: Colors.amber,
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(MyRoutes.doctorData);
                            },
                            child: const Center(
                              child: Text(
                                "DOCTOR",
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
                                  Theme.of(context).colorScheme.secondary,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)),
                      ),
                    )
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
