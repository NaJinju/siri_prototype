import 'package:flutter/material.dart';
import 'package:siri_prototype/modules/main/chat/chat_room_screen.dart';
import 'package:siri_prototype/modules/main/main_screen.dart';
import 'package:siri_prototype/modules/splash/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  Map<String, WidgetBuilder> routes = {
    '/main': (context) => const MainScreen(),
    '/chatroom': (context) => const ChatRoomScreen(),
    '/splash': (context) => const SplashScreen(),
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: '/main',
      routes: routes,
    );
  }
}
