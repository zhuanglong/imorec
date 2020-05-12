import 'package:imorec/modal/movie_actor_modal.dart';

String actor2String(List<MovieActorModal> actors) {
  StringBuffer sb = StringBuffer();
  actors.forEach((actor) {
    sb.write(' ${actor.name} ');
  });
  return sb.toString();
}

String genres2String(List genres) {
  StringBuffer sb = StringBuffer();
  genres.forEach((genre) {
    sb.write(' $genre ');
  });
  return sb.toString();
}

String list2String(List list) {
  StringBuffer sb = StringBuffer();
  list.forEach((item) {
    sb.write(' $item ');
  });
  return sb.toString();
}

String countries2String(List countries) {
  StringBuffer sb = StringBuffer();
  countries.forEach((country) {
    sb.write(' $country ');
  });
  return sb.toString();
}