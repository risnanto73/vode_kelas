import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vodexapp_kelas/core/theme/vodex_theme.dart';
import 'package:vodexapp_kelas/cubit/home/home_cubit.dart';
import 'package:vodexapp_kelas/repository/movie_repository.dart';
import 'package:vodexapp_kelas/ui/screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  runApp(const VodexApp());
}

class VodexApp extends StatelessWidget {
  final MovieRepository? repository;

  const VodexApp({super.key, this.repository});

  @override
  Widget build(BuildContext context) {
    final movieRepository = repository ?? TmdbMovieRepository();
    return RepositoryProvider<MovieRepository>.value(
      value: movieRepository,
      child: BlocProvider<HomeCubit>(
        create: (_) => HomeCubit(movieRepository)..loadHome(),
        child: MaterialApp(
          title: 'Vodex — Video Online Desktop X',
          debugShowCheckedModeBanner: false,
          theme: VodexTheme.darkTheme,
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
