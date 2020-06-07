import 'package:flutter/material.dart';

class RouterTest extends StatefulWidget {
  final String title;
  final String content;

  RouterTest({this.title = 'defaultTitle', this.content = 'defaultContent'});

  @override
  _RouterTestState createState() => _RouterTestState();
}

class _RouterTestState extends State<RouterTest> {
  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final Map routerArgs = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          routerArgs['title'] ?? this.widget.title,
          style: TextStyle(
            color: Colors.amberAccent,
          ),
        ),
      ),
      body: Center(
        child: Text(routerArgs['content'] ?? this.widget.content),
      )
    );
  }
}