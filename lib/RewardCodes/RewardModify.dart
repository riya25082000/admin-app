import 'package:adminapp/RewardCodes/RewardHomePage.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RewardModify extends StatefulWidget {
  int rid, rpoint, rvalid;
  String rcode;
  DateTime rstart, rend;
  RewardModify(
      this.rid, this.rcode, this.rpoint, this.rstart, this.rend, this.rvalid);
  @override
  _RewardModifyState createState() => _RewardModifyState(
      id: rid,
      code: rcode,
      point: rpoint,
      start: rstart,
      end: rend,
      valid: rvalid);
}

class _RewardModifyState extends State<RewardModify> {
  int id, point, valid;
  String code;
  DateTime start, end;
  _RewardModifyState(
      {this.id, this.code, this.point, this.start, this.end, this.valid});

  Future RewardCodeUpdate() async {
    var url =
        'http://sanjayagarwal.in/Finance App/AdminApp/Rewards/RewardCodeUpdate.php';
    final response1 = await http.post(
      url,
      body: jsonEncode(<String, String>{
        "RewardCode": code,
        "RewardPoints": point.toString(),
        "Start": start.toString(),
        "End": end.toString(),
        "State": valid.toString(),
        "Rid": id.toString(),
      }),
    );
    var message1 = jsonDecode(response1.body);
    if (message1 == "Successful Updation") {
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
          'MODIFY REWARD CODE',
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
                    child: TextFormField(
                      initialValue: code,
                      onChanged: (v1) {
                        code = v1;
                      },
                      decoration: InputDecoration(
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
                    child: TextFormField(
                      initialValue: point.toString(),
                      onChanged: (v2) {
                        point = int.parse(v2);
                      },
                      decoration: InputDecoration(
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
                        initialDate: start,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100),
                        initialDatePickerMode: DatePickerMode.year,
                      );
                      if (pickedstart != null && pickedstart != start)
                        setState(() {
                          start = pickedstart;
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
                        initialDate: end,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100),
                        initialDatePickerMode: DatePickerMode.year,
                      );
                      if (pickedend != null && pickedend != end)
                        setState(() {
                          end = pickedend;
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
                    child: TextFormField(
                      initialValue: valid.toString(),
                      onChanged: (v3) {
                        valid = int.parse(v3);
                      },
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
                    RewardCodeUpdate();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'MODIFY REWARD CODE',
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
