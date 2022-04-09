import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/doctor_provider.dart';

class VerifyDoctor extends StatelessWidget {
  const VerifyDoctor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Doctors data = Provider.of<Doctors>(context);
    var indexDoctor = ModalRoute.of(context)!.settings.arguments as int;
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Contact Doctor',
            style: TextStyle(color: Theme.of(context).backgroundColor),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Padding(
          padding: EdgeInsets.only(top: size.height * 0.05),
          child: Column(
            children: [
              Center(
                child: Text(
                  'Doctor Details are given:',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      data.verifyStatus(data.doctors[indexDoctor].idD, true);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Verify'),
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Not Applicable'),
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
