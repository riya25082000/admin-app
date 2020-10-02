import 'package:adminapp/MyGoals/modifygoals.dart';
import 'package:adminapp/RewardCodes/RewardAdd.dart';
import 'package:adminapp/RewardCodes/RewardModify.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ShowRewards extends StatefulWidget {
  @override
  _ShowRewardsState createState() => _ShowRewardsState();
}

class _ShowRewardsState extends State<ShowRewards> {
  List rewards = [];
  bool _loading;
  void getRewardCodes() async {
    setState(() {
      _loading = true;
    });
    var url2 =
        'http://sanjayagarwal.in/Finance App/AdminApp/Rewards/RewardCodeView.php';
    final response2 = await http.post(
      url2,
      body: jsonEncode(<String, String>{}),
    );
    var message2 = await jsonDecode(response2.body);
    print("****************************************");
    print(message2);
    print("****************************************");
    setState(() {
      rewards = message2;
      _loading=false;
    });
  }

  void RewardCodeDelete(var rno) async {
    var url =
        'http://sanjayagarwal.in/Finance App/AdminApp/Rewards/RewardCodeDelete.php';
    final response = await http.post(
      url,
      body: jsonEncode(<String, String>{'Rid': rno}),
    );
    var message = await jsonDecode(response.body);
    if (message == "Successfully Deleted") {
      getRewardCodes();
    } else {
      print(message);
    }
  }

  @override
  void initState() {
    print("****************************************");
    print("****************************************");
    getRewardCodes();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'REWARD CODES',
          style: TextStyle(color: Color(0xff373D3F)),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => RewardAdd()));
              },
              child: Text(' + Add '),
              color: Color(0xff63E2E0),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
      body:_loading
          ? Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
          backgroundColor: Color(0xff63E2E0),
        ),
      )
          : LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;
          return ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: rewards.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 1.0, // soften the shadow
                                spreadRadius: 0, //extend the shadow
                              ),
                            ]),
                        height: height * 0.2,
                        width: width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    rewards[index]['RewardCode'],
                                  ),
                                  Text(rewards[index]['RewardPoints']),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      RewardModify(
                                                        int.parse(rewards[index]
                                                            ['Rid']),
                                                        rewards[index]
                                                            ['RewardCode'],
                                                        int.parse(rewards[index]
                                                            ['RewardPoints']),
                                                        DateTime.parse(
                                                            rewards[index]
                                                                ['Start']),
                                                        DateTime.parse(
                                                            rewards[index]
                                                                ['End']),
                                                        int.parse(rewards[index]
                                                            ['State']),
                                                      )));
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text('Warning'),
                                                  content: Text(
                                                      "Are you sure you want to delete this module ?"),
                                                  actions: <Widget>[
                                                    FlatButton(
                                                      child: Text("Yes"),
                                                      onPressed: () {
                                                        RewardCodeDelete(
                                                            rewards[index]
                                                                ['Rid']);
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                    FlatButton(
                                                      child: Text("Cancel"),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    )
                                                  ],
                                                );
                                              });
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            int.parse(rewards[index]['State']) == 1
                                ? Text('Valid')
                                : Text('Invalid'),
                            Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          "Start: ",
                                          style: TextStyle(
                                              color: Color(0xff373D3F)),
                                        ),
                                        Text(rewards[index]['Start'],
                                            style: TextStyle(
                                                color: Color(0xff373D3F))),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text("End: ",
                                            style: TextStyle(
                                                color: Color(0xff373D3F))),
                                        Text(rewards[index]['End'],
                                            style: TextStyle(
                                                color: Color(0xff373D3F))),
                                      ],
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              });
        },
      ),
    );
  }
}
