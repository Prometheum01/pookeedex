import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:pookeedex/core/services/navigator/navigator_service.dart';
import 'package:pookeedex/product/components/widgets.dart';

import '../constants/nature_constants.dart';
import '../model/move.dart';

class MovesTile extends StatelessWidget {
  const MovesTile({
    Key? key,
    required this.move,
  }) : super(key: key);

  final Move move;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(NavigatorKeys.moves_detail.path,
            arguments: {"move": move});
      },
      splashColor: NatureConst.checkNatureWithName(move.type.name)
          .natureColor
          .firstColor
          .withOpacity(0.5),
      child: Ink(
        color: Colors.white,
        child: ListTile(
          title: Text(
            move.normalName.toTitleCase(),
            style: context.textTheme.headline5,
          ),
          trailing: NatureCircle(
            nature: NatureConst.checkNatureWithName(move.type.name),
          ),
        ),
      ),
    );
  }
}
