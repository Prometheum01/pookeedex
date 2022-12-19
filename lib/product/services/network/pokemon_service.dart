import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pookeedex/core/extensions/string_extension.dart';
import 'package:pookeedex/product/model/item.dart';
import 'package:pookeedex/product/model/move.dart';
import 'package:pookeedex/product/model/pokemon.dart';
import 'package:pookeedex/product/services/network/network_extension.dart';

import 'network_enum.dart';

class PookeeService {
  static Dio? _manager;
  static Dio get manager {
    _manager ??= _manager = Dio(BaseOptions(
      baseUrl: "https://pokeapi.co/api/v2/",
    ));
    return _manager!;
  }

  cancel() {
    manager.close();
  }

  Future<Item?> fetchItem(String id) async {
    try {
      final response = await manager.get(
        '${NetworkEnums.item.path}$id',
      );

      if (response.statusCode != HttpStatus.ok) {
        return null;
      } else {
        return Item.fromJson(response.data);
      }
    } catch (e) {
      return null;
    }
  }

  Future<List<Item>> fetchItems({int page = 0, int itemPerPage = 10}) async {
    List<Item> itemList = [];
    try {
      final response = await manager.get(
        NetworkEnums.item.path,
        queryParameters: {
          NetworkEnums.offset.name: page * itemPerPage,
          NetworkEnums.limit.name: itemPerPage,
        },
      );

      if (response.statusCode != HttpStatus.ok) {
      } else {
        for (var i in response.data["results"] as List) {
          itemList.add(
            await fetchItem(
                  i["name"].toString(),
                ) ??
                Item.emptyItem,
          );
        }
      }
      // ignore: empty_catches
    } catch (error) {}

    return itemList;
  }

  Future<Move?> fetchMove(String id) async {
    try {
      final response = await manager.get(
        '${NetworkEnums.move.path}$id',
      );

      if (response.statusCode != HttpStatus.ok) {
        return null;
      } else {
        return Move.fromJson(response.data);
      }
    } catch (e) {
      return null;
    }
  }

  Future<List<Move>> fetchMoves({int page = 0, int movesPerPage = 10}) async {
    List<Move> moveList = [];
    try {
      final response =
          await manager.get(NetworkEnums.move.path, queryParameters: {
        NetworkEnums.offset.name: page * movesPerPage,
        NetworkEnums.limit.name: movesPerPage,
      });

      if (response.statusCode != HttpStatus.ok) {
      } else {
        for (var i in response.data["results"] as List) {
          moveList.add(await fetchMove(i["name"].toString()) ?? Move.emptyMove);
        }
      }
      // ignore: empty_catches
    } catch (error) {}

    return moveList;
  }

  Future<List<Move>> fetchPokemonMoves(
      {required String id, int offset = 0, int perPage = 10}) async {
    List<Move> movesList = [];

    try {
      final idResponse = await manager.get(
        '${NetworkEnums.pokemon.path}$id',
      );

      if (idResponse.statusCode != HttpStatus.ok) {
      } else {
        List moveJsonList = idResponse.data["moves"];

        for (int i = (offset * perPage);
            i <
                (((offset + 1) * perPage) > moveJsonList.length
                    ? moveJsonList.length
                    : ((offset + 1) * perPage));
            i++) {
          final response = await manager.get(
            '${NetworkEnums.move.path}${moveJsonList[i]["move"]["url"].toString().pookeeId}',
          );

          if (response.statusCode != HttpStatus.ok) {
            return movesList;
          } else {
            movesList.add(Move.fromJson(response.data));
          }
        }
      }
      // ignore: empty_catches
    } catch (e) {}

    return movesList;
  }

  Future<Map<String, dynamic>?> fetchSpecies(String id) async {
    try {
      final response = await manager.get(
        'pokemon-species/$id',
      );

      if (response.statusCode != HttpStatus.ok) {
        return null;
      } else {
        return response.data;
      }
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>?> fetchChain(String id) async {
    try {
      final response = await manager.get(
        "evolution-chain/$id",
      );
      if (response.statusCode != HttpStatus.ok) {
        return {};
      } else {
        return response.data;
      }
    } catch (e) {
      return null;
    }
  }

  Future<Pokemon?> fetchPokemon(String id) async {
    try {
      final response = await manager.get(
        NetworkEnums.pokemon.path + id,
      );

      if (response.statusCode != HttpStatus.ok) {
        return null;
      } else {
        Map<String, dynamic> speciesJson = await fetchSpecies(id) ?? {};
        return Pokemon.fromJson(
          pookeeJson: response.data,
          speciesJson: speciesJson,
          chainJson: await fetchChain(
                speciesJson["evolution_chain"]["url"].toString().pookeeId,
              ) ??
              {},
        );
      }
    } catch (e) {
      return null;
    }
  }

  Future<List<Pokemon>> fetchPokemons(
      {int page = 0, int pokemonPerPage = 10}) async {
    List<Pokemon> pookeeList = [];
    try {
      final response =
          await manager.get(NetworkEnums.pokemon.path, queryParameters: {
        NetworkEnums.offset.name: page * pokemonPerPage,
        NetworkEnums.limit.name: pokemonPerPage,
      });

      if (response.statusCode != HttpStatus.ok) {
      } else {
        for (var i in response.data["results"] as List) {
          pookeeList.add(await fetchPokemon(i["url"].toString().pookeeId) ??
              Pokemon.emptyPokemon);
        }
      }
      // ignore: empty_catches
    } catch (error) {}

    return pookeeList;
  }
}
