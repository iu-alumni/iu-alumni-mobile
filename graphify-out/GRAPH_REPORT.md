# Graph Report - .  (2026-07-25)

## Corpus Check
- 243 files · ~58,686 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 2382 nodes · 4708 edges · 154 communities (125 shown, 29 thin omitted)
- Extraction: 94% EXTRACTED · 6% INFERRED · 0% AMBIGUOUS · INFERRED: 290 edges (avg confidence: 0.5)
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- Community 1
- Community 2
- Community 3
- Community 4
- Community 5
- Community 6
- Community 7
- Community 8
- Community 9
- Community 10
- Community 11
- Community 12
- Community 13
- Community 14
- Community 15
- Community 16
- Community 17
- Community 18
- Community 19
- Community 20
- Community 21
- Community 22
- Community 23
- Community 24
- Community 25
- Community 26
- Community 27
- Community 28
- Community 29
- Community 30
- Community 31
- Community 32
- Community 33
- Community 34
- Community 35
- Community 36
- Community 37
- Community 38
- Community 39
- Community 40
- Community 41
- Community 42
- Community 43
- Community 44
- Community 45
- Community 46
- Community 47
- Community 48
- Community 49
- Community 50
- Community 51
- Community 52
- Community 53
- Community 54
- Community 55
- Community 56
- Community 57
- Community 58
- Community 59
- Community 60
- Community 61
- Community 62
- Community 63
- Community 64
- Community 65
- Community 66
- Community 67
- Community 68
- Community 69
- Community 70
- Community 71
- Community 72
- Community 73
- Community 74
- Community 75
- Community 76
- Community 77
- Community 78
- Community 79
- Community 80
- Community 81
- Community 82
- Community 83
- Community 84
- Community 85
- Community 86
- Community 87
- Community 88
- Community 89
- Community 90
- Community 91
- Community 92
- Community 93
- Community 94
- Community 95
- Community 96
- Community 97
- Community 98
- Community 99
- Community 100
- Community 101
- Community 102
- Community 103
- Community 104
- Community 105
- Community 106
- Community 107
- Community 108
- Community 109
- Community 110
- Community 111
- Community 112
- Community 113
- Community 114
- Community 115
- Community 116
- Community 117
- Community 118
- Community 120
- Community 121
- Community 122
- Community 123
- Community 124
- Community 125
- Community 126
- Community 127
- Community 128
- Community 129
- Community 130
- Community 131
- Community 132
- Community 133
- Community 134
- Community 135
- Community 136
- Community 137
- Community 138
- Community 139
- Community 140
- Community 141
- Community 142
- Community 143

## God Nodes (most connected - your core abstractions)
1. `b()` - 108 edges
2. `h()` - 94 edges
3. `c()` - 89 edges
4. `i()` - 60 edges
5. `d()` - 57 edges
6. `l()` - 51 edges
7. `Reporter` - 45 edges
8. `OneEventCubit` - 38 edges
9. `J()` - 36 edges
10. `M()` - 34 edges

## Surprising Connections (you probably didn't know these)
- `_FakeAuthRepository` --implements--> `AuthRepository`  [EXTRACTED]
  test/unit/blocs/registration_cubit_test.dart → lib/application/repositories/auth/auth_repository.dart
- `ReporterAppMetrica` --implements--> `Reporter`  [EXTRACTED]
  lib/application/repositories/reporter/reporter_appmetrica.dart → lib/application/repositories/reporter/reporter.dart
- `ReporterMock` --inherits--> `Reporter`  [EXTRACTED]
  lib/application/repositories/reporter/reporter_mock.dart → lib/application/repositories/reporter/reporter.dart
- `_open` --references--> `Reporter`  [EXTRACTED]
  lib/presentation/pages/map/map_page.dart → lib/application/repositories/reporter/reporter.dart
- `OtpLoginCubit` --references--> `OtpLoginState`  [EXTRACTED]
  lib/presentation/blocs/otp_login/otp_login_cubit.dart → lib/presentation/blocs/models/otp_login_state.dart

## Import Cycles
- None detected.

