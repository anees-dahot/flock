import 'package:flock/features/splash%20screen/repository/splash_repository.dart';
import 'package:flock/utils/storage.dart';
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
    initialization();
    super.initState();
  }
    void initialization() async {
    final List<String>? images =
        await Storage().deleteList('images') as List<String>?;
    if (images != null) {
      // Check if images is not null
      print(images.length);
    } else {
      print('No images found'); // Handle the null case
    }
    await Storage().saveDate('visibilityType', 'Public');
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
