import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:covid19_case_tracker/services/State_Services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import '../model/World_State_Model.dart';
import 'CountriesList.dart';
import 'InternetErrorScreen.dart';

class Word_State_Screen extends StatefulWidget {
  const Word_State_Screen({super.key});

  @override
  State<Word_State_Screen> createState() => _Word_State_ScreenState();
}

class _Word_State_ScreenState extends State<Word_State_Screen>
    with TickerProviderStateMixin {
  //for animated pichart || Spinkit effect
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  //colour codes
  final colorList = [
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];

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
    //for calling data
    StatesServices statesServices = StatesServices();

    if (isConnected) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .01),

                //Data call from API
                FutureBuilder(
                  future: statesServices.fetchWorkedStatesRecords(),
                  builder: (context, AsyncSnapshot<WorldStateModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50.0,
                          controller: _controller,
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          //for showing data in PI Chart
                          PieChart(
                            dataMap: {
                              //in api we have data in numeric value so we can parse it
                              "Total":
                                  double.parse(snapshot.data!.cases.toString()),
                              "Recoverd": double.parse(
                                  snapshot.data!.recovered.toString()),
                              "Deaths": double.parse(
                                  snapshot.data!.deaths.toString()),
                            },

                            //for showing data in Percentage
                            chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true,
                            ),
                            chartRadius:
                                MediaQuery.of(context).size.width / 3.2,
                            legendOptions: LegendOptions(
                              legendPosition: LegendPosition.left,
                            ),
                            animationDuration: Duration(seconds: 2),
                            chartType: ChartType.ring,
                            colorList: colorList,
                          ),

                          //for table
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * .06),
                            child: Card(
                              child: Column(
                                children: [
                                  ResuableRow(
                                      title: 'Total',
                                      value: snapshot.data!.cases.toString()),
                                  ResuableRow(
                                      title: 'Deaths',
                                      value: snapshot.data!.deaths.toString()),
                                  ResuableRow(
                                      title: 'Recoverd',
                                      value:
                                          snapshot.data!.recovered.toString()),
                                  ResuableRow(
                                      title: 'Active',
                                      value: snapshot.data!.active.toString()),
                                  ResuableRow(
                                      title: 'Critical',
                                      value:
                                          snapshot.data!.critical.toString()),
                                  ResuableRow(
                                      title: 'Today Deaths',
                                      value: snapshot.data!.todayDeaths
                                          .toString()),
                                  ResuableRow(
                                      title: 'Today Recoverd',
                                      value: snapshot.data!.todayRecovered
                                          .toString()),
                                ],
                              ),
                            ),
                          ),

                          //for countery || Track Button
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CountriesList_Screen()));
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Color(0xff1aa260),
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Center(
                                child: Text('Track Countires'),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return InternetErrorScreen();
    }
  }
}

//for use multiple time
class ResuableRow extends StatelessWidget {
  String title, value;
  ResuableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(height: 5),
          Divider(),
        ],
      ),
    );
  }
}