## Communities (154 total, 29 thin omitted)

### Community 1 - "Community 1"
Cohesion: 0.04
Nodes (69): ../application/models/cost.dart, ../../../../application/models/user_status.dart, ../../application/repositories/reporter/reporter.dart, AutoRouteObserver, badges_section.dart, ../../blocs/badges/badges_cubit.dart, ../../../blocs/models/profile_state.dart, ../../../blocs/profile/profile_cubit.dart (+61 more)

### Community 2 - "Community 2"
Cohesion: 0.04
Nodes (49): ../../../../application/models/event.dart, ../../../../application/models/profile.dart, ../../../application/repositories/events/events_repository.dart, ../../../application/repositories/users/users_repository.dart, ../../common/models/loaded_state.dart, loadProfile, update, EventsListData (+41 more)

### Community 3 - "Community 3"
Cohesion: 0.06
Nodes (55): ac(), aL(), av(), aX(), bW(), c3(), cL(), d7() (+47 more)

### Community 4 - "Community 4"
Cohesion: 0.07
Nodes (45): ../../../blocs/models/one_event_state.dart, ../../../blocs/one_event/one_event_cubit.dart, ../../common/constants/app_colors.dart, ../../../common/widgets/app_switch.dart, ../../../common/widgets/app_text_field.dart, ../../../common/widgets/location_dialog.dart, ../../../common/widgets/profile_pic.dart, ../../../common/widgets/titled_item.dart (+37 more)

### Community 5 - "Community 5"
Cohesion: 0.06
Nodes (39): ../../../application/repositories/auth/otp_login_repository.dart, ../../../blocs/auth/auth_cubit.dart, ../../../blocs/code_verification/code_verification_cubit.dart, ../../../blocs/models/otp_login_state.dart, ../../../blocs/otp_login/otp_login_cubit.dart, ../../../blocs/password_reset/password_reset_request_cubit.dart, ../../../blocs/registration/registration_cubit.dart, ../../../common/widgets/app_loader.dart (+31 more)

### Community 6 - "Community 6"
Cohesion: 0.08
Nodes (30): @freezed, cost.dart, CityLocation, fromJson, Coordinates, fromJson, CostModel, Currency (+22 more)

### Community 7 - "Community 7"
Cohesion: 0.07
Nodes (41): $0(), a8(), aH(), aI(), aJ(), aW(), bm(), bO() (+33 more)

### Community 8 - "Community 8"
Cohesion: 0.06
Nodes (35): @immutable, ../../../application/models/badge.dart, ../../../application/repositories/badges/badges_repository.dart, DateTime, double get, awardedAt, Badge, BadgesData (+27 more)

### Community 9 - "Community 9"
Cohesion: 0.06
Nodes (32): app.dart, ../constants/app_colors.dart, ../constants/app_text_styles.dart, dart:convert, dart:ui, double?, IconData, main (+24 more)

### Community 10 - "Community 10"
Cohesion: 0.06
Nodes (37): application/repositories/auth/auth_repository_impl.dart, application/repositories/auth/otp_login_repository_impl.dart, application/repositories/auth/password_reset_repository_impl.dart, application/repositories/auth/telegram_otp_login_repository_impl.dart, application/repositories/auth/telegram_verify_repository_impl.dart, application/repositories/badges/badges_repository_api.dart, application/repositories/events/events_repository_impl.dart, application/repositories/map/map_repository_impl.dart (+29 more)

### Community 11 - "Community 11"
Cohesion: 0.10
Nodes (35): @RoutePage, AutoRouteWrapper, EventsRepository, EventsRepositoryImpl, UsersRepositoryImpl, UsersRepository, AppTextField, _AppTextFieldState (+27 more)

### Community 12 - "Community 12"
Cohesion: 0.06
Nodes (33): Key?, cityData, coords, email, eventId, key, location, name (+25 more)

### Community 13 - "Community 13"
Cohesion: 0.09
Nodes (28): $1(), $3(), $5(), aK(), d9(), fi(), fn(), fo() (+20 more)

