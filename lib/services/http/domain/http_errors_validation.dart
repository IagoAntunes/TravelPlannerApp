import '../../../core/utils/app_errors_const.dart';

String verifyResponseMessage(String error, context) {
  switch (error) {
    case AppErrorsConst.noConnection:
      return "Sem Internet";
  }
  return "falha";
}
