import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movievm/constants/my_theme_data.dart';
import 'package:movievm/enums/theme_enums.dart';
import 'package:movievm/screens/splash_screen.dart';
import 'package:movievm/service/init_getit.dart';
import 'package:movievm/service/navigation_service.dart';
import 'package:movievm/view_models/theme_provider.dart';

void main() async {
  setupLocator(); // Initialize GetIt
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    // DeviceOrientation.landscapeLeft,
    // DeviceOrientation.landscapeRight,
  ]).then((_) async {
    await dotenv.load(fileName: "assets/.env");
    runApp(const ProviderScope(child: MainApp()));
  });
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);

    return MaterialApp(
      navigatorKey: getIt<NavigationService>().navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'MovieVM',
      theme: themeState == ThemeEnums.dark
          ? MyThemeData.darkTheme
          : MyThemeData.lightTheme,
      home: const SplashScreen(),
    );
  }
}
