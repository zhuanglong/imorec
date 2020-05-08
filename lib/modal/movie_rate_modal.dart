// 电影评分

class MovieRateModal {
  double max;
  double average;
  String stars;
  double min;

  MovieRateModal(this.max, this.average, this.stars, this.min);

  MovieRateModal.fromJson(Map data) {
    max = data['max']?.toDouble();
    average = data['average'].toDouble();
    stars = data['stars'];
    min = data['min'].toDouble();
  }
}

