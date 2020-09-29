import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'RewardHistory.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RewardandRefer extends StatefulWidget {
  String currentUserID;
  RewardandRefer({@required this.currentUserID});
  @override
  _RewardandReferState createState() =>
      _RewardandReferState(currentUserID: currentUserID);
}

class _RewardandReferState extends State<RewardandRefer> {
  String currentUserID;
  _RewardandReferState({@required this.currentUserID});
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String rCode = '';
  List<List> rewards = [
    [
      'rewards1',
      'rewards detailpoiuytrewqasdfghj kll,mnbvcxzasdfghjkl;poiuytrewqasdfghjkll,mnbvcxzsdfghjklpoiuytrewqasdfghjkl,mnbvcxzasdfghjklpoiuy'
    ],
    ['rewards1', 'rewards detail'],
    ['rewards1', 'rewards detail'],
    ['rewards1', 'rewards detail'],
  ];
  void getReferData() async {
    var url =
        'http://sanjayagarwal.in/Finance App/UserApp/Profile/UserDetails.php';
    final response = await http.post(
      url,
      body: jsonEncode(<String, String>{
        "UserID": currentUserID,
      }),
    );
    var message = await jsonDecode(response.body);
    print("****************************************");
    print(message);
    print(message[0]['ReferalCode']);
    print("****************************************");
    setState(() {
      rCode = message[0]['ReferalCode'];
    });
    var url1 = 'http://sanjayagarwal.in/Finance App/ReferedToDetails.php';
    final response1 = await http.post(
      url1,
      body: jsonEncode(<String, String>{
        "CodeUsed": message[0]['ReferalCode'],
      }),
    );
    var message1 = await jsonDecode(response1.body);
    print("****************************************");
    print(message1);
    print("****************************************");
  }

  @override
  void initState() {
    getReferData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Color(0xff373D3F),
        ),
        backgroundColor: Color(0xff63E2E0),
        centerTitle: true,
        title: Text(
          'REWARDS & REFERRALS',
          style: TextStyle(color: Color(0xff373D3F)),
        ),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          physics: ScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Reward 1"),
                  ),
                  LinearPercentIndicator(
                    lineHeight: 14.0,
                    percent: 0.3,
                    backgroundColor: Colors.grey,
                    progressColor: Color(0xff63E2E0),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Reward 2"),
                  ),
                  LinearPercentIndicator(
                    lineHeight: 14.0,
                    percent: 0.3,
                    backgroundColor: Colors.grey,
                    progressColor: Color(0xff63E2E0),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 24),
                    child: Container(
                      height: height * 0.07,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 4.0,
                                spreadRadius: 2.0,
                                color: Colors.black12),
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text(
                              '$rCode',
                              style: TextStyle(
                                  fontSize: height * 0.03,
                                  color: Color(0xFF373D3F)),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Text('Copy Code',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: height * 0.02,
                                          color: Color(0xff373D3F))),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  GestureDetector(
                    child: Container(
                        width: width,
                        decoration: BoxDecoration(
                            color: Color(0xff63E2E0),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        padding: EdgeInsets.all(16),
                        child: Center(
                            child: Text(
                          'Swipe up to see your Reward History',
                          style: TextStyle(
                              fontSize: height * 0.02,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff373D3F)),
                        ))),
                    onVerticalDragStart: (DragStartDetails details) {
                      _scaffoldKey.currentState
                          .showBottomSheet<Null>((BuildContext context) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: Color(0xff63E2E0),
                          ),
                          height: height < 640 ? height * 0.7 : height * 0.5,
                          width: width,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Your Reward History',
                                  style: TextStyle(
                                      color: Color(0xff373D3F),
                                      fontSize: height * 0.02,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: height * 0.4,
                                  child: ListView.builder(
                                    itemCount: codesUsed.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Column(
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                              color: Colors.white,
                                            ),
                                            height: 80,
                                            width: width * 0.8,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Expanded(
                                                    flex: 3,
                                                    child: Center(
                                                      child: Text(
                                                        codesUsed[index]
                                                            .codeName,
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xff373D3F),
                                                          fontSize:
                                                              height * 0.03,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Text(
                                                          'Points Earned',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff373D3F),
                                                              fontSize:
                                                                  height * 0.02,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        Text(
                                                          codesUsed[index]
                                                              .points,
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xff373D3F),
                                                            fontSize:
                                                                height * 0.02,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
