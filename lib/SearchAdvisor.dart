import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'advisor_data.dart';
import 'erroralert.dart';

class SearchAdvisorPage extends StatefulWidget {
  @override
  _SearchAdvisorPage createState() => _SearchAdvisorPage();
}

class _SearchAdvisorPage extends State<SearchAdvisorPage> {
  List searchList = [];



  String get currentUserID => null;
  Future userAdvisorData() async {
    var url = 'http://sanjayagarwal.in/Finance App/SearchAdvisor.php';
    try {
      final response = await http.post(url);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        for (var i = 0; i < jsonData.length; i++) {
          searchList.add(jsonData[i]['Name']);
        }

        print(searchList);
      }
    }
    on TimeoutException catch (e) {
    alerttimeout(context, currentUserID);
    } on Error catch (e) {
    
    alerterror(context, currentUserID);
    } on SocketException catch (e) {
    alertinternet(context, currentUserID);
    }
  }

  @override
  void initState() {
    super.initState();
    userAdvisorData();

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
          'SEARCH ADVISOR',
          style: TextStyle(
            color: Color(0xff373D3F),
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showSearch(
                  context: context, delegate: AdvisorSearch(list: searchList));
            },
            icon: Icon(
              Icons.search,
              color: Color(0xff373D3F),
            ),
          )
        ],
      ),
    );
  }
}

class AdvisorSearch extends SearchDelegate<AdvisorData> {
  List<dynamic> list;
  AdvisorSearch({this.list});
  Future advisorData() async {
    var url = 'http://sanjayagarwal.in/Finance App/advisorData.php';
    final response = await http.post(
      url,
      body: jsonEncode(<String, String>{
        "Name": query,
      }),
    );
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      print(
          "**********************************************************************");
      print(query);
      print(
          "**********************************************************************");
      return jsonData;
    }
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          query = "";
          showSuggestions(context);
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back_ios),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: advisorData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                var list = snapshot.data[index];

                return ListTile(
                  title: Text(list['AdvisorID']),
                );
              });
        }
        return CircularProgressIndicator();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var listData = query.isEmpty
        ? list
        : list.where((element) => element.contains(query)).toList();
    return listData.isEmpty
        ? Center(
            child: Text(
            'NO ADVISOR FOUND',
            style: TextStyle(fontSize: 20),
          ))
        : ListView.builder(
            itemCount: listData.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  query = listData[index];
                  showResults(context);
                },
                title: Text(listData[index]),
              );
            });
  }
}
