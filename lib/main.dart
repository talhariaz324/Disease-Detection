import 'package:camera/camera.dart';
import 'package:disease_detection/provider/auth_provider.dart';
import 'package:disease_detection/provider/doctor_provider.dart';
import 'package:disease_detection/provider/patient_provider.dart';
import 'package:disease_detection/screens/admin_home.dart';
import 'package:disease_detection/screens/doctor_dashboard.dart';
import 'package:disease_detection/screens/doctor_data.dart';
import 'package:disease_detection/screens/hired_doctor_detail.dart';
import 'package:disease_detection/screens/p_dchecker.dart';
import 'package:disease_detection/screens/patient_data.dart';
import 'package:disease_detection/screens/patients_lists_admin.dart';
import 'package:disease_detection/screens/test_face.dart';

import 'package:disease_detection/screens/login_screen.dart';
import 'package:disease_detection/screens/sign_up.dart';
import 'package:disease_detection/screens/splash_screen.dart';
import 'package:disease_detection/screens/verify_d.dart';
import 'package:disease_detection/utilities/routes.dart';
import 'package:disease_detection/widgets/camera_hand.dart';
import 'package:disease_detection/widgets/result.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

late List<CameraDescription> cameras;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    throw ('Error: $e.code\nError Message: $e.message');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Patients>(
          create: (_) => Patients(null, null, []),
          update: (ctx, auth, previousPatients) => Patients(
            auth.userId,
            auth.token,
            previousPatients == null ? [] : previousPatients.patients,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, Doctors>(
          create: (_) => Doctors(null, null, []),
          update: (ctx, auth, previousPatients) => Doctors(
            auth.userId,
            auth.token,
            previousPatients == null ? [] : previousPatients.doctors,
          ),
        )
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: GoogleFonts.libreBaskervilleTextTheme(
                  // Theme.of(context).textTheme,

                  ),
              backgroundColor: const Color(0xFFEEEEEE),
              cardColor: const Color.fromRGBO(4, 174, 175, 1),
              hintColor: Colors.white,
              primaryColor: const Color(0xFF8e0438),
              visualDensity: VisualDensity.adaptivePlatformDensity,
              colorScheme:
                  const ColorScheme.light(secondary: Color(0xFFc9366c)),
              appBarTheme: const AppBarTheme(
                color: Colors.white,
                elevation: 0,
                iconTheme:
                    IconThemeData(color: Color.fromRGBO(255, 255, 255, 1)),
                titleTextStyle: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  // fontFamily: ,
                ),
              ),
              iconTheme: const IconThemeData(
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
            ),
            home:
                // TestFace(cameras),
                // // CameraHands(cameras),
                // // Result(),
                // // DoctorData(),
                auth.userId == 'yXgMrjutKnY69b9NkxOHkcxxtUC3'
                    ? const AdminHome()
                    : auth.isAuth &&
                            auth.userId == 'yXgMrjutKnY69b9NkxOHkcxxtUC3'
                        ? const AdminHome()
                        : auth.isAuth
                            ? const MySplashScreen()
                            : FutureBuilder(
                                future: auth.autoLogin(),
                                builder: (ctx, snapShot) => snapShot
                                            .connectionState ==
                                        ConnectionState.waiting
                                    ? Center(
                                        child: CircularProgressIndicator(
                                        color: Theme.of(context).primaryColor,
                                      ))
                                    : const Login(),
                              ),
            routes: {
              MyRoutes.mainFile: (context) => const MyApp(),
              MyRoutes.splashScreenRoute: (context) => const MySplashScreen(),
              MyRoutes.signInScreenRoute: (context) => const Login(),
              MyRoutes.signUpScreenRoute: (context) => const SignUp(),
              MyRoutes.testFaceScreenRoute: (context) => TestFace(cameras),
              MyRoutes.result: (context) => const Result(),
              MyRoutes.pdChecker: (context) => const PDChecker(),
              MyRoutes.patientData: (context) => const PatientData(),
              MyRoutes.doctorData: (context) => const DoctorData(),
              MyRoutes.handTest: (context) => CameraHands(cameras),
              MyRoutes.hiredDetail: (context) => const HiredDetail(),
              MyRoutes.doctorDashBoard: (context) => const DoctorDashBoard(),
              MyRoutes.verifyD: (context) => const VerifyDoctor(),
              MyRoutes.patientListAdmin: (context) => const PatientListAdmin(),
              // MyRoutes.negitiveP: (context) => const NegitivePatients(),
            }),
      ),
    );
  }
}
