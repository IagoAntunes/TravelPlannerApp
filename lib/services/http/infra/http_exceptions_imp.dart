import '../../../core/utils/app_errors_const.dart';
import '../domain/http_exceptions.dart';

class InternetException extends HttpExceptions {
  InternetException({super.message})
      : super(error: AppErrorsConst.noConnection);
}

class AuthenticationException extends HttpExceptions {
  AuthenticationException({super.message})
      : super(error: AppErrorsConst.noAuthorization);
}

class RequestTimeoutException extends HttpExceptions {
  RequestTimeoutException({super.message})
      : super(error: AppErrorsConst.timeoutExceeded);
}
