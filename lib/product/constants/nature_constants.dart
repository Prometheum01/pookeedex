import 'package:flutter/material.dart';
import 'package:pookeedex/core/constants/asset_const.dart';
import 'package:pookeedex/product/model/nature.dart';

import '../model/nature_color.dart';

class NatureConst {
  NatureConst._();

  static Nature checkNatureWithName(String name) {
    switch (name) {
      case "bug":
        return bug;
      case "dragon":
        return dragon;
      case "fairy":
        return fairy;
      case "fire":
        return fire;
      case "ghost":
        return ghost;
      case "ground":
        return ground;
      case "normal":
        return normal;
      case "psychic":
        return psychic;
      case "steel":
        return steel;
      case "dark":
        return dark;
      case "electric":
        return electric;
      case "fight":
        return fight;
      case "flying":
        return flying;
      case "grass":
        return grass;
      case "ice":
        return ice;
      case "poison":
        return poison;
      case "rock":
        return rock;
      case "water":
        return water;
      default:
        return normal;
    }
  }

  static Nature get bug => const Nature(
        name: "bug",
        natureColor: NatureColor(
          firstColor: Color(0xFF92BC2C),
          secondColor: Color(0xFFAFC836),
          shadowColor: Color(0xFF98C32F),
        ),
        iconPath: AssetConst.bug,
      );

  static Nature get dragon => const Nature(
        name: "dragon",
        natureColor: NatureColor(
          firstColor: Color(0xFF0C69C8),
          secondColor: Color(0xFF0180C7),
          shadowColor: Color(0xFF076DC0),
        ),
        iconPath: AssetConst.dragon,
      );

  static Nature get fairy => const Nature(
        name: "fairy",
        natureColor: NatureColor(
          firstColor: Color(0xFFEC8CE5),
          secondColor: Color(0xFFF3A7E7),
          shadowColor: Color(0xFFF294E9),
        ),
        iconPath: AssetConst.fairy,
      );

  static Nature get fire => const Nature(
        name: "fire",
        natureColor: NatureColor(
          firstColor: Color(0xFFFB9B51),
          secondColor: Color(0xFFFBAE46),
          shadowColor: Color(0xFFFE9E54),
        ),
        iconPath: AssetConst.fire,
      );

  static Nature get ghost => const Nature(
        name: "ghost",
        natureColor: NatureColor(
          firstColor: Color(0xFF516AAC),
          secondColor: Color(0xFF7773D4),
          shadowColor: Color(0xFF656CC6),
        ),
        iconPath: AssetConst.ghost,
      );

  static Nature get ground => const Nature(
        name: "ground",
        natureColor: NatureColor(
          firstColor: Color(0xFFDC7545),
          secondColor: Color(0xFFD29463),
          shadowColor: Color(0xFFD88255),
        ),
        iconPath: AssetConst.ground,
      );

  static Nature get normal => const Nature(
        name: "normal",
        natureColor: NatureColor(
          firstColor: Color(0xFF9298A4),
          secondColor: Color(0xFFA3A49E),
          shadowColor: Color(0xFF5D596A),
        ),
        iconPath: AssetConst.normal,
      );

  static Nature get psychic => const Nature(
        name: "psychic",
        natureColor: NatureColor(
          firstColor: Color(0xFFF66F71),
          secondColor: Color(0xFFFE9F92),
          shadowColor: Color(0xFFD94256),
        ),
        iconPath: AssetConst.psychic,
      );

  static Nature get steel => const Nature(
        name: "steel",
        natureColor: NatureColor(
          firstColor: Color(0xFF52869D),
          secondColor: Color(0xFF58A6AA),
          shadowColor: Color(0xFF5094A1),
        ),
        iconPath: AssetConst.steel,
      );

  static Nature get dark => const Nature(
        name: "dark",
        natureColor: NatureColor(
          firstColor: Color(0xFF595761),
          secondColor: Color(0xFF6E7587),
          shadowColor: Color(0xFF5D596A),
        ),
        iconPath: AssetConst.dark,
      );

  static Nature get electric => const Nature(
        name: "electric",
        natureColor: NatureColor(
          firstColor: Color(0xFFEDD53E),
          secondColor: Color(0xFFFBE273),
          shadowColor: Color(0xFFF4D556),
        ),
        iconPath: AssetConst.electric,
      );

  static Nature get fight => const Nature(
        name: "fight",
        natureColor: NatureColor(
          firstColor: Color(0xFFCE4265),
          secondColor: Color(0xFFE74347),
          shadowColor: Color(0xFFD4445D),
        ),
        iconPath: AssetConst.fight,
      );

  static Nature get flying => const Nature(
        name: "flying",
        natureColor: NatureColor(
          firstColor: Color(0xFF90A7DA),
          secondColor: Color(0xFFA6C2F2),
          shadowColor: Color(0xFF9DB5E4),
        ),
        iconPath: AssetConst.flying,
      );

  static Nature get grass => const Nature(
        name: "grass",
        natureColor: NatureColor(
          firstColor: Color(0xFF5FBC51),
          secondColor: Color(0xFF5AC178),
          shadowColor: Color(0xFF64B954),
        ),
        iconPath: AssetConst.grass,
      );

  static Nature get ice => const Nature(
        name: "ice",
        natureColor: NatureColor(
          firstColor: Color(0xFF70CCBD),
          secondColor: Color(0xFF8CDDD4),
          shadowColor: Color(0xFF7ED4C9),
        ),
        iconPath: AssetConst.ice,
      );

  static Nature get poison => const Nature(
        name: "poison",
        natureColor: NatureColor(
          firstColor: Color(0xFFA864C7),
          secondColor: Color(0xFFC261D4),
          shadowColor: Color(0xFFA36BCB),
        ),
        iconPath: AssetConst.poison,
      );

  static Nature get rock => const Nature(
        name: "rock",
        natureColor: NatureColor(
          firstColor: Color(0xFFC5B489),
          secondColor: Color(0xFFD7CD90),
          shadowColor: Color(0xFFCBC194),
        ),
        iconPath: AssetConst.rock,
      );

  static Nature get water => const Nature(
        name: "water",
        natureColor: NatureColor(
          firstColor: Color(0xFF4A90DD),
          secondColor: Color(0xFF6CBDE4),
          shadowColor: Color(0xFF559EDF),
        ),
        iconPath: AssetConst.water,
      );
}
