import 'package:flutter/material.dart';

import 'package:pookeedex/features/screens/home_screen/view_model/home_view_model.dart';
import 'package:pookeedex/product/components/list_template.dart';

import '../../../../core/enum/list_enum.dart';
import '../../../../product/components/widgets.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends HomeViewModel {
  @override
  Widget build(BuildContext context) {
    return ListTemplate(
      isPaginateLoading: isPaginateLoading,
      scrollController: listController,
      list: list,
      type: ListType.pokemon,
    );
  }
}
