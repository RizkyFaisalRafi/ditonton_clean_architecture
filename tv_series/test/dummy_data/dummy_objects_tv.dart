import 'package:tv_series/module/tv_series.dart';

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

final testTvList = [testTvSeries];

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

final testTvCache = TvSeriesTable(
  id: 13945,
  overview:
      "Gute Zeiten, schlechte Zeiten is a long-running German television soap opera, first broadcast on RTL in 1992. The programme concerns the lives of a fictional neighborhood in Germany's capital city Berlin. Over the years the soap opera tends to have an overhaul of young people in their late teens and early twenties; targeting a young viewership.",
  posterPath: '/qujVFLAlBnPU9mZElV4NZgL8iXT.jpg',
  name: 'Gute Zeiten, schlechte Zeiten',
);

final testTvCacheMap = {
  'id': 13945,
  'overview':
      "Gute Zeiten, schlechte Zeiten is a long-running German television soap opera, first broadcast on RTL in 1992. The programme concerns the lives of a fictional neighborhood in Germany's capital city Berlin. Over the years the soap opera tends to have an overhaul of young people in their late teens and early twenties; targeting a young viewership.",
  'posterPath': '/qujVFLAlBnPU9mZElV4NZgL8iXT.jpg',
  'name': 'Gute Zeiten, schlechte Zeiten',
};

final testTvFromCache = TvSeries.watchlist(
  id: 13945,
  overview:
      "Gute Zeiten, schlechte Zeiten is a long-running German television soap opera, first broadcast on RTL in 1992. The programme concerns the lives of a fictional neighborhood in Germany's capital city Berlin. Over the years the soap opera tends to have an overhaul of young people in their late teens and early twenties; targeting a young viewership.",
  posterPath: '/qujVFLAlBnPU9mZElV4NZgL8iXT.jpg',
  name: 'Gute Zeiten, schlechte Zeiten',
);

final testWatchlistTv = TvSeries.watchlist(
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  name: 'name',
);

final testTvTable = TvSeriesTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

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
