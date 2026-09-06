import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../common/components/app_text_field.dart';
import '../../../common/components/app_text_style.dart';
import '../../../common/components/irh_button.dart';
import '../../../common/extensions/responsive_extension.dart';
import '../../../common/themes/theme_extensions/app_color_scheme.dart';
import '../../../generated/l10n.dart';
import '../../../route/go_router.dart';
import 'bloc/login_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => LoginCubit(), child: const _LoginView());
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    final colors = context.appColorScheme;
    final strings = S.of(context);

    void login() {
      FocusManager.instance.primaryFocus?.unfocus();
      formKey.currentState?.save();
      const HomeRoute().go(context);
    }

    return Scaffold(
      backgroundColor: colors.surfacePrimary,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 24.width,
              vertical: 32.height,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 440.width),
              child: FormBuilder(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const _BrandMark(),
                    40.height.heightBox,
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
                    ),
                    16.height.heightBox,
                    BlocBuilder<LoginCubit, bool>(
                      builder: (context, obscurePassword) {
                        return AppTextField(
                          context,
                          key: const Key('login-password-field'),
                          name: 'password',
                          obscureText: obscurePassword,
                          textInputAction: TextInputAction.done,
                          autofillHints: const [AutofillHints.password],
                          labelText: strings.passwordLabel,
                          hintText: strings.passwordHint,
                          onSubmitted: (_) => login(),
                          suffixIcon: CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: context
                                .read<LoginCubit>()
                                .togglePasswordVisibility,
                            child: Text(
                              obscurePassword
                                  ? strings.showPassword
                                  : strings.hidePassword,
                              style: AppTextStyle.m12.copyWith(
                                color: colors.textBrand,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    12.height.heightBox,
                    Align(
                      alignment: Alignment.centerRight,
                      child: IrhTextButton(
                        label: strings.forgotPassword,
                        onPressed: () {},
                      ),
                    ),
                    12.height.heightBox,
                    IrhButton(
                      key: const Key('login-button'),
                      label: strings.loginButton,
                      onPressed: login,
                    ),
                    24.height.heightBox,
                    Text(
                      strings.loginMockNotice,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.r12.copyWith(
                        color: colors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BrandMark extends StatelessWidget {
  const _BrandMark();

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    return Column(
      children: [
        Container(
          width: 80.width,
          height: 80.height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: colors.iconBrand,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            S.of(context).brandMonogram,
            style: AppTextStyle.b24.copyWith(color: Colors.white),
          ),
        ),
        16.height.heightBox,
        Text(
          S.of(context).appName,
          style: AppTextStyle.b20.copyWith(color: colors.textBrand),
        ),
      ],
    );
  }
}
