// 评分者评分

class MovieCommentRateModal {
  double max;
  double value;
  double min;

  MovieCommentRateModal(this.max, this.value, this.min);

  MovieCommentRateModal.fromJson(Map data) {
    max = data['max']?.toDouble();
    value = data['value'].toDouble();
    min = data['min'].toDouble();
  }
}

