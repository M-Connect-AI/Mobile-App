import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/components/app_text_style.dart';
import '../../common/server_config/server_config_scope.dart';
import '../../common/themes/theme_extensions/app_color_scheme.dart';
import '../../domain/model/server_config.dart';
import '../../domain/repository/server_config_repository.dart';
import '../../generated/l10n.dart';

Future<void> showServerConfigDialog(BuildContext context) async {
  final repository = context.read<ServerConfigRepository>();
  final apply = ServerConfigScope.of(context).apply;
  final current = await repository.read();
  if (!context.mounted) return;

  final result = await showDialog<ServerConfig>(
    context: context,
    barrierDismissible: false,
    builder: (_) =>
        _ServerConfigDialog(current: current, defaults: repository.defaults),
  );
  if (result != null) await apply(result);
}

class _ServerConfigDialog extends StatefulWidget {
  const _ServerConfigDialog({required this.current, required this.defaults});

  final ServerConfig current;
  final ServerConfig defaults;

  @override
  State<_ServerConfigDialog> createState() => _ServerConfigDialogState();
}

class _ServerConfigDialogState extends State<_ServerConfigDialog> {
  late final TextEditingController _hrController;
  late final TextEditingController _agentController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _hrController = TextEditingController(text: widget.current.hrApiBaseUrl);
    _agentController = TextEditingController(
      text: widget.current.agentApiBaseUrl,
    );
  }

  @override
  void dispose() {
    _hrController.dispose();
    _agentController.dispose();
    super.dispose();
  }

  String? _validateUrl(String? value) {
    final uri = Uri.tryParse(value?.trim() ?? '');
    if (uri == null ||
        !uri.hasScheme ||
        uri.host.isEmpty ||
        (uri.scheme != 'http' && uri.scheme != 'https')) {
      return S.of(context).serverConfigInvalidUrl;
    }
    return null;
  }

  void _restoreDefaults() {
    _hrController.text = widget.defaults.hrApiBaseUrl;
    _agentController.text = widget.defaults.agentApiBaseUrl;
    _formKey.currentState?.validate();
  }

  void _save() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    Navigator.of(context).pop(
      ServerConfig(
        hrApiBaseUrl: _hrController.text,
        agentApiBaseUrl: _agentController.text,
      ).normalized(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final colors = context.appColorScheme;
    return AlertDialog(
      key: const Key('server-config-dialog'),
      scrollable: true,
      backgroundColor: colors.surfaceSecondary,
      title: Text(
        strings.serverConfigTitle,
        style: AppTextStyle.b20.copyWith(color: colors.textPrimary),
      ),
      content: SizedBox(
        width: 420,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                strings.serverConfigDescription,
                style: AppTextStyle.r14.copyWith(color: colors.textSecondary),
              ),
              const SizedBox(height: 20),
              TextFormField(
                key: const Key('hr-api-url-field'),
                controller: _hrController,
                keyboardType: TextInputType.url,
                autocorrect: false,
                enableSuggestions: false,
                validator: _validateUrl,
                decoration: InputDecoration(labelText: strings.hrApiUrlLabel),
              ),
              const SizedBox(height: 16),
              TextFormField(
                key: const Key('agent-api-url-field'),
                controller: _agentController,
                keyboardType: TextInputType.url,
                autocorrect: false,
                enableSuggestions: false,
                validator: _validateUrl,
                decoration: InputDecoration(
                  labelText: strings.agentApiUrlLabel,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                strings.serverConfigLogoutNotice,
                style: AppTextStyle.r12.copyWith(color: colors.textTertiary),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          key: const Key('restore-server-defaults-button'),
          onPressed: _restoreDefaults,
          child: Text(strings.restoreDefaultsButton),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(strings.cancelButton),
        ),
        FilledButton(
          key: const Key('save-server-config-button'),
          onPressed: _save,
          child: Text(strings.saveButton),
        ),
      ],
    );
  }
}

class ServerConfigButton extends StatelessWidget {
  const ServerConfigButton({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    return Semantics(
      button: true,
      label: strings.serverConfigButton,
      child: CupertinoButton(
        key: const Key('server-config-button'),
        minimumSize: const Size(44, 44),
        padding: const EdgeInsets.all(10),
        onPressed: () => showServerConfigDialog(context),
        child: Icon(
          CupertinoIcons.gear_alt_fill,
          size: 23,
          color: color ?? context.appColorScheme.iconSecondary,
        ),
      ),
    );
  }
}
