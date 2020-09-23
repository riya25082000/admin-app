import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

class ShowLetter extends StatefulWidget {
  String pdftitle, pdfurl;
  int id;
  ShowLetter(this.id, this.pdftitle, this.pdfurl);
  @override
  _ShowLetterState createState() => _ShowLetterState();
}

class _ShowLetterState extends State<ShowLetter> {
  String url = "http://www.pdf995.com/samples/pdf.pdf";
  PDFDocument _doc;
  bool _loading;

  @override
  void initState() {
    super.initState();
    _initPdf();
  }

  _initPdf() async {
    setState(() {
      _loading = true;
    });
    final doc = await PDFDocument.fromURL(widget.pdfurl);
    setState(() {
      _doc = doc;
      _loading = false;
    });
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
          widget.pdftitle,
          style: TextStyle(color: Color(0xff373D3F)),
        ),
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Color(0xff63E2E0),
              ),
            )
          : PDFViewer(
              document: _doc,
              indicatorBackground: Color(0xff63E2E0),
              // showIndicator: false,
              // showPicker: false,
            ),
    );
  }
}
