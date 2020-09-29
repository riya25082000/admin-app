import 'dart:math';

import 'package:adminapp/Income_Expenses/widgetcode.dart';
import 'package:flutter/material.dart';

class IncomeHomePage extends StatefulWidget {
  String currentUserID;
  IncomeHomePage({@required this.currentUserID});
  @override
  _IncomeHomePageState createState() =>
      _IncomeHomePageState(currentUserID: currentUserID);
}

class _IncomeHomePageState extends State<IncomeHomePage> {
  String currentUserID;
  _IncomeHomePageState({@required this.currentUserID});
  String dropdown = "YEARLY";
  int totalincome = 0,
      totalexpense = 0,
      savings = 0,
      c1 = 0,
      c2 = 0,
      potentialValue = 0,
      rate,
      time;
  double potential = 0;
  bool visible1 = false, visible2 = false;
  String incometype, expensetype, typei, typee;
  TextEditingController income = new TextEditingController();
  TextEditingController expense = new TextEditingController();
  TextEditingController x = new TextEditingController();
  TextEditingController y = new TextEditingController();

  void calculatePotential(String value, int r, int t) {
    setState(() {
      if (y.text.isEmpty) {
        t = 10;
      }
      if (x.text.isEmpty) {
        r = 15;
      }
      if (dropdown == "YEARLY") {
        potential = savings * pow((1 + (r / (12 * 100))), (t * 12));
      } else {
        potential = savings * pow((1 + (r / 100)), (t));
      }
      potentialValue = potential.toInt();
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var h1 = height * 0.1;
    var h2 = height * 0.3;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Color(0xff373D3F),
        ),
        centerTitle: true,
        title: Text(
          'INCOME AND EXPENSE',
          style: TextStyle(
            color: Color(0xff373D3F),
          ),
        ),
        backgroundColor: Color(0xff63E2E0),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          physics: ScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Material(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: dropdown,
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Color(0xff373D3F),
                              ),
                              iconSize: 16,
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdown = newValue;
                                  calculatePotential(dropdown, rate, time);
                                });
                              },
                              items: <String>[
                                'YEARLY',
                                'MONTHLY'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Container(
                      height: height * 0.5,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xff373D3F),
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: visible1 == true ? h2 : h1,
                                child: Column(
                                  mainAxisAlignment: visible1 == true
                                      ? MainAxisAlignment.spaceBetween
                                      : MainAxisAlignment.start,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          visible1 = !visible1;
                                          visible2 = false;
                                        });
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          "INCOME",
                                          style: TextStyle(
                                              color: Color(0xff63E2E0),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color(0xff373D3F),
                                          ),
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0)),
                                        ),
                                        height: height * 0.1,
                                        child: ListView.builder(
                                            itemCount: c1,
                                            scrollDirection: Axis.vertical,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Text(typei),
                                                    Text(income.text),
                                                  ],
                                                ),
                                              );
                                            }),
                                      ),
                                      visible: (c1 != 0 && visible1 == true)
                                          ? true
                                          : false,
                                    ),
                                    Visibility(
                                      visible:
                                          (visible1 == true) ? true : false,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButton(
                                                  hint: Text(
                                                    "Add Income",
                                                    style: TextStyle(
                                                      color: Color(0xff373D3F),
                                                    ),
                                                  ),
                                                  value: incometype,
                                                  icon: Icon(
                                                    Icons.arrow_drop_down,
                                                    color: Color(0xff373D3F),
                                                  ),
                                                  iconSize: 16,
                                                  onChanged: (String newValue) {
                                                    setState(() {
                                                      incometype = newValue;
                                                    });
                                                  },
                                                  items: <String>[
                                                    'Salary',
                                                    'Investment',
                                                    'Business',
                                                    'Others'
                                                  ].map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 10),
                                              child: Visibility(
                                                visible: incometype != null
                                                    ? true
                                                    : false,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    Container(
                                                      width: 180,
                                                      height: 50,
                                                      child: TextField(
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        controller: income,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              "Enter amount",
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Color(
                                                                    0xff373D3F)),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color(
                                                                  0xff63E2E0),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          c1 = c1 + 1;
                                                          typei = incometype;
                                                          incometype = null;
                                                          totalincome =
                                                              totalincome +
                                                                  int.parse(
                                                                      income
                                                                          .text);
                                                        });
                                                      },
                                                      icon: Icon(
                                                          Icons.arrow_forward),
                                                      color: Color(0xff373D3F),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                            "Total Income",
                                            style: TextStyle(
                                                color: Color(0xff373D3F),
                                                fontSize: 16),
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(right: 20),
                                            child: (totalincome == null)
                                                ? textpart(context, "00")
                                                : textpart(context,
                                                    totalincome.toString())),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  Divider(
                                    color: Colors.grey,
                                  ),
                                  Container(
                                    height: visible2 == true ? h2 : h1,
                                    child: Column(
                                      mainAxisAlignment: visible2 == true
                                          ? MainAxisAlignment.spaceBetween
                                          : MainAxisAlignment.start,
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              visible2 = !visible2;
                                              visible1 = false;
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "EXPENSE",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          child: Container(
                                            height: height * 0.1,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Color(0xff373D3F),
                                              ),
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0)),
                                            ),
                                            child: ListView.builder(
                                                itemCount: c2,
                                                scrollDirection: Axis.vertical,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10, right: 10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Text(typee),
                                                        Text(expense.text),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                          ),
                                          visible: (c2 != 0 && visible2 == true)
                                              ? true
                                              : false,
                                        ),
                                        Visibility(
                                          visible:
                                              visible2 == true ? true : false,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  child:
                                                      DropdownButtonHideUnderline(
                                                    child: DropdownButton(
                                                      hint: Text(
                                                        "Add Expense",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xff373D3F),
                                                        ),
                                                      ),
                                                      value: expensetype,
                                                      icon: Icon(
                                                        Icons.arrow_drop_down,
                                                        color:
                                                            Color(0xff373D3F),
                                                      ),
                                                      iconSize: 16,
                                                      onChanged:
                                                          (String newValue) {
                                                        setState(() {
                                                          expensetype =
                                                              newValue;
                                                        });
                                                      },
                                                      items: <String>[
                                                        'Rent',
                                                        'EMI(House)',
                                                        'EMI(Car)',
                                                        'Car costs',
                                                        'Education',
                                                        'Food',
                                                        'House costs',
                                                        'Shopping',
                                                        'Other'
                                                      ].map<
                                                              DropdownMenuItem<
                                                                  String>>(
                                                          (String value) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: value,
                                                          child: Text(value),
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 10),
                                                  child: Visibility(
                                                    visible: expensetype != null
                                                        ? true
                                                        : false,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: <Widget>[
                                                        Container(
                                                          width: 180,
                                                          height: 50,
                                                          child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            controller: expense,
                                                            decoration:
                                                                InputDecoration(
                                                              hintText:
                                                                  "Enter amount",
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Color(
                                                                        0xff373D3F)),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0xff63E2E0),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              c2 = c2 + 1;
                                                              typee =
                                                                  expensetype;
                                                              expensetype =
                                                                  null;
                                                              totalexpense =
                                                                  totalexpense +
                                                                      int.parse(
                                                                          expense
                                                                              .text);
                                                              savings =
                                                                  totalincome -
                                                                      totalexpense;
                                                            });
                                                          },
                                                          icon: Icon(Icons
                                                              .arrow_forward),
                                                          color:
                                                              Color(0xff373D3F),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Text(
                                                "Total Expense",
                                                style: TextStyle(
                                                    color: Color(0xff373D3F),
                                                    fontSize: 16),
                                              ),
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(right: 20),
                                                child: (totalexpense == null)
                                                    ? textpart(context, "00")
                                                    : textpart(
                                                        context,
                                                        totalexpense
                                                            .toString())),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                      height: height * 0.1,
                      decoration: BoxDecoration(
                        color: Color(0xff63E2E0),
                        border: Border.all(
                          color: Color(0xff373D3F),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("YOUR SAVINGS $dropdown WILL BE",
                                style: TextStyle(
                                    color: Color(0xff373D3F), fontSize: 14)),
                          ),
                          Center(
                            child: Text("Rs. $savings",
                                style: TextStyle(
                                    color: Color(0xff373D3F), fontSize: 14)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Container(
                        height: height * 0.15,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xff373D3F),
                          ),
                          color: Color(0xff63E2E0),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                      "Potential Value of your Savings ",
                                      style: TextStyle(
                                          color: Color(0xff373D3F),
                                          fontSize: 14)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      height: 20,
                                      width: 30,
                                      child: TextField(
                                        onChanged: (t) {
                                          setState(() {
                                            time = int.parse(t);
                                            calculatePotential(
                                                dropdown, rate, time);
                                          });
                                        },
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        controller: y,
                                        decoration: InputDecoration(
                                          hintText: "Y",
                                          contentPadding:
                                              EdgeInsets.only(bottom: 10),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      " years from now at ",
                                      style: TextStyle(
                                          color: Color(0xff373D3F),
                                          fontSize: 14),
                                    ),
                                    Container(
                                      height: 20,
                                      width: 30,
                                      child: TextField(
                                        onChanged: (r) {
                                          setState(() {
                                            rate = int.parse(r);
                                            calculatePotential(
                                                dropdown, rate, time);
                                          });
                                        },
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        controller: x,
                                        decoration: InputDecoration(
                                          hintText: "X",
                                          contentPadding:
                                              EdgeInsets.only(bottom: 10),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      " % CAGR will be  ",
                                      style: TextStyle(
                                          color: Color(0xff373D3F),
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Center(
                                child: Text("Rs. $potentialValue",
                                    style: TextStyle(
                                        color: Color(0xff373D3F),
                                        fontSize: 24)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
