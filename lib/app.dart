import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/controllers/home_screen_controller.dart';
import 'package:rims_ccs_v1/views/pages/login_page.dart';
// import 'package:rims_ccs_v1/views/pages/register_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/home') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => HomeScreen(
              role: args['role'],
              nickname: args['nickname'],
              title: args['title'],
              name: args['name'],
              suffix: args['suffix'],
            ),
          );
        }
        return null;
      },
    );
  }
}
