import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/doctor_provider.dart';

class HiredDetail extends StatelessWidget {
  const HiredDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Doctors data = Provider.of<Doctors>(context);
    var indexDoctor = ModalRoute.of(context)!.settings.arguments as int;
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Contact Doctor'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Padding(
          padding: EdgeInsets.only(top: size.height * 0.05),
          child: Column(
            children: [
              Center(
                child: Text(
                  'Contact your Doctor by using below details',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.043),
                ),
              ),
              SizedBox(
                height: size.height * 0.2,
              ),
              Text(
                'Name: ${data.doctors[indexDoctor].nameD}',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.06),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                'Number: ${data.doctors[indexDoctor].numD}',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.06),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                'Address: ${data.doctors[indexDoctor].adressD}',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.06),
              ),
              SizedBox(
                height: size.height * 0.2,
              ),
              Text(
                'Thanks for using our app',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.05),
              ),
            ],
          ),
        ));
  }
}
