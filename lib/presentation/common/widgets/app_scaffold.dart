import 'package:flutter/material.dart';

import '../../../util/gap.dart';
import '../constants/app_text_styles.dart';
import 'nav_button.dart';

sealed class AppBody {
  final EdgeInsets padding;
  const AppBody(this.padding);
}

class AppListBody extends AppBody {
  final List<Widget> children;
  const AppListBody({
    required this.children,
    EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 16),
  }) : super(padding);
}

class AppChildBody extends AppBody {
  final Widget child;
  const AppChildBody({
    required this.child,
    EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 16),
  }) : super(padding);
}

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.title,
    this.leadingButton = const NavButton(),
    this.actions = const [],
    this.topSafeArea = true,
    this.body = const AppChildBody(child: Placeholder()),
    super.key,
  });

  final String? title;
  final Widget? leadingButton;
  final List<Widget> actions;
  final bool topSafeArea;
  final AppBody body;

  static const _padding = EdgeInsets.symmetric(horizontal: 16);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          top: topSafeArea,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Padding(
                padding: _padding,
                child: Row(
                  children: [
                    if (leadingButton case final button?)
                      button
                    else
                      const SizedBox.square(dimension: 48),
                    const Spacer(),
                    ...actions.gapI(const SizedBox(width: 16)),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: switch (body) {
                  AppListBody(:final children, :final padding) =>
                    SingleChildScrollView(
                      padding: padding.copyWith(top: 16),
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (title case final t?) ...[
                            Text(
                              t,
                              style: AppTextStyles.largeTitle,
                            ),
                            const SizedBox(height: 24),
                          ],
                          ...children,
                        ],
                      ),
                    ),
                  AppChildBody(:final child, :final padding) => Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (title case final t?) ...[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Text(
                                t,
                                style: AppTextStyles.largeTitle,
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
                          Expanded(
                            child: Padding(padding: padding, child: child),
                          ),
                        ],
                      ),
                    ),
                },
              ),
            ],
          ),
        ),
      );
}
