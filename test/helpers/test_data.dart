import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'package:ui_alumni_mobile/application/models/cost.dart';
import 'package:ui_alumni_mobile/application/models/event.dart';
import 'package:ui_alumni_mobile/application/models/profile.dart';
import 'package:ui_alumni_mobile/application/models/register_request.dart';
import 'package:ui_alumni_mobile/application/models/user_status.dart';
import 'package:ui_alumni_mobile/data/models/event_data_model.dart';
import 'package:ui_alumni_mobile/data/models/event_request_data_model.dart';

class TestData {
  static const String userId = 'user123';
  static const String anotherUserId = 'user456';
  static const String ownerId = 'owner123';
  static const String eventId = 'event789';
  static const String email = 'test@innopolis.university';
  static const String password = 'password123';
  static const String code = '123456';
  static const String firstName = 'John';
  static const String lastName = 'Doe';
  static const String graduationYear = '2025';
  static const String title = 'Test Event';
  static const String description = 'Test Description';
  static const String location = 'Room 101';
  static const String cover = 'base64_cover_data';
  static const double cost = 0.0;
  static const List<String> participants = ['user1', 'user2'];

  static final DateTime dateTime = DateTime(2025, 1, 15, 10, 0);

  static Profile profile({
    String? id,
    String? firstName,
    String? lastName,
    String? graduationYear,
    String? location,
    String? biography,
    bool? showLocation,
    String? telegramAlias,
    String? avatar,
    bool? isTelegramVerified,
  }) {
    return Profile(
      profileId: id ?? TestData.userId,
      firstName: firstName ?? TestData.firstName,
      lastName: lastName ?? TestData.lastName,
      graduationYear: graduationYear ?? TestData.graduationYear,
      location: location,
      biography: biography,
      showLocation: showLocation ?? false,
      telegramAlias: telegramAlias,
      avatar: avatar,
      isTelegramVerified: isTelegramVerified ?? false,
    );
  }

  static RegisterRequest registerRequest({
    String? email,
    String? password,
    String? firstName,
    String? lastName,
    String? gradYear,
    String? telegram,
    bool? manualVerification,
  }) {
    return RegisterRequest(
      email: email ?? TestData.email,
      password: password ?? TestData.password,
      firstName: firstName ?? TestData.firstName,
      lastName: lastName ?? TestData.lastName,
      gradYear: gradYear ?? TestData.graduationYear,
      telegram: telegram,
      manualVerification: manualVerification ?? false,
    );
  }

  static EventDataModel eventData({
    String? eventId,
    String? ownerId,
    List<String>? participantsIds,
    String? title,
    String? description,
    String? location,
    DateTime? datetime,
    int? cost,
    bool? isOnline,
    String? cover,
    bool? approved,
  }) {
    return EventDataModel(
      eventId: eventId ?? TestData.eventId,
      ownerId: ownerId ?? TestData.userId,
      participantsIds: participantsIds ?? TestData.participants,
      title: title ?? TestData.title,
      description: description ?? TestData.description,
      location: location ?? TestData.location,
      datetime: datetime ?? TestData.dateTime,
      cost: cost ?? 0,
      isOnline: isOnline ?? false,
      cover: cover,
      approved: approved,
    );
  }

  static EventRequestDataModel eventRequestDataModel({
    String? title,
    String? description,
    String? location,
    DateTime? datetime,
    int? cost,
    bool? isOnline,
    String? cover,
  }) {
    return EventRequestDataModel(
      title: title ?? TestData.title,
      description: description ?? TestData.description,
      location: location ?? TestData.location,
      datetime: datetime ?? TestData.dateTime,
      cost: cost ?? 0,
      isOnline: isOnline ?? false,
      cover: cover,
    );
  }

  static EventModel eventModel({
    String? eventId,
    UserStatus? userStatus,
    String? title,
    String? description,
    String? coverBytes,
    String? location,
    CostModel? cost,
    DateTime? occurringAt,
    bool? onlineEvent,
    ISet<String>? participantsIds,
    bool? pendingApproval,
  }) {
    return EventModel(
      eventId: eventId ?? TestData.eventId,
      userStatus: userStatus ?? const UserStatus.author(),
      title: title,
      description: description,
      coverBytes: coverBytes,
      location: location,
      cost: cost ?? const CostModel(number: 0.0, currency: Currency.rub),
      occurringAt: occurringAt ?? TestData.dateTime,
      onlineEvent: onlineEvent ?? false,
      participantsIds: participantsIds ?? TestData.participants.toISet(),
      pendingApproval: pendingApproval ?? false,
    );
  }

  static Map<String, dynamic> profileJson({
    String? id,
    String? firstName,
    String? lastName,
    String? graduationYear,
    String? location,
    String? biography,
    bool? showLocation,
    String? telegramAlias,
    String? avatar,
    bool? isTelegramVerified,
  }) {
    return {
      'id': id ?? userId,
      'first_name': firstName ?? TestData.firstName,
      'last_name': lastName ?? TestData.lastName,
      'graduation_year': graduationYear ?? TestData.graduationYear,
      'location': location,
      'biography': biography,
      'show_location': showLocation ?? false,
      'telegram_alias': telegramAlias,
      'avatar': avatar,
      'is_telegram_verified': isTelegramVerified ?? false,
    };
  }

  static Map<String, dynamic> eventDataJson({
    String? eventId,
    String? ownerId,
    List<String>? participantsIds,
    String? title,
    String? description,
    String? location,
    DateTime? datetime,
    int? cost,
    bool? isOnline,
    String? cover,
    bool? approved,
  }) {
    return {
      'id': eventId ?? TestData.eventId,
      'owner_id': ownerId ?? TestData.userId,
      'participants_ids': participantsIds ?? TestData.participants,
      'title': title ?? TestData.title,
      'description': description ?? TestData.description,
      'location': location ?? TestData.location,
      'datetime': (datetime ?? TestData.dateTime).toIso8601String(),
      'cost': cost ?? 0,
      'is_online': isOnline ?? false,
      'cover': cover,
      'approved': approved,
    };
  }

  static Map<String, dynamic> eventRequestDataJson({
    String? title,
    String? description,
    String? location,
    DateTime? datetime,
    int? cost,
    bool? isOnline,
    String? cover,
  }) {
    return {
      'title': title ?? TestData.title,
      'description': description ?? TestData.description,
      'location': location ?? TestData.location,
      'datetime': (datetime ?? TestData.dateTime).toIso8601String(),
      'cost': cost ?? 0,
      'is_online': isOnline ?? false,
      'cover': cover,
    };
  }
}