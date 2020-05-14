import 'package:imorec/modal/movie_item_modal.dart';
import 'package:imorec/modal/movie_photo_modal.dart';

import 'movie_image_modal.dart';

// 演员详情
class MovieActorDetailModal {
  String name;
  String enName;
  String gender;
  List professions;
  MovieImageModal avatars;
  List<MoviePhotoModal> photos; // 剧照
  String birthday;
  List aka; // 外号
  String bornPlace;
  String constellation; // 星座
  String id;
  List<MovieActorWorkModal> works;
  String summary;

  MovieActorDetailModal(
    this.name, this.enName, this.gender, this.professions, this.avatars,
    this.photos, this.birthday, this.aka, this.bornPlace, this.constellation,
    this.id, this.works, this.summary
  );

  MovieActorDetailModal.fromJson(Map data) {
    String avatarPlaceholder = 'http://img3.doubanio.com/f/movie/ca527386eb8c4e325611e22dfcb04cc116d6b423/pics/movie/celebrity-default-small.png';
    name = data['name'];
    enName = data['enName'];
    gender = data['gender'];
    professions = data['professions']?.cast<String>()?.toList();
    if (data['avatars'] == null) {
      avatars = MovieImageModal(avatarPlaceholder, avatarPlaceholder, avatarPlaceholder);
    } else {
      avatars = MovieImageModal.fromJson(data['avatars']);
    }
    birthday = data['birthday'];
    aka = data['aka']?.cast<String>()?.toList();
    bornPlace = data['born_place'];
    constellation = data['constellation'];
    id = data['id'];
    summary = data['summary'];

    List<MoviePhotoModal> photosData = [];
    List<MovieActorWorkModal> worksData = [];

    for (var i = 0; i < data['photos'].length; i++) {
      photosData.add(MoviePhotoModal.fromJson(data['photos'][i]));
    }
    for (var i = 0; i < data['works'].length; i++) {
      worksData.add(MovieActorWorkModal.fromJson(data['works'][i]));
    }

    photos = photosData;
    works = worksData;
  }
}

// 演员影视作品
class MovieActorWorkModal {
  List roles;
  MovieItemModal movie;

  MovieActorWorkModal(this.roles, this.movie);

  MovieActorWorkModal.fromJson(Map data) {
    roles = data['roles']?.cast<String>()?.toList();
    movie = MovieItemModal.fromJson(data['subject']);
  }
}
