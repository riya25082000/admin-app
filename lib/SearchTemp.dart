import 'package:flutter/material.dart';

class SearchTemp extends StatefulWidget {
  @override
  _SearchTempState createState() => _SearchTempState();
}

class _SearchTempState extends State<SearchTemp> {
  TextEditingController searchuser = TextEditingController();
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
        iconTheme: IconThemeData(
          color: Color(0xff373D3F),
        ),
        title: Text(
          "SEARCH",
          style: TextStyle(
            color: Color(0xff373D3F),
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff63E2E0),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search User",
                              hintStyle: TextStyle(color: Color(0xff373D3F)),
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
                            controller: searchuser,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {},
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
