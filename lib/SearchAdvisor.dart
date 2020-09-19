

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'advisor_data.dart';

class SearchAdvisorPage extends StatefulWidget {
  @override
  _SearchAdvisorPage createState() => _SearchAdvisorPage();
}

class _SearchAdvisorPage extends State<SearchAdvisorPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Advisor'),
        actions:<Widget> [
          IconButton(onPressed: () {
            showSearch(context: context, delegate: AdvisorSearch());

          }, icon: Icon(Icons.search),)
        ],
      ),
    );

  }
}

class AdvisorSearch extends SearchDelegate<AdvisorData>{
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
    final advisorList = query.isEmpty ? loadAdvisorData() :
    loadAdvisorData().where((p)=>p.UserName.startsWith(query)).toList();

    return  advisorList.isEmpty ? Text('No Advisor Found', style: TextStyle(fontSize: 20),) :ListView.builder(
        itemCount: advisorList.length,
        itemBuilder: (context, index){
          final AdvisorData listItem = advisorList[index];
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

