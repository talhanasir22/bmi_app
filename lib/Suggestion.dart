import 'package:flutter/material.dart';

class SuggestionScreen extends StatelessWidget {
  final String gender;
  final double bmi;
  final int age;
  const SuggestionScreen({
    Key? key,
    required this.gender,
    required this.bmi,
    required this.age,
  }) : super(key: key);

  String getDietPlan() {
    if (bmi < 18.5) {
      return 'For a high-calorie diet that supports health and vitality, incorporate nutrient-dense foods such as avocados, nuts, lean meats, and whole grains. Avocados offer healthy monounsaturated fats and essential vitamins, while nuts provide a rich source of healthy fats and protein. Lean meats, like chicken and turkey, supply high-quality protein necessary for muscle growth and repair. Whole grains, including quinoa and brown rice, deliver complex carbohydrates, fiber, and additional protein, ensuring sustained energy and overall well-being. This combination not only increases caloric intake but also supports balanced nutrition.';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return 'For a balanced diet, focus on incorporating a variety of fruits, vegetables, lean proteins, and whole grains into your meals while maintaining your current intake levels. Fruits and vegetables provide essential vitamins, minerals, and fiber, which support overall health and digestion. Lean proteins, such as chicken, fish, and legumes, are vital for muscle maintenance and repair, while whole grains like quinoa, brown rice, and oats offer sustained energy and additional nutrients. By ensuring a diverse and well-rounded intake of these food groups, you can maintain nutritional balance and support your overall well-being.';
    } else if (bmi >= 25.0 && bmi < 29.9) {
      return 'A low-calorie diet should emphasize vegetables, fruits, lean proteins, and whole grains while avoiding processed foods and sugary drinks. Vegetables and fruits provide essential nutrients and fiber with minimal calories. Lean proteins, such as chicken, fish, and legumes, help maintain muscle mass and keep you feeling full. Whole grains, like brown rice and quinoa, offer sustained energy and additional fiber. Steering clear of processed foods and sugary drinks helps reduce unnecessary calories and added sugars, supporting better overall health and weight management.';
    } else {
      return 'Adopt a low-calorie, nutrient-dense diet by concentrating on vegetables, fruits, lean proteins, and whole grains. Prioritize foods that are rich in essential nutrients while minimizing calorie intake. Reduce consumption of sugar, salt, and unhealthy fats to improve overall health and support weight management. This approach helps ensure you receive vital nutrients without excess calories, promoting better health and sustainable weight control.';
    }
  }

  String getExercisePlan() {
    if (bmi < 18.5) {
      return 'Incorporate light strength training and resistance exercises to build muscle effectively. Focus on body weight squats to target the legs and glutes, push-ups for chest and triceps, and dumbbell rows to strengthen the back and biceps. Include lunges to work the legs and glutes, bicep curls for arm strength, and tricep dips to enhance the upper arms. Add planks to engage the core and use a leg press machine to target the lower body. Gradually increase resistance and weights as you progress to continue challenging your muscles and promoting growth.';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return 'Engage in regular exercise by incorporating a balanced mix of cardiovascular, strength training, and flexibility exercises. Aim for at least 150 minutes of moderate-intensity exercise each week. This includes activities like brisk walking, cycling, or jogging for cardiovascular health, combined with strength training exercises such as weight lifting or bodyweight exercises to build muscle. Complement these with flexibility exercises like stretching or yoga to improve range of motion and prevent injuries. This holistic approach supports overall fitness, enhances endurance, and contributes to a healthy lifestyle.';
    } else if (bmi >= 25.0 && bmi < 29.9) {
      return 'Engage in cardio-focused exercises like running, cycling, and swimming to improve cardiovascular health and endurance. Complement this with strength training sessions 2-3 times a week to build muscle and enhance overall strength. This combination ensures a well-rounded fitness regimen, promoting both aerobic fitness and muscular development.';
    } else {
      return 'Incorporate low-impact exercises like walking, swimming, or cycling into your routine to reduce stress on your joints while enhancing cardiovascular health and endurance. These activities provide a gentle yet effective way to stay active, especially for those new to exercise or recovering from injury. Start with a light intensity to avoid overexertion, and gradually increase the duration and intensity as your fitness level improves. Additionally, incorporate strength training exercises into your regimen as tolerated. These can help build muscle strength and support overall fitness, creating a well-rounded approach to physical activity that is sustainable and beneficial in the long term.';
    }
  }

  @override
  Widget build(BuildContext context) {
    String dietPlan = getDietPlan();
    String exercisePlan = getExercisePlan();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Diet & Exercise Suggestions',style: TextStyle(fontSize: 20,color: Colors.white),),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_ios),color: Colors.white,),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Gender: $gender',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'BMI: ${bmi.toStringAsFixed(1)}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Age: $age',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                'Suggested Diet Plan:',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(height: 10),
              Text(
                dietPlan,
                style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 20),
              Text(
                'Suggested Exercise Plan:',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(height: 10),
              Text(
                exercisePlan,
                style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
