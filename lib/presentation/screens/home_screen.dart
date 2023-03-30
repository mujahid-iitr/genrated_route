import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_concepts/constants/enums.dart';
import 'package:flutter_bloc_concepts/logic/cubit/internet_cubit.dart';

import '../../logic/cubit/counter_cubit.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title, this.color}) : super(key: key);

  final String title;
  final Color color;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> homeScreenKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetCubit, InternetState>(
      listener: (context, state) {
        if (state is InternetConnect &&
            state.connectionType == ConnectionType.Wifi) {
          context.bloc<CounterCubit>().increment();
        }
        else if (state is InternetConnect &&
            state.connectionType == ConnectionType.Mobile) {
          context.bloc<CounterCubit>().decrement();
        }
        else if (state is InternetDisconnect) {
          return Text('Disconnected');
        }      },
      child: Scaffold(
        key: homeScreenKey,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BlocBuilder<InternetCubit, InternetState>(
                  builder: (context, state) {
                    if (state is InternetConnect &&
                        state.connectionType == ConnectionType.Wifi) {
                      return Text('Wifi');
                    }
                    else if (state is InternetConnect &&
                        state.connectionType == ConnectionType.Mobile) {
                      return Text('Mobile');
                    }
                    else if (state is InternetDisconnect) {
                      return Text('Disconnected');
                    }
                    return CircularProgressIndicator();
                  }),
              Text(
                'You have pushed the button this many times:',
              ),
              BlocConsumer<CounterCubit, CounterState>(
                listener: (context, state) {
                  if (state.wasIncremented == true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Incremented!'),
                        duration: Duration(milliseconds: 300),
                      ),
                    );
                  } else if (state.wasIncremented == false) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Decremented'),
                    ));
                  }
                },
                builder: (context, state) {
                  if (state.counterValue < 0) {
                    return Text(
                      'BRR, NEGATIVE ' + state.counterValue.toString(),
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline4,
                    );
                  } else if (state.counterValue % 2 == 0) {
                    return Text(
                      'YAAAY ' + state.counterValue.toString(),
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline4,
                    );
                  } else if (state.counterValue == 5) {
                    return Text(
                      'HMM, NUMBER 5',
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline4,
                    );
                  } else
                    return Text(
                      state.counterValue.toString(),
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline4,
                    );
                },
              ),
              /* SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: Text('${widget.title}'),
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).decrement();
                    // context.bloc<CounterCubit>().decrement();
                  },
                  tooltip: 'Decrement',
                  child: Icon(Icons.remove),
                ),
                FloatingActionButton(
                  heroTag: Text('${widget.title} #2'),
                  onPressed: () {
                    // BlocProvider.of<CounterCubit>(context).increment();
                    context.bloc<CounterCubit>().increment();
                  },
                  tooltip: 'Increment',
                  child: Icon(Icons.add),
                ),
              ],
            ),*/
              SizedBox(
                height: 24,
              ),
              MaterialButton(
                color: Colors.redAccent,
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    '/second',
                    arguments: homeScreenKey,
                  );
                },
                child: Text(
                  "Go to second screen",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              MaterialButton(
                color: Colors.greenAccent,
                onPressed: () {
                  Navigator.of(context).pushNamed('/second');
                },
                child: Text(
                  "Go to third screen",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
