import 'package:flutter/material.dart';
class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF001F3F),
      appBar: AppBar(
      backgroundColor: Color(0xFF2E5B8B),
      title: Center(child: Text('Locais do seu mundo',style:TextStyle(color:Colors.black))),
      ),
      body:SizedBox.expand(
      child: Image.network(
      'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fpreview.redd.it%2Fmapa-mundi-groomind-v0-u6yo644qliaa1.jpg%3Fauto%3Dwebp%26s%3D1655648552c7d41e7ea86dbd28f6a652025775a3&f=1&nofb=1&ipt=86a2db0bd452e6b10d2326cc3cc180aaeef51f55197d1bf8a43ee4b21e46b1ff',
          ),
      )
    );
  }
}

