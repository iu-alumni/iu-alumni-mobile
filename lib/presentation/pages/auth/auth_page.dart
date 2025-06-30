import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/repositories/auth/auth_repository.dart';
import '../../../application/repositories/reporter/reporter.dart';
import '../../blocs/auth/auth_cubit.dart';
import '../../blocs/code_verification/code_verification_cubit.dart';
import '../../blocs/registration/registration_cubit.dart';
import '../../common/constants/app_colors.dart';
import '../../common/widgets/alumni_logo.dart';
import 'widgets/code_verification_scaffold.dart';
import 'widgets/registration_scaffold.dart';
import 'widgets/sign_in_scaffold.dart';

@RoutePage()
class AuthPage extends StatefulWidget implements AutoRouteWrapper {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();

  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => RegistrationCubit(
              context.read<AuthRepository>(),
              context.read<Reporter>(),
            ),
          ),
          BlocProvider(
            create: (context) => AuthCubit(
              context.read<AuthRepository>(),
              context.read<Reporter>(),
            ),
          ),
          BlocProvider(
            create: (context) => CodeVerificationCubit(
              context.read<AuthRepository>(),
            ),
          ),
        ],
        child: this,
      );
}

class _AuthPageState extends State<AuthPage> {
  static const _duration = Duration(milliseconds: 600);
  static const _curve = Curves.easeOutExpo;

  var _email = '';
  var _password = '';

  late final _registerWidget = ValueNotifier<Widget>(const Placeholder());
  late final _codeVerificationWidget = CodeVerificationScaffold(back: _back);

  late final _scrollController = ScrollController();

  double _width(BuildContext context) => MediaQuery.of(context).size.width;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _back() {
    final width = _width(context);
    final newOffset = _scrollController.offset - width;
    if (newOffset >= 0) {
      _scrollController.animateTo(
        newOffset - newOffset % width,
        duration: _duration,
        curve: _curve,
      );
    }
  }

  void _prepareWidgets(double newOffset, double width) {
    final index = (newOffset / width).toInt();
    switch (index) {
      case 1:
        _registerWidget.value = RegistrationScaffold(
          key: ObjectKey((_email, _password)),
          back: _back,
          toVerification: _forward,
          email: _email,
          password: _password,
        );
        break;
    }
  }

  void _forward() {
    final width = _width(context);
    final rawOffset = _scrollController.offset + width;
    final newOffset = rawOffset - rawOffset % width;

    _prepareWidgets(newOffset, width);

    _scrollController.animateTo(newOffset, duration: _duration, curve: _curve);
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          const Positioned.fill(child: ColoredBox(color: AppColors.primary)),
          Positioned.fill(
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 64),
                    child: AlumniLogo(),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (final w in [
                              SignInScaffold(
                                sinkEmail: (a) => _email = a,
                                sinkPassword: (a) => _password = a,
                                email: () => _email,
                                password: () => _password,
                                forward: _forward,
                              ),
                              ValueListenableBuilder(
                                valueListenable: _registerWidget,
                                builder: (context, child, _) => child,
                              ),
                              _codeVerificationWidget,
                            ])
                              SizedBox(width: _width(context), child: w),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      );
}
