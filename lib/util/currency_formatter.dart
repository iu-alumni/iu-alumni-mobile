import '../application/models/cost.dart';

extension CurrencyFormatter on Currency {
  String get format => switch (this) {
        Currency.usd => 'USD',
        Currency.rub => 'RUB',
        Currency.aed => 'AED',
        Currency.amd => 'AMD',
      };
}
