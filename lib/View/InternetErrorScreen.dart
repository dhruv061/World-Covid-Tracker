import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'Word_States.dart';

class InternetErrorScreen extends StatefulWidget {
  InternetErrorScreen({super.key});

  @override
  State<InternetErrorScreen> createState() => _InternetErrorScreenState();
}

class _InternetErrorScreenState extends State<InternetErrorScreen> {
  //for Internet Connectivity Check
  Connectivity _connectivity = Connectivity();
  bool isConnected = false;

  Future checkInternetConnection() async {
    var connectivityResult = await _connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile) {
      //Phone have internet Connection
      isConnected = true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      //phone connected to wifi
      isConnected = true;
    } else {
      isConnected = false;
    }
    setState(() {});
  }

  @override
  void initState() {
    checkInternetConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 68, 63, 63),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height * .2),
              child: Container(
                // color: Colors.red,
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.5,
                child: Image.asset('assets/images/NoInternet.png'),
              ),
            ),
            Center(
              child: Text(
                'Please Check Your Internet connection',
                style: TextStyle(fontSize: 20),
              ),
            ),

            //button
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .06),
              child: TextButton(
                onPressed: () {
                  checkInternetConnection();
                  if (isConnected) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Word_State_Screen()));

                    setState(() {
                      isConnected = true;
                    });
                  }
                },
                child: Container(
                  height: 50,
                  width: 90,
                  decoration: BoxDecoration(
                      color: Color(0xff1aa260),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      'OK',
                      style: TextStyle(fontSize: 22, color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
