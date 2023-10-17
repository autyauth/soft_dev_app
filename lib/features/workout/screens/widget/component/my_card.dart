import 'package:flutter/material.dart';
import '../../../../../core/theme/constants.dart';


class Mycard extends StatelessWidget {

  final String balance;
  final String cardNum;
  final int expiryM;
  final int expiryY;
  final color;

  const Mycard({
    Key? key,
    required this.balance,
    required this.cardNum,
    required this.expiryM,
    required this.expiryY,
    required this.color,
    }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
              width: 300,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(16)),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(
                  height: 8,
                ),
                Text(
                  'เวลาออกกำลังกาย',
                  style: TextStyle(
                    color: Constants.white,
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      balance.toString()  ,
                      style: TextStyle(
                        color: Constants.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                    SizedBox(
                  width: 10,
                ),
                
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 13, 0, 0),
                      child: Container(
                        
                        child: Text(
                          "นาที" ,
                          style: TextStyle(
                            color: Constants.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cardNum.toString(),
                      style: TextStyle(
                        color: Constants.white,
                      ),
                    ),
                    Text(
                      expiryM.toString() + '/' + expiryY.toString(),
                      style: TextStyle(
                        color: Constants.white,
                      ),
                    ),
                  ],
                ),                
              ]),
            ),
      )
      );
  }
}

