import 'package:flutter_test/flutter_test.dart';
import 'package:ui_alumni_mobile/application/models/paginated_result.dart';

void main() {
  group('PaginatedResult', () {
    test('should parse from JSON with generic type', () {
      const json = {
        'items': ['item1', 'item2'],
        'next_cursor': 'cursor123',
      };

      final result = PaginatedResult<String>.fromJson(
        json,
        (json) => json as String,
      );

      expect(result.items, ['item1', 'item2']);
      expect(result.nextCursor, 'cursor123');
    });

    test('should parse from JSON with null cursor', () {
      const json = {
        'items': ['item1'],
        'next_cursor': null,
      };

      final result = PaginatedResult<String>.fromJson(
        json,
        (json) => json as String,
      );

      expect(result.items, ['item1']);
      expect(result.nextCursor, null);
    });
  });
}