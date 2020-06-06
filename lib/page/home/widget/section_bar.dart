import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'package:imorec/provider/theme_provider.dart';
import 'package:imorec/util/navigator_util.dart';

class SectionBar extends StatelessWidget {
  final String title;
  final String action;

  SectionBar(this.title, [this.action]);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              Consumer<ThemeProvider>(
                builder: (_, themeProvider, __) {
                  return Container(
                    width: 80,
                    height: 2,
                    color: themeProvider.theme['sectionBarLineColor'],
                  );
                },
              ),
            ],
          ),
          action != null
              ? GestureDetector(
                  onTap: () {
                    NavigatorUtil.pushMovieList(context, title, action);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '全部',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 3),
                      Consumer<ThemeProvider>(
                        builder: (_, themeProvider, __) {
                          return Icon(
                            CupertinoIcons.forward,
                            size: 14,
                            color: themeProvider.theme['textColor1'],
                          );
                        },
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