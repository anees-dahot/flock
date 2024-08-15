import 'package:flock/features/splash%20screen/repository/splash_repository.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashRepository splashRepository = SplashRepository();
  @override
  void initState() {
    splashRepository.redirectUser(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            CircularProgressIndicator(), 
          ],
        ),
      ),
    );
  }
}
