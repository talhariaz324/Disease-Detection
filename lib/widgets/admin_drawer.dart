import 'package:flutter/material.dart';

import '../utilities/routes.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Drawer(
        backgroundColor: const Color.fromARGB(57, 0, 0, 0),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).colorScheme.secondary,
                ],
              )),
              child: Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.015,
                    left: size.height * 0.015,
                    right: size.height * 0.015),
                child: Text(
                  'Hello Admin!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).backgroundColor,
                    fontSize: size.height * 0.03,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            UserAccountsDrawerHeader(
              currentAccountPicture: Padding(
                padding: EdgeInsets.only(bottom: size.height * 0.005),
                child: const CircleAvatar(
                  foregroundImage: NetworkImage(
                      'https://previews.123rf.com/images/ismagilov/ismagilov1904/ismagilov190401823/121455928-serious-man-in-suit-holding-laptop-computer-with-facial-recognition-and-biometric-verification-techn.jpg'),
                ),
              ),
              accountName: Text(
                '',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(
                '',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold),
              ),
              currentAccountPictureSize:
                  Size(size.height * 0.1, size.width * 0.3),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).colorScheme.secondary,
                ],
              )),
            ),
            Padding(
              padding: EdgeInsets.all(size.height * 0.025),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(size.height * 0.05),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).colorScheme.secondary,
                    ],
                  ),
                ),
                child: ListTile(
                  leading: Icon(Icons.data_saver_on_sharp,
                      color: Theme.of(context).appBarTheme.backgroundColor),
                  title: Text(
                    'All Patients',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).appBarTheme.backgroundColor),
                  ),
                  onTap: () async {
                    await Navigator.of(context).pushNamed(
                        MyRoutes.patientListAdmin,
                        arguments: true); // true for all patients
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(size.height * 0.025),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(size.height * 0.05),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).colorScheme.secondary,
                    ],
                  ),
                ),
                child: ListTile(
                  leading: Icon(Icons.data_saver_on_sharp,
                      color: Theme.of(context).appBarTheme.backgroundColor),
                  title: Text(
                    '+ve Patients List ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).appBarTheme.backgroundColor),
                  ),
                  onTap: () async {
                    await Navigator.of(context).pushNamed(
                        MyRoutes.patientListAdmin,
                        arguments:
                            false); // false for patients who are +ve and hired some doctor
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.all(size.height * 0.025),
            //   child: Container(
            //     decoration: BoxDecoration(
            //       shape: BoxShape.rectangle,
            //       borderRadius: BorderRadius.circular(size.height * 0.05),
            //       gradient: LinearGradient(
            //         begin: Alignment.topLeft,
            //         end: Alignment.bottomRight,
            //         colors: [
            //           Theme.of(context).primaryColor,
            //           Theme.of(context).colorScheme.secondary,
            //         ],
            //       ),
            //     ),
            //     child: ListTile(
            //       leading: Icon(Icons.data_saver_on_sharp,
            //           color: Theme.of(context).appBarTheme.backgroundColor),
            //       title: Text(
            //         '-ve Patients List ',
            //         style: TextStyle(
            //             fontWeight: FontWeight.bold,
            //             color: Theme.of(context).appBarTheme.backgroundColor),
            //       ),
            //       onTap: () async {
            //         await Navigator.of(context).pushNamed(MyRoutes
            //             .negitiveP); // false for patients who are +ve and hired some doctor
            //         Navigator.of(context).pop();
            //       },
            //     ),
            //   ),
            // ),
          ],
        ));
  }
}
