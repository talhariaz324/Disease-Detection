import 'package:disease_detection/provider/doctor_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';
import '../utilities/routes.dart';

class DoctorDashBoard extends StatelessWidget {
  const DoctorDashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final Patients patientData = Provider.of<Patients>(context);
    final Doctors doctorsData = Provider.of<Doctors>(context);
    var size = MediaQuery.of(context).size;
    var id = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
        appBar: AppBar(
          title: const Text('DashBoard'),
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(MyRoutes.mainFile);
                  Provider.of<Auth>(context, listen: false).logout();
                },
                child: Text(
                  'Logout',
                  style: TextStyle(
                      color: Theme.of(context).backgroundColor,
                      fontWeight: FontWeight.bold),
                )),
          ],
        ),
        body: FutureBuilder(
            future: doctorsData.showPtoD(myId: id),
            builder: (ctx, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                );
              } else if (dataSnapshot.connectionState == ConnectionState.none) {
                return Center(
                  child: Text(
                    'Error Occured',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: size.width * 0.05),
                  ),
                );
              } else if (doctorsData.toDoctor.isEmpty) {
                return Center(
                  child: Text(
                    'Nobody hired you yet',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.bold),
                  ),
                );
              } else {
                return Column(children: [
                  Padding(
                    padding: EdgeInsets.only(top: size.height * 0.05),
                    child: Center(
                      child: Text(
                        'Your Patients',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.08),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Expanded(
                      child: ListView.builder(
                    itemCount: doctorsData.toDoctor.length,
                    itemBuilder: (ctx, index) {
                      return ChangeNotifierProvider.value(
                        value: doctorsData.toDoctor[index],
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.circular(size.height * 0.05),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Theme.of(context).primaryColor,
                                    Theme.of(context).colorScheme.secondary,
                                  ],
                                )),
                            child: ListTile(
                              // leading: Text(
                              //   'Exp: ${patientData.toDoctor[index].expD}',
                              //   style: TextStyle(
                              //       fontWeight: FontWeight.bold,
                              //       color: Theme.of(context)
                              //           .backgroundColor),
                              // ),
                              title: Text(
                                'Name: ${doctorsData.toDoctor[index].nameP}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background),
                                // textAlign: TextAlign.center,
                              ),
                              subtitle: Text(
                                'Number: ${doctorsData.toDoctor[index].numP}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background),
                              ),
                            ),
                          ),
                        ),
                      );
                    },

                    //     Column(
                    //   children: [
                    //     Padding(
                    //       padding: EdgeInsets.only(top: size.height * 0.05),
                    //       child: Center(
                    //         child: Text(
                    //           'Your Patients',
                    //           style: TextStyle(
                    //               color: Theme.of(context).primaryColor,
                    //               fontWeight: FontWeight.bold,
                    //               fontSize: size.width * 0.08),
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       height: size.height * 0.03,
                    //     ),
                    //     Expanded(
                    //       child: ListView.builder(
                    //         itemCount: doctorsData.toDoctor.length,
                    //         itemBuilder: (context, index) {
                    //           return Card(
                    //             elevation: 5,
                    //             color: Theme.of(context).primaryColor,
                    //             child: ListTile(
                    //               title: Text(
                    //                 'Name: ${doctorsData.toDoctor[index].nameP}',
                    //                 style: TextStyle(
                    //                     fontWeight: FontWeight.bold,
                    //                     color: Theme.of(context).colorScheme.background),
                    //                 // textAlign: TextAlign.center,
                    //               ),
                    //               subtitle: Text(
                    //                 'Number: ${doctorsData.toDoctor[index].numP}',
                    //                 style: TextStyle(
                    //                     fontWeight: FontWeight.bold,
                    //                     color: Theme.of(context).colorScheme.background),
                    //               ),
                    //             ),
                    //           );
                    //         },
                    //       ),
                    //     )
                    //   ],
                    // )
                  ))
                ]);
              }
            }));
  }
}
