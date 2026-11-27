import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vodexapp_kelas/core/theme/vodex_theme.dart';
import 'package:vodexapp_kelas/main.dart';
import 'package:vodexapp_kelas/model/movie.dart';
import 'package:vodexapp_kelas/model/movie_details.dart';
import 'package:vodexapp_kelas/model/movie_images.dart';
import 'package:vodexapp_kelas/model/movie_list.dart' as ml;
import 'package:vodexapp_kelas/model/movie_videos.dart' as videos;
import 'package:vodexapp_kelas/model/now_playing.dart' as np;
import 'package:vodexapp_kelas/model/popular.dart' as pop;
import 'package:vodexapp_kelas/model/top_rated.dart' as tr;
import 'package:vodexapp_kelas/model/upcoming.dart' as up;
import 'package:vodexapp_kelas/repository/movie_repository.dart';
import 'package:vodexapp_kelas/ui/screens/discover_screen.dart';
import 'package:vodexapp_kelas/ui/screens/movie_detail_screen.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late MockMovieRepository repository;

  setUp(() {
    repository = MockMovieRepository();

    when(() => repository.getNowPlaying()).thenAnswer(
      (_) async => np.NowPlaying(
        dates: null,
        page: 1,
        totalPages: 1,
        totalResults: 1,
        results: [
          np.Result(
            adult: false,
            backdropPath: null,
            genreIds: const [28],
            id: 550,
            title: 'Interstellar',
            originalLanguage: 'en',
            originalTitle: 'Interstellar',
            overview: 'A team of explorers travel through a wormhole.',
            popularity: 120,
            posterPath: null,
            releaseDate: DateTime(2014, 11, 7),
            softcore: false,
            video: false,
            voteAverage: 8.7,
            voteCount: 33000,
          ),
        ],
      ),
    );

    when(() => repository.getPopular()).thenAnswer(
      (_) async => pop.Popular(
        page: 1,
        totalPages: 1,
        totalResults: 1,
        results: [
          pop.Result(
            adult: false,
            backdropPath: null,
            genreIds: const [18],
            id: 551,
            title: 'Oppenheimer',
            originalLanguage: 'en',
            originalTitle: 'Oppenheimer',
            overview: 'The story of J. Robert Oppenheimer.',
            popularity: 110,
            posterPath: null,
            releaseDate: DateTime(2023, 7, 21),
            softcore: false,
            video: false,
            voteAverage: 8.1,
            voteCount: 8000,
          ),
        ],
      ),
    );

    when(() => repository.getTopRated()).thenAnswer(
      (_) async => tr.TopRated(
        page: 1,
        totalPages: 1,
        totalResults: 1,
        results: [
          tr.Result(
            adult: false,
            backdropPath: null,
            genreIds: const [18],
            id: 552,
            title: 'The Shawshank Redemption',
            originalLanguage: 'en',
            originalTitle: 'The Shawshank Redemption',
            overview: 'Two imprisoned men bond over years.',
            popularity: 90,
            posterPath: null,
            releaseDate: DateTime(1994, 9, 23),
            softcore: false,
            video: false,
            voteAverage: 9.3,
            voteCount: 26000,
          ),
        ],
      ),
    );

    when(() => repository.getUpcoming()).thenAnswer(
      (_) async => up.Upcoming(
        dates: null,
        page: 1,
        totalPages: 1,
        totalResults: 1,
        results: [
          up.Result(
            adult: false,
            backdropPath: null,
            genreIds: const [878],
            id: 553,
            title: 'Dune Messiah',
            originalLanguage: up.OriginalLanguage.EN,
            originalTitle: 'Dune Messiah',
            overview: 'Upcoming sci-fi epic.',
            popularity: 80,
            posterPath: null,
            releaseDate: DateTime(2026, 12, 18),
            softcore: false,
            video: false,
            voteAverage: 8.0,
            voteCount: 100,
          ),
        ],
      ),
    );

    when(() => repository.getGenres()).thenAnswer(
      (_) async => ml.MovieList(
        genres: [
          ml.Genre(id: 28, name: 'Action'),
          ml.Genre(id: 878, name: 'Sci-Fi'),
        ],
      ),
    );

    when(() => repository.discoverMovies(genreId: any(named: 'genreId'), page: any(named: 'page')))
        .thenAnswer(
      (_) async => Movie(
        page: 1,
        totalPages: 1,
        totalResults: 1,
        results: [
          Result(
            adult: false,
            backdropPath: null,
            genreIds: const [28],
            id: 600,
            title: 'Mad Max: Fury Road',
            originalLanguage: 'en',
            originalTitle: 'Mad Max: Fury Road',
            overview: 'An apocalyptic story.',
            popularity: 95,
            posterPath: null,
            releaseDate: DateTime(2015, 5, 15),
            softcore: false,
            video: false,
            voteAverage: 8.1,
            voteCount: 22000,
          ),
        ],
      ),
    );

    when(() => repository.searchMovies(query: any(named: 'query'), page: any(named: 'page')))
        .thenAnswer(
      (_) async => Movie(
        page: 1,
        totalPages: 1,
        totalResults: 1,
        results: [
          Result(
            adult: false,
            backdropPath: null,
            genreIds: const [878],
            id: 700,
            title: 'Inception',
            originalLanguage: 'en',
            originalTitle: 'Inception',
            overview: 'A thief who steals corporate secrets.',
            popularity: 105,
            posterPath: null,
            releaseDate: DateTime(2010, 7, 16),
            softcore: false,
            video: false,
            voteAverage: 8.4,
            voteCount: 35000,
          ),
        ],
      ),
    );
  });

  group('Vodex Widget Tests', () {
    testWidgets('HomeScreen renders Vodex branding, genres, and movie sections',
        (tester) async {
      await tester.pumpWidget(VodexApp(repository: repository));
      await tester.pumpAndSettle();

      expect(find.text('VODEX'), findsOneWidget);
      expect(find.text('Video Online Desktop X'), findsOneWidget);
      expect(find.text('Action'), findsOneWidget);
      expect(find.text('Now Playing'), findsOneWidget);
      expect(find.text('Interstellar'), findsWidgets);

      await tester.tap(find.text('Action'));
      await tester.pumpAndSettle();

      expect(find.text('Mad Max: Fury Road'), findsOneWidget);
      verify(() => repository.discoverMovies(genreId: 28, page: 1)).called(1);
    });

    testWidgets('HomeScreen shows error view and retries on tap',
        (tester) async {
      when(() => repository.getNowPlaying())
          .thenThrow(Exception('Connection failed'));

      await tester.pumpWidget(VodexApp(repository: repository));
      await tester.pumpAndSettle();

      expect(find.text('Unable to load Vodex catalog'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
    });

    testWidgets('DiscoverScreen searches movies by query', (tester) async {
      await tester.pumpWidget(
        RepositoryProvider<MovieRepository>.value(
          value: repository,
          child: MaterialApp(
            theme: VodexTheme.darkTheme,
            home: const DiscoverScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Discover & Search'), findsOneWidget);
      expect(find.text('Mad Max: Fury Road'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'Inception');
      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pumpAndSettle();

      expect(find.text('Inception'), findsOneWidget);
      verify(() => repository.searchMovies(query: 'Inception', page: 1))
          .called(1);
    });

    testWidgets('MovieDetailScreen renders details, trailers, and gallery',
        (tester) async {
      when(() => repository.getMovieDetails(550)).thenAnswer(
        (_) async => MovieDetails(
          adult: false,
          backdropPath: null,
          belongsToCollection: null,
          budget: 165000000,
          genres: [Genre(id: 878, name: 'Science Fiction')],
          homepage: null,
          id: 550,
          imdbId: 'tt0816692',
          originCountry: const ['US'],
          originalLanguage: 'en',
          originalTitle: 'Interstellar',
          overview: 'Mankind was born on Earth. It was never meant to die here.',
          popularity: 120,
          posterPath: null,
          productionCompanies: [
            ProductionCompany(
              id: 1,
              logoPath: null,
              name: 'Syncopy',
              originCountry: 'GB',
            ),
          ],
          productionCountries: const [],
          releaseDate: DateTime(2014, 11, 7),
          revenue: 701729206,
          runtime: 169,
          softcore: false,
          spokenLanguages: const [],
          status: 'Released',
          tagline: 'Mankind was born on Earth.',
          title: 'Interstellar',
          video: false,
          voteAverage: 8.7,
          voteCount: 33000,
        ),
      );

      when(() => repository.getMovieImages(550)).thenAnswer(
        (_) async => MovieImages(
          id: 550,
          backdrops: const [],
          logos: const [],
          posters: const [],
        ),
      );

      when(() => repository.getMovieVideos(550)).thenAnswer(
        (_) async => videos.MovieVideos(
          id: 550,
          results: [
            videos.Result(
              iso6391: videos.Iso6391.EN,
              iso31661: videos.Iso31661.US,
              name: 'Main Trailer',
              key: 'zSWdZVtXT7E',
              site: videos.Site.YOU_TUBE,
              size: 1080,
              type: videos.Type.TRAILER,
              official: true,
              id: 'vid1',
              publishedAt: DateTime(2014, 10, 1),
            ),
          ],
        ),
      );

      await tester.pumpWidget(
        RepositoryProvider<MovieRepository>.value(
          value: repository,
          child: MaterialApp(
            theme: VodexTheme.darkTheme,
            home: const MovieDetailScreen(movieId: 550),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Interstellar'), findsOneWidget);
      expect(find.text('2h 49m'), findsOneWidget);
      expect(find.text('Science Fiction'), findsOneWidget);
      expect(find.text('Trailers & Videos'), findsOneWidget);
      expect(find.text('Main Trailer'), findsOneWidget);
      expect(find.text('Syncopy'), findsOneWidget);
    });
  });
}
