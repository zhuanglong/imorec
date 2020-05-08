// 电影简介 item

import 'movie_image_modal.dart';
import 'movie_rate_modal.dart';
import 'movie_actor_modal.dart';

class MovieItemModal {
  List genres;
  MovieRateModal rating;
  String title;
  String year;
  MovieImageModal images;
  String id;
  String mainlandPubdate;
  int collectCount;
  List<MovieActorModal> casts;
  List<MovieActorModal> directors;

  MovieItemModal(
    this.genres,
    this.rating,
    this.title,
    this.year,
    this.images,
    this.id,
    this.mainlandPubdate,
    this.collectCount,
    this.casts,
    this.directors,
  );

  MovieItemModal.fromJson(Map data) {
    id = data['id'];
    images = MovieImageModal.fromJson(data['images']);
    year = data['year'];
    title = data['title'];
    genres = data['genres']?.cast<String>()?.toList();
    rating = MovieRateModal.fromJson(data['rating']);
    mainlandPubdate = data['mainland_pubdate'];
    collectCount = data['collect_count'];
    
    List<MovieActorModal> castsData = [];
    List<MovieActorModal> directorsData = [];

    for (int i = 0; i < data['casts'].length; i++) {
      castsData.add(MovieActorModal.fromJson(data['casts'][i]));
    }
    for (int i = 0; i < data['directors'].length; i++) {
      directorsData.add(MovieActorModal.fromJson(data['directors'][i]));
    }

    casts = castsData;
    directors = directorsData;
  }
}