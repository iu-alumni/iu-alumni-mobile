import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/models/project.dart';
import '../../../application/repositories/projects/projects_repository.dart';
import '../../blocs/projects/one_project_cubit.dart';
import '../../common/constants/app_colors.dart';
import '../../common/constants/app_text_styles.dart';

/// Prompted after the user returns from the external donation URL.
/// Asks "how much did you donate?" and POSTs to /projects/{id}/donations.
///
/// Returns `true` if a donation was successfully logged, so the caller
/// can refresh the list / details view to pick up the new raised total.
class DonateDialog {
  static Future<bool> run(BuildContext context, ProjectModel project) async {
    final repo = context.read<ProjectsRepository>();
    // OneProjectCubit is only in scope on the details page — reused
    // there to update the local card too. We look it up defensively.
    final oneProjectCubit = _tryReadOneProjectCubit(context);

    final amount = await showDialog<int>(
      context: context,
      builder: (_) => _AmountPromptDialog(project: project),
    );
    if (amount == null || amount <= 0) {
      return false;
    }

    final refreshed = await repo.donate(project.id, amount);
    if (refreshed == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not record the donation. Try again.')),
        );
      }
      return false;
    }
    // Push the fresh state into the details cubit if we're on that page.
    oneProjectCubit?.refresh(refreshed);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Thanks for donating ₽$amount!')),
      );
    }
    return true;
  }

  static OneProjectCubit? _tryReadOneProjectCubit(BuildContext context) {
    try {
      return context.read<OneProjectCubit>();
    } catch (_) {
      return null;
    }
  }
}

class _AmountPromptDialog extends StatefulWidget {
  const _AmountPromptDialog({required this.project});

  final ProjectModel project;

  @override
  State<_AmountPromptDialog> createState() => _AmountPromptDialogState();
}

class _AmountPromptDialogState extends State<_AmountPromptDialog> {
  final _ctrl = TextEditingController();
  String? _err;

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _submit() {
    final raw = _ctrl.text.trim();
    if (raw.isEmpty) {
      setState(() => _err = 'Enter an amount, or press Skip if you did not donate.');
      return;
    }
    final n = int.tryParse(raw);
    if (n == null || n <= 0) {
      setState(() => _err = 'Amount must be a positive whole number of rubles.');
      return;
    }
    Navigator.of(context).pop(n);
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text('Did you donate?', style: AppTextStyles.subtitle),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enter the amount you gave to "${widget.project.title}" so it '
          'shows up on the project total. This is honour-based — no '
          'payment verification.',
          style: AppTextStyles.caption.copyWith(color: AppColors.gray30),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _ctrl,
          autofocus: true,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onSubmitted: (_) => _submit(),
          decoration: InputDecoration(
            prefixText: '₽ ',
            hintText: 'e.g. 500',
            errorText: _err,
            border: const OutlineInputBorder(),
          ),
        ),
      ],
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.of(context).pop(null),
        child: const Text('Skip'),
      ),
      FilledButton(
        style: FilledButton.styleFrom(backgroundColor: AppColors.primary),
        onPressed: _submit,
        child: const Text('Log donation'),
      ),
    ],
  );
}
