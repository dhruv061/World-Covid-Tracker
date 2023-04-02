import 'package:covid19_case_tracker/services/State_Services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'detail_country_screen.dart';

class CountriesList_Screen extends StatefulWidget {
  const CountriesList_Screen({super.key});

  @override
  State<CountriesList_Screen> createState() => _CountriesList_ScreenState();
}

class _CountriesList_ScreenState extends State<CountriesList_Screen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: GestureDetector(
          //for disble keybors -- when user tap on screen
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            children: [
              //Search Box
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {});
                  },
                  controller: searchController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    hintText: "Search with country name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ),

              //list of country
              Expanded(
                child: FutureBuilder(
                  future: statesServices.countiresStateApi(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    //if data not loaded
                    if (!snapshot.hasData) {
                      //show shimmer effect
                      return ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey.shade700,
                              highlightColor: Colors.grey.shade100,
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Container(
                                      height: 10,
                                      width: 89,
                                      color: Colors.white,
                                    ),
                                    subtitle: Container(
                                      height: 10,
                                      width: 89,
                                      color: Colors.white,
                                    ),
                                    leading: Container(
                                      height: 60,
                                      width: 60,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            //for searching the country
                            String name = snapshot.data![index]['country'];

                            if (searchController.text.isEmpty) {
                              //show all country
                              return Column(
                                children: [
                                  //when user touch one iteam the  go in detail that's why we use InkWell
                                  InkWell(
                                    onTap: () {
                                      //go and send data to detail countery scren
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailCountry_Screenn(
                                            image: snapshot.data![index]
                                                ['countryInfo']['flag'],
                                            name: snapshot.data![index]
                                                ['country'],
                                            totalcase: snapshot.data![index]
                                                ['cases'],
                                            totalRecoverd: snapshot.data![index]
                                                ['recovered'],
                                            totalDaths: snapshot.data![index]
                                                ['deaths'],
                                            active: snapshot.data![index]
                                                ['active'],
                                            test: snapshot.data![index]
                                                ['tests'],
                                            todayRecovery: snapshot.data![index]
                                                ['todayRecovered'],
                                            critical: snapshot.data![index]
                                                ['critical'],
                                          ),
                                        ),
                                      );
                                    },

                                    //for showing list we use list tile
                                    child: ListTile(
                                      title: Text(
                                          snapshot.data![index]['country']),
                                      subtitle: Text(snapshot.data![index]
                                              ['cases']
                                          .toString()),
                                      leading: Image(
                                          height: 60,
                                          width: 60,
                                          image: NetworkImage(
                                              snapshot.data![index]
                                                  ['countryInfo']['flag'])),
                                    ),
                                  ),
                                ],
                              );
                            } else if (name.toLowerCase().contains(
                                searchController.text.toLowerCase())) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      //when user search and touch countery that time also they goto detail screen
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailCountry_Screenn(
                                            image: snapshot.data![index]
                                                ['countryInfo']['flag'],
                                            name: snapshot.data![index]
                                                ['country'],
                                            totalcase: snapshot.data![index]
                                                ['cases'],
                                            totalRecoverd: snapshot.data![index]
                                                ['recovered'],
                                            totalDaths: snapshot.data![index]
                                                ['deaths'],
                                            active: snapshot.data![index]
                                                ['active'],
                                            test: snapshot.data![index]
                                                ['tests'],
                                            todayRecovery: snapshot.data![index]
                                                ['todayRecovered'],
                                            critical: snapshot.data![index]
                                                ['critical'],
                                          ),
                                        ),
                                      );
                                    },
                                    child: ListTile(
                                      title: Text(
                                          snapshot.data![index]['country']),
                                      subtitle: Text(snapshot.data![index]
                                              ['cases']
                                          .toString()),
                                      leading: Image(
                                          height: 60,
                                          width: 60,
                                          image: NetworkImage(
                                              snapshot.data![index]
                                                  ['countryInfo']['flag'])),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Container();
                            }
                          });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
