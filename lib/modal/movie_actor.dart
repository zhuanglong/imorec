// 演员

import 'movie_image.dart';

class MovieActor {
  String alt;
  MovieImage avatars;
  String name;
  String id;

  MovieActor(this.alt, this.avatars, this.name, this.id);

  MovieActor.fromJson(Map data) {
    String avatarPlaceholder = 'http://img3.doubanio.com/f/movie/ca527386eb8c4e325611e22dfcb04cc116d6b423/pics/movie/celebrity-default-small.png';
    alt = data['alt'];
    name = data['name'];
    id = data['id'];
    if (data['avatars'] == null) {
      avatars = MovieImage(avatarPlaceholder, avatarPlaceholder, avatarPlaceholder);
    } else {
      avatars = MovieImage.fromJson(data['avatars']);
    }
  }
}

