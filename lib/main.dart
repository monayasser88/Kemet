import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kemet/cubit/createprofile_cubit.dart';
import 'package:kemet/cubit/home_cubit_cubit.dart';
import 'package:kemet/cubit2/logout_cubit.dart';
import 'package:kemet/logic/cache/cache_helper.dart';
import 'package:kemet/logic/core/api/dio_consumer.dart';
import 'package:kemet/pages2/account.dart';
import 'package:kemet/pages2/history_of_place.dart';
import 'package:kemet/pages2/profile_page.dart';
import 'package:kemet/pages2/setting.dart';
import 'package:kemet/providers2/theme_provider.dart';
import 'package:kemet/screens/book_ticket.dart';
import 'package:kemet/screens/homepage.dart';
import 'package:kemet/screens/intro3.dart';
import 'package:kemet/screens/login.dart';
import 'package:kemet/screens/logo.dart';
import 'package:kemet/screens/notification.dart';
import 'package:kemet/views2/favorites_legend_view.dart';
import 'package:kemet/views2/favorites_tourism_view.dart';
import 'package:kemet/views2/favorites_trips_view.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  
  runApp(const Kemet());
}

class Kemet extends StatelessWidget {
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);
  const Kemet({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => LogoutCubit(),
              ),
              BlocProvider(
                create: (context) =>
                    createprofileCubit(api: DioConsumer(dio: Dio())),
              ),
     
            ],
            child: ChangeNotifierProvider(
              create: (_) => ThemeProvider(),
              child:
                  Consumer<ThemeProvider>(builder: (context, themeProvider, _) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  initialRoute: '/',
      routes: {
        //'/': (context) => HomeScreen(),
        '/account': (context) => Account(),
        '/settings': (context) => Setting(),
        '/profile': (context) => ProfilePage(),
        
       '/BookTicket': (context) => BookTicket(),
        '/NotificationScreen': (context) => NotificationScreen(),
        '/HistoricScreen': (context) => HistoricScreen(),
        '/login': (context) => login(),
        '/home':(context) => HomePage(),
       
      },
      
                  theme: ThemeData.light(),
                  darkTheme: ThemeData.dark(),
                  themeMode: themeProvider.themeMode == ThemeModeType.dark
                      ? ThemeMode.dark
                      : ThemeMode.light,

                  home: Logo(),
                );
              }),
            ),
          );
        });
  }
}
