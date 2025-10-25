// core/network_structure/failure.dart
import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;
  final int? code;

  const Failure(this.message, {this.code});

  @override
  List<Object?> get props => [message, code];
}
