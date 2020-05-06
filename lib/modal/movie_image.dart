// 电影封面图片

class MovieImage {
  String small;
  String large;
  String medium;

  MovieImage(this.small, this.large, this.medium);

  MovieImage.fromJson(Map data) {
    small = data['small'];
    large = data['large'];
    medium = data['medium'];
  }
}

