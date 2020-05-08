// 首页新闻 banner

class MovieNewsModal {
  String title;
  String cover;
  String summary;
  String link;

  MovieNewsModal(this.title, this.cover, this.summary, this.link);

  MovieNewsModal.fromJson(Map data) {
    title = data['title'];
    summary = data['summary'];
    cover = data['cover'];
    link = data['link'];
  }
}