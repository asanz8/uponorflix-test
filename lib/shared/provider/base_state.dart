import 'package:equatable/equatable.dart';
import 'package:uponorflix/core/errors/failure.dart';

class BaseState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Initial extends BaseState {}

class Loading extends BaseState {}

class Loaded<T> extends BaseState {
  final T? data;

  Loaded({this.data});

  @override
  List<Object?> get props => [data];
}

class Error extends BaseState {
  final Failure failure;

  Error(this.failure);

  @override
  List<Object?> get props => [failure];
}
