import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pookeedex/core/services/provider/main_screen_provider.dart';
import 'package:provider/provider.dart';

abstract class IListModel<T extends StatefulWidget> extends State<T> {
  // ignore: non_constant_identifier_names
  int DATA_PER_PAGE = 10;

  late final ScrollController listController;

  @override
  void initState() {
    super.initState();
    listController = ScrollController();
    listController.addListener(listListener);
  }

  Future<void> listListener() async {
    if (!isPaginateLoading) {
      if (listController.position.pixels ==
          listController.position.maxScrollExtent) {
        checkInternet(
            function: () async {
              await paginateList();
            },
            errorWidget: const Text("There is no internet connection!"));
      }
    }
  }

  checkInternet(
      {required Function function, required Widget errorWidget}) async {
    if (context.read<MainScreenProvider>().connection ==
        InternetConnectionStatus.connected) {
      await function();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: errorWidget,
        ),
      );
    }
  }

  Future<void> paginateList() async {}

  bool get isPaginateLoading;

  List? get list;
}
