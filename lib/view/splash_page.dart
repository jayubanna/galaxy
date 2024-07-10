import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(
      Duration(seconds: 4),
      () {
        Navigator.pushReplacementNamed(context, "home_page");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2C494F),
      body: Stack(children: [
        Positioned.fill(
          child: Opacity(
            opacity: 0.8,
            child: Image.asset(
              "assets/galaxy.jpg",
              fit: BoxFit.cover,
            ),
          ),
        ),
        Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 800),
                child: Text(
                  "GALAXY UNIVERSE",
                  style: TextStyle(color: Colors.white, fontSize: 35,fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
