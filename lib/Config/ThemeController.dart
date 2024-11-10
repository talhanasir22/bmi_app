import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ThemeController extends GetxController{

  RxBool isDark = false.obs;

  void Changetheme() async{
    isDark.value = !isDark.value;

    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light );
  }
}