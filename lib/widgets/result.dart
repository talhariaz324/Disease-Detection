import 'package:disease_detection/models/patient_model.dart';
import 'package:disease_detection/provider/auth_provider.dart';
import 'package:disease_detection/provider/doctor_provider.dart';
import 'package:disease_detection/provider/patient_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utilities/routes.dart';

class Result extends StatelessWidget {
  const Result({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var sumData = ModalRoute.of(context)!.settings.arguments;
    final Doctors dataD = Provider.of<Doctors>(context);
    final Patients dataP = Provider.of<Patients>(context);
    // final Auth auth = Provider.of<Auth>(context);

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('Result Screen'),
          automaticallyImplyLeading: false,
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
        body: sumData == 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'Object not found',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w900,
                          fontSize: size.width * 0.05),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.08,
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: size.height * 0.09,
                          child: Container(
                            child: Material(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(50),
                                splashColor: Colors.amber,
                                onTap: () {
                                  Navigator.of(context).pushReplacementNamed(
                                      MyRoutes.testFaceScreenRoute);
                                },
                                child: const Center(
                                  child: Text(
                                    "FACE TEST",
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
                    height: size.height * 0.08,
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: size.height * 0.09,
                          child: Container(
                            child: Material(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(50),
                                splashColor: Colors.amber,
                                onTap: () {
                                  Navigator.of(context)
                                      .pushReplacementNamed(MyRoutes.handTest);
                                },
                                child: const Center(
                                  child: Text(
                                    "HAND TEST",
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
                    height: size.height * 0.02,
                  ),
                  Center(
                    child: Text(
                      'THANKS FOR USING OUR APP',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * 0.05),
                    ),
                  ),
                ],
              )
            : sumData == 17 || sumData == 34
                ? SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(size.height * 0.04),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              'Result is: Negitive',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w900,
                                  fontSize: size.width * 0.05),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.08,
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  height: size.height * 0.09,
                                  child: Container(
                                    child: Material(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(50),
                                        splashColor: Colors.amber,
                                        onTap: () {
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  MyRoutes.testFaceScreenRoute);
                                        },
                                        child: const Center(
                                          child: Text(
                                            "FACE TEST",
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
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.08,
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height: size.height * 0.09,
                                  child: Container(
                                    child: Material(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(50),
                                        splashColor: Colors.amber,
                                        onTap: () {
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  MyRoutes.handTest);
                                        },
                                        child: const Center(
                                          child: Text(
                                            "HAND TEST",
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
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: size.height * 0.001,
                              left: size.height * 0.02,
                              right: size.height * 0.02,
                              bottom: size.height * 0.02,
                            ),
                            child: Text(
                              "Here are tips from the American Academy of Pediatrics: \n\n 1) Know wandering triggers. \n\n 2) Secure your home—regardless of your child's age. \n\n 3) Work on communication and behavior strategies. \n\n 4) Set expectations. \n\n 5) Consider monitoring \n\n 6) Technology and identification.",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  // fontWeight: FontWeight.bold,
                                  fontSize: size.width * 0.05),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Center(
                            child: Text(
                              'THANKS FOR USING OUR APP',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.width * 0.05),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(top: size.height * 0.1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'Result is: Positive',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w900,
                                fontSize: size.width * 0.05),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.08,
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    height: size.height * 0.09,
                                    child: Container(
                                      child: Material(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          splashColor: Colors.amber,
                                          onTap: () {
                                            Navigator.of(context)
                                                .pushReplacementNamed(MyRoutes
                                                    .testFaceScreenRoute);
                                          },
                                          child: const Center(
                                            child: Text(
                                              "FACE TEST",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: size.height * 0.05,
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    height: size.height * 0.09,
                                    child: Container(
                                      child: Material(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          splashColor: Colors.amber,
                                          onTap: () {
                                            Navigator.of(context)
                                                .pushReplacementNamed(
                                                    MyRoutes.handTest);
                                          },
                                          child: const Center(
                                            child: Text(
                                              "HAND TEST",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.08,
                        ),
                        Text(
                          'Recommended Doctors:',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: size.width * 0.05),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        FutureBuilder(
                            future: dataD.fetchAndSetDoctortoP(),
                            builder: (ctx, dataSnapshot) {
                              if (dataSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                );
                              } else if (dataSnapshot.connectionState ==
                                  ConnectionState.none) {
                                return Center(
                                  child: Text(
                                    'Error Occured',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        fontSize: size.width * 0.05),
                                  ),
                                );
                              } else if (dataD.doctors.isEmpty) {
                                return Center(
                                  child: Text(
                                    'No result found',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        fontSize: size.width * 0.05),
                                  ),
                                );
                              } else {
                                return Expanded(
                                  child: ListView.builder(
                                    itemCount: dataD.doctors.length,
                                    itemBuilder: (ctx, index) {
                                      return ChangeNotifierProvider.value(
                                        value: dataD.doctors[index],
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        size.height * 0.05),
                                                gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Theme.of(context)
                                                        .primaryColor,
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .secondary,
                                                  ],
                                                )),
                                            child: ListTile(
                                                leading: Text(
                                                  'Exp: ${dataD.doctors[index].expD} \n\n Fees: RS 100',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Theme.of(context)
                                                          .backgroundColor),
                                                ),
                                                title: Text(
                                                  'Name: ${dataD.doctors[index].nameD}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .background),
                                                  // textAlign: TextAlign.center,
                                                ),
                                                subtitle: Text(
                                                  'Edu: ${dataD.doctors[index].eduD}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .background),
                                                ),
                                                trailing: IconButton(
                                                    onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder:
                                                              (ctx) =>
                                                                  AlertDialog(
                                                                    title: const Text(
                                                                        'Are you sure you want to hire this doctor?'),
                                                                    actions: <
                                                                        Widget>[
                                                                      TextButton(
                                                                        child: const Text(
                                                                            'Yes'),
                                                                        onPressed:
                                                                            () async {
                                                                          await dataD.addPtoD(
                                                                              Patient(idP: '', nameP: dataP.patients[0].nameP, numP: dataP.patients[0].numP, creatorId: dataP.userId),
                                                                              dataD.doctors[index].idD,
                                                                              dataD.doctors[index].verified,
                                                                              report: 'Positive');

                                                                          Navigator.of(context)
                                                                              .pop();
                                                                          Navigator.of(context).pushNamed(
                                                                              MyRoutes.hiredDetail,
                                                                              arguments: index);
                                                                        },
                                                                      ),
                                                                      TextButton(
                                                                        child: const Text(
                                                                            'No'),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                      )
                                                                    ],
                                                                  ));
                                                    },
                                                    icon: const Icon(
                                                        Icons.remove_red_eye,
                                                        color: Colors
                                                            .greenAccent))),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }
                            }),
                      ],
                    ),
                  ));
  }
}
