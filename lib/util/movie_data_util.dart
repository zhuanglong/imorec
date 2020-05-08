import 'package:imorec/modal/movie_item_modal.dart';
import 'package:imorec/modal/movie_photo_modal.dart';

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
}