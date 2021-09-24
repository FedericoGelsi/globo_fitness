import 'package:flutter/material.dart';
import 'package:globo_fitness/shared/bottom_navbar.dart';
import 'package:globo_fitness/shared/menu_drawer.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({Key? key}) : super(key: key);

  @override
  _BmiScreenState createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  final double fontSize = 18;
  String result = '';
  bool isMetric = true;
  bool isImperial = false;
  double? height;
  double? weight;
  late List<bool> isSelected;
  final TextEditingController txtHeight = TextEditingController();
  final TextEditingController txtWeight = TextEditingController();

  @override
  void initState() {
    isSelected = [isMetric, isImperial];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String heightMessage =
        'Please insert your height in ' + ((isMetric) ? 'meters' : 'inches');
    String weightMessage =
        'Please insert your weight in ' + ((isMetric) ? 'kilograms' : 'pounds');
    return Scaffold(
      appBar: AppBar(title: Text('BMI Calculator')),
      drawer: MenuDrawer(),
      bottomNavigationBar: BottomMenu(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ToggleButtons(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Metric',
                    style: TextStyle(fontSize: fontSize),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Imperial',
                    style: TextStyle(fontSize: fontSize),
                  ),
                ),
              ],
              isSelected: isSelected,
              onPressed: toggleMeasure,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: txtHeight,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: heightMessage),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: txtWeight,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: weightMessage),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: ElevatedButton(
                  onPressed: findBMI,
                  child: Text(
                    'Calculate BMI',
                    style: TextStyle(fontSize: fontSize),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                result,
                style: TextStyle(fontSize: fontSize),
              ),
            )
          ],
        ),
      ),
    );
  }

  void toggleMeasure(value) {
    if (value == 0) {
      isMetric = true;
      isImperial = false;
    } else {
      isMetric = false;
      isImperial = true;
    }
    setState(() {
      isSelected = [isMetric, isImperial];
    });
  }

  void findBMI() {
    double bmi = 0;
    double height = double.tryParse(txtHeight.text) ?? 0;
    double weight = double.tryParse(txtWeight.text) ?? 0;
    if (isMetric){
      bmi = weight / (height * height);
    }else{
      bmi = weight * 703 / (height * height);
    }
    setState(() {
      result = 'Your BMI is ' + bmi.toStringAsFixed(2);
    });
  }
}
