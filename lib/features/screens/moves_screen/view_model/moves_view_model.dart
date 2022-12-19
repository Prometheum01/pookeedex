import 'package:provider/provider.dart';

import '../../../../core/services/provider/main_screen_provider.dart';
import '../../../../product/services/network/pokemon_service.dart';
import '../../../interface/i_list_model.dart';
import '../view/moves_view.dart';

abstract class MovesViewModel extends IListModel<MovesView> {
  @override
  Future<void> paginateList() async {
    var list = context.read<MainScreenProvider>().loadedMoveList;

    context.read<MainScreenProvider>().changePaginateLoadingMoves();
    if (list.isNotEmpty) {
      context.read<MainScreenProvider>().setLoadedMoveList(
            list +
                await PookeeService().fetchMoves(
                    page: (list.length ~/ DATA_PER_PAGE),
                    movesPerPage: DATA_PER_PAGE),
          );
    }

    // ignore: use_build_context_synchronously
    context.read<MainScreenProvider>().changePaginateLoadingMoves();
  }

  @override
  bool get isPaginateLoading =>
      context.read<MainScreenProvider>().isPaginateLoadingMoves;

  @override
  List get list => context.watch<MainScreenProvider>().loadedMoveList;
}
