// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:pookeedex/core/extensions/string_extension.dart';
import 'package:pookeedex/core/services/provider/cache_provider.dart';
import 'package:pookeedex/product/components/widgets.dart';
import 'package:pookeedex/product/model/item.dart';
import 'package:pookeedex/product/model/pokemon.dart';
import 'package:pookeedex/product/services/network/pokemon_service.dart';
import 'package:provider/provider.dart';

import '../../core/constants/color_const.dart';
import '../../core/constants/radius_const.dart';
import '../../core/services/navigator/navigator_service.dart';
import '../../core/services/provider/main_screen_provider.dart';
import '../../core/services/provider/pookee_provider.dart';
import '../model/move.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController searchController = TextEditingController();

  final key = GlobalKey<FormState>();

  search() async {
    if (key.currentState!.validate()) {
      switch (context.read<MainScreenProvider>().currentScreenIndex) {
        case 0:
          //Pokemon

          _showLoading();
          Pokemon? pookee;

          for (Pokemon tmpP in context.read<CacheProvider>().pookeeList) {
            if (tmpP.name.trim().toLowerCase() ==
                searchController.text.trim().toLowerCase().toJsonText) {
              pookee = tmpP;
            }
          }

          try {
            pookee ??= await PookeeService().fetchPokemon(
                searchController.text.trim().toLowerCase().toString());
          } catch (_) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Somethings get wrong please try again later"),
              ),
            );
            break;
          }

          if (pookee == null) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("There is no Pokemon with this name"),
              ),
            );
          } else {
            Navigator.of(context).pop();

            context.read<PookeeProvider>().setPookee(pookee);

            Navigator.of(context).pushNamed(NavigatorKeys.detail.path);
          }

          break;
        case 1:
          //Moves
          _showLoading();

          Move? move;

          for (Move tmpM in context.read<CacheProvider>().moveList) {
            print(tmpM.name);
            if (tmpM.name.trim().toLowerCase() ==
                searchController.text.trim().toLowerCase().toJsonText) {
              move = tmpM;
            }
          }
          try {
            move ??= await PookeeService().fetchMove(
                searchController.text.trim().toLowerCase().toString());
          } catch (_) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Somethings get wrong please try again later"),
              ),
            );
            break;
          }

          if (move == null) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("There is no Move with this name"),
              ),
            );
          } else {
            Navigator.of(context).pop();

            Navigator.of(context).pushNamed(NavigatorKeys.moves_detail.path,
                arguments: {"move": move});
          }

          break;
        case 2:
          //Items
          _showLoading();

          Item? item;

          for (Item tmpI in context.read<CacheProvider>().itemList) {
            if (tmpI.name.trim().toLowerCase() ==
                searchController.text.trim().toLowerCase()) {
              item = tmpI;
            }
          }

          try {
            item ??= await PookeeService().fetchItem(searchController.text
                .trim()
                .toLowerCase()
                .toString()
                .toJsonText);
          } catch (_) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Somethings get wrong please try again later"),
              ),
            );
            break;
          }

          if (item == null) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("There is no Item with this name"),
              ),
            );
          } else {
            Navigator.of(context).pop();

            Navigator.of(context).pushNamed(NavigatorKeys.item_detail.path,
                arguments: {"item": item});
          }
          break;
        case 3:
          //Favorites
          break;
        default:
        //Pokemon
      }
    }
  }

  Future<dynamic> _showLoading() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(
          child: CustomLoading(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          context.watch<MainScreenProvider>().selectedTabName,
          style: context.textTheme.headline4,
        ),
        Form(
          key: key,
          child: TextFormField(
            controller: searchController,
            cursorColor: ColorConst.cursorColor,
            style: context.textTheme.headline5,
            onFieldSubmitted: (value) async {
              //Search
              await search();
            },
            validator: (value) {
              if (value == null) {
                return "Enter values";
              } else {
                if (value.trim().isEmpty) {
                  return "Enter values";
                }
              }
              return null;
            },
            decoration: InputDecoration(
              enabledBorder: _border(),
              focusedBorder: _border(),
              errorBorder: _border(),
              focusedErrorBorder: _border(),
              filled: true,
              fillColor: Colors.black12,
              hintText: "Search",
              prefixIcon: _TextFieldButton(
                  icon: Icons.search,
                  function: () async {
                    await search();
                  }),
              //suffixIcon: _TextFieldButton(icon: Icons.mic, function: () {}),
            ),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _border() {
    return const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
      borderRadius: RadiusConst.all360(),
    );
  }
}

class _TextFieldButton extends StatelessWidget {
  const _TextFieldButton({
    Key? key,
    required this.icon,
    required this.function,
  }) : super(key: key);

  final IconData icon;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        function();
      },
      splashRadius: 20,
      icon: Icon(
        icon,
        color: ColorConst.cursorColor,
      ),
    );
  }
}
