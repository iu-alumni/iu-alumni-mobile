import 'package:flutter_test/flutter_test.dart';
import '../../../lib/application/models/cost.dart';

void main() {
  group('CostModel', () {
    test('should create with rub currency', () {
      final cost = CostModel(number: 100.0, currency: Currency.rub);
      expect(cost.number, 100.0);
      expect(cost.currency, Currency.rub);
    });

    test('should create with usd currency', () {
      final cost = CostModel(number: 50.0, currency: Currency.usd);
      expect(cost.number, 50.0);
      expect(cost.currency, Currency.usd);
    });

    test('should handle zero value', () {
      final cost = CostModel(number: 0.0, currency: Currency.rub);
      expect(cost.number, 0.0);
    });

    test('should handle decimal values', () {
      final cost = CostModel(number: 99.99, currency: Currency.usd);
      expect(cost.number, 99.99);
    });
  });
}