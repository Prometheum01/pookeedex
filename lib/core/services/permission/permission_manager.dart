import 'package:permission_handler/permission_handler.dart';
import 'package:pookeedex/core/services/permission/i_permission_manager.dart';

class PermissionManager extends IPermissionManager {
  @override
  Future<void> askStoragePermission({
    required Function permanentlyDeniedFunction,
    required Function deniedFunction,
    required Function limitedFunction,
    required Function grantedFunction,
    required Function grantedBeforeFunction,
    required Function restrictedFunction,
  }) async {
    if (await Permission.storage.isGranted) {
      await grantedBeforeFunction();
    } else {
      PermissionStatus status = await Permission.storage.request();

      switch (status) {
        case PermissionStatus.permanentlyDenied:
          await permanentlyDeniedFunction();
          break;
        case PermissionStatus.denied:
          await deniedFunction();
          break;
        case PermissionStatus.limited:
          await limitedFunction();
          break;
        case PermissionStatus.granted:
          await grantedBeforeFunction();
          break;
        case PermissionStatus.restricted:
          await restrictedFunction();
          break;
        default:
          await deniedFunction();
      }
    }
  }

  @override
  Future<bool> get hasPermissionForStorage async =>
      await Permission.storage.isGranted;
}
