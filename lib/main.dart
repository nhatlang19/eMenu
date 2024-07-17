import 'package:emenu/bloc/add_to_cart_bloc/cart_bloc.dart';
import 'package:emenu/config/routes/router.dart' as router;
import 'package:emenu/config/routes/routes.dart';
import 'package:emenu/config/themes/app_colors.dart';
import 'package:emenu/modules/auth/bloc/auth_bloc.dart';
import 'package:emenu/repositories/auth_repository.dart';
import 'package:emenu/repositories/cart_repository.dart';
import 'package:emenu/repositories/item_repository.dart';
import 'package:emenu/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const MainApp());
  FlutterNativeSplash.remove();
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final AuthRepository _authenticationRepository;
  late final UserRepository _userRepository;
  late final ItemRepository _itemRepository;
  late final CartRepository _cartRepository;

  @override
  void initState() {
    super.initState();
    _authenticationRepository = AuthRepository();
    _userRepository = UserRepository();
    _itemRepository = ItemRepository();
    _cartRepository = CartRepository();
  }

  @override
  void dispose() {
    _authenticationRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: _authenticationRepository,
        child: MultiBlocProvider(providers: [
          BlocProvider<AuthBloc>(
            create: (_) => AuthBloc(
              authenticationRepository: _authenticationRepository,
              userRepository: _userRepository,
            ),
          ),
          BlocProvider<CartBloc>(
            create: (BuildContext context) =>
                CartBloc(itemRepository: _itemRepository, cartRepository: _cartRepository),
          ),
        ], child: const AppView()));
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;
  @override
  Widget build(BuildContext context) {
    // _splashAction();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EMenu',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.mainBLue,
            foregroundColor: Colors.white,
          )),
      initialRoute: Routes.mainPage,
      onGenerateRoute: router.Router.generateRoute,
      navigatorKey: _navigatorKey,
    );
  }
}
