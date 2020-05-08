// 演员

import 'movie_image_modal.dart';

class MovieActorModal {
  String alt;
  MovieImageModal avatars;
  String name;
  String id;

  MovieActorModal(this.alt, this.avatars, this.name, this.id);

  MovieActorModal.fromJson(Map data) {
    String avatarPlaceholder = 'http://img3.doubanio.com/f/movie/ca527386eb8c4e325611e22dfcb04cc116d6b423/pics/movie/celebrity-default-small.png';
    alt = data['alt'];
    name = data['name'];
    id = data['id'];
    if (data['avatars'] == null) {
      avatars = MovieImageModal(avatarPlaceholder, avatarPlaceholder, avatarPlaceholder);
    } else {
      avatars = MovieImageModal.fromJson(data['avatars']);
    }
  }
}

