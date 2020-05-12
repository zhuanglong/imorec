// 评论

import 'movie_comment_author_modal.dart';
import 'movie_comment_rate_modal.dart';

class MovieCommentModal {
  MovieCommentRateModal rating;
  int usefulCount;
  MovieCommentAuthorModal author;
  String content;
  String time;
  String id;

  MovieCommentModal(this.rating, this.usefulCount, this.author, this.content, this.time, this.id);

  MovieCommentModal.fromJson(Map data) {
    rating = MovieCommentRateModal.fromJson(data['rating']);
    usefulCount = data['useful_count'];
    author = MovieCommentAuthorModal.fromJson(data['author']);
    content = data['content'];
    time = data['created_at'];
    id = data['id'];
  }
}