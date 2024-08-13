import 'package:flock/core/theme/theme_cubit.dart';
import 'package:flock/features/create%20account/screens/suggested_friends.dart';
import 'package:flock/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/theme.dart';
import 'features/tabbars/screens/tab_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeCubit = ThemeCubit();
  await themeCubit.loadTheme();

  runApp(MyApp(themeCubit: themeCubit));
}

class MyApp extends StatelessWidget {
  final ThemeCubit themeCubit;

  const MyApp({super.key, required this.themeCubit});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>.value(value: themeCubit),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeMode,
            onGenerateRoute: generateRoute,
            initialRoute: TabScreen.routeName,
          );
        },
      ),
    );
  }
}