### Community 14 - "Community 14"
Cohesion: 0.07
Nodes (27): cities, coordinates, dispose, cities, coordinates, dispose, _gateway, init (+19 more)

### Community 15 - "Community 15"
Cohesion: 0.06
Nodes (31): allProfiles, _auth, _cities, coordinates, events, eventsOwner, eventsPending, eventsWhereParticipant (+23 more)

### Community 16 - "Community 16"
Cohesion: 0.08
Nodes (27): ../../application/models/map_location_group.dart, ../common/dio_options_manager.dart, DioOptionsManager, opts, _token, _tokenProvider, getMapLocations, _dio (+19 more)

### Community 17 - "Community 17"
Cohesion: 0.07
Nodes (29): ../../application/models/paginated_result.dart, events_gateway.dart, addEvent, deleteEvent, EventsGateway, eventsIOwn, eventsWhereParticipate, addEvent (+21 more)

### Community 18 - "Community 18"
Cohesion: 0.08
Nodes (32): an(), ao(), bC(), bd(), be(), bI(), bP(), bQ() (+24 more)

### Community 19 - "Community 19"
Cohesion: 0.07
Nodes (29): AssetGenImage get, ChangeNotifier, class AlwaysRootRouteInformationProvider extends, alumni, AssetGenImage, _assetName, Assets, flavors (+21 more)

### Community 20 - "Community 20"
Cohesion: 0.08
Nodes (31): a_(), a2(), dV(), dz(), e2(), f6(), ff(), fq() (+23 more)

### Community 21 - "Community 21"
Cohesion: 0.07
Nodes (29): static const double, static const List, static final DateTime, anotherUserId, code, cost, cover, dateTime (+21 more)

### Community 22 - "Community 22"
Cohesion: 0.09
Nodes (24): ../../../application/repositories/auth/password_reset_repository.dart, ../../blocs/password_reset/password_reset_confirm_cubit.dart, class PasswordResetConfirmPage extends, requestOtp, verifyOtp, confirmReset, PasswordResetRepositoryImpl, PasswordResetRepository (+16 more)

### Community 23 - "Community 23"
Cohesion: 0.08
Nodes (26): ../../../blocs/models/registration_state.dart, ../../../common/constants/app_text_styles.dart, ../../common/widgets/app_button.dart, ../../../common/widgets/app_card.dart, build, createState, dispose, email (+18 more)

### Community 24 - "Community 24"
Cohesion: 0.11
Nodes (29): a4(), aE(), aF(), ay(), aZ(), b5(), bX(), bz() (+21 more)

### Community 25 - "Community 25"
Cohesion: 0.10
Nodes (24): @AutoRouterConfig, app_router.gr.dart, ../../../blocs/models/telegram_otp_login_state.dart, ../../../blocs/telegram_otp_login/telegram_otp_login_cubit.dart, TelegramOtpLoginCubit, init, _reporter, _secretsManager (+16 more)

### Community 26 - "Community 26"
Cohesion: 0.07
Nodes (27): dart:math, ../../../data/events/events_gateway.dart, events_repository.dart, _cache, createEvent, deleteEvent, _fixEvent, _gateway (+19 more)

### Community 27 - "Community 27"
Cohesion: 0.10
Nodes (28): aB(), aR(), bj(), bk(), bT(), bU(), cD(), cG() (+20 more)

### Community 28 - "Community 28"
Cohesion: 0.08
Nodes (25): build, profiles, _profileWidgets, StackedRow, alumniCount, build, cityData, coords (+17 more)

### Community 29 - "Community 29"
Cohesion: 0.12
Nodes (23): ../../auth/widgets/year_picker.dart, ../../../blocs/models/profile_editing_state.dart, ../../../blocs/profile/profile_editing_cubit.dart, ../../../common/widgets/event_cover.dart, ImagePicker, ProfileEditingCubit, build, _buildWhen (+15 more)

### Community 30 - "Community 30"
Cohesion: 0.08
Nodes (24): badge_details_sheet.dart, allCount, _BadgeFilter, _badgeWidth, build, createState, current, data (+16 more)

