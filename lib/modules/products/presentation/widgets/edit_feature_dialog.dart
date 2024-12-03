import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:echidna_dto/echidna_dto.dart';
import 'package:echidna_webui/modules/app/app.dart';
import 'package:echidna_webui/modules/products/products.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Dialog to edit a feature.
class EditFeatureDialog extends ToastConsumer {
  /// Dialog to edit a feature.
  const EditFeatureDialog({super.key, required this.feature, required super.showToast});

  /// The feature to edit.
  final Feature feature;

  @override
  State<EditFeatureDialog> createState() => _EditFeatureDialogState();
}

class _EditFeatureDialogState extends State<EditFeatureDialog> {
  final nameController = TextEditingController();
  final trialPeriodController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    trialPeriodController.text = widget.feature.trialPeriod?.toString() ?? '';
    nameController.text = widget.feature.name;
    descriptionController.text = widget.feature.description;
    type = widget.feature.type;
  }

  FeatureType type = FeatureType.free;

  bool isEditing = false;

  Future<void> _editFeature() async {
    if (isEditing) {
      return;
    }

    if (nameController.text.isEmpty || descriptionController.text.isEmpty) {
      return;
    }

    isEditing = true;

    final features = context.read<FeaturesRepository>();

    final name = nameController.text;
    final trialPeriod = int.tryParse(trialPeriodController.text);
    final description = descriptionController.text;

    final t = context.t;

    Navigator.of(context).pop();

    final loader = showLoadingToast(
      title: t.products_editFeatureDialog_updatingFeature,
      subtitle: t.products_editFeatureDialog_updatingFeatureWith(name),
    );

    try {
      await features.updateFeature(
        id: widget.feature.id,
        name: name,
        type: type,
        description: description,
        trialPeriod: type == FeatureType.paid ? trialPeriod : null,
      );

      loader.close();

      showSuccessToast(
        title: t.products_editFeatureDialog_updatedFeature,
        subtitle: t.products_editFeatureDialog_updatedFeatureWith(name),
      );
    } catch (e) {
      loader.close();

      showErrorToast(
        title: t.products_editFeatureDialog_errorUpdatingFeature,
        subtitle: t.products_editFeatureDialog_errorUpdatingFeatureWith(name),
      );
    } finally {
      isEditing = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(t.products_editFeatureDialog_editFeatureTitle(widget.feature.id.toString())),
      content: SizedBox(
        width: 500,
        child: Form(
          child: FormTableLayout(
            rows: [
              FormField<String>(
                key: const FormKey(#name),
                label: Text(t.global_name),
                validator: NotEmptyValidator(message: t.global_nameRequired),
                child: TextField(
                  controller: nameController,
                  placeholder: Text(t.products_addFeatureDialog_namePlaceholder),
                ),
              ),
              FormField<FeatureType>(
                key: const FormKey(#type),
                label: Text(t.products_addFeatureDialog_typeLabel),
                child: Select<FeatureType>(
                  itemBuilder: (context, item) {
                    return Text(
                      item.translate(context),
                      textAlign: TextAlign.start,
                    ).alignAtCenterLeft();
                  },
                  popupConstraints: const BoxConstraints(
                    maxHeight: 300,
                    maxWidth: 200,
                  ),
                  onChanged: (value) {
                    setState(() {
                      type = value!;
                    });
                  },
                  orderSelectedFirst: false,
                  value: type,
                  placeholder: Text(t.products_addFeatureDialog_typePlaceholder),
                  children: [
                    SelectItemButton(value: FeatureType.free, child: Text(FeatureType.free.translate(context))),
                    SelectItemButton(value: FeatureType.paid, child: Text(FeatureType.paid.translate(context))),
                  ],
                ),
              ),
              if (type == FeatureType.paid)
                FormField<int>(
                  key: const FormKey(#trialPeriod),
                  label: Text(t.products_addFeatureDialog_trailPeriodLabel),
                  child: NumberInput(controller: trialPeriodController),
                ),
              FormField<String>(
                key: const FormKey(#description),
                label: Text(t.global_description),
                validator: NotEmptyValidator(message: t.global_descriptionRequired),
                child: TextArea(
                  controller: descriptionController,
                  placeholder: Text(t.products_addFeatureDialog_descriptionPlaceholder),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(context.t.global_cancel),
        ),
        TextButton(
          onPressed: _editFeature,
          child: Text(t.products_editFeatureDialog_updateFeature),
        ),
      ],
    );
  }
}
