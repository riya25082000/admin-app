import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'categoryinfo.dart';
import 'income2.dart';

class modifyI extends StatefulWidget {
  String currentUserID;
  int incid;
  String inamt;
  int indexone;
  modifyI(this.incid, this.indexone, this.inamt,
      {@required this.currentUserID});
  @override
  _modifyIState createState() => _modifyIState(
      currentUserID: currentUserID,
      incselected: indexone,
      iamt: inamt,
      incomeID: incid.toString());
}

class _modifyIState extends State<modifyI> {
  String currentUserID;
  _modifyIState(
      {@required this.currentUserID,
      this.incselected,
      this.iamt,
      this.incomeID});
  var incselected;
  String incomeID;
  String iamt;
  Future incomeUpdate() async {
    print("********************************************************");
    print("ch1,$incselected,$iamt,$currentUserID,$incomeID");
    print("********************************************************");
    var url =
        'http://sanjayagarwal.in/Finance App/UserApp/IncomeExpense/IncomeUpdate.php';
    final response1 = await http.post(
      url,
      body: jsonEncode(<String, String>{
        "Type": incselected.toString(),
        "Amount": iamt,
        "UserID": currentUserID,
        "IncomeID": incomeID
      }),
    );
    print("********************************************************");
    print("ch2");
    print("********************************************************");
    var message1 = jsonDecode(response1.body);
    print("********************************************************");
    print("ch1,$message1");
    print("********************************************************");
    if (message1 == "Successful Updation") {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => income2(
                    currentUserID: currentUserID,
                  )));
    } else {
      print(message1["message"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
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
          'MODIFY INCOME',
          style: TextStyle(color: Color(0xff373D3F)),
        ),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Material(
              color: Color(0xffECEFF1),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  height: height * 0.65,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              left: 10, right: 8, top: 15, bottom: 10),
                          child: Text('Income Type',
                              style: TextStyle(color: Color(0xff373D3F))),
                        ),
                        Container(
                          height: (height < 640) ? height * 0.18 : height * 0.2,
                          width: width,
                          child: ListView.builder(
                            itemCount: inccategory.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                physics: NeverScrollableScrollPhysics(),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        incselected = index;
                                      });
                                    },
                                    child: Container(
                                      decoration: incselected == index
                                          ? BoxDecoration(
                                              border: Border.all(
                                                width: 4,
                                                color: Color(0xff63E2E0),
                                              ),
                                            )
                                          : BoxDecoration(
                                              border: Border.all(
                                                width: 4,
                                                color: Color(0xff373D3F),
                                              ),
                                            ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 20,
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          Image.asset(
                                            inccategory[index].imageUrl,
                                            height: (height < 640)
                                                ? height * 0.05
                                                : height * 0.1,
                                            width: width * 0.2,
                                          ),
                                          Text(
                                            inccategory[index].iname,
                                            style: TextStyle(
                                                color: Color(0xff373D3F),
                                                fontWeight: incselected == index
                                                    ? FontWeight.bold
                                                    : FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Text('Income Amount',
                              style: TextStyle(color: Color(0xff373D3F))),
                        ),
                        Container(
                          height: height < 640 ? height * 0.06 : height * 0.08,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              initialValue: iamt,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                iamt = value;
                              },
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff373D3F)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xff63E2E0),
                                  ),
                                ),
                                hintText: "Enter amount",
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: RaisedButton(
                            onPressed: () {
                              print(
                                  "********************************************************");
                              print("ch1");
                              print(
                                  "********************************************************");
                              incomeUpdate();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'MODIFY INCOME',
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
              ),
            ),
          ),
        );
      }),
    );
  }
}

class modifyE extends StatefulWidget {
  String currentUserID;
  int expid;
  String examt;
  int indexe;
  modifyE(this.expid, this.indexe, this.examt, {@required this.currentUserID});
  @override
  _modifyEState createState() => _modifyEState(
      currentUserID: currentUserID,
      expselected: indexe,
      eamt: examt,
      expenseID: expid.toString());
}

class _modifyEState extends State<modifyE> {
  Future expenseUpdate() async {
    print("********************************************************");
    print("ch1,$expselected,$eamt,$currentUserID,$expenseID");
    print("********************************************************");
    var url =
        'http://sanjayagarwal.in/Finance App/UserApp/IncomeExpense/ExpenseUpdate.php';
    final response1 = await http.post(
      url,
      body: jsonEncode(<String, String>{
        "Type": expselected.toString(),
        "Amount": eamt,
        "UserID": currentUserID,
        "ExpenseID": expenseID
      }),
    );
    print("********************************************************");
    print("ch2");
    print("********************************************************");
    var message1 = jsonDecode(response1.body);
    print("********************************************************");
    print("ch1,$message1");
    print("********************************************************");
    if (message1 == "Successful Updation") {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => income2(
                    currentUserID: currentUserID,
                  )));
    } else {
      print(message1["message"]);
    }
  }

  String currentUserID;
  _modifyEState(
      {@required this.currentUserID,
      this.expselected,
      this.eamt,
      this.expenseID});
  var expselected;
  String eamt;
  String expenseID;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
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
          'MODIFY EXPENSE',
          style: TextStyle(color: Color(0xff373D3F)),
        ),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Material(
              color: Color(0xffECEFF1),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  height: height * 0.65,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              left: 10, right: 8, top: 15, bottom: 10),
                          child: Text('Expense Type',
                              style: TextStyle(color: Color(0xff373D3F))),
                        ),
                        Container(
                          height: (height < 640) ? height * 0.18 : height * 0.2,
                          width: width,
                          child: ListView.builder(
                            itemCount: expcategory.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                physics: NeverScrollableScrollPhysics(),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        expselected = index;
                                      });
                                    },
                                    child: Container(
                                      decoration: expselected == index
                                          ? BoxDecoration(
                                              border: Border.all(
                                                width: 4,
                                                color: Color(0xff63E2E0),
                                              ),
                                            )
                                          : BoxDecoration(
                                              border: Border.all(
                                                width: 4,
                                                color: Color(0xff373D3F),
                                              ),
                                            ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 20,
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          Image.asset(
                                            expcategory[index].imageUrl,
                                            height: (height < 640)
                                                ? height * 0.05
                                                : height * 0.1,
                                            width: width * 0.2,
                                          ),
                                          Text(
                                            expcategory[index].ename,
                                            style: TextStyle(
                                                color: Color(0xff373D3F),
                                                fontWeight: expselected == index
                                                    ? FontWeight.bold
                                                    : FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Text('Expense Amount',
                              style: TextStyle(color: Color(0xff373D3F))),
                        ),
                        Container(
                          height: height < 640 ? height * 0.06 : height * 0.08,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              initialValue: widget.examt,
                              onChanged: (value) {
                                eamt = value;
                              },
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff373D3F)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xff63E2E0),
                                  ),
                                ),
                                hintText: "Enter amount",
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: RaisedButton(
                            onPressed: () {
                              expenseUpdate();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'MODIFY EXPENSE',
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
              ),
            ),
          ),
        );
      }),
    );
  }
}
