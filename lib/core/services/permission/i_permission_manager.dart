import 'package:permission_handler/permission_handler.dart';

abstract class IPermissionManager {
  Future<void> askStoragePermission({
    required Function permanentlyDeniedFunction,
    required Function deniedFunction,
    required Function limitedFunction,
    required Function grantedFunction,
    required Function grantedBeforeFunction,
    required Function restrictedFunction,
  }) async {}

  Future<bool> get hasPermissionForStorage;
}