### Community 31 - "Community 31"
Cohesion: 0.09
Nodes (25): ap(), bA(), bg(), c(), c5(), dM(), dx(), fA() (+17 more)

### Community 32 - "Community 32"
Cohesion: 0.08
Nodes (23): _activated, init, _report, reportAuthError, reportAuthSuccessful, reportCreateEventTap, reportDeleteEvent, reportEditEventTap (+15 more)

### Community 33 - "Community 33"
Cohesion: 0.10
Nodes (21): ../../../application/repositories/auth/telegram_verify_repository.dart, Cubit, AuthCubit, copyWith, hashCode, init, operator, _repository (+13 more)

### Community 34 - "Community 34"
Cohesion: 0.10
Nodes (22): ../../blocs/models/badges_state.dart, ../../blocs/root/root_page_cubit.dart, ../events_list/events_list_page.dart, RootPageCubit, _badgesShown, build, createState, _drainBadgePopups (+14 more)

### Community 35 - "Community 35"
Cohesion: 0.09
Nodes (20): Color get, EdgeInsets, AppButton, AppButtonStyle, build, _buttonColor, buttonStyle, child (+12 more)

### Community 36 - "Community 36"
Cohesion: 0.09
Nodes (22): _authRepository, dataIsValid, dispose, _missingFieldsMessage, _register, registerManually, registerViaEmail, _reporter (+14 more)

### Community 37 - "Community 37"
Cohesion: 0.12
Nodes (20): ../../blocs/events_list/events_list_cubit.dart, EventsListState, EventsListCubit, build, createState, _delete, _ErrorText, eventId (+12 more)

### Community 38 - "Community 38"
Cohesion: 0.10
Nodes (20): Currency, ../../../gen/assets.gen.dart, AlumniLogo, build, build, _Currency, CurrencyDialog, _EarnedBody (+12 more)

### Community 39 - "Community 39"
Cohesion: 0.10
Nodes (19): FlutterSecureStorage, clear, init, _secureStorage, _token, _tokenKey, TokenManager, clear (+11 more)

### Community 40 - "Community 40"
Cohesion: 0.09
Nodes (21): AppLocation, init, NavAction, reportAuthError, reportAuthSuccessful, reportCreateEventTap, reportDeleteEvent, reportEditEventTap (+13 more)

### Community 41 - "Community 41"
Cohesion: 0.09
Nodes (21): init, reportAuthError, reportAuthSuccessful, reportCreateEventTap, reportDeleteEvent, reportEditEventTap, reportEditProfileTap, ReporterMock (+13 more)

### Community 42 - "Community 42"
Cohesion: 0.12
Nodes (19): ../../blocs/pin_locations/pin_locations_cubit.dart, PinLocationsCubit, PinLocationsState, build, _ClusterMarker, createState, dispose, initState (+11 more)

### Community 43 - "Community 43"
Cohesion: 0.10
Nodes (19): badge, BadgeEarnedPopup, build, _Card, circle, color, _Confetti, _iconFor (+11 more)

### Community 44 - "Community 44"
Cohesion: 0.11
Nodes (18): int?, build, _controller, createState, dispose, _focused, _focusNode, hintText (+10 more)

### Community 45 - "Community 45"
Cohesion: 0.11
Nodes (17): _badgeCollector, _crossCity, _foundingHost, _hostWithTheMost, _innopolisOg, loadFor, loadMyBadges, _localLegend (+9 more)

### Community 46 - "Community 46"
Cohesion: 0.11
Nodes (17): BadgeDetailsSheet, build, child, earned, _iconFor, locked, _LockedBody, _requirementText (+9 more)

### Community 47 - "Community 47"
Cohesion: 0.12
Nodes (16): auth_gateway.dart, authorize, _dio, _dioOptionsManager, loginOtpRequest, loginOtpVerify, loginTelegramOtpRequest, loginTelegramOtpVerify (+8 more)

### Community 48 - "Community 48"
Cohesion: 0.12
Nodes (15): int get, code, copyWith, hashCode, operator, OtpLoginState, request, verify (+7 more)

