import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:echidna_dto/echidna_dto.dart';
import 'package:echidna_webui/modules/app/app.dart';
import 'package:echidna_webui/modules/products/products.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Dialog to add a feature to a product.
class AddFeatureDialog extends ToastConsumer {
  /// Dialog to add a feature to a product.
  const AddFeatureDialog({super.key, required this.product, required super.showToast});

  /// The product to add the feature to.
  final Product product;

  @override
  State<AddFeatureDialog> createState() => _AddFeatureDialogState();
}

class _AddFeatureDialogState extends State<AddFeatureDialog> {
  final nameController = TextEditingController();
  final trialPeriodController = TextEditingController();
  final descriptionController = TextEditingController();

  FeatureType type = FeatureType.free;

  bool isCreating = false;

  Future<void> _createFeature() async {
    if (isCreating) {
      return;
    }

    if (nameController.text.isEmpty || descriptionController.text.isEmpty) {
      return;
    }

    isCreating = true;

    final features = context.read<FeaturesRepository>();

    final name = nameController.text;
    final trialPeriod = int.tryParse(trialPeriodController.text);
    final description = descriptionController.text;

    final t = context.t;

    Navigator.of(context).pop();

    final loader = showLoadingToast(
      title: 'Creating feature',
      subtitle: 'Creating feature $name',
    );

    try {
      await features.createFeature(
        name: name,
        productId: widget.product.id,
        type: type,
        description: description,
        trialPeriod: type == FeatureType.paid ? trialPeriod : null,
      );

      loader.close();

      showSuccessToast(
        title: 'Created feature',
        subtitle: 'Created feature $name',
      );
    } catch (e) {
      loader.close();

      showErrorToast(
        title: 'Created feature',
        subtitle: 'Successfully created feature with $name',
      );
    } finally {
      isCreating = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add feature'),
      content: Expanded(
        child: SingleChildScrollView(
          child: SizedBox(
            width: 500,
            child: Form(
              child: FormTableLayout(
                rows: [
                  FormField<String>(
                    key: const FormKey(#name),
                    label: const Text('Name'),
                    validator: const NotEmptyValidator(message: 'Name is required'),
                    child: TextField(
                      controller: nameController,
                      placeholder: 'Feature Name',
                    ),
                  ),
                  FormField<FeatureType>(
                    key: const FormKey(#type),
                    label: const Text('Type'),
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
                      placeholder: const Text('Select a type'),
                      children: [
                        SelectItemButton(value: FeatureType.free, child: Text(FeatureType.free.translate(context))),
                        SelectItemButton(value: FeatureType.paid, child: Text(FeatureType.paid.translate(context))),
                      ],
                    ),
                  ),
                  if (type == FeatureType.paid)
                    FormField<int>(
                      key: const FormKey(#trialPeriod),
                      label: const Text('Trial period (days)'),
                      child: NumberInput(controller: trialPeriodController),
                    ),
                  FormField<String>(
                    key: const FormKey(#description),
                    label: const Text('Description'),
                    validator: const NotEmptyValidator(message: 'Description is required'),
                    child: TextArea(
                      controller: descriptionController,
                      placeholder: 'description',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      actions: [
        Button.primary(
          onPressed: _createFeature,
          child: Text(context.t.global_create),
        ),
        Button.secondary(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(context.t.global_cancel),
        ),
      ],
    );
  }
}

extension on FeatureType {
  String translate(BuildContext context) {
    return switch (this) {
      FeatureType.free => 'Free',
      FeatureType.paid => 'Paid',
    };
  }
}
