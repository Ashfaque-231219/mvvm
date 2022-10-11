import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final int code;
  final String message;

  const Failure({required this.message, required this.code});

  @override
  List<Object?> get props => [message, code];
}

class BaseFailure extends Failure {
  const BaseFailure({required String message, required int code})
      : super(message: message, code: code);
}

class BaseException extends Failure implements Exception {
  const BaseException({required String message, required int code})
      : super(message: message, code: code);
}
