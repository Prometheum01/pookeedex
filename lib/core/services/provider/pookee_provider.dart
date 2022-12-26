// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:pookeedex/product/model/pokemon.dart';

import '../../../product/model/move.dart';

class PookeeProvider extends ChangeNotifier {
  bool _isPaginateLoadingMoves = false;

  bool _isLoadingMoves = false;

  void changePaginateLoadingMoves({bool? newState}) {
    if (newState == null) {
      _isPaginateLoadingMoves = !_isPaginateLoadingMoves;
      notifyListeners();
    } else {
      _isPaginateLoadingMoves = newState;
    }
  }

  void changeLoadingMoves({bool? newState}) {
    if (newState == null) {
      _isLoadingMoves = !_isLoadingMoves;
      notifyListeners();
    } else {
      _isLoadingMoves = newState;
    }
  }

  bool get isPaginateLoadingMoves => _isPaginateLoadingMoves;

  bool get isLoadingMoves => _isLoadingMoves;

  Pokemon _currentPookee = Pokemon.emptyPokemon;

  //0 = Stats, 1 = Evolutions, 2 = Moves
  int _selectedPage = 0;

  setPookee(Pokemon? newPookee) {
    if (newPookee == null) {
      _currentPookee = Pokemon.emptyPokemon;
    } else {
      _currentPookee = newPookee;
      notifyListeners();
    }
  }

  setMovesList(List<Move>? newList) {
    _currentPookee.changeMoves(newList);
    notifyListeners();
  }

  changePage(int newPageIndex) {
    _selectedPage = newPageIndex;
    notifyListeners();
  }

  int get selectedPage => _selectedPage;

  Pokemon get pookee => _currentPookee;
}
