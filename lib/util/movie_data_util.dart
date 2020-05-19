import 'package:imorec/modal/movie_item_modal.dart';
import 'package:imorec/modal/movie_photo_modal.dart';
import 'package:imorec/modal/movie_actor_modal.dart';

class MovieDataUtil {
  static List<MovieItemModal> getMovieList(list) {
    List<MovieItemModal> movies = [];
    list.forEach((item) {
      movies.add(MovieItemModal.fromJson(item));
    });
    return movies;
  }

  static List<MoviePhotoModal> getPhotoList(list) {
    List<MoviePhotoModal> photos = [];
    list.forEach((item) {
      photos.add(MoviePhotoModal.fromJson(item));
    });
    return photos;
  }

  static String actor2String(List<MovieActorModal> actors) {
    StringBuffer sb = StringBuffer();
    actors.forEach((actor) {
      sb.write(' ${actor.name} ');
    });
    return sb.toString();
  }

  static String genres2String(List genres) {
    StringBuffer sb = StringBuffer();
    genres.forEach((genre) {
      sb.write(' $genre ');
    });
    return sb.toString();
  }

  static String list2String(List list) {
    StringBuffer sb = StringBuffer();
    list.forEach((item) {
      sb.write(' $item ');
    });
    return sb.toString();
  }

  static String countries2String(List countries) {
    StringBuffer sb = StringBuffer();
    countries.forEach((country) {
      sb.write(' $country ');
    });
    return sb.toString();
  }

  static String number2Unit(int number) {
    double n;
    if (number >= 1000) {
      n = number / 1000;
      return n.toStringAsFixed(1) + 'k';
    }
    return number.toString();
  }
}