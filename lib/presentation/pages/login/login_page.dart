import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';

import '../../../common/components/app_text_field.dart';
import '../../../common/components/app_text_style.dart';
import '../../../common/components/app_toast.dart';
import '../../../common/components/irh_button.dart';
import '../../../common/extensions/responsive_extension.dart';
import '../../../common/themes/theme_extensions/app_color_scheme.dart';
import '../../../domain/repository/auth_repository.dart';
import '../../../domain/repository/credential_repository.dart';
import '../../../domain/usecase/login/login_use_case.dart';
import '../../../domain/usecase/login/restore_session_use_case.dart';
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

  Future<void> _showAccountDialog() async {
    final email = await showDialog<String>(
      context: context,
      builder: (_) => const _AccountPickerDialog(),
    );
    if (!mounted || email == null) return;

    final selectedEmail = email.isNotEmpty
        ? email
        : await showDialog<String>(
            context: context,
            builder: (_) => const _OtherEmailDialog(),
          );
    if (!mounted || selectedEmail == null) return;
    _formKey.currentState?.fields['email']?.didChange(selectedEmail);
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
        backgroundColor: colors.surfacePrimary,
        body: SafeArea(
          child: Stack(
            children: [
              const Positioned(top: 4, right: 8, child: ServerConfigButton()),
              Center(
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 440.width),
                    child: FormBuilder(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            strings.loginWelcome,
                            textAlign: TextAlign.center,
                            style: AppTextStyle.b28.copyWith(
                              color: colors.textPrimary,
                            ),
                          ),
                          12.height.heightBox,
                          Text(
                            strings.loginSubtitle(strings.appName),
                            textAlign: TextAlign.center,
                            style: AppTextStyle.r16.copyWith(
                              color: colors.textSecondary,
                            ),
                          ),
                          36.height.heightBox,
                          AppTextField(
                            context,
                            key: const Key('login-email-field'),
                            name: 'email',
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            autofillHints: const [AutofillHints.email],
                            labelText: strings.emailLabel,
                            hintText: strings.emailHint,
                            readOnly: true,
                            onTap: _showAccountDialog,
                            validator: (value) =>
                                (value?.trim().isEmpty ?? true)
                                ? strings.emailRequired
                                : null,
                          ),
                          16.height.heightBox,
                          BlocBuilder<LoginCubit, LoginState>(
                            buildWhen: (previous, current) =>
                                previous.obscurePassword !=
                                current.obscurePassword,
                            builder: (context, state) {
                              return AppTextField(
                                context,
                                key: const Key('login-password-field'),
                                name: 'password',
                                obscureText: state.obscurePassword,
                                textInputAction: TextInputAction.done,
                                autofillHints: const [AutofillHints.password],
                                labelText: strings.passwordLabel,
                                hintText: strings.passwordHint,
                                validator: (value) => (value?.isEmpty ?? true)
                                    ? strings.passwordRequired
                                    : null,
                                onSubmitted: (_) => _login(),
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
                              );
                            },
                          ),
                          12.height.heightBox,
                          const _LoginOptions(),
                          12.height.heightBox,
                          BlocBuilder<LoginCubit, LoginState>(
                            buildWhen: (previous, current) =>
                                previous.status != current.status,
                            builder: (context, state) {
                              final loading =
                                  state.status == LoginStatus.loading;
                              return IrhButton(
                                key: const Key('login-button'),
                                label: loading
                                    ? strings.loggingIn
                                    : strings.loginButton,
                                onPressed: loading ? null : _login,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ).paddingSymmetric(horizontal: 24.width, vertical: 32.height),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _failureMessage(S strings, LoginState state) {
    return switch (state.failureType) {
      AuthFailureType.invalidCredentials => strings.loginFailed,
      AuthFailureType.network => strings.loginNetworkError,
      AuthFailureType.server => strings.loginServerError,
      AuthFailureType.validation =>
        state.failureMessage ?? strings.loginValidationError,
      AuthFailureType.invalidResponse => strings.loginInvalidResponse,
      null => strings.loginFailed,
    };
  }
}

class _AccountPickerDialog extends StatelessWidget {
  const _AccountPickerDialog();

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final accounts = [
      (email: 'a.nguyen@msb.vn', label: strings.employeeNguyenVanA),
      (email: 'c.le@msb.vn', label: strings.employeeLeVanC),
      (email: 'b.tran@msb.vn', label: strings.managerTranThiB),
    ];
    final colors = context.appColorScheme;
    return Dialog(
      backgroundColor: colors.surfaceSecondary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                strings.suggestedAccounts,
                style: AppTextStyle.b20.copyWith(color: colors.textPrimary),
              ),
            ),
            16.height.heightBox,
            ...accounts.map(
              (account) => _AccountDialogOption(
                email: account.email,
                label: account.label,
              ),
            ),
            8.height.heightBox,
            IrhTextButton(
              label: strings.otherEmail,
              onPressed: () => GoRouterHelper(context).pop(''),
            ),
          ],
        ).paddingAll(20.width),
      ),
    );
  }
}

