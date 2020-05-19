import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:imorec/common/api/api_service.dart';
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
  List<MovieItemModal> movieList = [];

  int start = 0;
  int count = 20;
  bool loaded = false;

  ScrollController scrollController = ScrollController();
  
  @override
  void initState() {
    super.initState();
    fetchData();

    // 滑动到底部
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        fetchData();
      }
    });
  }

  back() {
    Navigator.pop(context);
  }

  Future fetchData() async {
    if (loaded) return;

    ApiService apiService = ApiService();
    var data;
    switch (this.widget.action) {
      case 'in_theaters':
        data = await apiService.getHottingList(start: start, count: count);
        break;
      case 'coming_soon':
        data = await apiService.getComingList(start: start, count: count);
        break;
      default:
    }
    List<MovieItemModal> newMovies = [];
    data.forEach((item) {
      newMovies.add(MovieItemModal.fromJson(item));
    });
    
    setState(() {
      if (newMovies.length == 0) {
        loaded = true;
        return;
      }
      movieList.addAll(newMovies);
      start = start + count;
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
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
      body: buildBody(),
    );
  }

  Widget buildBody() {
    if (movieList.length == 0) {
      return Center(
        child: CupertinoActivityIndicator(),
      );
    }
    return Container(
      child: ListView.builder(
        itemCount: movieList.length,
        itemBuilder: (BuildContext context, int index) {
          if (index + 1 == movieList.length) {
            return Container(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Offstage(
                  offstage: loaded,
                  child: CupertinoActivityIndicator(),
                ),
              ),
            );
          }
          return MovieListItem(movieList[index], this.widget.action);
        },
        controller: scrollController,
      ),
    );
  }
}