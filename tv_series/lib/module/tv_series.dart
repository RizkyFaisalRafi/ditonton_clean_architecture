library;

/// Data Folder
// data/datasources
export 'package:tv_series/data/datasources/tv_series_local_data_source.dart';
export 'package:tv_series/data/datasources/tv_series_remote_data_source.dart';

// data/models
export 'package:tv_series/data/models/created_by_model.dart';
export 'package:tv_series/data/models/episode_to_air_model.dart';
export 'package:tv_series/data/models/genre_model.dart';
export 'package:tv_series/data/models/production_companies_model.dart';
export 'package:tv_series/data/models/season_model.dart';
export 'package:tv_series/data/models/tv_detail_model.dart';
export 'package:tv_series/data/models/tv_model.dart';
export 'package:tv_series/data/models/tv_response.dart';

// data/models/cache
export 'package:tv_series/data/models/cache/tv_series_detail_table.dart';
export 'package:tv_series/data/models/cache/tv_series_table.dart';

// data/repositories
export 'package:tv_series/data/repositories/tv_series_repository_impl.dart';

/// Domain Folder
// domain/entities
export 'package:tv_series/domain/entities/created_by.dart';
export 'package:tv_series/domain/entities/episode_to_air.dart';
export 'package:tv_series/domain/entities/genre.dart';
export 'package:tv_series/domain/entities/production_companies.dart';
export 'package:tv_series/domain/entities/season.dart';
export 'package:tv_series/domain/entities/tv_detail.dart';
export 'package:tv_series/domain/entities/tv_series.dart';

// domain/repositories
export 'package:tv_series/domain/repositories/tv_series_repository.dart';

// domain/usecases
export 'package:tv_series/domain/usecases/get_airing_today_tv.dart';
export 'package:tv_series/domain/usecases/get_on_the_air_tv.dart';
export 'package:tv_series/domain/usecases/get_popular_tv.dart';
export 'package:tv_series/domain/usecases/get_top_rated_tv.dart';
export 'package:tv_series/domain/usecases/get_tv_detail.dart';
export 'package:tv_series/domain/usecases/get_tv_recommendations.dart';
export 'package:tv_series/domain/usecases/get_watchlist_status_tv.dart';
export 'package:tv_series/domain/usecases/get_watchlist_tv.dart';
export 'package:tv_series/domain/usecases/remove_watchlist_tv.dart';
export 'package:tv_series/domain/usecases/save_watchlist_tv.dart';
export 'package:tv_series/domain/usecases/search_tv_series.dart';

/// Presentation Folder
// presentation/bloc
export 'package:tv_series/presentation/bloc/see_more_on_the_air/see_more_on_the_air_tv_bloc.dart';
export 'package:tv_series/presentation/bloc/see_more_popular/see_more_popular_tv_bloc.dart';
export 'package:tv_series/presentation/bloc/see_more_top_rated/see_more_top_rated_tv_bloc.dart';
export 'package:tv_series/presentation/bloc/tv_detail/tv_detail_bloc.dart';
export 'package:tv_series/presentation/bloc/tv_list/airing_today/airing_today_tv_bloc.dart';
export 'package:tv_series/presentation/bloc/tv_list/on_the_air/on_the_air_tv_bloc.dart';
export 'package:tv_series/presentation/bloc/tv_list/popular/popular_tv_bloc.dart';
export 'package:tv_series/presentation/bloc/tv_list/top_rated/top_rated_tv_bloc.dart';
export 'package:tv_series/presentation/bloc/tv_search/tv_search_bloc.dart';
export 'package:tv_series/presentation/bloc/tv_watchlist/watchlist_tv_bloc.dart';

// presentation/pages
export 'package:tv_series/presentation/pages/on_the_air_tv_page.dart';
export 'package:tv_series/presentation/pages/popular_tv_page.dart';
export 'package:tv_series/presentation/pages/search_tv_page.dart';
export 'package:tv_series/presentation/pages/top_rated_tv_page.dart';
export 'package:tv_series/presentation/pages/tv_series_detail_page.dart';
export 'package:tv_series/presentation/pages/tv_series_page.dart';
export 'package:tv_series/presentation/pages/watchlist_tv_page.dart';

// presentation/provider
export 'package:tv_series/presentation/provider/drawer_provider.dart';
export 'package:tv_series/presentation/provider/on_the_air_notifier.dart';
export 'package:tv_series/presentation/provider/popular_tv_notifier.dart';
export 'package:tv_series/presentation/provider/top_rated_tv_notifier.dart';
export 'package:tv_series/presentation/provider/tv_detail_notifier.dart';
export 'package:tv_series/presentation/provider/tv_list_notifier.dart';
export 'package:tv_series/presentation/provider/tv_search_notifier.dart';
export 'package:tv_series/presentation/provider/watchlist_tv_notifier.dart';

// presentation/widgets
export 'package:tv_series/presentation/widgets/tv_card.dart';
