// 电影剧照

class MoviePhotoModal {
  String thumb;
  String image;
  String cover;
  String alt;
  String id;
  String icon;

  MoviePhotoModal(this.thumb, this.image, this.cover, this.alt, this.id, this.icon);

  MoviePhotoModal.fromJson(Map data) {
    thumb = data['thumb'];
    image = data['image'];
    cover = data['cover'];
    alt = data['alt'];
    id = data['id'];
    icon = data['icon'];
  }
}