library movies;

/// Data Folder
// data/datasources
export 'package:movies/data/datasources/movie_local_data_source.dart';
export 'package:movies/data/datasources/movie_remote_data_source.dart';

// data/models
export 'package:movies/data/models/movie_detail_model.dart';
export 'package:movies/data/models/movie_model.dart';
export 'package:movies/data/models/movie_response.dart';

// data/models/cache
export 'package:movies/data/models/cache/movie_detail_table.dart';
export 'package:movies/data/models/cache/movie_table.dart';

// data/repositories
export 'package:movies/data/repositories/movie_repository_impl.dart';

/// Domain Folder
// domain/entities
export 'package:movies/domain/entities/movie.dart';
export 'package:movies/domain/entities/movie_detail.dart';

// domain/repositories
export 'package:movies/domain/repositories/movie_repository.dart';

// domain/usecase
export 'package:movies/domain/usecase/get_movie_detail.dart';
export 'package:movies/domain/usecase/get_movie_recommendations.dart';
export 'package:movies/domain/usecase/get_now_playing_movies.dart';
export 'package:movies/domain/usecase/get_popular_movies.dart';
export 'package:movies/domain/usecase/get_top_rated_movies.dart';
export 'package:movies/domain/usecase/get_up_coming_movies.dart';
export 'package:movies/domain/usecase/get_watchlist_movies.dart';
export 'package:movies/domain/usecase/get_watchlist_status.dart';
export 'package:movies/domain/usecase/remove_watchlist.dart';
export 'package:movies/domain/usecase/save_watchlist.dart';
export 'package:movies/domain/usecase/search_movies.dart';

/// Presentation Folder
// presentation/bloc/movie_detail
export 'package:movies/presentation/bloc/movie_detail/movie_detail_bloc.dart';

// presentation/bloc/movie_list
export 'package:movies/presentation/bloc/movie_list/movie_list_bloc.dart';

// presentation/bloc/movie_search
export 'package:movies/presentation/bloc/movie_search/movie_search_bloc.dart';

// presentation/bloc/movie_watchlist
export 'package:movies/presentation/bloc/movie_watchlist/watchlist_movie_bloc.dart';

// presentation/bloc/see_more_popular
export 'package:movies/presentation/bloc/see_more_popular/see_more_popular_movie_bloc.dart';

// presentation/bloc/see_more_top_rated
export 'package:movies/presentation/bloc/see_more_top_rated/see_more_top_rated_movie_bloc.dart';

// presentation/bloc/see_more_upcoming
export 'package:movies/presentation/bloc/see_more_upcoming/see_more_upcoming_movie_bloc.dart';

// presentation/pages
export 'package:movies/presentation/pages/home_movie_page.dart';
export 'package:movies/presentation/pages/movie_detail_page.dart';
export 'package:movies/presentation/pages/popular_movies_page.dart';
export 'package:movies/presentation/pages/search_movie_page.dart';
export 'package:movies/presentation/pages/top_rated_movies_page.dart';
export 'package:movies/presentation/pages/up_coming_movies_page.dart';
export 'package:movies/presentation/pages/watchlist_movies_page.dart';

// presentation/provider
export 'package:movies/presentation/provider/movie_detail_notifier.dart';
export 'package:movies/presentation/provider/movie_list_notifier.dart';
export 'package:movies/presentation/provider/movie_search_notifier.dart';
export 'package:movies/presentation/provider/popular_movies_notifier.dart';
export 'package:movies/presentation/provider/top_rated_movies_notifier.dart';
export 'package:movies/presentation/provider/up_coming_movies_notifier.dart';
export 'package:movies/presentation/provider/watchlist_movie_notifier.dart';

// presentation/widgets
export 'package:movies/presentation/widgets/movie_card_list.dart';
