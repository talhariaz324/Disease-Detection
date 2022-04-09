import 'package:disease_detection/provider/patient_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/doctor_provider.dart';

class PatientListAdmin extends StatelessWidget {
  const PatientListAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Doctors doctorsData = Provider.of<Doctors>(context);
    final Patients patientsData = Provider.of<Patients>(context);
    var size = MediaQuery.of(context).size;
    final argu = ModalRoute.of(context)!.settings.arguments as bool;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            argu == true ? 'Patients List' : '+ve Patients List',
            style: TextStyle(color: Theme.of(context).backgroundColor),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: argu == true
            ? FutureBuilder(
                future: patientsData.getAllPatients(),
                builder: (ctx, dataSnapshot) {
                  if (dataSnapshot.connectionState == ConnectionState.waiting) {
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
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: size.width * 0.05),
                      ),
                    );
                  } else if (patientsData.patients.isEmpty) {
                    return Center(
                      child: Text(
                        'No Patient is registerd yet',
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
                            'All Patients List',
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
                        itemCount: patientsData.patients.length,
                        itemBuilder: (ctx, index) {
                          return ChangeNotifierProvider.value(
                            value: patientsData.patients[index],
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(
                                        size.height * 0.05),
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
                                  //   'Report: ${patientsData.patients[index].report}',
                                  //   style: TextStyle(
                                  //       fontWeight: FontWeight.bold,
                                  //       color:
                                  //           Theme.of(context).backgroundColor),
                                  // ),
                                  title: Text(
                                    'Name: ${patientsData.patients[index].nameP}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background),
                                    // textAlign: TextAlign.center,
                                  ),
                                  subtitle: Text(
                                    'Number: ${patientsData.patients[index].numP}',
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
                      ))
                    ]);
                  }
                })
            : FutureBuilder(
                future: doctorsData.showPtoD(),
                builder: (ctx, dataSnapshot) {
                  if (dataSnapshot.connectionState == ConnectionState.waiting) {
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
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: size.width * 0.05),
                      ),
                    );
                  } else if (doctorsData.toDoctor.isEmpty) {
                    return Center(
                      child: Text(
                        'No Patient is registerd yet',
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
                            '+ve Patients List',
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
                                    borderRadius: BorderRadius.circular(
                                        size.height * 0.05),
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Theme.of(context).primaryColor,
                                        Theme.of(context).colorScheme.secondary,
                                      ],
                                    )),
                                child: ListTile(
                                  leading: Text(
                                    'Report: ${doctorsData.toDoctor[index].report}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Theme.of(context).backgroundColor),
                                  ),
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
                      ))
                    ]);
                  }
                }));
  }
}
