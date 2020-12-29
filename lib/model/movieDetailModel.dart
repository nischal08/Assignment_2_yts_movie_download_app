class MovieDetailModel {
  final String title;
  final String movieDesc;
  final int realeaseYear;
  final dynamic rating;
  final List genres;
  final List torrent;
  final String image;
  final int runtime;
  final int downloadCount;

  MovieDetailModel({
    this.downloadCount,
    this.runtime,
    this.image,
    this.title,
    this.movieDesc,
    this.rating,
    this.genres,
    this.realeaseYear,
    this.torrent,
  });
}
