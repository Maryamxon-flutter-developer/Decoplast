import 'package:decopalst/asosiy.dart';
import 'package:decopalst/document.dart';
import 'package:decopalst/icomning%20new.dart';
import 'package:decopalst/new%20incoming.dart';
import 'package:decopalst/scan.dart';
import 'package:decopalst/store.dart';
import 'package:decopalst/supliers.dart';
import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title: Text('WELCOME'),
          backgroundColor: const Color.fromARGB(0, 249, 248, 248),
          elevation: 10,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: List.generate(6, (index) {
                return ClayContainerWidget(index: index);
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class ClayContainerWidget extends StatefulWidget {
  final int index;

  const ClayContainerWidget({Key? key, required this.index}) : super(key: key);

  @override
  _ClayContainerWidgetState createState() => _ClayContainerWidgetState();
}

class _ClayContainerWidgetState extends State<ClayContainerWidget> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isTapped = !_isTapped;
        });

        // Navigate to a different page depending on the index
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => _getPageForIndex(widget.index),
          ),
        );
      },
      child: ClayTheme(
        themeData: const ClayThemeData(
          height: 10,
          width: 20,
          borderRadius: 370,
          textTheme: ClayTextTheme(style: TextStyle()),
          depth: 45,
        ),
        child: ClayAnimatedContainer(
          height: 150,
          width: 150,
          child: ClayContainer(
            borderRadius: 10,
            color: const Color.fromARGB(255, 233, 228, 228),
          ),
        ),
      ),
    );
  }

  // Helper function to return the corresponding page for each index
  Widget _getPageForIndex(int index) {
    switch (index) {
      case 0:
        return PostApiPage();
      case 1:
        return docsex();
      case 2:
        return qrcode();
      case 3:
        return stres();
      case 4:
        return subperson();
      case 5:
        return MyWidget();
      default:
        return emki();
    }
  }
}


