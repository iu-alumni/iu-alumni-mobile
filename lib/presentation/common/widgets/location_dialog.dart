import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/repositories/map/map_repository.dart';
import '../../blocs/location_suggestions/location_suggestions_cubit.dart';
import '../constants/app_text_styles.dart';
import '../models/loaded_state.dart';
import 'app_text_field.dart';
import 'nav_button.dart';
import 'app_button.dart';

class LocationDialog extends StatelessWidget {
  const LocationDialog({required this.previousWasNone, super.key});

  final bool previousWasNone;

  static Future<String?> show(
    BuildContext context, [
    bool previousWasNone = false,
  ]) =>
      showCupertinoModalPopup<String>(
        context: context,
        builder: (context) => BlocProvider(
          create: (context) => LocationSuggestionsCubit(
            context.read<MapRepository>(),
          ),
          child: LocationDialog(previousWasNone: previousWasNone),
        ),
      );

  void _onTap(BuildContext context, String? option) => context.maybePop(option);

  @override
  Widget build(BuildContext context) => SafeArea(
        bottom: false,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Material(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: NavButton(content: NavButtonContent.close),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: AppTextField(
                        initialText: null,
                        hintText: 'Enter a city',
                        onChange:
                            context.read<LocationSuggestionsCubit>().suggest,
                        maxLines: 1,
                      ),
                    ),
                    BlocBuilder<LocationSuggestionsCubit,
                        LocationSuggestionsState>(
                      builder: (context, sugs) => switch (sugs) {
                        LoadedStateLoading() => const Center(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        LoadedStateData(:final data) => Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(height: 8),
                              for (final option in data)
                                AppButton(
                                  buttonStyle: AppButtonStyle.text,
                                  onTap: () => _onTap(context, option),
                                  child: Text(
                                    option,
                                    textAlign: TextAlign.start,
                                    style: AppTextStyles.body,
                                  ),
                                ),
                            ],
                          ),
                        _ => const SizedBox(),
                      },
                    ),
                    if (!previousWasNone)
                      AppButton(
                        buttonStyle: AppButtonStyle.text,
                        onTap: () => _onTap(context, null),
                        child: Text(
                          'Set to none',
                          textAlign: TextAlign.start,
                          style: AppTextStyles.body,
                        ),
                      ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
