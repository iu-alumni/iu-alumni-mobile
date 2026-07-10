import 'dart:convert';
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../application/repositories/projects/projects_repository.dart';
import '../../blocs/projects/projects_cubit.dart';
import '../../common/constants/app_colors.dart';
import '../../common/constants/app_text_styles.dart';
import '../../common/widgets/app_button.dart';
import '../../common/widgets/app_loader.dart';
import '../../common/widgets/app_scaffold.dart';

@RoutePage()
class ProjectEditingPage extends StatefulWidget {
  const ProjectEditingPage({required this.projectId, super.key});

  /// `null` = create mode; otherwise the id of the project to edit.
  final String? projectId;

  @override
  State<ProjectEditingPage> createState() => _ProjectEditingPageState();
}

class _ProjectEditingPageState extends State<ProjectEditingPage> {
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  String? _cover;
  bool _saving = false;
  bool _loading = false;

  bool get _isEditMode => widget.projectId != null;

  @override
  void initState() {
    super.initState();
    if (_isEditMode) {
      _loading = true;
      WidgetsBinding.instance.addPostFrameCallback((_) => _prefill());
    }
  }

  Future<void> _prefill() async {
    final repo = context.read<ProjectsRepository>();
    final project = await repo.getOne(widget.projectId!);
    if (!mounted) {
      return;
    }
    if (project != null) {
      _titleCtrl.text = project.title;
      _descCtrl.text = project.description;
      _cover = project.cover;
    }
    setState(() => _loading = false);
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AppScaffold(
    title: _isEditMode ? 'Edit project' : 'New project',
    body: AppChildBody(
      child: _loading
          ? const Center(child: AppLoader(inCard: true))
          : ListView(
              padding: const EdgeInsets.only(top: 8, bottom: 32),
              children: [
                _CoverPicker(
                  cover: _cover,
                  onPick: (b64) => setState(() => _cover = b64),
                ),
                const SizedBox(height: 20),
                _Label('Title'),
                TextField(
                  controller: _titleCtrl,
                  decoration: _decoration('Give the project a name'),
                  maxLength: 80,
                ),
                const SizedBox(height: 8),
                _Label('Description'),
                TextField(
                  controller: _descCtrl,
                  decoration: _decoration('Explain the idea and how people can help'),
                  minLines: 5,
                  maxLines: 12,
                  maxLength: 2000,
                ),
                if (_isEditMode) ...[
                  const SizedBox(height: 8),
                  Text(
                    'Editing an approved project will send it back to admin '
                    'review before it is visible again.',
                    style: AppTextStyles.caption.copyWith(color: AppColors.gray50),
                  ),
                ],
                const SizedBox(height: 24),
                AppButton(
                  buttonStyle: AppButtonStyle.primary,
                  onTap: _saving ? () {} : _submit,
                  child: _saving
                      ? const Center(child: AppLoader(color: Colors.white))
                      : Text(
                          _isEditMode ? 'Save changes' : 'Submit for approval',
                          style: AppTextStyles.actionSB.copyWith(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                ),
              ],
            ),
    ),
  );

  InputDecoration _decoration(String hint) => InputDecoration(
    hintText: hint,
    hintStyle: AppTextStyles.body.copyWith(color: AppColors.gray50),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.gray80),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.gray80),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.primary),
    ),
  );

  Future<void> _submit() async {
    final title = _titleCtrl.text.trim();
    final desc = _descCtrl.text.trim();
    if (title.isEmpty || desc.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Title and description are required.')),
      );
      return;
    }
    setState(() => _saving = true);
    final repo = context.read<ProjectsRepository>();
    final ok = _isEditMode
        ? (await repo.update(
              widget.projectId!,
              title: title,
              description: desc,
              cover: _cover,
            )) !=
            null
        : (await repo.create(
              title: title,
              description: desc,
              cover: _cover,
            )) !=
            null;

    if (!mounted) {
      return;
    }
    setState(() => _saving = false);
    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Something went wrong. Please try again.')),
      );
      return;
    }
    // Refresh the list so a new draft (or resubmitted project) is
    // reflected immediately when the user pops back.
    // ignore: unawaited_futures
    context.read<ProjectsCubit>().refresh();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isEditMode
              ? 'Changes sent for admin review.'
              : 'Sent for admin approval.',
        ),
      ),
    );
    if (context.mounted) {
      await context.router.maybePop();
    }
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(
      text,
      style: AppTextStyles.caption.copyWith(
        color: AppColors.darkGray,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

class _CoverPicker extends StatelessWidget {
  const _CoverPicker({required this.cover, required this.onPick});

  final String? cover;
  final ValueChanged<String?> onPick;

  @override
  Widget build(BuildContext context) {
    final bytes = _decode(cover);
    return InkWell(
      onTap: () async {
        final picker = context.read<ImagePicker>();
        final file = await picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 75,
        );
        if (file == null) {
          return;
        }
        final data = await file.readAsBytes();
        onPick(base64Encode(data));
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.gray90,
          image: bytes != null
              ? DecorationImage(
                  image: MemoryImage(bytes), fit: BoxFit.cover)
              : null,
        ),
        alignment: Alignment.center,
        child: bytes == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.add_photo_alternate_outlined,
                    color: AppColors.gray50,
                    size: 34,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Add a cover (optional)',
                    style: AppTextStyles.caption.copyWith(color: AppColors.gray50),
                  ),
                ],
              )
            : Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Material(
                    color: Colors.black54,
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => onPick(''),
                      child: const Padding(
                        padding: EdgeInsets.all(6),
                        child: Icon(Icons.close, color: Colors.white, size: 16),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  static Uint8List? _decode(String? cover) {
    if (cover == null || cover.isEmpty) {
      return null;
    }
    try {
      return base64Decode(cover);
    } catch (_) {
      return null;
    }
  }
}

