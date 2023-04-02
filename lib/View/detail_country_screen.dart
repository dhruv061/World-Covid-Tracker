import "package:flutter/material.dart";

import 'Word_States.dart';

class DetailCountry_Screenn extends StatefulWidget {
  String name, image;
  int totalcase,
      totalDaths,
      totalRecoverd,
      active,
      critical,
      todayRecovery,
      test;

  DetailCountry_Screenn(
      {super.key,
      required this.name,
      required this.image,
      required this.totalcase,
      required this.totalDaths,
      required this.totalRecoverd,
      required this.active,
      required this.critical,
      required this.todayRecovery,
      required this.test});

  @override
  State<DetailCountry_Screenn> createState() => _DetailCountry_ScreennState();
}

class _DetailCountry_ScreennState extends State<DetailCountry_Screenn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .067),
                  child: Card(
                    child: Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .06),

                        //ResuableRow comes from Word_State_Screen
                        ResuableRow(
                            title: 'Cases', value: widget.totalcase.toString()),
                        ResuableRow(
                            title: 'Recovered',
                            value: widget.totalRecoverd.toString()),
                        ResuableRow(
                            title: 'Deaths',
                            value: widget.totalDaths.toString()),
                        ResuableRow(
                            title: 'Critical',
                            value: widget.critical.toString()),
                        ResuableRow(
                            title: 'active', value: widget.active.toString()),
                        ResuableRow(
                            title: 'Today Recovered',
                            value: widget.todayRecovery.toString()),
                        ResuableRow(
                            title: 'Test', value: widget.test.toString()),
                      ],
                    ),
                  ),
                ),

                //image
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
