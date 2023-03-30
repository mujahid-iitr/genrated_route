import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_concepts/presentation/screens/home_screen.dart';
import 'package:flutter_bloc_concepts/presentation/screens/second_screen.dart';
import 'package:flutter_bloc_concepts/presentation/screens/third_screen.dart';

import '../../logic/cubit/counter_cubit.dart';

class AppRouter {

  Route onGenerateRoute(RouteSettings settings) {
    final GlobalKey<ScaffoldState> key = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => HomeScreen(
              title: 'Home Screen',
              color: Colors.blueAccent,
            ));
        break;
      case '/second':
        return MaterialPageRoute(
            builder: (_) => SecondScreen(
              title: 'Home Screen',
              color: Colors.redAccent,
              homeScreenKey: key,
            ));
        break;
      case '/third':
        return MaterialPageRoute(
            builder: (_) => ThirdScreen(
              title: 'Home Screen',
              color: Colors.greenAccent,
            ));
        break;
      default:
        return null;
    }
  }


}
