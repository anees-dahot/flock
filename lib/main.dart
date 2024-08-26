import 'package:flock/core/theme/theme_cubit.dart';
import 'package:flock/features/add%20posts/screens/add_post.dart';
import 'package:flock/features/splash%20screen/screens/splash_screen.dart';
import 'package:flock/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workmanager/workmanager.dart';

import 'core/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //  await Workmanager().initialize(callbackDispatcher);

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
            themeMode: ThemeMode.dark,
            onGenerateRoute: generateRoute,
            // initialRoute: NavigationBarScreen.routeName,
            home: AddPost(),
          );
        },
      ),
    );
  }
}
