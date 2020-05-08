import 'package:imorec/modal/movie_item.dart';
import 'package:imorec/modal/movie_photo.dart';

class MovieDataUtil {
  static List<MovieItem> getMovieList(list) {
    List<MovieItem> movies = [];
    list.forEach((item) {
      movies.add(MovieItem.fromJson(item));
    });
    return movies;
  }

  static List<MoviePhoto> getPhotoList(list) {
    List<MoviePhoto> photos = [];
    list.forEach((item) {
      photos.add(MoviePhoto.fromJson(item));
    });
    return photos;
  }
}