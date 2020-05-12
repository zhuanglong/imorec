// 电影榜单

import 'package:palette_generator/palette_generator.dart';
import 'movie_item_modal.dart';

class MovieTopBannerModal {
  List<MovieItemModal> movies;
  String title;
  String subTitle;
  String action;
  PaletteColor coverColor;

  MovieTopBannerModal(this.movies, this.title, this.subTitle, this.action, this.coverColor);
}