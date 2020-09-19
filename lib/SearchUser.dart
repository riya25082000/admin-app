
import 'package:adminapp/user_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchUserPage extends StatefulWidget {
  @override
  _SearchUserPage createState() => _SearchUserPage();
}

class _SearchUserPage extends State<SearchUserPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Search User'),
        actions:<Widget> [
          IconButton(onPressed: () {
            showSearch(context: context, delegate: UserSearch());

          }, icon: Icon(Icons.search),)
        ],
      ),
    );

  }
}

class UserSearch extends SearchDelegate<UserData>{
  @override
  List<Widget> buildActions(BuildContext context) {

    return [IconButton(icon: Icon(Icons.clear), onPressed: () {
      query = "";
    },)];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(onPressed: () {
      close(context, null);
    }, icon: Icon(Icons.arrow_back),);
  }

  @override
  Widget buildResults(BuildContext context) {

    return Center(child: Text(query, style: TextStyle(fontSize: 20)));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
  final userList = query.isEmpty ? loadUserData() :
   loadUserData().where((p)=>p.UserName.startsWith(query)).toList();
  
  return  userList.isEmpty ? Text('No User Found', style: TextStyle(fontSize: 20),) :ListView.builder(
      itemCount: userList.length,
      itemBuilder: (context, index){
        final UserData listItem = userList[index];
        return ListTile (
          onTap: () {
            showResults(context);
          },
          title:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(listItem.UserName , style: TextStyle(fontSize: 20),),
            Text(listItem.UserID, style: TextStyle(color: Colors.grey),),
            Divider()
          ],
        ),);
  });
  }

}

