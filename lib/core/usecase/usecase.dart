import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:uponorflix/core/errors/failure.dart';

typedef Callback<T> = Function(T);

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params, {Callback? callback});
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
