import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

extension TestExpectations<L, R> on Future<Either<L, R>> {
  Future<void> expectRight(dynamic expected) async {
    final result = await this;
    expect(result.fold((l) => l, (r) => r), expected);
  }

  Future<void> expectLeft(L expectedError) async {
    final result = await this;
    expect(result.fold((l) => l, (r) => r), expectedError);
  }

  Future<void> expectRightSuccess() async {
    final result = await this;
    expect(result.isRight(), true);
  }

  Future<void> expectLeftError() async {
    final result = await this;
    expect(result.isLeft(), true);
  }
}