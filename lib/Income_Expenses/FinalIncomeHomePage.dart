import 'dart:math';
import 'package:adminapp/Income_Expenses/widgetcode.dart';
import 'package:flutter/material.dart';

class IncomePage extends StatefulWidget {
  final String currentUserID;
  IncomePage({@required this.currentUserID});
  @override
  _IncomePageState createState() =>
      _IncomePageState(currentUserID: currentUserID);
}

class _IncomePageState extends State<IncomePage> {
  final String currentUserID;
  _IncomePageState({@required this.currentUserID});
  TextEditingController newiamt = TextEditingController();
  TextEditingController neweamt = TextEditingController();
  Widget Income(double height, double width) {
    return Container(
      height: height < 640 ? height * 0.55 : height * 0.35,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <
                Widget>[
          Visibility(
            child: Container(
              height: height * 0.1,
              width: width * 0.9,
              child: ListView.builder(
                  itemCount: c1,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(itype[index]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(iamt[index]),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("Edit Amount"),
                                          content: TextField(
                                            decoration: InputDecoration(
                                                hintText: "Enter New Amount"),
                                            keyboardType: TextInputType.number,
                                            controller: newiamt,
                                          ),
                                          actions: <Widget>[
                                            FlatButton(
                                              color: Color(0xff63E2E0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              child: Text(
                                                'Confirm',
                                                style: TextStyle(
                                                  color: Color(0xff373D3F),
                                                ),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  totalincome = totalincome -
                                                      int.parse(iamt[index]) +
                                                      int.parse(newiamt.text);
                                                  savings = totalincome -
                                                      totalexpense;
                                                  iamt[index] = newiamt.text;
                                                  calculatePotential(
                                                      dropdown, rate, time);
                                                  Navigator.of(context).pop();
                                                });
                                              },
                                            )
                                          ],
                                        );
                                      });
                                },
                                icon: Icon(Icons.edit),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  }),
            ),
            visible: (c1 != 0 && selected == "income") ? true : false,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: DropdownButtonHideUnderline(
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
                          itype.add(newValue);
                        });
                      },
                      items: <String>[
                        'Salary',
                        'Investment',
                        'Business',
                        'Others'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Visibility(
                  visible: incometype != null ? true : false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: width * 0.4,
                        height: height * 0.07,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: income,
                          decoration: InputDecoration(
                            hintText: "Enter amount",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff373D3F)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xff63E2E0),
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
                            totalincome = totalincome + int.parse(income.text);
                            savings = totalincome - totalexpense;
                            iamt.add(income.text);
                            calculatePotential(dropdown, rate, time);
                          });
                        },
                        icon: Icon(Icons.arrow_forward),
                        color: Color(0xff373D3F),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget Expense(double height, double width) {
    return Container(
      height: height < 640 ? height * 0.55 : height * 0.35,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Visibility(
              child: Container(
                height: height * 0.1,
                width: width * 0.9,
                child: ListView.builder(
                    itemCount: c2,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(etype[index]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(eamt[index]),
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text("Edit Amount"),
                                            content: TextField(
                                              decoration: InputDecoration(
                                                  hintText: "Enter New Amount"),
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: neweamt,
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                color: Color(0xff63E2E0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                child: Text(
                                                  'Confirm',
                                                  style: TextStyle(
                                                    color: Color(0xff373D3F),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    totalexpense =
                                                        totalexpense -
                                                            int.parse(
                                                                eamt[index]) +
                                                            int.parse(
                                                                neweamt.text);
                                                    savings = totalincome -
                                                        totalexpense;
                                                    eamt[index] = neweamt.text;
                                                    calculatePotential(
                                                        dropdown, rate, time);
                                                    Navigator.of(context).pop();
                                                  });
                                                },
                                              )
                                            ],
                                          );
                                        });
                                  },
                                  icon: Icon(Icons.edit),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    }),
              ),
              visible: (c2 != 0 && selected == "expense") ? true : false,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: Text(
                          "Add Expense",
                          style: TextStyle(
                            color: Color(0xff373D3F),
                          ),
                        ),
                        value: expensetype,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Color(0xff373D3F),
                        ),
                        iconSize: 16,
                        onChanged: (String newValue) {
                          setState(() {
                            expensetype = newValue;
                            etype.add(newValue);
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
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: expensetype != null ? true : false,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: width * 0.4,
                          height: height * 0.07,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: expense,
                            decoration: InputDecoration(
                              hintText: "Enter amount",
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff373D3F)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xff63E2E0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              c2 = c2 + 1;
                              typee = expensetype;
                              expensetype = null;
                              totalexpense =
                                  totalexpense + int.parse(expense.text);
                              savings = totalincome - totalexpense;
                              eamt.add(expense.text);
                              calculatePotential(dropdown, rate, time);
                            });
                          },
                          icon: Icon(Icons.arrow_forward),
                          color: Color(0xff373D3F),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> itype = [];
  List<String> etype = [];
  List<String> iamt = [];
  List<String> eamt = [];
  String dropdown = "YEARLY";
  int totalincome = 0,
      totalexpense = 0,
      savings = 0,
      c1 = 0,
      c2 = 0,
      potentialValue = 0,
      rate = 15,
      time = 10;
  double potential = 0;
  String incometype, expensetype, typei, typee;
  String selected = "income";
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: height < 640 ? height * 0.8 : height * 0.6,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xff373D3F),
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          IntrinsicHeight(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Expanded(
                                    child: FlatButton(
                                      onPressed: () {
                                        setState(() {
                                          selected = 'income';
                                        });
                                      },
                                      child: Text(
                                        "INCOME",
                                        style: TextStyle(
                                          color: Color(0xff63E2E0),
                                          fontWeight: FontWeight.bold,
                                          decoration: selected == "income"
                                              ? TextDecoration.underline
                                              : TextDecoration.none,
                                          decorationThickness: 4,
                                        ),
                                      ),
                                    ),
                                  ),
                                  VerticalDivider(
                                    color: Colors.grey,
                                  ),
                                  Expanded(
                                    child: FlatButton(
                                      onPressed: () {
                                        setState(() {
                                          selected = "expense";
                                        });
                                      },
                                      child: Text(
                                        "EXPENSE",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          decoration: selected == "expense"
                                              ? TextDecoration.underline
                                              : TextDecoration.none,
                                          decorationThickness: 4,
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
                          Column(
                            children: <Widget>[
                              SingleChildScrollView(
                                physics: ScrollPhysics(),
                                child: selected == "income"
                                    ? Income(height, width)
                                    : Expense(height, width),
                              ),
                              Divider(
                                color: Colors.grey,
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
                                          : textpart(
                                              context, totalincome.toString())),
                                ],
                              ),
                              Divider(
                                color: Colors.grey,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      "Total Expense",
                                      style: TextStyle(
                                          color: Color(0xff373D3F),
                                          fontSize: 16),
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: (totalexpense == null)
                                          ? textpart(context, "00")
                                          : textpart(context,
                                              totalexpense.toString())),
                                ],
                              ),
                              Divider(
                                color: Colors.grey,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      "$dropdown SAVINGS",
                                      style: TextStyle(
                                          color: Color(0xff373D3F),
                                          fontSize: 16),
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: (savings == null)
                                          ? textpart(context, "00")
                                          : textpart(
                                              context, savings.toString())),
                                ],
                              ),
                            ],
                          )
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
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        height: height < 640 ? height * 0.2 : height * 0.15,
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
                                          hintText: "10",
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
                                          hintText: "15",
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
                            Center(
                              child: Text("Rs. $potentialValue",
                                  style: TextStyle(
                                      color: Color(0xff373D3F), fontSize: 24)),
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
