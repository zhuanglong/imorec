import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:imorec/app/api_client.dart';
import 'package:imorec/modal/movie_item_modal.dart';
import 'package:imorec/page/movie/widget/movie_list_item.dart';

class MovieListPage extends StatefulWidget {
  final String title;
  final String action;

  MovieListPage({this.title, this.action});

  @override
  _MovieListPageState createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  List<MovieItemModal> _movieList = [];

  int _start = 0;
  int _count = 20;
  bool _loaded = false;

  ScrollController _scrollController = ScrollController();
  
  @override
  void initState() {
    super.initState();
    _fetchData();

    // 滑动到底部
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text(this.widget.title),
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: back,
          child: Image.asset('images/icon_arrow_back_black.png'),
        ),
        elevation: 0,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_movieList.length == 0) {
      return Center(
        child: CupertinoActivityIndicator(),
      );
    }
    return Container(
      child: ListView.builder(
        itemCount: _movieList.length,
        itemBuilder: (BuildContext context, int index) {
          if (index + 1 == _movieList.length) {
            return Container(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Offstage(
                  offstage: _loaded,
                  child: CupertinoActivityIndicator(),
                ),
              ),
            );
          }
          return MovieListItem(_movieList[index], this.widget.action);
        },
        controller: _scrollController,
      ),
    );
  }

  back() {
    Navigator.pop(context);
  }

  Future _fetchData() async {
    if (_loaded) return;

    ApiClient client = ApiClient();
    var data;
    switch (this.widget.action) {
      case 'in_theaters':
        data = await client.getHottingList(start: _start, count: _count);
        break;
      case 'coming_soon':
        data = await client.getComingList(start: _start, count: _count);
        break;
      default:
    }
    List<MovieItemModal> newMovies = [];
    data.forEach((item) {
      newMovies.add(MovieItemModal.fromJson(item));
    });
    
    setState(() {
      if (newMovies.length == 0) {
        _loaded = true;
        return;
      }
      _movieList.addAll(newMovies);
      _start = _start + _count;
    });
  }
}