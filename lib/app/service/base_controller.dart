import 'package:flutter/foundation.dart';

import '../components/custom_snackbar.dart';
import 'api_exceptions.dart';
import 'helper/dialog_helper.dart';

class BaseController {
  void handleError(error) {
    hideLoading();

    var errorText = DioExceptions.fromDioError(error).toString();
    CustomSnackBar.showCustomErrorSnackBar(title: "Error", message: errorText);
    if (kDebugMode) {
      print(errorText);
    }
  }

  showLoading([String? message]) {
    DialogHelper.showLoading(message);
  }

  hideLoading() {
    DialogHelper.hideLoading();
  }
}
