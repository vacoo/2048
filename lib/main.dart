import 'package:flutter/material.dart';
import 'package:myapp/redux.dart';
import 'package:myapp/ui.dart';

void main() {
  runApp(new App2048());
}

class App2048 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new GameRedux(
      child: new MaterialApp(
        title: '2048',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new Scaffold(
          body: new Center(
            child: _addBackgroundColor(new Game()),
          ),
        ),
      ),
    );
  }
}

class Game extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      behavior: HitTestBehavior.opaque,
      onHorizontalDragEnd: (DragEndDetails d) {
        if (d.primaryVelocity > 0) {
          GameRedux.dispatch(context, moveRight());
        } else {
          GameRedux.dispatch(context, moveLeft());
        }
      },
      onVerticalDragEnd: (DragEndDetails d) {
        if (d.primaryVelocity > 0) {
          GameRedux.dispatch(context, moveDown());
        } else {
          GameRedux.dispatch(context, moveUp());
        }
      },
      child: const GameGrid(),
    );
  }
}

Widget _addBackgroundColor(Widget child) {
  return new Container(
    child: child,
    color: Colors.indigo,
  );
}
