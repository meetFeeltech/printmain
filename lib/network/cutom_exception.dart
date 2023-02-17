class CustomException implements Exception {
  final _message;
  final _prefix;

  CustomException(this._message, this._prefix);

  @override
  String toString() {
    return "$_prefix : $_message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([String? message]): super(message, "No Internet");
}

class UnAuthorizedException extends CustomException {
  UnAuthorizedException([String? message]) : super(message, "Unautorized");
}

class DoesNotExistException extends CustomException {
  DoesNotExistException([String? message]) : super(message, "User Not Found");
}

class ServerValidationError extends CustomException {
  ServerValidationError([String? message]) : super(message, "");
}