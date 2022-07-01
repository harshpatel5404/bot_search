import 'dart:convert';
import 'package:bot_search/screens/Home/home_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static HomeController homeController = Get.put(HomeController());
  static Future getUserDetails() async {
    const baseUrl = "https://jsonplaceholder.typicode.com";
    homeController.userlist.clear();
    homeController.isloading.value = true;
    try {
      final response = await http.get(Uri.parse('$baseUrl/users'), headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
      });

      if (response.statusCode == 200) {
        List userinfo = [];
        var data = jsonDecode(response.body);
        userinfo = data;
        for (var i = 0; i < userinfo.length; i++) {
          homeController.userlist.add({"name": userinfo[i]["name"], "img": i});
        }

        print(homeController.userlist);
        homeController.isloading.value = false;
        print(data);
      }
    } catch (e) {
      print(e.toString());
      return "Something went wrong!";
    }
  }
}
