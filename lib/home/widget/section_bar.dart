import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SectionBar extends StatelessWidget {
  final String title;
  final Function action;

  SectionBar(this.title, [this.action]);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                '$title',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Container(
                width: 80,
                height: 2,
                color: Colors.black,
              ),
            ],
          ),
          action != null
              ? GestureDetector(
                  onTap: action,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          '全部',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 3),
                      Icon(
                        CupertinoIcons.forward,
                        size: 14,
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}