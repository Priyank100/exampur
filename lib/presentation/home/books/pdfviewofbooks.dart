// import 'package:exampur_mobile/utils/appBar.dart';
// import 'package:flutter/material.dart';
// import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
//
// class PdfViewBooks extends StatefulWidget {
//   const PdfViewBooks({Key? key}) : super(key: key);
//
//   @override
//   _PdfViewBooksState createState() => _PdfViewBooksState();
// }
//
// class _PdfViewBooksState extends State<PdfViewBooks> {
//   bool _isLoading = true;
//   late PDFDocument document;
//   loadDocument() async {
//     document = await PDFDocument.fromURL("https://unec.edu.az/application/uploads/2014/12/pdf-sample.pdf");
//
//     setState(() => _isLoading = false);
//   }
//   @override
//   void initState() {
//     super.initState();
//     loadDocument();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(),
//       body: _isLoading
//       ? Center(child: CircularProgressIndicator())
//         : PDFViewer(
//     document: document),
//     );
//   }
// }
