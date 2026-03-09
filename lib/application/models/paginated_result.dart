import 'package:freezed_annotation/freezed_annotation.dart';

part 'paginated_result.freezed.dart';
part 'paginated_result.g.dart';

/// Wraps a page of items with an optional cursor for the next page.
///
/// Mirrors the backend `Paginated<T>` schema:
/// ```json
/// { "items": [...], "next_cursor": "base64..." }
/// ```
@Freezed(genericArgumentFactories: true)
abstract class PaginatedResult<T> with _$PaginatedResult<T> {
  const factory PaginatedResult({
    required List<T> items,
    @JsonKey(name: 'next_cursor') String? nextCursor,
  }) = _PaginatedResult<T>;

  factory PaginatedResult.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) =>
      _$PaginatedResultFromJson(json, fromJsonT);
}
