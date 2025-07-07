import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


class PDFScreen extends StatefulWidget {
  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  String? _localPdfPath;
  String errorMessage = '';

  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    loadPdfFromAssets();
  }

  Future<void> loadPdfFromAssets() async {
    try {
      final byteData = await rootBundle.load('assets/story/vocab.pdf');
      final file = File('${(await getTemporaryDirectory()).path}/vocab.pdf');
      await file.writeAsBytes(byteData.buffer.asUint8List());
      setState(() {
        _localPdfPath = file.path;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vocabulary PDF"),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.arrow_drop_down),
          //   onPressed: () {
          //     _pdfViewerKey.currentState?.jumpTo(pageNumber: 5); // Jump to page 5
          //   },
          // ),
        ],
      ),
      body: errorMessage.isNotEmpty
          ? Center(child: Text(errorMessage))
          : _localPdfPath == null
              ? Center(child: CircularProgressIndicator())
              : SfPdfViewer.file(
                  File(_localPdfPath!),
                  key: _pdfViewerKey,
                  canShowScrollHead: true,
                  canShowScrollStatus: true,
                  enableDoubleTapZooming: true,
                ),
    );
  }
}
