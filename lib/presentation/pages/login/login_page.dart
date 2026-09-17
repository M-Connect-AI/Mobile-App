import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../common/components/app_text_field.dart';
import '../../../common/components/app_toast.dart';
import '../../../common/components/irh_button.dart';
import '../../../common/components/irh_text.dart';
import '../../../common/extensions/responsive_extension.dart';
import '../../../common/themes/theme_extensions/app_color_scheme.dart';
import '../../../domain/repository/auth_repository.dart';
import '../../../domain/repository/auth_preference_repository.dart';
import '../../../domain/repository/credential_repository.dart';
import '../../../domain/usecase/login/login_use_case.dart';
import '../../../domain/usecase/login/restore_session_use_case.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/l10n.dart';
import '../../../route/go_router.dart';
import '../../server_config/server_config_dialog.dart';
import 'bloc/login_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(
        LoginUseCase(context.read<AuthRepository>()),
        RestoreSessionUseCase(
          context.read<AuthRepository>(),
          context.read<CredentialRepository>(),
        ),
        context.read<CredentialRepository>(),
        context.read<AuthPreferenceRepository>(),
      ),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final _formKey = GlobalKey<FormBuilderState>();

  void _login() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (!(_formKey.currentState?.saveAndValidate() ?? false)) return;
    final values = _formKey.currentState!.value;
    context.read<LoginCubit>().submit(
      email: values['email'].toString().trim().toLowerCase(),
      password: values['password'].toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    final strings = S.of(context);

    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) =>
          (!previous.credentialsLoaded && current.credentialsLoaded) ||
          previous.status != current.status,
      listener: (context, state) {
        if (state.credentialsLoaded && state.savedEmail != null) {
          _formKey.currentState?.fields['email']?.didChange(state.savedEmail);
        }
        if (state.status == LoginStatus.success) {
          const HomeRoute().go(context);
        } else if (state.status == LoginStatus.failure) {
          AppToast.failed(context, _failureMessage(strings, state));
        }
      },
      child: Scaffold(
        body: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                colors.iconBrand,
                Color.lerp(colors.iconBrand, colors.textError, .76)!,
              ],
            ),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 440.width),
                    child: CustomScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      slivers: [
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Column(
                            children: [
                              const _LoginLogo().expanded(),
                              _LoginFormCard(
                                formKey: _formKey,
                                onLogin: _login,
                              ).paddingSymmetric(horizontal: 16.width),
                            ],
                          ).paddingLTRB(0, 64.height, 0, 24.height),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 4.height,
                  right: 8.width,
                  child: ServerConfigButton(color: colors.surfaceSecondary),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _failureMessage(S strings, LoginState state) {
    return switch (state.failureType) {
      AuthFailureType.invalidCredentials => strings.loginFailed,
      AuthFailureType.conflict => strings.loginFailed,
      AuthFailureType.network => strings.loginNetworkError,
      AuthFailureType.server => strings.loginServerError,
      AuthFailureType.validation =>
        state.failureMessage ?? strings.loginValidationError,
      AuthFailureType.invalidResponse => strings.loginInvalidResponse,
      null => strings.loginFailed,
    };
  }
}

class _LoginLogo extends StatelessWidget {
  const _LoginLogo();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 280.width,
        child: Assets.image.logo.svg(
          key: const Key('login-logo'),
          fit: BoxFit.contain,
          excludeFromSemantics: true,
        ),
      ),
    );
  }
}

class _LoginFormCard extends StatelessWidget {
  const _LoginFormCard({required this.formKey, required this.onLogin});

  final GlobalKey<FormBuilderState> formKey;
  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    final strings = S.of(context);
    return Container(
      key: const Key('login-form-card'),
      decoration: BoxDecoration(
        color: colors.surfaceSecondary.withValues(alpha: .96),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colors.textPrimary.withValues(alpha: .08),
            blurRadius: 24,
            offset: Offset(0, 8.height),
          ),
        ],
      ),
      child: FormBuilder(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            IrhText.title(
              strings.loginButton,
              textAlign: TextAlign.center,
              color: colors.textPrimary,
            ),
            24.height.heightBox,
            _LoginField(
              label: strings.emailLabel,
              child: AppTextField(
                context,
                key: const Key('login-email-field'),
                name: 'email',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.email],
                hintText: strings.emailHint,
                validator: (value) => (value?.trim().isEmpty ?? true)
                    ? strings.emailRequired
                    : null,
              ),
            ),
            16.height.heightBox,
            BlocBuilder<LoginCubit, LoginState>(
              buildWhen: (previous, current) =>
                  previous.obscurePassword != current.obscurePassword,
              builder: (context, state) {
                return _LoginField(
                  label: strings.passwordLabel,
                  child: AppTextField(
                    context,
                    key: const Key('login-password-field'),
                    name: 'password',
                    obscureText: state.obscurePassword,
                    textInputAction: TextInputAction.done,
                    autofillHints: const [AutofillHints.password],
                    hintText: strings.passwordHint,
                    validator: (value) => (value?.isEmpty ?? true)
                        ? strings.passwordRequired
                        : null,
                    onSubmitted: (_) => onLogin(),
                    suffixIcon: CupertinoButton(
                      key: const Key('password-visibility-button'),
                      padding: EdgeInsets.zero,
                      onPressed: context
                          .read<LoginCubit>()
                          .togglePasswordVisibility,
                      child: Semantics(
                        label: state.obscurePassword
                            ? strings.showPassword
                            : strings.hidePassword,
                        child: Icon(
                          state.obscurePassword
                              ? CupertinoIcons.eye_slash
                              : CupertinoIcons.eye,
                          size: 20.sp,
                          color: colors.iconSecondary,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            24.height.heightBox,
            BlocBuilder<LoginCubit, LoginState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status,
              builder: (context, state) {
                final loading = state.status == LoginStatus.loading;
                return IrhButton(
                  key: const Key('login-button'),
                  label: loading ? strings.loggingIn : strings.loginButton,
                  height: 56.height,
                  onPressed: loading ? null : onLogin,
                );
              },
            ),
            20.height.heightBox,
            IrhRichTextButton(
              text: strings.noAccount,
              actionText: strings.registerButton,
              onPressed: () => const RegisterRoute().push(context),
            ),
            12.height.heightBox,
            IrhText.small(
              strings.loginCopyright,
              textAlign: TextAlign.center,
              color: colors.textSecondary,
            ),
          ],
        ).paddingSymmetric(horizontal: 16.width, vertical: 24.height),
      ),
    );
  }
}

class _LoginField extends StatelessWidget {
  const _LoginField({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        IrhText.small(label, color: context.appColorScheme.textPrimary),
        8.height.heightBox,
        child,
      ],
    );
  }
}
