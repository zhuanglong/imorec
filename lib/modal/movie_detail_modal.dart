// 电影详情

import 'movie_actor_modal.dart';
import 'movie_comment_modal.dart';
import 'movie_photo_modal.dart';
import 'movie_trailer_modal.dart';
import 'movie_image_modal.dart';
import 'movie_rate_modal.dart';

class MovieDetailModal {
  MovieRateModal rating; // 电影评分
  String originalTitle; // 原标题
  MovieImageModal images; // 电影封面
  String year; // 上映年份
  List<MovieCommentModal> comments; // 评论
  String alt; // 豆瓣地址
  String id; // 电影 id
  String title; // 电影标题
  List pubdates; // 上映日期
  List tags; // 电影标签
  List durations;
  List genres; // 电影类型
  List<MovieTrailerModal> trailers; // 预告
  List<MovieActorModal> casts; // 演员
  List<MovieActorModal> directors; // 导员
  List countries; // 国家
  List<MoviePhotoModal> photos; // 剧照
  String summary; // 电影简介

  MovieDetailModal(
    this.rating, this.originalTitle, this.images, this.year, this.comments, this.alt,
    this.id, this.title, this.pubdates, this.tags, this.durations, this.genres, this.trailers,
    this.casts, this.directors, this.countries, this.photos, this.summary,
  );

  MovieDetailModal.fromJson(Map data) {
    rating = MovieRateModal.fromJson(data['rating']);
    originalTitle = data['original_title'];
    images = MovieImageModal.fromJson(data['images']);
    year = data['year'];
    alt = data['alt'];
    id = data['id'];
    title = data['title'];
    pubdates = data['pubdates']?.cast<String>()?.toList();
    tags = data['tags']?.cast<String>()?.toList();
    durations = data['durations']?.cast<String>()?.toList();
    genres = data['genres']?.cast<String>()?.toList();
    countries = data['countries']?.cast<String>()?.toList();
    summary = data['summary'];

    List<MovieCommentModal> commentData = [];
    List<MovieActorModal> castsData = [];
    List<MovieActorModal> directorsData = [];
    List<MoviePhotoModal> photosData = [];
    List<MovieTrailerModal> trailerData = [];

    for (var i = 0; i < data['popular_comments'].length; i++) {
      commentData.add(MovieCommentModal.fromJson(data['popular_comments'][i]));
    }
    for (var i = 0; i < data['casts'].length; i++) {
      castsData.add(MovieActorModal.fromJson(data['casts'][i]));
    }
    for (var i = 0; i < data['directors'].length; i++) {
      directorsData.add(MovieActorModal.fromJson(data['directors'][i]));
    }
    for (var i = 0; i < data['photos'].length; i++) {
      photosData.add(MoviePhotoModal.fromJson(data['photos'][i]));
    }
    for (var i = 0; i < data['trailers'].length; i++) {
      trailerData.add(MovieTrailerModal.fromJson(data['trailers'][i]));
    }

    comments = commentData;
    casts = castsData;
    directors = directorsData;  
    photos = photosData;
    trailers = trailerData;
  }
}