### Community 49 - "Community 49"
Cohesion: 0.13
Nodes (17): $2(), cI(), d(), d5(), eT(), eU(), gar(), kS() (+9 more)

### Community 50 - "Community 50"
Cohesion: 0.17
Nodes (14): ../../../blocs/models/code_verification_state.dart, CodeVerificationCubit, CodeVerificationState, build, CodeVerificationSubPage, _CodeVerificationSubPageState, createState, _cubit (+6 more)

### Community 51 - "Community 51"
Cohesion: 0.15
Nodes (15): class, AuthRepository, AuthRepositoryImpl, build, createState, _email, _loading, _message (+7 more)

### Community 52 - "Community 52"
Cohesion: 0.12
Nodes (15): ../../../data/profile/profile_gateway.dart, ../../../data/users/users_gateway.dart, getAllUsers, getUsersAtLocation, getUsersByIds, loadMe, logout, _me (+7 more)

### Community 53 - "Community 53"
Cohesion: 0.12
Nodes (15): Equatable, alumniCount, city, CityData, coord, country, events, fullLocation (+7 more)

### Community 54 - "Community 54"
Cohesion: 0.15
Nodes (15): RegistrationCubit, initState, build, _desc, _ErrorText, _listen, _showBetterImage, _showVerificationInitiated (+7 more)

### Community 55 - "Community 55"
Cohesion: 0.15
Nodes (16): $4(), ag(), aQ(), d2(), dC(), i(), k(), mH() (+8 more)

### Community 56 - "Community 56"
Cohesion: 0.13
Nodes (13): ../../application/models/city_location.dart, ../../application/models/coordinates.dart, cities, coordinates, DbManager, dispose, init, cities (+5 more)

### Community 57 - "Community 57"
Cohesion: 0.13
Nodes (13): auth_repository_impl_test.mocks.dart, Either, MockAuthGateway, package:mockito/annotations.dart, package:mockito/mockito.dart, package:ui_alumni_mobile/application/models/register_request.dart, package:ui_alumni_mobile/application/repositories/auth/auth_repository_impl.dart, package:ui_alumni_mobile/data/auth/auth_gateway.dart (+5 more)

### Community 58 - "Community 58"
Cohesion: 0.13
Nodes (14): badges_repository.dart, ../../../data/common/dio_options_manager.dart, _base, _dio, loadFor, loadMyBadges, markSeen, _options (+6 more)

### Community 59 - "Community 59"
Cohesion: 0.18
Nodes (14): ../../common/widgets/alumni_logo.dart, ../../../data/secrets/secrets_manager.dart, ../../../data/token/token_provider.dart, SecretsManager, TokenProviderImpl, TokenProvider, AppLoadingManager, AppLoadingPage (+6 more)

### Community 60 - "Community 60"
Cohesion: 0.14
Nodes (14): ../../../common/widgets/event_card.dart, Iterable, build, _colorFor, createState, events, EventsList, _EventsListState (+6 more)

### Community 61 - "Community 61"
Cohesion: 0.13
Nodes (14): events_repository_impl_test.mocks.dart, MockEventsGateway, MockUsersRepository, MockUuid, package:ui_alumni_mobile/application/repositories/events/events_repository_impl.dart, package:ui_alumni_mobile/application/repositories/users/users_repository.dart, package:ui_alumni_mobile/data/events/events_gateway.dart, package:ui_alumni_mobile/data/models/event_request_data_model.dart (+6 more)

### Community 62 - "Community 62"
Cohesion: 0.15
Nodes (14): actions, AppBody, AppChildBody, AppListBody, AppScaffold, body, build, child (+6 more)

### Community 63 - "Community 63"
Cohesion: 0.13
Nodes (14): package:ui_alumni_mobile/application/repositories/auth/auth_repository.dart, package:ui_alumni_mobile/application/repositories/reporter/reporter_mock.dart, authorize, authRepository, cleanEmail, cubit, fillRequiredFields, _leftMessage (+6 more)

### Community 64 - "Community 64"
Cohesion: 0.15
Nodes (15): a0(), b(), ky(), oK(), ow(), oy(), pA(), pD() (+7 more)

