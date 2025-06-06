import 'package:ditonton_clean_architecture/data/models/movies/cache/movie_table.dart';
import 'package:ditonton_clean_architecture/data/models/tv_series/created_by_model.dart';
import 'package:ditonton_clean_architecture/data/models/tv_series/tv_series_table.dart';
import 'package:ditonton_clean_architecture/domain/entities/genre.dart';
import 'package:ditonton_clean_architecture/domain/entities/movies/movie.dart';
import 'package:ditonton_clean_architecture/domain/entities/movies/movie_detail.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/created_by.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/episode_to_air.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/production_companies.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/season.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/tv_detail.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/tv_series.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
  'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testTvSeries = TvSeries(
  adult: false,
  backdropPath: '/ottT2Yt0OfHiHp3PHJTLNVV8JPE.jpg',
  genreIds: [18, 10766],
  id: 13945,
  originCountry: ["DE"],
  originalLanguage: "de",
  originalName: "Gute Zeiten, schlechte Zeiten",
  overview:
  "Gute Zeiten, schlechte Zeiten is a long-running German television soap opera, first broadcast on RTL in 1992. The programme concerns the lives of a fictional neighborhood in Germany's capital city Berlin. Over the years the soap opera tends to have an overhaul of young people in their late teens and early twenties; targeting a young viewership.",
  popularity: 677.2062,
  posterPath: "/qujVFLAlBnPU9mZElV4NZgL8iXT.jpg",
  firstAirDate: "1992-05-11",
  name: "Gute Zeiten, schlechte Zeiten",
  voteAverage: 5.769,
  voteCount: 39,
);

final testMovieList = [testMovie];
final testTvList = [testTvSeries];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testTvDetail = TvDetail(
  adult: false,
  backdropPath: 'backdropPath',
  createdBy: [
    CreatedBy(
      id: 1,
      creditId: "creditId",
      name: "name",
      originalName: "originalName",
      gender: 1,
      profilePath: "profilePath",
    ),
  ],
  episodeRunTime: [1],
  firstAirDate: 'firstAirDate',
  genres: [Genre(id: 1, name: 'Action')],
  homepage: 'homepage',
  id: 1,
  inProduction: false,
  lastAirDate: 'lastAirDate',
  lastEpisodeToAir: EpisodeToAir(
    id: 1,
    name: 'name',
    overview: 'overview',
    voteAverage: 1.0,
    voteCount: 1,
    airDate: 'airDate',
    episodeNumber: 1,
    episodeType: 'episodeType',
    productionCode: 'productionCode',
    runtime: 1,
    seasonNumber: 1,
    showId: 1,
    stillPath: 'stillPath',
  ),
  name: 'name',
  nextEpisodeToAir: EpisodeToAir(
    id: 1,
    name: 'name',
    overview: 'overview',
    voteAverage: 1.0,
    voteCount: 1,
    airDate: 'airDate',
    episodeNumber: 1,
    episodeType: 'episodeType',
    productionCode: 'productionCode',
    runtime: 1,
    seasonNumber: 1,
    showId: 1,
    stillPath: 'stillPath',
  ),
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  overview: 'overview',
  popularity: 2.0,
  posterPath: 'posterPath',
  productionCompanies: [
    ProductionCompanies(
      id: 1,
      logoPath: 'logoPath',
      name: 'name',
      originCountry: 'originCountry',
    ),
  ],
  seasons: [
    Season(
      airDate: 'airDate',
      episodeCount: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      posterPath: 'posterPath',
      seasonNumber: 1,
      voteAverage: 1.0,
    ),
  ],
  status: 'status',
  voteAverage: 1,
  voteCount: 1,
);

final testMovieCache = MovieTable(
  id: 557,
  overview:
  'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  title: 'Spider-Man',
);

final testTvCache = TvSeriesTable(
  id: 13945,
  overview:
  "Gute Zeiten, schlechte Zeiten is a long-running German television soap opera, first broadcast on RTL in 1992. The programme concerns the lives of a fictional neighborhood in Germany's capital city Berlin. Over the years the soap opera tends to have an overhaul of young people in their late teens and early twenties; targeting a young viewership.",
  posterPath: '/qujVFLAlBnPU9mZElV4NZgL8iXT.jpg',
  name: 'Gute Zeiten, schlechte Zeiten',
);

final testMovieCacheMap = {
  'id': 557,
  'overview':
  'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  'posterPath': '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  'title': 'Spider-Man',
};

final testTvCacheMap = {
  'id': 13945,
  'overview':
  "Gute Zeiten, schlechte Zeiten is a long-running German television soap opera, first broadcast on RTL in 1992. The programme concerns the lives of a fictional neighborhood in Germany's capital city Berlin. Over the years the soap opera tends to have an overhaul of young people in their late teens and early twenties; targeting a young viewership.",
  'posterPath': '/qujVFLAlBnPU9mZElV4NZgL8iXT.jpg',
  'name': 'Gute Zeiten, schlechte Zeiten',
};

final testMovieFromCache = Movie.watchlist(
  id: 557,
  overview:
  'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  title: 'Spider-Man',
);

final testTvFromCache = TvSeries.watchlist(
  id: 13945,
  overview:
  "Gute Zeiten, schlechte Zeiten is a long-running German television soap opera, first broadcast on RTL in 1992. The programme concerns the lives of a fictional neighborhood in Germany's capital city Berlin. Over the years the soap opera tends to have an overhaul of young people in their late teens and early twenties; targeting a young viewership.",
  posterPath: '/qujVFLAlBnPU9mZElV4NZgL8iXT.jpg',
  name: 'Gute Zeiten, schlechte Zeiten',
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testWatchlistTv = TvSeries.watchlist(
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  name: 'name',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvTable = TvSeriesTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};

final testCreatedByModel = CreatedByModel(
  id: 1,
  creditId: 'creditId',
  name: 'Creator Name',
  gender: 1,
  profilePath: 'profilePath.jpg',
);

