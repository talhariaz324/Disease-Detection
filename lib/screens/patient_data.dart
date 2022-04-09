import 'package:disease_detection/provider/patient_provider.dart';
import 'package:disease_detection/utilities/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/patient_model.dart';
import '../widgets/custom_textformfield.dart';

class PatientData extends StatefulWidget {
  const PatientData({Key? key}) : super(key: key);

  @override
  State<PatientData> createState() => _PDCheckerState();
}

class _PDCheckerState extends State<PatientData> {
  final TextEditingController nameP = TextEditingController();
  final TextEditingController numP = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _disableBtn = false;
  @override
  Widget build(BuildContext context) {
    final patientsProvider = Provider.of<Patients>(context, listen: false);
    var size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(size.height * 0.05),
          child: Form(
            key: _globalKey,
            child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/patientData.png',
                    height: size.height * 0.4,
                    width: double.infinity,
                  ),
                  Text(
                    'Enter Your Data',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: size.height * 0.05,
                        fontStyle: FontStyle.italic,
                        decoration: TextDecoration.underline),
                  ),
                  SizedBox(
                    height: size.height * 0.035,
                  ),
                  CustomTextFormField(
                    controller: nameP,
                    hint: 'Name',
                    label: 'Name',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name';
                      } else if (value.length < 3) {
                        return 'Please enter a valid name';
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(
                    keyboardType: TextInputType.number,
                    controller: numP,
                    hint: 'Number',
                    label: 'Number',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Number';
                      } else if (value.length != 11) {
                        return 'Please Enter Valid Number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  _isLoading
                      ? CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        )
                      : Container(
                          margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: size.height * 0.06,
                                child: Container(
                                  child: Material(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(20),
                                      splashColor: Colors.amber,
                                      onTap: _disableBtn == false
                                          ? () async {
                                              if (_globalKey.currentState!
                                                  .validate()) {
                                                try {
                                                  setState(() {
                                                    _isLoading = true;
                                                    _disableBtn = true;
                                                  });
                                                  await patientsProvider
                                                      .addPatients(
                                                    Patient(
                                                      idP: '',
                                                      nameP: nameP.text,
                                                      numP: numP.text,
                                                      creatorId: '',
                                                    ),
                                                  );
                                                  setState(() {
                                                    _isLoading = false;
                                                  });
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: const Text(
                                                        'Thanks for adding your data'),
                                                    backgroundColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                  ));
                                                } catch (error) {
                                                  await showDialog<void>(
                                                    barrierDismissible: false,
                                                    context: context,
                                                    builder: (ctx) =>
                                                        AlertDialog(
                                                      title: const Text(
                                                          'An error occurred!'),
                                                      content: const Text(
                                                          'Something went wrong.'),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          child: const Text(
                                                              'Okay'),
                                                          onPressed: () {
                                                            setState(() {
                                                              _isLoading =
                                                                  false;
                                                            });
                                                            Navigator.of(ctx)
                                                                .pop();
                                                          },
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                }
                                              }
                                            }
                                          : () {},
                                      child: _disableBtn
                                          ? ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pushNamed(
                                                    MyRoutes
                                                        .testFaceScreenRoute);
                                              },
                                              child: const Text('TEST ME'))
                                          : const Center(
                                              child: Text(
                                                "SAVE",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w700),
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
                        )
                ]),
          ),
        )));
  }
}
