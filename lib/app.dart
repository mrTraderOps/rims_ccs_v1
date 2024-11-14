import 'package:flutter/material.dart';
import 'package:rims_ccs_v1/controllers/home_screen_controller.dart';
import 'package:rims_ccs_v1/views/pages/landing_page.dart';
import 'package:rims_ccs_v1/views/pages/login_page.dart';
import 'package:rims_ccs_v1/views/pages/register_page.dart';
import 'package:rims_ccs_v1/views/pages/forgot_password_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LandingPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/login') {
          return MaterialPageRoute(builder: (context) => LoginPage());
        } else if (settings.name == '/register') {
          return MaterialPageRoute(builder: (context) => RegisterPage());
        } else if (settings.name == '/reset_password') {
        return MaterialPageRoute(builder: (context) => ForgotPasswordPage());
        } else if (settings.name == '/home') {
          final args = settings.arguments as Map<String, dynamic>;

          if (args['Role'] == 'Group') {
            return MaterialPageRoute(
              builder: (context) => HomeScreen(
                role: args['Role'],
              groupNumber: args['Group Number'],
                section: args['Section'],
                title: args['Title'],
              ),
            );
          } else {
            return MaterialPageRoute(
              builder: (context) => HomeScreen(
                role: args['Role'],
                nickname: args['Nickname'],
                title: args['Title'],
                name: args['Name'],
                suffix: args['Suffix'],
              ),
            );
          }
        }
        return null;
      },
    );
  }
}
