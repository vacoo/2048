import 'dart:math' show Random;

import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/state.dart';
import 'package:myapp/indux.dart';

enum ActionType {
  moveLeft,
  moveUp,
  moveRight,
  moveDown
}

class Action2 {
  final ActionType type;
  final int randomInt;

  Action2(this.type, {this.randomInt});
}

class GameRedux extends StatelessWidget {
  final Widget child;

  GameRedux({this.child});

  @override
  Widget build(BuildContext context) {
    return new Store<BoardState, Action2>(
      child: child,
      initialState: new BoardState([
        [2, 0, 2, 0],
        [0, 0, 0, 0],
        [0, 0, 4, 0],
        [0, 0, 0, 0],
      ]),
      reducer: reduce,
    );
  }

  static BoardState reduce(BoardState state, Action2 action) {
    switch (action.type) {
      case ActionType.moveLeft:
        return _addNewTileIfMoved(state.moveLeft(), state, action.randomInt);
      case ActionType.moveUp:
        return _addNewTileIfMoved(state.moveUp(), state, action.randomInt);
      case ActionType.moveRight:
        return _addNewTileIfMoved(state.moveRight(), state, action.randomInt);
      case ActionType.moveDown:
        return _addNewTileIfMoved(state.moveDown(), state, action.randomInt);
    }
    return state;
  }

  static BoardState _addNewTileIfMoved(BoardState newState, BoardState prevState, int randomInt) {
    if (const DeepCollectionEquality().equals(prevState.tiles, newState.tiles)) {
      return new BoardState(prevState.tiles);
    }
    return newState.addNewTile(randomInt, _maxRand);
  }

  static StoreUpdate<BoardState, Action2> stateOf(BuildContext context) {
    return Store?.storeStateOf(context);
  }

  static void dispatch(BuildContext context, Action2 action) {
    Store?.dispatch(context, action);
  }
}

const int _maxRand = 1000;
Random _rand = new Random.secure();

Action2 moveUp() {
  return new Action2(ActionType.moveUp, randomInt: _rand.nextInt(_maxRand));
}

Action2 moveRight() {
  return new Action2(ActionType.moveRight, randomInt: _rand.nextInt(_maxRand));
}

Action2 moveDown() {
  return new Action2(ActionType.moveDown, randomInt: _rand.nextInt(_maxRand));
}

Action2 moveLeft() {
  return new Action2(ActionType.moveLeft, randomInt: _rand.nextInt(_maxRand));
}
