import 'dart:convert';
import 'package:adminapp/RewardCodes/RewardHomePage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class RewardAdd extends StatefulWidget {
  @override
  _RewardAddState createState() => _RewardAddState();
}

class _RewardAddState extends State<RewardAdd> {
  DateTime selectedDate1 = DateTime.now();
  DateTime selectedDate2 = DateTime.now();
  TextEditingController code = TextEditingController();
  TextEditingController point = TextEditingController();
  TextEditingController start = TextEditingController();
  TextEditingController end = TextEditingController();
  TextEditingController validity = TextEditingController();
  Future RewardCodeInsert() async {
    var url1 =
        'http://sanjayagarwal.in/Finance App/AdminApp/Rewards/RewardCodeInsert.php';
    final response = await http.post(
      url1,
      body: jsonEncode(<String, String>{
        'RewardCode': code.text,
        'RewardPoints': point.text,
        'Start': selectedDate1.toString(),
        'End': selectedDate2.toString(),
        'State': validity.text,
      }),
    );
    print("****************************************************");
    print("${code.text}**${point.text}** ** **${validity.text}");
    print("****************************************************");
    var message1 = jsonDecode(response.body);
    if (message1 == "Successful Insertion") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ShowRewards()));
    } else {
      print(message1);
    }
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
          'ADD REWARD',
          style: TextStyle(color: Color(0xff373D3F)),
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Reward Code'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: code,
                      decoration: InputDecoration(
                        hintText: "Enter code",
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 5.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Reward Points'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: point,
                      decoration: InputDecoration(
                        hintText: "Enter points",
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 5.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Start Date: '),
                  ),
                  RaisedButton(
                    color: Color(0xff63E2E0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    onPressed: () async {
                      final DateTime pickedstart = await showDatePicker(
                        context: context,
                        initialDate: selectedDate1,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100),
                        initialDatePickerMode: DatePickerMode.year,
                      );
                      if (pickedstart != null && pickedstart != selectedDate1)
                        setState(() {
                          selectedDate1 = pickedstart;
                        });
                    },
                    child: Text('Select Start Date'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('End Date'),
                  ),
                  RaisedButton(
                    color: Color(0xff63E2E0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    onPressed: () async {
                      final DateTime pickedend = await showDatePicker(
                        context: context,
                        initialDate: selectedDate2,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100),
                        initialDatePickerMode: DatePickerMode.year,
                      );
                      if (pickedend != null && pickedend != selectedDate2)
                        setState(() {
                          selectedDate2 = pickedend;
                        });
                    },
                    child: Text('Select End Date'),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('State'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: validity,
                      decoration: InputDecoration(
                        hintText: "Enter 1 for Valid, 0 for Invalid",
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 5.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: RaisedButton(
                  onPressed: () {
                    RewardCodeInsert();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'ADD REWARD CODE',
                      style: TextStyle(color: Color(0xff373D3F)),
                    ),
                  ),
                  color: Color(0xff63E2E0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
