import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../application/models/event.dart';
import '../../../../application/models/profile.dart';
import '../../../../application/repositories/reporter/reporter.dart';
import '../../../../util/gap.dart';
import '../../../blocs/models/profile_state.dart';
import '../../../blocs/profile/profile_cubit.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_text_styles.dart';
import '../../../common/models/loaded_state.dart';
import '../../../common/widgets/app_button.dart';
import '../../../common/widgets/app_loader.dart';
import '../../../common/widgets/app_scaffold.dart';
import '../../../common/widgets/app_tag.dart';
import '../../../common/widgets/event_card.dart';
import '../../../common/widgets/profile_pic.dart';
import '../../../common/widgets/titled_item.dart';
import '../../root/root_page.dart';
import 'open_bot_card.dart';

const _eventCardWidth = 200.0;

class ProfileContent {
  ProfileContent({required this.personal, required this.profile});

  final Profile profile;
  final bool personal;

  static const _horPadding = EdgeInsets.symmetric(horizontal: 16);

  void _openTelegram(BuildContext context) {
    context.read<Reporter>().reportUserTelegramOpen(
          profile,
          AppLocation.profileScreen,
        );
    if (profile.telegramAlias case final tg?) {
      launchUrl(
        Uri.parse('https://t.me/$tg'),
        mode: LaunchMode.externalApplication,
      );
    }
  }

  void _copyTelegram(BuildContext context) {
    context.read<Reporter>().reportUserTelegramCopy(
          profile,
          AppLocation.profileScreen,
        );
    if (profile.telegramAlias case final tg?) {
      Clipboard.setData(ClipboardData(text: tg));
    }
  }

  AppBody build(BuildContext context) => AppListBody(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(height: 24),
          ProfilePic(profile: profile),
          const SizedBox(height: 8),
          Padding(
            padding: _horPadding,
            child: Text(
              '${profile.firstName.trim()} ${profile.lastName.trim()}',
              style: AppTextStyles.subtitle,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: _horPadding,
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: [
                if (profile.location case final loc?)
                  AppTag(icon: Icons.pin_drop, text: loc),
                AppTag(icon: Icons.school, text: profile.graduationYear),
              ],
            ),
          ),
          ...[
            if (profile.biography case final bio?)
              Text(bio, style: AppTextStyles.body),
            if (profile.telegramAlias case final telegram?)
              Padding(
                padding: _horPadding,
                child: TitledItem(
                  title: 'Telegram alias',
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: AppButton(
                          buttonStyle: AppButtonStyle.text,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '@$telegram',
                              style: AppTextStyles.body.copyWith(
                                decoration: TextDecoration.underline,
                              ),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          onTap: () => _copyTelegram(context),
                        ),
                      ),
                      const SizedBox(width: 2),
                      AppButton(
                        buttonStyle: AppButtonStyle.text,
                        onTap: () => _openTelegram(context),
                        child: const Padding(
                          padding: EdgeInsets.all(12),
                          child: Icon(
                            Icons.open_in_new,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (personal) const _OwnedEvents(),
            const _ParticipatedEvents(),
            if (personal)
              const Padding(padding: _horPadding, child: OpenBotCard()),
          ].expand(
            (e) => [const SizedBox(height: 24), e],
          ),
          const SizedBox(height: RootPage.navigationBarHeight + 16),
        ],
      );
}

class _ParticipatedEvents extends StatelessWidget {
  const _ParticipatedEvents();

  @override
  Widget build(BuildContext context) => TitledItem(
        title: 'Participated events',
        titlePadding: const EdgeInsets.symmetric(horizontal: 24),
        child: BlocBuilder<ProfileCubit, ProfileState>(
          buildWhen: (p, c) => p.participatedEvents != c.participatedEvents,
          builder: (context, state) => switch (state.participatedEvents) {
            LoadedStateData<IList<EventModel>>(:final data) when data.isEmpty =>
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Empty here 😢',
                  style: AppTextStyles.caption,
                  textAlign: TextAlign.center,
                ),
              ),
            LoadedStateData<IList<EventModel>>(:final data) =>
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                // padding: const EdgeInsets.symmetric(horizontal: 0),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    for (final e in data)
                      SizedBox(
                        width: _eventCardWidth,
                        child: EventCard(event: e),
                      )
                  ].gap(
                    const SizedBox(width: 8),
                  ),
                ),
              ),
            _ => const Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: AppLoader(),
                ),
              ),
          },
        ),
      );
}

class _OwnedEvents extends StatelessWidget {
  const _OwnedEvents();

  @override
  Widget build(BuildContext context) => TitledItem(
        title: 'Created events',
        titlePadding: const EdgeInsets.symmetric(horizontal: 24),
        child: BlocBuilder<ProfileCubit, ProfileState>(
          buildWhen: (p, c) => p.ownedEvents != c.ownedEvents,
          builder: (context, state) => switch (state.ownedEvents) {
            LoadedStateData<IList<EventModel>>(:final data) when data.isEmpty =>
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'You have not created any events yet',
                  style: AppTextStyles.caption,
                  textAlign: TextAlign.center,
                ),
              ),
            LoadedStateData<IList<EventModel>>(:final data) =>
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    for (final e in data)
                      SizedBox(
                        width: _eventCardWidth,
                        child: EventCard(event: e),
                      )
                  ].gap(
                    const SizedBox(width: 8),
                  ),
                ),
              ),
            _ => const Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(color: AppColors.gray50),
              ),
          },
        ),
      );
}
