// 电影封面图片

class MovieImageModal {
  String small;
  String large;
  String medium;

  MovieImageModal(this.small, this.large, this.medium);

  MovieImageModal.fromJson(Map data) {
    small = data['small'];
    large = data['large'];
    medium = data['medium'];
  }
}

