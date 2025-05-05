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
import '../../../common/widgets/button.dart';
import '../../../common/widgets/profile_pic.dart';
import '../../../common/widgets/titled_item.dart';
import '../../root/root_page.dart';
import 'event_card.dart';
import 'open_bot_card.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({
    required this.profile,
    required this.personal,
    super.key,
  });

  final Profile profile;
  final bool personal;

  static const _horPadding = EdgeInsets.symmetric(horizontal: 24);

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

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 40),
          ProfilePic(profile: profile),
          const SizedBox(height: 16),
          Padding(
            padding: _horPadding,
            child: Text(
              '${profile.firstName.trim()} ${profile.lastName.trim()}',
              style: AppTextStyles.h3,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: _horPadding,
            child: Text(
              profile.graduationYear,
              style: AppTextStyles.body,
              textAlign: TextAlign.center,
            ),
          ),
          ...[
            if (profile.biography case final bio?)
              Padding(
                padding: _horPadding,
                child: TitledItem(
                  title: 'Biography',
                  child: Text(
                    bio,
                    style: AppTextStyles.body,
                  ),
                ),
              ),
            if (profile.location case final location?)
              Padding(
                padding: _horPadding,
                child: TitledItem(
                  title: 'Location',
                  child: Text(
                    location,
                    style: AppTextStyles.body,
                  ),
                ),
              ),
            if (profile.telegramAlias case final telegram?)
              Padding(
                padding: _horPadding,
                child: TitledItem(
                  title: 'Telegram',
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: AppButton(
                          buttonStyle: AppButtonStyle.text,
                          child: Text(
                            '@$telegram',
                            style: AppTextStyles.body.copyWith(
                              decoration: TextDecoration.underline,
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
                padding: const EdgeInsets.symmetric(horizontal: 24),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      <Widget>[for (final e in data) EventCard(event: e)].gap(
                    const SizedBox(width: 8),
                  ),
                ),
              ),
            _ => const Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: CircularProgressIndicator(color: AppColors.blueGray),
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
                  children:
                      <Widget>[for (final e in data) EventCard(event: e)].gap(
                    const SizedBox(width: 8),
                  ),
                ),
              ),
            _ => const Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(color: AppColors.blueGray),
              ),
          },
        ),
      );
}
