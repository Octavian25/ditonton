import 'package:about/about_page.dart';
import 'package:core/core.dart';
import 'package:ditonton/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/search.dart';
import 'package:core/presentation/pages/home_series_page.dart';
import 'package:core/presentation/pages/movie_detail_page.dart';
import 'package:core/presentation/pages/home_movie_page.dart';
import 'package:core/presentation/pages/popular_movies_page.dart';
import 'package:core/presentation/pages/popular_series_page.dart';
import 'package:core/presentation/pages/series_detail_page.dart';
import 'package:core/presentation/pages/top_rated_movies_page.dart';
import 'package:core/presentation/pages/top_rated_series_page.dart';
import 'package:core/presentation/pages/watchlist_movies_page.dart';
import 'package:core/presentation/pages/watchlist_series_page.dart';
import 'package:core/presentation/bloc/movies/popular_movies_bloc/popular_movies_bloc.dart';
import 'package:core/presentation/bloc/movies/now_playing/now_playing_bloc_bloc.dart';
import 'package:core/presentation/bloc/movies/top_rated/top_rated_bloc.dart';
import 'package:core/presentation/bloc/movies/recommendation_movies/recommendation_movies_bloc.dart';
import 'package:core/presentation/bloc/movies/added_wachlist_movies/added_wachlist_movies_bloc.dart';
import 'package:core/presentation/bloc/movies/detail_movies/detail_movies/detail_movies_bloc.dart';
import 'package:core/presentation/bloc/movies/watchlist_movies/watchlist_movies_bloc.dart';
import 'package:core/presentation/bloc/series/on_the_air_series/on_the_air_series_bloc.dart';
import 'package:core/presentation/bloc/series/popular_series/popular_series_bloc.dart';
import 'package:core/presentation/bloc/series/top_rated_series/top_rated_series_bloc.dart';
import 'package:core/presentation/bloc/series/added_watchlist_series/added_watchlist_series_bloc.dart';
import 'package:core/presentation/bloc/series/recommendation_series/recommendation_series_bloc.dart';
import 'package:core/presentation/bloc/series/detail_series/detail_series_bloc.dart';
import 'package:core/presentation/bloc/series/watchlist_series/watchlist_series_bloc.dart';
import 'package:core/utils/route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SSLPinning.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (context) => di.locator<SearchMovieBloc>()),
        BlocProvider(create: (context) => di.locator<SearchSeriesBloc>()),
        BlocProvider(create: (context) => di.locator<PopularMoviesBloc>()),
        BlocProvider(create: (context) => di.locator<NowPlayingBloc>()),
        BlocProvider(create: (context) => di.locator<TopRatedBloc>()),
        BlocProvider(create: (context) => di.locator<OnTheAirSeriesBloc>()),
        BlocProvider(create: (context) => di.locator<PopularSeriesBloc>()),
        BlocProvider(create: (context) => di.locator<TopRatedSeriesBloc>()),
        BlocProvider(create: (context) => di.locator<DetailMoviesBloc>()),
        BlocProvider(create: (context) => di.locator<DetailSeriesBloc>()),
        BlocProvider(create: (context) => di.locator<WatchlistMoviesBloc>()),
        BlocProvider(create: (context) => di.locator<WatchlistSeriesBloc>()),
        BlocProvider(
            create: (context) => di.locator<RecommendationSeriesBloc>()),
        BlocProvider(
            create: (context) => di.locator<AddedWachlistMoviesBloc>()),
        BlocProvider(
            create: (context) => di.locator<AddedWatchlistSeriesBloc>()),
        BlocProvider(
            create: (context) => di.locator<RecommendationMoviesBloc>()),
        ChangeNotifierProvider(
          create: (_) => di.locator<SeriesSearchNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Ditonton',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomeMoviePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case HomeSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeSeriesPage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case PopularSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularSeriesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case TopRatedSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedSeriesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SeriesDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => SeriesDetailPage(id: id),
                settings: settings,
              );
            case SEARCH_MOVIE_ROUTE:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case SEARCH_SERIES_ROUTE:
              return CupertinoPageRoute(builder: (_) => SearchSeriesPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case WatchlistSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistSeriesPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
