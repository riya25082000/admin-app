import 'dart:convert';
import 'package:adminapp/user_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchUserPage extends StatefulWidget {
  @override
  _SearchUserPage createState() => _SearchUserPage();
}

class _SearchUserPage extends State<SearchUserPage> {
  List searchList = [];
  Future userSearchData() async {
    var url = 'http://sanjayagarwal.in/Finance App/SearchUser.php';
    final response = await http.post(
      url
    );
    if(response.statusCode == 200)
     {
       var jsonData = jsonDecode(response.body);

       for(var i =0; i<jsonData.length; i++)
         {
           searchList.add(jsonData[i]['Name']);
         }

       print(searchList);
     }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userSearchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Search User', style: TextStyle(color: Colors.black),),
        actions:<Widget> [
          IconButton(onPressed: () {
            showSearch(context: context, delegate: UserSearch(list: searchList));

          }, icon: Icon(Icons.search),)

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Color(0xff373D3F),
        ),
        centerTitle: true,
        title: Text(
          'SEARCH USER',
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: UserSearch());
            },
            icon: Icon(Icons.search),
            color: Color(0xff373D3F),
          )
        ],
        backgroundColor: Color(0xff63E2E0),
      ),
    );
  }
}

class UserSearch extends SearchDelegate<String>{

  List<dynamic> list;
  UserSearch({this.list});

  Future userData() async {
    var url = 'http://sanjayagarwal.in/Finance App/userData.php';
    final response = await http.post(
        url,
      body: jsonEncode(<String, String>{
        "Name": query,

      }),
    );

    if(response.statusCode == 200)
    {
      var jsonData = jsonDecode(response.body);
      print("**********************************************************************");
      print(query);
      print("**********************************************************************");
      return jsonData;

    }
  }

  @override
  List<Widget> buildActions(BuildContext context) {

    return [IconButton(icon: Icon(Icons.search), onPressed: () {
      query = "";
      showSuggestions(context);
    },)];
class UserSearch extends SearchDelegate<UserData> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
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
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder (
      future: userData(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data.length,
              itemBuilder: (context,index){
              var list = snapshot.data[index];

            return ListTile(title: Text(list['UserID']),);
          });
        }
        return CircularProgressIndicator();
        },);
    return Center(child: Text(query, style: TextStyle(fontSize: 20)));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
   var listData =  query.isEmpty ? list : list.where((element) => element.contains(query)).toList();
    return listData.isEmpty ? Center(child: Text('NO USER FOUND',  style: TextStyle(fontSize: 20), )) : ListView.builder(
      itemCount: listData.length,
        itemBuilder: (context, index){
          return ListTile(
            onTap: (){
              query = listData[index];
              showResults(context);
            },
            title: Text(listData[index]),);
    });

  }
    final userList = query.isEmpty
        ? loadUserData()
        : loadUserData().where((p) => p.UserName.startsWith(query)).toList();

    return userList.isEmpty
        ? Text(
            'No User Found',
            style: TextStyle(fontSize: 20),
          )
        : ListView.builder(
            itemCount: userList.length,
            itemBuilder: (context, index) {
              final UserData listItem = userList[index];
              return ListTile(
                onTap: () {
                  showResults(context);
                },
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      listItem.UserName,
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      listItem.UserID,
                      style: TextStyle(color: Colors.grey),
                    ),
                    Divider()
                  ],
                ),
              );
            });
  }
}
