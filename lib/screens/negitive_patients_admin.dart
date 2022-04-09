// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../provider/doctor_provider.dart';
// import '../provider/patient_provider.dart';

// class NegitivePatients extends StatelessWidget {
//   const NegitivePatients({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final Doctors doctorsData = Provider.of<Doctors>(context);
//     final Patients patientsData = Provider.of<Patients>(context);
//     var size = MediaQuery.of(context).size;
  

//     return Scaffold(
//         appBar: AppBar(),
//         body: FutureBuilder(
//             future: compLists(),
//             builder: (ctx, dataSnapshot) {
//               if (dataSnapshot.connectionState == ConnectionState.waiting) {
//                 return Center(
//                   child: CircularProgressIndicator(
//                     color: Theme.of(context).primaryColor,
//                   ),
//                 );
//               } else if (dataSnapshot.connectionState == ConnectionState.none) {
//                 return Center(
//                   child: Text(
//                     'Error Occured',
//                     style: TextStyle(
//                         color: Theme.of(context).colorScheme.secondary,
//                         fontSize: size.width * 0.05),
//                   ),
//                 );
//               } else if (negPatients1.isEmpty) {
//                 return Center(
//                   child: Text(
//                     'No Patient is registerd yet',
//                     style: TextStyle(
//                         color: Theme.of(context).colorScheme.secondary,
//                         fontSize: size.width * 0.05,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 );
//               } else {
//                 return Column(children: [
//                   Padding(
//                     padding: EdgeInsets.only(top: size.height * 0.05),
//                     child: Center(
//                       child: Text(
//                         '+ve Patients List',
//                         style: TextStyle(
//                             color: Theme.of(context).primaryColor,
//                             fontWeight: FontWeight.bold,
//                             fontSize: size.width * 0.08),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: size.height * 0.03,
//                   ),
//                   Expanded(
//                       child: ListView.builder(
//                     itemCount: negPatients1.length,
//                     itemBuilder: (ctx, index) {
//                       return ChangeNotifierProvider.value(
//                         value: negPatients1[index],
//                         child: Padding(
//                           padding: const EdgeInsets.all(20.0),
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 shape: BoxShape.rectangle,
//                                 borderRadius:
//                                     BorderRadius.circular(size.height * 0.05),
//                                 gradient: LinearGradient(
//                                   begin: Alignment.topLeft,
//                                   end: Alignment.bottomRight,
//                                   colors: [
//                                     Theme.of(context).primaryColor,
//                                     Theme.of(context).colorScheme.secondary,
//                                   ],
//                                 )),
//                             child: ListTile(
//                               leading: Text(
//                                 'Report: ${negPatients1[index]}',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Theme.of(context).backgroundColor),
//                               ),
//                               title: Text(
//                                 'Name: ${doctorsData.toDoctor[index].nameP}',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Theme.of(context)
//                                         .colorScheme
//                                         .background),
//                                 // textAlign: TextAlign.center,
//                               ),
//                               subtitle: Text(
//                                 'Number: ${doctorsData.toDoctor[index].numP}',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Theme.of(context)
//                                         .colorScheme
//                                         .background),
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ))
//                 ]);
//               }
//             }));
//   }
// }
