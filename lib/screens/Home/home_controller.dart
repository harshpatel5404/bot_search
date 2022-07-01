import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList userlist = [].obs;
  RxList searchlist = [].obs;
  RxBool isloading = false.obs;
  RxBool isSearch = false.obs;
}
