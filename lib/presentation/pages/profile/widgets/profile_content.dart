import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../application/models/event.dart';
import '../../../../application/models/profile.dart';
import '../../../../application/repositories/reporter/reporter.dart';
import '../../../blocs/models/profile_state.dart';
import '../../../blocs/profile/profile_cubit.dart';
import '../../../blocs/telegram_verify/telegram_verify_cubit.dart';
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

  void _openDeleteAccount() =>
      launchUrl(Uri.parse('https://forms.gle/6exD5U78s8ccya24A'));

  AppBody build(BuildContext context) => AppListBody(
    children: [
      const SizedBox(height: 24),
      ProfilePic(profile: profile),
      const SizedBox(height: 8),
      Text(
        '${profile.firstName.trim()} ${profile.lastName.trim()}',
        style: AppTextStyles.subtitle,
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 8),
      Wrap(
        alignment: WrapAlignment.center,
        spacing: 8,
        runSpacing: 8,
        children: [
          if (profile.location case final loc?)
            AppTag(icon: Icons.pin_drop, text: loc),
          AppTag(icon: Icons.school, text: profile.graduationYear),
        ],
      ),
      ...[
        if (profile.biography case final bio?)
          Text(bio, style: AppTextStyles.body),
        if (profile.telegramAlias case final telegram?)
          TitledItem(
            title: 'Telegram alias',
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
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
                AppButton(
                  buttonStyle: AppButtonStyle.text,
                  onTap: () => _openTelegram(context),
                  child: const Icon(
                    Icons.open_in_new,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        if (personal && profile.telegramAlias != null)
          _TelegramVerifySection(profile: profile),
        if (personal) const _OwnedEvents(),
        const _ParticipatedEvents(),
        if (personal) const OpenBotCard(),
        if (personal)
          AppButton(
            buttonStyle: AppButtonStyle.text,
            onTap: _openDeleteAccount,
            child: Text(
              'Delete my account',
              style: AppTextStyles.actionM.copyWith(color: AppColors.error),
            ),
          ),
      ].expand((e) => [const SizedBox(height: 24), e]),
      const SizedBox(height: RootPage.navigationBarHeight + 16),
    ],
  );
}

class _ParticipatedEvents extends StatelessWidget {
  const _ParticipatedEvents();

  @override
  Widget build(BuildContext context) => TitledItem(
    title: 'Participated events',
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
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                for (final e in data)
                  SizedBox(
                    width: _eventCardWidth,
                    child: EventCard(event: e),
                  ),
              ],
            ),
          ),
        _ => const Center(
          child: Padding(padding: EdgeInsets.all(16), child: AppLoader()),
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
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                for (final e in data)
                  SizedBox(
                    width: _eventCardWidth,
                    child: EventCard(event: e),
                  ),
              ],
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

class _TelegramVerifySection extends StatelessWidget {
  const _TelegramVerifySection({required this.profile});

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    if (profile.isTelegramVerified) {
      return TitledItem(
        title: 'Telegram status',
        child: Row(
          children: [
            const Icon(Icons.verified, color: Colors.green, size: 20),
            const SizedBox(width: 8),
            Text(
              'Telegram account verified',
              style: AppTextStyles.body.copyWith(color: Colors.green),
            ),
          ],
        ),
      );
    }
    return TitledItem(
      title: 'Telegram status',
      child: BlocConsumer<TelegramVerifyCubit, TelegramVerifyState>(
        builder: (context, state) => switch (state.request) {
          LoadedStateLoading() => const Center(child: AppLoader()),
          LoadedStateData() => Text(
            'Verification email sent! Check your inbox.',
            style: AppTextStyles.body.copyWith(color: Colors.green),
          ),
          LoadedStateError(:final error) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                error,
                style: AppTextStyles.caption.copyWith(color: AppColors.error),
              ),
              const SizedBox(height: 8),
              AppButton(
                onTap: () =>
                    context.read<TelegramVerifyCubit>().requestVerification(),
                buttonStyle: AppButtonStyle.secondary,
                child: Text(
                  'Verify Telegram',
                  style: AppTextStyles.actionM.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
          _ => AppButton(
            onTap: () =>
                context.read<TelegramVerifyCubit>().requestVerification(),
            buttonStyle: AppButtonStyle.secondary,
            child: Text(
              'Verify Telegram',
              style: AppTextStyles.actionM.copyWith(color: Colors.white),
            ),
          ),
        },
        listener: (context, state) {},
      ),
    );
  }
}