class _AccountDialogOption extends StatelessWidget {
  const _AccountDialogOption({required this.email, required this.label});

  final String email;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    return CupertinoButton(
      key: ValueKey('account-$email'),
      minimumSize: Size.zero,
      padding: EdgeInsets.symmetric(horizontal: 12.width, vertical: 12.height),
      onPressed: () => GoRouterHelper(context).pop(email),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyle.m16.copyWith(color: colors.textPrimary),
              ),
              4.height.heightBox,
              Text(
                email,
                style: AppTextStyle.r14.copyWith(color: colors.textSecondary),
              ),
            ],
          ).expanded(),
          Icon(
            CupertinoIcons.chevron_right,
            size: 16.sp,
            color: colors.iconSecondary,
          ),
        ],
      ),
    );
  }
}

class _OtherEmailDialog extends StatefulWidget {
  const _OtherEmailDialog();

  @override
  State<_OtherEmailDialog> createState() => _OtherEmailDialogState();
}

class _OtherEmailDialogState extends State<_OtherEmailDialog> {
  final _formKey = GlobalKey<FormBuilderState>();

  void _select() {
    if (!(_formKey.currentState?.saveAndValidate() ?? false)) return;
    GoRouterHelper(
      context,
    ).pop(_formKey.currentState!.value['otherEmail'].toString().trim());
  }

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final colors = context.appColorScheme;
    return Dialog(
      backgroundColor: colors.surfaceSecondary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: FormBuilder(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              strings.otherEmailTitle,
              style: AppTextStyle.b20.copyWith(color: colors.textPrimary),
            ),
            16.height.heightBox,
            AppTextField(
              context,
              key: const Key('other-email-field'),
              name: 'otherEmail',
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              labelText: strings.emailLabel,
              hintText: strings.emailHint,
              validator: (value) => (value?.trim().isEmpty ?? true)
                  ? strings.emailRequired
                  : null,
              onSubmitted: (_) => _select(),
            ),
            12.height.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IrhTextButton(
                  label: strings.cancelButton,
                  onPressed: () => GoRouterHelper(context).pop(),
                ),
                12.width.widthBox,
                IrhTextButton(label: strings.selectButton, onPressed: _select),
              ],
            ),
          ],
        ).paddingAll(20.width),
      ),
    );
  }
}

class _LoginOptions extends StatelessWidget {
  const _LoginOptions();

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    return Align(
      alignment: Alignment.centerRight,
      child: BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) =>
            previous.rememberSession != current.rememberSession,
        builder: (context, state) {
          return Semantics(
            label: strings.rememberSession,
            checked: state.rememberSession,
            child: CupertinoButton(
              key: const Key('remember-session-button'),
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
              onPressed: context.read<LoginCubit>().toggleRememberSession,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    strings.rememberSession,
                    style: AppTextStyle.m14.copyWith(
                      color: context.appColorScheme.textSecondary,
                    ),
                  ),
                  8.width.widthBox,
                  CupertinoSwitch(
                    value: state.rememberSession,
                    activeTrackColor: context.appColorScheme.iconBrand,
                    onChanged: (_) =>
                        context.read<LoginCubit>().toggleRememberSession(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
