import 'package:flutter/material.dart';
import 'package:pookeedex/core/enum/list_enum.dart';
import 'package:pookeedex/product/components/list_template.dart';

import '../view_model/moves_view_model.dart';

class MovesView extends StatefulWidget {
  const MovesView({super.key});

  @override
  State<MovesView> createState() => _MovesViewState();
}

class _MovesViewState extends MovesViewModel {
  @override
  Widget build(BuildContext context) {
    return ListTemplate(
        isPaginateLoading: isPaginateLoading,
        scrollController: listController,
        list: list,
        type: ListType.moves);
  }
}
