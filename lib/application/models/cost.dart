import 'package:freezed_annotation/freezed_annotation.dart';

part 'cost.freezed.dart';

@freezed
class CostModel with _$CostModel {
  const factory CostModel({
    required double number,
    required Currency currency,
  }) = _CostModel;
}

enum Currency { usd, rub, aed, amd }
