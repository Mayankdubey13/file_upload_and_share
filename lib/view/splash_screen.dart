import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../services/splash_services.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SplashServices().isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               Text("Splashh Screen"),
                 SizedBox(height: 10,),
                const Text(
                  "Wheater App",
                  style: TextStyle(
                      fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )),
    );
  }
        }