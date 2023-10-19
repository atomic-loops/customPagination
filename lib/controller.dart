import 'dart:convert';

import 'package:get/get.dart';
import 'package:paginationexp/model.dart';
import 'package:http/http.dart' as http;

class ExampleController extends GetxController {
  late Demomodel demomodel;
  List<Result> result = [];

  bool isLoading = false;
  bool isEmpty = false;

  // Function to fetch additional data for pagination
  getSeconData() async {
    if (demomodel.data.count == result.length) {
      print("empty");
      isEmpty = true;
      isLoading = false;
      update();
    } else {
      try {
        print(result.length);
        isLoading = true;
        update();
        Future.delayed(Duration(seconds: 2), () async {
          final response = await apiCallSecond(demomodel.data.next);
          var data = jsonDecode(response.body);
          if (data["isSuccess"]) {
            demomodel = Demomodel.fromJson(data);

            result.addAll(demomodel.data.results);
            update();
          }

          isLoading = false;
          update();
        });
      } catch (e) {
        print(e);
      }
    }
  }

  // Function to fetch initial data
  Future<Demomodel?> getData() async {
    isLoading = true;
    update();
    final response = await apiCall();
    var data = jsonDecode(response.body);

    if (data["isSuccess"]) {
      demomodel = Demomodel.fromJson(data);

      result = demomodel.data.results;
      update();
      // print(result.length);
      return demomodel;
    }

    // Handle errors here

    isLoading = false;
    update();
    return null;
  }

  // Function to reset flags for pagination state
  changeBool() {
    isEmpty = false;
    isLoading = false;
    update();
  }

  // Function to make an API call
  apiCall() async {
    final response = await http.get(
      Uri.parse('http://192.168.68.122:8000/country/'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    return response;
  }

  apiCallSecond(String url) async {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    return response;
  }
}
