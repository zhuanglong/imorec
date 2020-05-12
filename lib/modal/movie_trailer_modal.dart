class MovieTrailerModal {
  String cover;
  String trailerUrl;
  String id;

  MovieTrailerModal(this.cover, this.id, this.trailerUrl);

  MovieTrailerModal.fromJson(Map data) {
    cover = data['medium'];
    trailerUrl = data['resource_url'];
    id = data['id'];
  }
}