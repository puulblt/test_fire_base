import 'package:test_fire_base/Pages/loginPage.dart';
import 'package:test_fire_base/Back/UserProfile.dart';
import 'package:test_fire_base/Pages/AppBar.dart';
import 'package:test_fire_base/Pages/Scanner.dart';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:dotted_border/dotted_border.dart';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AcceuilPage extends StatefulWidget {
  const AcceuilPage({super.key});

  @override
  State<AcceuilPage> createState() => _AcceuilPageState();
}

class _AcceuilPageState extends State<AcceuilPage> {
  // Utilisateur connecté
  final user = FirebaseAuth.instance.currentUser;

  UserProfile? userProfile;

  // Liste de jours de la semaine
  final List<String> daysOfWeek = [
    'Lundi',
    'Mardi',
    'Mercredi',
    'Jeudi',
    'Vendredi',
    'Samedi',
    'Dimanche'
  ];

  final List<FlSpot> dummyData1 = List.generate(7, (index) {
    final xValue = index
        .toDouble(); // Les valeurs de l'axe X correspondent aux jours de la semaine
    final yValue = 40 +
        Random().nextDouble() *
            60; // Les valeurs de l'axe Y sont comprises entre 40 et 100

    return FlSpot(xValue, yValue);
  });

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: Text(
              "Bonjour ${userProfile?.firstName}",
              style: const TextStyle(
                fontFamily: "futura",
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xffde3211),
                height: 32 / 24,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30, bottom: 20),
            child: const Text(
              "Récapitulatif de votre semaine",
              style: TextStyle(
                fontFamily: "futura",
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xff000000),
                height: 19 / 14,
                decoration: TextDecoration.underline,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Center(
            child: SizedBox(
                //padding: const EdgeInsets.all(20),
                width: 320,
                height: 170,
                child: LineChart(
                  LineChartData(
                    maxY: 100,
                    minY: 0,
                    borderData: FlBorderData(
                        border: const Border(
                            bottom: BorderSide(), left: BorderSide())),
                    gridData:
                        const FlGridData(horizontalInterval: 20, show: true),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(sideTitles: _leftTitles),
                      bottomTitles: AxisTitles(
                        sideTitles: _bottomTitles,
                      ),
                      topTitles: const AxisTitles(
                          sideTitles: SideTitles(
                        showTitles: false,
                      )),
                      rightTitles: const AxisTitles(
                          sideTitles: SideTitles(
                        showTitles: false,
                      )),
                    ),
                    lineBarsData: [
                      // The red line
                      LineChartBarData(
                        spots: dummyData1,
                        dotData: FlDotData(
                          show: true,
                          getDotPainter: (spot, percent, barData, index) =>
                              FlDotCirclePainter(
                                  radius: 2,
                                  color: Colors.indigo,
                                  strokeColor: Colors.indigo),
                        ),
                        isCurved: true,
                        barWidth: 2,
                        color: Colors.indigo,
                      ),
                    ],
                  ),
                )),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            child: const Text(
              "Performances de votre semaine",
              style: TextStyle(
                fontFamily: "futura",
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xff000000),
                height: 19 / 14,
                decoration: TextDecoration.underline,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                  width: 105,
                  height: 105,
                  child: DottedBorder(
                    borderType: BorderType.Circle,
                    color: const Color(0xff222fe6),
                    strokeWidth: 2,
                    dashPattern: const [5, 5],
                    //dash patterns, 10 is dash width, 6 is space width
                    child: const Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          Text(
                            '15,3 k',
                            style: TextStyle(
                              fontFamily: "futura",
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff222fe6),
                              height: 21 / 16,
                            ),
                          ),
                          Text(
                            'Charge max',
                            style: TextStyle(
                              fontFamily: "futura",
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff000000),
                              height: 16 / 12,
                            ),
                          )
                        ]) //inner container
                        ),
                  )),
              SizedBox(
                  width: 105,
                  height: 105,
                  child: DottedBorder(
                    borderType: BorderType.Circle,
                    color: const Color(0xff222fe6),
                    strokeWidth: 2,
                    dashPattern: const [5, 5],
                    //dash patterns, 10 is dash width, 6 is space width
                    child: const Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          Text(
                            '6,52 g/s',
                            style: TextStyle(
                              fontFamily: "futura",
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff222fe6),
                              height: 21 / 16,
                            ),
                          ),
                          Text(
                            'Intensité max',
                            style: TextStyle(
                              fontFamily: "futura",
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff000000),
                              height: 16 / 12,
                            ),
                          )
                        ]) //inner container
                        ),
                  )),
            ],
          ),
          SizedBox(
              width: 105,
              height: 105,
              child: DottedBorder(
                borderType: BorderType.Circle,
                color: const Color(0xffde3211),
                strokeWidth: 2,
                dashPattern: const [5, 5],
                //dash patterns, 10 is dash width, 6 is space width
                child: const Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Text(
                        "1127 '",
                        style: TextStyle(
                          fontFamily: "futura",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffde3211),
                          height: 21 / 16,
                        ),
                      ),
                      Text(
                        'Entrainement total',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "futura",
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          height: 16 / 12,
                        ),
                      )
                    ]) //inner container
                    ),
              )),
          Expanded(
              child: Container(
                  margin: const EdgeInsets.only(bottom: 40),
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      backgroundColor: Colors.deepOrange,
                      minimumSize: const Size(280, 50),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ScannerPage()),
                      );
                    },
                    child: const Text('Commencer une session',
                        style: TextStyle(
                          fontFamily: "futura",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 27 / 20,
                        )),
                  )))
        ],
      ),
    );
  }

  SideTitles get _bottomTitles => SideTitles(
      interval: 1,
      showTitles: true,
      getTitlesWidget: (value, meta) {
        String text = '';
        switch (value.toInt()) {
          case 0:
            text = 'Dimanche';
            break;
          case 1:
            text = 'Lundi';
            break;
          case 2:
            text = 'Mardi';
            break;
          case 3:
            text = 'Mercredi';
            break;
          case 4:
            text = 'Jeudi';
            break;
          case 5:
            text = 'Vendredi';
            break;
          case 6:
            text = 'Samedi';
            break;
          case 7:
            text = 'Dimanche';
            break;
        }
        return Container(
            margin: const EdgeInsets.only(top: 10),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 10,
                fontFamily: 'futura',
              ),
            ));
      });

  SideTitles get _leftTitles => SideTitles(
      showTitles: true,
      interval: 20,
      getTitlesWidget: (value, meta) {
        String text = (value.toInt()).toString();
        return Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 10,
            fontFamily: 'futura',
          ),
        );
      });

  Future<void> fetchUserData() async {
    final userDoc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (userDoc.exists) {
      final data = userDoc.data() as Map<String, dynamic>;
      final firstName = data['firstName'];
      final lastName = data['lastName'];
      // Ajoutez d'autres champs du profil ici en fonction de votre structure de base de données.

      setState(() {
        userProfile = UserProfile(firstName: firstName, lastName: lastName);
      });
    }
  }
}
