import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tneos_eduloution/widgets/drawer.dart';
import 'package:tneos_eduloution/widgets/navbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PackageView extends StatefulWidget {
  @override
  PackageViewState createState() => PackageViewState();
}

class PackageViewState extends State<PackageView> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: "Buy Course",
      ),
      drawer: ArgonDrawer(
        currentPage: "Packages Website",
      ),
      body: WebView(
        initialUrl: 'https://tneos.in/packages',
      ),
    );
  }
}