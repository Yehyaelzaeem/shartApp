import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import '../core/localization/appLocale.dart';
import 'custom_app_bar.dart';

class PDFViewerPage extends StatefulWidget {
  final String pdfUrl;
  PDFViewerPage({super.key, required this.pdfUrl});
  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  late String _filePath = '';
  @override
  void initState() {
    super.initState();
    _downloadFile();
  }

  Future<void> _downloadFile() async {
    Dio dio = Dio();
    try {
      final Directory dir = await getApplicationDocumentsDirectory();
      _filePath = '${dir.path}/document.pdf';
      await dio.download(widget.pdfUrl, _filePath);
      setState(() {});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 70.h),
          child: CustomAppBar(title: 'PDF', hasBackButton: true)),
      body: _filePath.isEmpty
          ? Center(
        child: CircularProgressIndicator(),
      )
          :
      PDFView(
        filePath: _filePath,
        enableSwipe: true,
        swipeHorizontal: false,
        autoSpacing: true,
        pageFling: true,
        onRender: (int? _pages) {
          setState(() {
          });
        },
        onError: (error) {
          debugPrint(error.toString());
        },
        onPageError: (int? page, error) {
          debugPrint('$page: ${error.toString()}');
        },
        // onViewCreated: (PDFViewController pdfViewController) {
        //   _controller.complete(pdfViewController);
        // },
        // onPageChanged: (int page, int total) {
        //   print('page change: $page/$total');
        // },
      ),
    );
  }
}


