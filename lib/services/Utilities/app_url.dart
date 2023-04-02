//here we put link of API so we can use in all the project easily

class AppUrl {
  //this is endpoint of API
  static const String baseUrl = "https://disease.sh/v3/covid-19/";

  //fetchd world cobid states
  static const String worldStateApi =
      baseUrl + 'all'; //here we use commen link that's via we write link/all
  static const String countriesList = baseUrl + 'countries'; // link/countries
}
