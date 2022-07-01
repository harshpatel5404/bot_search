import 'package:bot_search/services/api_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    ApiServices.getUserDetails();
  }

  HomeController homeController = Get.put(HomeController());
  TextEditingController searchController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height * 0.03,
              ),
              const Text(
                "Search",
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              TextFormField(
                controller: searchController,
                onChanged: (val) {
                  if (searchController.text == "") {
                    homeController.isSearch.value = false;
                    homeController.searchlist.clear();
                  }
                  homeController.isSearch.value = true;
                  homeController.searchlist.clear();
                  homeController.userlist.forEach((name) {
                    name
                            .toString()
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase())
                        ? homeController.searchlist.add(name)
                        : null;
                  });
                },
                decoration: const InputDecoration(
                  hintText: "search",
                  labelStyle:  TextStyle(color: Color(0xff969696)),
                  focusedBorder:  OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.black,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              const Text(
                "ALL RESULTS",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Obx(
                () => homeController.isSearch.value &&
                        homeController.searchlist.isEmpty
                    ? const Center(
                        child: const Text("Search Not Found"),
                      )
                    : const SizedBox(),
              ),
              Obx(
                () => homeController.userlist.isNotEmpty
                    ? GridView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.8,
                          mainAxisSpacing: 20,
                        ),
                        itemCount: homeController.isSearch.value
                            ? homeController.searchlist.length
                            : homeController.userlist.length,
                        itemBuilder: (BuildContext context, int index) {
                          print(homeController.searchlist);

                          return Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2, color: Colors.black)),
                              padding: const EdgeInsets.all(5),
                              child: homeController.isSearch.value
                                  ? Column(
                                      children: [
                                        Container(
                                          height: Get.height * 0.2,
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                            color: Colors.blue.shade200,
                                          ),
                                          child: Image.network(
                                            "https://robohash.org/${homeController.searchlist[index]["img"]}",
                                          ),
                                        ),
                                        Text(
                                          "${homeController.searchlist[index]["name"]}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        Container(
                                            height: Get.height * 0.2,
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                            color: Colors.blue.shade200,
                                          ),
                                          child: Image.network(
                                            "https://robohash.org/${homeController.userlist[index]["img"]}",
                                          ),
                                        ),
                                        Text(
                                          "${homeController.userlist[index]["name"]}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ));
                        },
                      )
                    : const Center(child: const CircularProgressIndicator()),
              )
            ],
          ),
        ),
      )),
    );
  }
}
