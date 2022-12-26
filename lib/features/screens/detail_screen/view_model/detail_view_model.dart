import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:pookeedex/core/services/provider/pookee_provider.dart';
import 'package:pookeedex/product/model/pokemon.dart';
import 'package:provider/provider.dart';

import '../view/detail_view.dart';

abstract class DetailViewModel extends State<DetailView> {
  late final Pokemon _pookee;

  final PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();

    _pookee = context.read<PookeeProvider>().pookee;

    Future.microtask(() => initPage());
  }

  @override
  void deactivate() {
    context.read<PookeeProvider>().setPookee(null);
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  Future<void> initPage() async {
    context.read<PookeeProvider>().changePage(0);
  }

  void changePage(int index) {
    pageController.animateToPage(index,
        duration: context.durationLow, curve: Curves.ease);
    context.read<PookeeProvider>().changePage(index);
  }

  int get selectedPage => context.read<PookeeProvider>().selectedPage;

  Pokemon get pookee => _pookee;
}
