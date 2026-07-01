import 'package:flutter_test/flutter_test.dart';
import '../../../lib/application/models/user_status.dart';

void main() {
  group('UserStatus', () {
    group('author', () {
      test('should create author status', () {
        final status = const UserStatus.author();
        expect(status, const UserStatus.author());
      });

      test('should match author in when', () {
        final status = const UserStatus.author();
        final result = status.when(
          author: () => 'author',
          notAuthor: (_, __) => 'notAuthor',
        );
        expect(result, 'author');
      });
    });

    group('notAuthor', () {
      test('should create notAuthor with participant true', () {
        final status = UserStatus.notAuthor(
          authorId: 'author123',
          participant: true,
        );
        expect(
          status,
          UserStatus.notAuthor(authorId: 'author123', participant: true),
        );
      });

      test('should create notAuthor with participant false', () {
        final status = UserStatus.notAuthor(
          authorId: 'author123',
          participant: false,
        );
        expect(
          status,
          UserStatus.notAuthor(authorId: 'author123', participant: false),
        );
      });

      test('should match notAuthor in when', () {
        final status = UserStatus.notAuthor(
          authorId: 'author123',
          participant: true,
        );
        final result = status.when(
          author: () => 'author',
          notAuthor: (authorId, participant) => 'notAuthor:$authorId:$participant',
        );
        expect(result, 'notAuthor:author123:true');
      });
    });
  });
}