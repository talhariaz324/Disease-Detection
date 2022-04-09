import 'package:disease_detection/models/doctor_model.dart';
import 'package:disease_detection/provider/doctor_provider.dart';
// import 'package:disease_detection/provider/patient_provider.dart';

import 'package:disease_detection/utilities/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_textformfield.dart';

class DoctorData extends StatefulWidget {
  const DoctorData({Key? key}) : super(key: key);

  @override
  State<DoctorData> createState() => _PDCheckerState();
}

class _PDCheckerState extends State<DoctorData> {
  final TextEditingController nameD = TextEditingController();
  final TextEditingController eduD = TextEditingController();
  final TextEditingController expD = TextEditingController();
  final TextEditingController numD = TextEditingController();
  final TextEditingController addressD = TextEditingController();
  final TextEditingController idDD = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _globalKey2 = GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final doctorProvider = Provider.of<Doctors>(context);
    // final patientProvider = Provider.of<Patients>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(size.height * 0.05),
          child: Form(
            key: _globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image.asset(
                //   'assets/images/patientData.png',
                //   height: size.height * 0.15,
                //   width: double.infinity,
                // ),
                Text(
                  'Enter Your Profile',
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
                  controller: nameD,
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
                  controller: eduD,
                  hint: 'Education',
                  label: 'Education',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your education';
                    } else if (value.length < 3) {
                      return 'Please enter a valid education';
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  controller: expD,
                  hint: 'Experience',
                  label: 'Experience',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your experience';
                    } else if (value.length < 3) {
                      return 'Please enter a valid experience';
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  keyboardType: TextInputType.number,
                  controller: numD,
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
                CustomTextFormField(
                  controller: addressD,
                  hint: 'Address',
                  label: 'Address',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Address';
                    } else if (value.length < 5) {
                      return 'Please Enter Valid Address';
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
                                    onTap: () async {
                                      if (_globalKey.currentState!.validate()) {
                                        try {
                                          setState(() {
                                            _isLoading = true;
                                          });
                                          final id =
                                              await doctorProvider.addDoctors(
                                            Doctor(
                                                idD: '',
                                                nameD: nameD.text,
                                                eduD: eduD.text,
                                                expD: expD.text,
                                                numD: numD.text,
                                                adressD: addressD.text,
                                                creatorId: '',
                                                verified: false),
                                          );
                                          setState(() {
                                            _isLoading = false;
                                          });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: const Text(
                                                'Thanks for adding your profile'),
                                            backgroundColor:
                                                Theme.of(context).primaryColor,
                                          ));
                                          showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                    backgroundColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                    title: Text(
                                                      'Note your id! Its important',
                                                      style: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .backgroundColor),
                                                    ),
                                                    content: FittedBox(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'ID: $id',
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .greenAccent),
                                                          ),
                                                          SizedBox(
                                                            width: size.width *
                                                                0.043,
                                                          ),
                                                          IconButton(
                                                              onPressed: () =>
                                                                  Clipboard.setData(ClipboardData(
                                                                          text:
                                                                              id))
                                                                      .then(
                                                                          (_) {
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(const SnackBar(
                                                                            content:
                                                                                Text("ID copied to clipboard")));
                                                                  }),
                                                              icon: const Icon(
                                                                Icons.copy,
                                                                color: Colors
                                                                    .greenAccent,
                                                              ))
                                                        ],
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child: Text(
                                                          'NOTED',
                                                          style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .backgroundColor),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.of(ctx)
                                                              .pop();
                                                        },
                                                      )
                                                    ],
                                                  ));
                                        } catch (error) {
                                          await showDialog<void>(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (ctx) => AlertDialog(
                                              title: const Text(
                                                  'An error occurred!'),
                                              content: const Text(
                                                  'Something went wrong.'),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text('Okay'),
                                                  onPressed: () {
                                                    setState(() {
                                                      _isLoading = false;
                                                    });
                                                    Navigator.of(ctx).pop();
                                                  },
                                                )
                                              ],
                                            ),
                                          );
                                        }
                                      }
                                    },
                                    child: const Center(
                                      child: Text(
                                        "SAVE",
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
                Text(
                  'Done Added profile then enter id',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                Form(
                  key: _globalKey2,
                  child: CustomTextFormField(
                    controller: idDD,
                    hint: 'ID',
                    label: 'ID',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter ID';
                      } else if (!value.startsWith('-')) {
                        return 'Please Enter Valid ID';
                      }
                      return null;
                    },
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    if (_globalKey2.currentState!.validate()) {
                      try {
                        // await doctorProvider.showPtoD(myId: idDD.text);
                        Navigator.pushNamed(
                          context,
                          MyRoutes.doctorDashBoard,
                          arguments: idDD.text,
                        );
                      } catch (error) {
                        await showDialog<void>(
                          barrierDismissible: false,
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('An error occurred!'),
                            content: const Text('Something went wrong.'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Okay'),
                                onPressed: () {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  Navigator.of(ctx).pop();
                                },
                              )
                            ],
                          ),
                        );
                      }
                    }
                  },
                  child: const Text('Show DashBoard'),
                  style: TextButton.styleFrom(
                      primary: Theme.of(context).primaryColor),
                ),
              ],
            ),
          ),
        )));
  }
}
