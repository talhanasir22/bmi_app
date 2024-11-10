import 'package:get/get.dart';

class BmiController extends GetxController{
  RxString gender = 'Male'.obs;
  void Genderhandle(String Gender){
    gender.value = Gender;
  }
}