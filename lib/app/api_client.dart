import 'dart:io';
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;

import 'package:imorec/modal/movie_news.dart';

class ApiClient {
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
    // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
    //   client.findProxy = (uri) {
    //     return 'PROXY 192.168.43.100:8888';
    //   };
    // };

    return dio;
  }

  Dio dio = ApiClient.createDio();

  // 获取首页热门新闻文章
  Future<List<MovieNews>> getNewsList() async {
    List<MovieNews> news = [];
    await http.get(webUrl).then((http.Response response) {
      dom.Document document = parse(response.body.toString());
      List<dom.Element> items = document.getElementsByClassName('gallery-frame');
      items.forEach((item) {
        String cover = item.getElementsByTagName('img')[0].attributes['src'].toString().trim();
        String link = item.getElementsByTagName('a')[0].attributes['href'].toString().trim();
        String title = item.getElementsByTagName('h3')[0].text.toString().trim();
        String summary = item.getElementsByTagName('p')[0].text.toString().trim();
        MovieNews movieNews = MovieNews(title, cover, summary, link);
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
}
