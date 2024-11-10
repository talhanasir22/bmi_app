import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'BmiController.dart';
import 'Config/Theme.dart';
import 'Config/ThemeController.dart';
import 'Genderbtn.dart';
import 'HeightAdjuster.dart' as Height;
import 'SplashPage.dart';
import 'Swipebtn.dart';
import 'WeightAdjuster.dart';
import 'AgeAdjuster.dart' as Age;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'BMI Calculator',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: DarkTheme,
      home: SplashPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double selectedHeight = 250.0; // Default value
  int selectedWeight = 0; // Default value
  String selectedGender = 'Male'; // Default value
  int selectedAge = 0;

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.put(ThemeController());
    BmiController bmiController = Get.put(BmiController());

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 35),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '      BMI\nCalculator',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 11.0,right: 5.0,bottom: 9.0),
                    child: Container(
                      width: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              themeController.Changetheme();
                            },
                            icon: const Icon(Icons.dark_mode),
                          ),
                          IconButton(
                            onPressed: () {
                              themeController.Changetheme();
                            },
                            icon: const Icon(Icons.light_mode),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Genderbutton(
                    icon: Icons.male,
                    btnname: 'MALE',
                    isSelected: selectedGender == 'Male', // Highlight if selected
                    onPress: () {
                      setState(() {
                        selectedGender = 'Male';
                        bmiController.Genderhandle('Male');
                      });
                    },
                  ),
                  const SizedBox(width: 20),
                  Genderbutton(
                    icon: Icons.female,
                    btnname: 'FEMALE',
                    isSelected: selectedGender == 'Female', // Highlight if selected
                    onPress: () {
                      setState(() {
                        selectedGender = 'Female';
                        bmiController.Genderhandle('Female');
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                child: Height.HeightAdjuster(
                  onHeightChanged: (double height) {
                    setState(() {
                      selectedHeight = height;
                    });
                  },
                ),
              ),
              const SizedBox(height: 35),
              SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WeightAdjuster(
                      onWeightChanged: (int weight) {
                        setState(() {
                          selectedWeight = weight;
                        });
                      },
                    ),
                    const SizedBox(width: 20),
                    Age.AgeAdjuster(onAgeChanged: (int age ) {
                      setState(() {
                        selectedAge = age;
                      });
                    },),
                  ],
                ),
              ),
              const SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 60,),
                child: SwipeButton(
                  height: selectedHeight,
                  weight: selectedWeight,
                  gender: selectedGender,
                  age: selectedAge,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