### Community 65 - "Community 65"
Cohesion: 0.18
Nodes (15): a6(), aM(), b2(), b4(), b6(), b7(), cA(), cE() (+7 more)

### Community 66 - "Community 66"
Cohesion: 0.15
Nodes (10): Any, Bool, Flutter, FlutterAppDelegate, AppDelegate, RunnerTests, UIApplication, UIKit (+2 more)

### Community 67 - "Community 67"
Cohesion: 0.19
Nodes (11): ../../../helpers/test_data.dart, ../../../lib/application/models/profile.dart, package:fast_immutable_collections/fast_immutable_collections.dart, package:ui_alumni_mobile/application/mappers/event_mapper.dart, package:ui_alumni_mobile/application/models/cost.dart, package:ui_alumni_mobile/application/models/event.dart, package:ui_alumni_mobile/application/models/user_status.dart, package:ui_alumni_mobile/data/models/event_data_model.dart (+3 more)

### Community 68 - "Community 68"
Cohesion: 0.14
Nodes (13): MockProfileGateway, MockTokenProvider, MockUsersGateway, package:ui_alumni_mobile/application/repositories/users/users_repository_impl.dart, package:ui_alumni_mobile/data/profile/profile_gateway.dart, package:ui_alumni_mobile/data/token/token_provider.dart, package:ui_alumni_mobile/data/users/users_gateway.dart, mockProfileGateway (+5 more)

### Community 69 - "Community 69"
Cohesion: 0.15
Nodes (12): ../../../application/models/register_request.dart, authorize, loginOtpRequest, loginOtpVerify, loginTelegramOtpRequest, loginTelegramOtpVerify, passwordResetConfirm, passwordResetRequest (+4 more)

### Community 70 - "Community 70"
Cohesion: 0.15
Nodes (12): ../../../data/map/map_gateway.dart, ../events/events_repository.dart, _cityLocationFromStr, _eventsRepository, getPinsOnMap, _locationsRepository, _mapGateway, suggestions (+4 more)

### Community 71 - "Community 71"
Cohesion: 0.15
Nodes (9): ../../../lib/application/models/cost.dart, ../../../lib/application/models/user_status.dart, package:flutter_test/flutter_test.dart, package:ui_alumni_mobile/application/models/map_location_group.dart, package:ui_alumni_mobile/application/models/paginated_result.dart, main, main, main (+1 more)

### Community 72 - "Community 72"
Cohesion: 0.18
Nodes (11): app_button.dart, app_text_field.dart, ../../blocs/location_suggestions/location_suggestions_cubit.dart, MapRepositoryImpl, MapRepository, build, LocationDialog, _onTap (+3 more)

### Community 73 - "Community 73"
Cohesion: 0.17
Nodes (11): ../../../application/repositories/auth/telegram_otp_login_repository.dart, checkCode, _codeIsValid, _rawVerify, _repository, requestOtp, reset, sinkCode (+3 more)

### Community 74 - "Community 74"
Cohesion: 0.17
Nodes (11): bool get, checkCode, _codeIsOk, dispose, _rawVerify, _repo, resend, setEmail (+3 more)

### Community 75 - "Community 75"
Cohesion: 0.18
Nodes (10): ../../../data/auth/auth_gateway.dart, _authGateway, confirmReset, requestReset, _authGateway, requestVerification, AuthGateway, AuthGatewayImpl (+2 more)

### Community 76 - "Community 76"
Cohesion: 0.17
Nodes (12): _i21.PageRouteInfo, AppLoadingRoute, AuthRoute, CodeVerificationSubRoute, OtpVerifySubRoute, PasswordResetRequestSubRoute, ProfileEditingRoute, RestoredVerificationSubRoute (+4 more)

### Community 77 - "Community 77"
Cohesion: 0.17
Nodes (11): createEvent, deleteEvent, getEvents, getEventsIOwn, getEventsWhereParticipate, getOneEvent, leave, modifyEvent (+3 more)

### Community 78 - "Community 78"
Cohesion: 0.18
Nodes (10): app_colors.dart, actionM, actionSB, AppTextStyles, body, caption, _default, largeTitle (+2 more)

