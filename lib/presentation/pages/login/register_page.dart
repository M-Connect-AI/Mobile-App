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
import '../../../domain/model/auth_session.dart';
import '../../../domain/repository/auth_preference_repository.dart';
import '../../../domain/repository/auth_repository.dart';
import '../../../domain/repository/credential_repository.dart';
import '../../../domain/usecase/login/register_use_case.dart';
import '../../../generated/l10n.dart';
import '../../../route/go_router.dart';
import 'bloc/register_cubit.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterCubit(
        RegisterUseCase(context.read<AuthRepository>()),
        context.read<CredentialRepository>(),
        context.read<AuthPreferenceRepository>(),
      ),
      child: const _RegisterView(),
    );
  }
}

class _RegisterView extends StatefulWidget {
  const _RegisterView();

  @override
  State<_RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<_RegisterView> {
  final _formKey = GlobalKey<FormBuilderState>();

  void _submit() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (!(_formKey.currentState?.saveAndValidate() ?? false)) return;
    final values = _formKey.currentState!.value;
    context.read<RegisterCubit>().submit(
      email: values['email'].toString().trim().toLowerCase(),
      password: values['password'].toString(),
      fullName: values['fullName'].toString().trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    final strings = S.of(context);
    return BlocListener<RegisterCubit, RegisterState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == RegisterStatus.success) {
          const HomeRoute().go(context);
        } else if (state.status == RegisterStatus.failure) {
          AppToast.failed(context, _failureMessage(strings, state));
        }
      },
      child: Scaffold(
        backgroundColor: colors.surfacePrimary,
        body: SafeArea(
          child: Column(
            children: [
              _RegisterHeader(onBack: () => const LoginRoute().go(context)),
              SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: FormBuilder(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      IrhText.title(strings.registerTitle),
                      8.height.heightBox,
                      IrhText.regular(
                        strings.registerSubtitle,
                        color: colors.textSecondary,
                      ),
                      24.height.heightBox,
                      _RegisterField(
                        label: strings.fullNameLabel,
                        child: AppTextField(
                          context,
                          key: const Key('register-full-name-field'),
                          name: 'fullName',
                          textInputAction: TextInputAction.next,
                          hintText: strings.fullNameHint,
                          validator: (value) => (value?.trim().length ?? 0) < 2
                              ? strings.fullNameValidation
                              : null,
                        ),
                      ),
                      16.height.heightBox,
                      _RegisterField(
                        label: strings.emailLabel,
                        child: AppTextField(
                          context,
                          key: const Key('register-email-field'),
                          name: 'email',
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          autofillHints: const [AutofillHints.email],
                          hintText: strings.emailHint,
                          validator: (value) {
                            final email = value?.trim() ?? '';
                            return email.contains('@') && email.contains('.')
                                ? null
                                : strings.emailValidation;
                          },
                        ),
                      ),
                      16.height.heightBox,
                      BlocBuilder<RegisterCubit, RegisterState>(
                        buildWhen: (previous, current) =>
                            previous.obscurePassword != current.obscurePassword,
                        builder: (context, state) => _RegisterField(
                          label: strings.passwordLabel,
                          child: AppTextField(
                            context,
                            key: const Key('register-password-field'),
                            name: 'password',
                            obscureText: state.obscurePassword,
                            textInputAction: TextInputAction.done,
                            autofillHints: const [AutofillHints.newPassword],
                            hintText: strings.passwordHint,
                            validator: (value) => (value?.length ?? 0) < 4
                                ? strings.passwordValidation
                                : null,
                            onSubmitted: (_) => _submit(),
                            suffixIcon: CupertinoButton(
                              key: const Key('register-password-visibility'),
                              padding: EdgeInsets.zero,
                              onPressed: context
                                  .read<RegisterCubit>()
                                  .togglePasswordVisibility,
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
                      ),
                      20.height.heightBox,
                      const _RoleSelector(),
                      24.height.heightBox,
                      BlocBuilder<RegisterCubit, RegisterState>(
                        buildWhen: (previous, current) =>
                            previous.status != current.status,
                        builder: (context, state) => IrhButton(
                          key: const Key('register-submit-button'),
                          label: state.status == RegisterStatus.loading
                              ? strings.registering
                              : strings.registerButton,
                          height: 56.height,
                          onPressed: state.status == RegisterStatus.loading
                              ? null
                              : _submit,
                        ),
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 20.width, vertical: 24.height),
                ),
              ).expanded(),
            ],
          ),
        ),
      ),
    );
  }

  String _failureMessage(S strings, RegisterState state) =>
      switch (state.failureType) {
        AuthFailureType.conflict => strings.registerEmailExists,
        AuthFailureType.validation =>
          state.failureMessage ?? strings.registerValidationError,
        AuthFailureType.network => strings.loginNetworkError,
        AuthFailureType.server => strings.loginServerError,
        AuthFailureType.invalidResponse => strings.loginInvalidResponse,
        AuthFailureType.invalidCredentials => strings.registerFailed,
        null => strings.registerFailed,
      };
}

class _RegisterHeader extends StatelessWidget {
  const _RegisterHeader({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      CupertinoButton(
        key: const Key('register-back-button'),
        padding: EdgeInsets.zero,
        onPressed: onBack,
        child: Icon(
          CupertinoIcons.chevron_back,
          size: 24.sp,
          color: context.appColorScheme.iconPrimary,
        ),
      ),
      IrhText.medium(S.of(context).loginButton),
    ],
  ).paddingSymmetric(horizontal: 8.width, vertical: 8.height);
}

class _RegisterField extends StatelessWidget {
  const _RegisterField({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      IrhText.small(label, color: context.appColorScheme.textPrimary),
      8.height.heightBox,
      child,
    ],
  );
}

class _RoleSelector extends StatelessWidget {
  const _RoleSelector();

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) => previous.role != current.role,
      builder: (context, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IrhText.small(
            strings.roleLabel,
            color: context.appColorScheme.textPrimary,
          ),
          8.height.heightBox,
          Row(
            children: [
              IrhOptionChip(
                key: const Key('register-role-staff'),
                label: strings.roleStaff,
                selected: state.role == UserRole.staff,
                onPressed: () =>
                    context.read<RegisterCubit>().selectRole(UserRole.staff),
              ).expanded(),
              12.width.widthBox,
              IrhOptionChip(
                key: const Key('register-role-manager'),
                label: strings.roleManager,
                selected: state.role == UserRole.manager,
                onPressed: () =>
                    context.read<RegisterCubit>().selectRole(UserRole.manager),
              ).expanded(),
            ],
          ),
        ],
      ),
    );
  }
}
