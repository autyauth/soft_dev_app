import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/constants.dart';
import '../widget/charts.dart';
import '../widget/component/my_card.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Product {
  String name;
  bool enable;
  Product({this.enable = true, required this.name});
}

class PanelRightPage extends StatefulWidget {
  @override
  _PanelRightPageState createState() => _PanelRightPageState();
}

class _PanelRightPageState extends State<PanelRightPage> {
  List<Widget> cardList = [];
  List<Map<String, dynamic>> calWeekdayList = [];
  List<Map<String, dynamic>> caltodayList = [];

  double totalCal = 0.0; // สร้างตัวแปรเพื่อเก็บผลรวม cal
  double calnow = 0;
  double sumcal = 0.0; // สร้างตัวแปรเพื่อเก็บผลรวม cal
  String formattedNumber = '';
  DateTime now = DateTime.now();
  final User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    retrieveDashborads();
  }

  void retrieveDashborads() {
   
            FirebaseFirestore.instance
                .collection("userProfile")
                .doc(currentUser?.uid)
                .collection("dashboard")
                .get()
                .then((subcol) {
              subcol.docs.forEach((element) {
                
                print(currentUser?.uid);
                double time = element.data()['time'];
                DateTime dateex = element.data()['date'].toDate();

                int weeekday = dateex.weekday;
                // print(DateTime.now());
                // print(dateex);
                if (dateex.year == now.year &&
                    dateex.month == now.month &&
                    dateex.day == now.day) {
                  calnow = time;
                  Map<String, dynamic> data1 = {
                    'time': time,
                  };
                  caltodayList.add(data1);
                  calnow = time;
                }

                // สร้าง Map เพื่อเก็บข้อมูล cal และ weekday
                Map<String, dynamic> data = {
                  'time': time,
                  'weekday': weeekday,
                };
                                

                calWeekdayList.add(data);
                print(calWeekdayList);
                totalCal += time;
                sumcal += 1;
                formattedNumber = (totalCal / sumcal).toStringAsFixed(2);
                setState(() {});
              });
            }
            );
          
        
  }


  final _controller = PageController();
  DateTime nowtoday = DateTime.now();
  int day = DateTime.now().day;
  int mm = DateTime.now().month;
  String formattedTime = DateFormat('HH:mm').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: SingleChildScrollView(
      backgroundColor: Constants.background,

      // ),
      body: SingleChildScrollView(
        child: Stack(children: [
          BackButton(),
          Column(
            children: [
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'สุขภาพ',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Constants.white,
                          ),
                        ),
                        // Text(
                        //   ' Card',
                        //   style: TextStyle(
                        //     fontSize: 28,
                        //     color: Constants.white,
                        //   ),
                        // ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Constants.primary,
                        shape: BoxShape.circle,
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(height: 25),

              //card
              Container(
                height: 180,
                child: PageView(
                  scrollDirection: Axis.horizontal,
                  controller: _controller,
                  children: [
                    Mycard(
                      balance: calnow.toString(),
                      cardNum: formattedTime,
                      expiryM: day,
                      expiryY: mm,
                      color: Constants.card,
                    ),
                    Mycard(
                      balance: totalCal.toString(),
                      cardNum: "โดยรวม",
                      expiryM: 5,
                      expiryY: 22,
                      color: Constants.card,
                    ),
                    Mycard(
                      balance: formattedNumber,
                      cardNum: "โดยเฉลี่ย",
                      expiryM: 5,
                      expiryY: 22,
                      color: Constants.card,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: ExpandingDotsEffect(activeDotColor: Constants.white),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BarChartSample3(),
                  Circular1(),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              LineChartSample12(),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ]),
      ),
    );
  }

  void retrieveCol() {
    FirebaseFirestore.instance.collection("userProfile").get().then((value) => {
          value.docs.forEach((result) {
            result.data();
          })
        });
  }
}
