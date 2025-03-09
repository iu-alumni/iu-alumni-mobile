import '../application/models/cost.dart';

extension CurrencyPresenter on Currency {
  String get present => switch (this) {
        Currency.usd => 'USD',
        Currency.rub => 'RUB',
        Currency.aed => 'AED',
        Currency.amd => 'AMD',
      };
}