### Community 79 - "Community 79"
Cohesion: 0.20
Nodes (9): ../../../application/repositories/map/map_repository.dart, _debouncePeriod, _debouncer, _mapRepository, suggest, _mapRepository, update, package:flutter_debouncer/flutter_debouncer.dart (+1 more)

### Community 80 - "Community 80"
Cohesion: 0.18
Nodes (9): _authGateway, requestOtp, _sessionToken, TelegramOtpLoginRepositoryImpl, verifyOtp, requestOtp, TelegramOtpLoginRepository, verifyOtp (+1 more)

### Community 81 - "Community 81"
Cohesion: 0.18
Nodes (10): background_color, description, display, icons, name, orientation, prefer_related_applications, short_name (+2 more)

### Community 82 - "Community 82"
Cohesion: 0.20
Nodes (11): aA(), f(), fD(), fl(), fx(), ga3(), k0(), lH() (+3 more)

### Community 83 - "Community 83"
Cohesion: 0.24
Nodes (11): au(), b9(), bN(), c0(), c7(), ck(), cs(), dW() (+3 more)

### Community 84 - "Community 84"
Cohesion: 0.20
Nodes (9): auth_repository.dart, _authGateway, authorize, cleanEmail, register, _registrationEmail, sendCode, setEmail (+1 more)

### Community 85 - "Community 85"
Cohesion: 0.20
Nodes (9): editing_cost.dart, editing_cover.dart, editing_date.dart, editing_desc.dart, editing_location.dart, editing_switch.dart, editing_title.dart, build (+1 more)

### Community 86 - "Community 86"
Cohesion: 0.20
Nodes (9): AppColors, darkGray, error, gray30, gray50, gray80, gray90, primary (+1 more)

### Community 87 - "Community 87"
Cohesion: 0.22
Nodes (8): getAllUsers, getUsersAtLocation, getUsersByIds, loadMe, logout, update, ../../models/paginated_result.dart, ../../models/profile.dart

### Community 88 - "Community 88"
Cohesion: 0.28
Nodes (8): EventsListState, LocationSuggestionsCubit, LocationSuggestionsState, data, error, init, LoadedState, loading

### Community 89 - "Community 89"
Cohesion: 0.25
Nodes (9): c1(), cU(), da(), ex(), ga9(), gem(), k3(), pJ() (+1 more)

### Community 90 - "Community 90"
Cohesion: 0.25
Nodes (7): app_card.dart, Color, AppLoader, build, color, inCard, package:flutter/cupertino.dart

### Community 91 - "Community 91"
Cohesion: 0.25
Nodes (7): ../../../data/models/event_data_model.dart, ../../data/models/event_request_data_model.dart, EventMapper, eventRequestFromModel, ../../models/cost.dart, ../../models/event.dart, ../../models/user_status.dart

### Community 92 - "Community 92"
Cohesion: 0.25
Nodes (7): authorize, cleanEmail, register, sendCode, setEmail, verifyCode, ../../models/register_request.dart

### Community 93 - "Community 93"
Cohesion: 0.25
Nodes (7): BadgesRepositoryApi, BadgesRepository, loadFor, loadMyBadges, markSeen, BadgesRepositoryMock, ../../models/badge.dart

### Community 94 - "Community 94"
Cohesion: 0.25
Nodes (8): aD(), at(), b8(), e6(), eO(), ev(), p8(), p9()

### Community 95 - "Community 95"
Cohesion: 0.29
Nodes (6): Future, expectLeft, expectLeftError, expectRight, expectRightSuccess, TestExpectations

### Community 96 - "Community 96"
Cohesion: 0.29
Nodes (6): _authGateway, requestOtp, _sessionToken, verifyOtp, otp_login_repository.dart, package:ui_alumni_mobile/util/logger.dart

### Community 97 - "Community 97"
Cohesion: 0.29
Nodes (6): appMetricaKey, hostPath, init, webSalt, package:ui_alumni_mobile/data/config/api_config.dart, String?

