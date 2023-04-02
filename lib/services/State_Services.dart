import 'dart:convert';

import 'package:covid19_case_tracker/services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;

import '../model/World_State_Model.dart';

class StatesServices {
  //for Covid data
  Future<WorldStateModel> fetchWorkedStatesRecords() async {
    final response = await http.get(Uri.parse(AppUrl.worldStateApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStateModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  //for counteris
  //here we Call REST api without model so that's why we use list
  Future<List> countiresStateApi() async {
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error');
    }
  }
}
