import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class CacheFailure extends Failure {}

class NoProfileFailure extends Failure {}

class AssetFailure extends Failure {}

class UnknownFailure extends Failure {
  UnknownFailure(this.message);

  final String message;
}