### Community 98 - "Community 98"
Cohesion: 0.33
Nodes (7): bF(), bV(), cq(), dL(), ee(), fj(), N()

### Community 99 - "Community 99"
Cohesion: 0.29
Nodes (7): cO(), cR(), cv(), cz(), gB(), lN(), mc()

### Community 100 - "Community 100"
Cohesion: 0.33
Nodes (5): ../../../../application/repositories/auth/auth_repository.dart, authorize, _authRepository, _reporter, _validateEmail

### Community 101 - "Community 101"
Cohesion: 0.33
Nodes (6): a1(), b1(), bB(), bl(), dN(), lt()

### Community 102 - "Community 102"
Cohesion: 0.33
Nodes (6): copyProperties(), inherit(), inheritMany(), setOrUpdateInterceptorsByTag(), setOrUpdateLeafTags(), updateHolder()

### Community 103 - "Community 103"
Cohesion: 0.40
Nodes (4): dart:js_interop, dart:js_interop_unsafe, fromEnvironment, getApiBaseUrl

### Community 104 - "Community 104"
Cohesion: 0.40
Nodes (5): a5(), a7(), dH(), gdf(), mr()

### Community 105 - "Community 105"
Cohesion: 0.40
Nodes (5): bh(), bs(), c4(), eB(), kO()

### Community 106 - "Community 106"
Cohesion: 0.40
Nodes (5): installInstanceTearOff(), installStaticTearOff(), instanceTearOffGetter(), staticTearOffGetter(), tearOffParameters()

### Community 107 - "Community 107"
Cohesion: 0.50
Nodes (4): @GenerateMocks, main, main, main

### Community 108 - "Community 108"
Cohesion: 0.50
Nodes (3): TelegramVerifyRepositoryImpl, requestVerification, TelegramVerifyRepository

### Community 109 - "Community 109"
Cohesion: 0.50
Nodes (4): getTag(), getTagFirefox(), getTagFixed(), getTagIE()

### Community 113 - "Community 113"
Cohesion: 0.67
Nodes (3): b0(), cN(), q8()

### Community 114 - "Community 114"
Cohesion: 0.67
Nodes (3): c6(), mY(), o2()

### Community 115 - "Community 115"
Cohesion: 0.67
Nodes (3): dG(), pZ(), sdJ()

### Community 116 - "Community 116"
Cohesion: 0.67
Nodes (3): gao(), kz(), n9()

## Knowledge Gaps
- **909 isolated node(s):** `build-apk.sh script`, `dbgen.sh script`, `entrypoint.sh script`, `XCTest`, `_host` (+904 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **29 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `Reporter` connect `Community 1` to `Community 32`, `Community 2`, `Community 34`, `Community 100`, `Community 36`, `Community 5`, `Community 37`, `Community 40`, `Community 41`, `Community 10`, `Community 11`, `Community 42`, `Community 25`, `Community 59`, `Community 29`?**
  _High betweenness centrality (0.041) - this node is a cross-community bridge._
- **Why does `ReporterMock` connect `Community 41` to `Community 1`?**
  _High betweenness centrality (0.012) - this node is a cross-community bridge._
- **Why does `EventsRepository` connect `Community 11` to `Community 1`, `Community 2`, `Community 37`, `Community 70`, `Community 10`, `Community 77`?**
  _High betweenness centrality (0.011) - this node is a cross-community bridge._
- **Are the 68 inferred relationships involving `b()` (e.g. with `$0()` and `a_()`) actually correct?**
  _`b()` has 68 INFERRED edges - model-reasoned connections that need verification._
- **Are the 10 inferred relationships involving `h()` (e.g. with `bl()` and `ec()`) actually correct?**
  _`h()` has 10 INFERRED edges - model-reasoned connections that need verification._
- **Are the 78 inferred relationships involving `c()` (e.g. with `a1()` and `a5()`) actually correct?**
  _`c()` has 78 INFERRED edges - model-reasoned connections that need verification._
- **What connects `build-apk.sh script`, `dbgen.sh script`, `entrypoint.sh script` to the rest of the system?**
  _909 weakly-connected nodes found - possible documentation gaps or missing edges._