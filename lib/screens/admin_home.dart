import 'package:disease_detection/widgets/admin_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';
import '../provider/doctor_provider.dart';

import '../utilities/routes.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final Doctors dataD = Provider.of<Doctors>(context);
    // final Patients dataP = Provider.of<Patients>(context);
    return Scaffold(
        drawer: const MyDrawer(),
        appBar: AppBar(
          title: Text(
            'Admin DashBoard',
            style: TextStyle(color: Theme.of(context).backgroundColor),
          ),
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
        body: Padding(
          padding: EdgeInsets.only(top: size.height * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Doctors List:',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.05),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              FutureBuilder(
                  future: dataD.fetchAndSetDoctor(),
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
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: size.width * 0.05),
                        ),
                      );
                    } else if (dataD.doctors.isEmpty) {
                      return Center(
                        child: Text(
                          'No result found',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
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
                                      borderRadius: BorderRadius.circular(
                                          size.height * 0.05),
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Theme.of(context).primaryColor,
                                          Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ],
                                      )),
                                  child: ListTile(
                                      leading: Text(
                                        'Ver: ${dataD.doctors[index].verified}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .backgroundColor),
                                      ),
                                      title: Text(
                                        'Name: ${dataD.doctors[index].nameD}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .background),
                                        // textAlign: TextAlign.center,
                                      ),
                                      subtitle: Text(
                                        'Edu: ${dataD.doctors[index].eduD}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .background),
                                      ),
                                      trailing: IconButton(
                                          onPressed: () async {
                                            Navigator.of(context).pushNamed(
                                                MyRoutes.verifyD,
                                                arguments: index);
                                          },
                                          icon: const Icon(Icons.remove_red_eye,
                                              color: Colors.greenAccent))),
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
