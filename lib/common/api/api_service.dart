import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;

import 'package:imorec/modal/movie_news_modal.dart';

class ApiService {
  static const String baseUrl = 'http://api.douban.com/v2/movie/';
  static const String apiKey = '0b2bdeda43b5688921839c8ecb20399b';
  static const String webUrl = 'https://movie.douban.com/';

  static Dio createDio() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 10000,
      receiveTimeout: 100000,
      queryParameters: {
        'apikey': apiKey
      }
    );
    Dio dio = Dio(options);

    // 抓包配置，同时需要打开 charles
    const bool enabledDebugHttp = false;
    if (enabledDebugHttp) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
        client.findProxy = (uri) {
          return 'PROXY 192.168.43.100:8888';
        };
      };
    }

    return dio;
  }

  Dio dio = ApiService.createDio();

  // 获取首页热门新闻文章
  Future<List<MovieNewsModal>> getNewsList() async {
    List<MovieNewsModal> news = [];
    await http.get(webUrl).then((http.Response response) {
      dom.Document document = parse(response.body.toString());
      List<dom.Element> items = document.getElementsByClassName('gallery-frame');
      items.forEach((item) {
        String cover = item.getElementsByTagName('img')[0].attributes['src'].toString().trim();
        String link = item.getElementsByTagName('a')[0].attributes['href'].toString().trim();
        String title = item.getElementsByTagName('h3')[0].text.toString().trim();
        String summary = item.getElementsByTagName('p')[0].text.toString().trim();
        MovieNewsModal movieNews = MovieNewsModal(title, cover, summary, link);
        news.add(movieNews);
      });
    });
    return news;
  }

  // 获取正在上映的电影
  Future<dynamic> getHottingList({int start, int count}) async {
    Response<Map> response = await dio.get('in_theaters', queryParameters: {'start': start, 'count': count});
    return response.data['subjects'];
  }

  // 获取即将上映的电影
  Future getComingList({int start, int count}) async {
    Response<Map> response = await dio.get('coming_soon', queryParameters: {'start': start, 'count': count});
    return response.data['subjects'];
  }

  // 获取本周口碑榜电影
  Future getWeeklyList() async {
    Response<Map> response = await dio.get('weekly');
    List content = response.data['subjects'];
    List movies = [];
    content.forEach((item) {
      movies.add(item['subject']);
    });
    return movies;
  }

  // 获取新片榜电影
  Future getNewMovieList() async {
    Response<Map> response = await dio.get('new_movies');
    return response.data['subjects'];
  }

  // 获取北美票房榜电影
  Future getUsBoxList() async {
    Response<Map> response = await dio.get('us_box');
    List content = response.data['subjects'];
    List movies = [];
    content.forEach((item) {
      movies.add(item['subject']);
    });
    return movies;
  }

  // 获取 top250 榜单
  Future getTop250List({int start, int count}) async {
    Response<Map> response = await dio.get('top250', queryParameters: {'start': start, 'count': count});
    return response.data['subjects'];
  }

  // 获取电影详情
  Future getMovieDetail(String movieId) async {
    Response<Map> response = await dio.get('subject/$movieId');
    return response.data;
  }

  // 获取演员
  Future getActorDetail(String actorId) async {
    Response<Map> response = await dio.get('celebrity/$actorId');
    return response.data;
  }

  // 获取图片
  Future getImage(String imageUrl) async {
    var response = await http.get(imageUrl);
    return response;
  }
}
