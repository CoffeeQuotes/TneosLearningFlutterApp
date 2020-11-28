import 'package:flutter/material.dart';
import 'package:tneos_eduloution/widgets/navbar.dart';

class Viewer extends StatefulWidget {
  final String path;
  Viewer(this.path);

  @override
  _ViewerState createState() => _ViewerState(this.path);
}

class _ViewerState extends State<Viewer> {
  String path;
  _ViewerState(this.path);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        transparent: true,
        backButton: true,
        title: "Viewer",
      ),
      backgroundColor: Colors.black.withOpacity(0.5),
      body: SafeArea(
        child: Center(
        child: InteractiveViewer(
          child: Image.network('https://tneos.in/'+ path),
        ),
          ),
      ),
    );
  }
}
