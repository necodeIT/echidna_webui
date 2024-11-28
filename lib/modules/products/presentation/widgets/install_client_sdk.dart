import 'package:echidna_dto/echidna_dto.dart';
import 'package:echidna_webui/modules/app/app.dart';
import 'package:echidna_webui/modules/customers/customers.dart';
import 'package:echidna_webui/modules/licenses/licenses.dart';
import 'package:echidna_webui/products.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Displays a step by step guide to install the client SDK for a product.
class InstallClientSdk extends ToastConsumer {
  /// Displays a step by step guide to install the client SDK for a product.
  const InstallClientSdk({super.key, required this.product, required super.showToast});

  /// The product to install the client SDK for.
  final Product product;

  @override
  State<InstallClientSdk> createState() => _InstallClientSdkState();
}

class _InstallClientSdkState extends State<InstallClientSdk> {
  ClientSdk? _sdk;

  List<MapEntry<String, String>>? _instructions;
  StepperController _controller = StepperController();
  Customer? _customer;
  ClientKey? _clientKey;

  Future<void> _onSelect(ClientSdk? sdk) async {
    if (sdk != _sdk) {
      setState(() {
        _sdk = sdk;
        _instructions = null;
        _controller = StepperController();
      });
    }

    if (sdk == null) {
      return;
    }

    final instructions = await context.read<ClientSdkRepository>().getInstructions(
          sdk: sdk,
          context: context,
          productId: widget.product.id,
          customerId: _customer?.id,
        );

    if (mounted) {
      setState(() {
        _instructions = instructions.$1.entries.toList();
        _clientKey = instructions.$2;
      });
    }
  }

  void _selectCustomer(Customer? customer) {
    _customer = customer;

    _onSelect(_sdk);
  }

  void _copy(String data) {
    Clipboard.setData(ClipboardData(text: data));
    showIconToast(
      title: 'Copied to clipboard',
      subtitle: 'Codesnippet has been copied to clipboard!',
      icon: BootstrapIcons.clipboard2CheckFill,
    );
  }

  @override
  Widget build(BuildContext context) {
    final clientSdks = context.watch<ClientSdkRepository>();
    final customers = context.watch<CustomersRepository>();
    final licenses = context.watch<LicensesRepository>();

    final state = customers.state.join(licenses.state).join(clientSdks.state);

    if (!state.hasData) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final product = ProductAggregate.join(
      product: widget.product,
      licenses: licenses.state.requireData,
      customers: customers.state.requireData,
    );

    if (_sdk == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _onSelect(clientSdks.state.requireData.first);
      });
    }

    return Column(
      children: [
        Row(
          children: [
            Text(context.t.products_installClientSDK_installFor(widget.product.name)).expanded(),
            const SizedBox(width: 10),
            Select<ClientSdk>(
              popupConstraints: const BoxConstraints(maxWidth: 150),
              value: _sdk,
              onChanged: _onSelect,
              itemBuilder: (context, sdk) => _sdkLabel(sdk),
              searchFilter: (sdk, query) => sdk.name.containsIgnoreCase(query) ? 1 : 0,
              children: [
                for (final sdk in clientSdks.state.requireData)
                  SelectItemButton(
                    value: sdk,
                    child: _sdkLabel(sdk),
                  ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: SingleChildScrollView(
            child: Stepper(
              controller: _controller,
              direction: Axis.vertical,
              steps: [
                Step(
                  title: Text('Select customer'),
                  contentBuilder: (context) => StepContainer(
                    actions: [
                      Select<Customer>(
                        popupConstraints: const BoxConstraints(maxWidth: 150),
                        value: _customer,
                        onChanged: _selectCustomer,
                        itemBuilder: (context, c) => Text(c.name),
                        searchFilter: (sdk, query) => sdk.name.containsIgnoreCase(query) ? 1 : 0,
                        placeholder: const Text('Select customer'),
                        children: [
                          for (final c in product.customers)
                            SelectItemButton(
                              value: c,
                              child: Text(c.name),
                            ),
                        ],
                      ),
                      PrimaryButton(
                        onPressed: _customer != null ? _controller.nextStep : null,
                        child: Text('Next'),
                      ),
                    ],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select the customer you want to install the SDK for.',
                        ),
                        if (_clientKey != null) ...[
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.info),
                              const SizedBox(width: 10),
                              Text('Your client id: ${_clientKey!.id}'),
                              const SizedBox(width: 5),
                              IconButton.ghost(
                                icon: const Icon(BootstrapIcons.clipboard2),
                                onPressed: () => _copy(_clientKey!.id.toString()),
                              ),
                            ],
                          ),
                          // const SizedBox(height: 5),
                          Row(
                            children: [
                              const Icon(Icons.info),
                              const SizedBox(width: 10),
                              Text('Your client key: ${_clientKey!.key}'),
                              const SizedBox(width: 5),
                              IconButton.ghost(
                                icon: const Icon(BootstrapIcons.clipboard2),
                                onPressed: () => _copy(_clientKey!.key),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                if (_instructions != null)
                  for (int i = 0; i < _instructions!.length; i++)
                    Step(
                      title: Text(_instructions![i].key),
                      contentBuilder: (context) => StepContainer(
                        actions: [
                          SecondaryButton(
                            onPressed: _controller.previousStep,
                            child: Text('Prev'),
                          ),
                          PrimaryButton(
                            onPressed: _controller.nextStep,
                            child: Text(i < _instructions!.length - 1 ? 'Next' : 'Finish'),
                          ),
                        ],
                        child: MarkdownBody(
                          data: _instructions![i].value,
                          builders: {
                            'code': CodeBlockBuilder(),
                          },
                          selectable: true,
                          styleSheet: MarkdownStyleSheet(
                            p: context.theme.typography.normal,
                            listBullet: context.theme.typography.normal,
                            h1: context.theme.typography.h1,
                            h2: context.theme.typography.h2,
                            h3: context.theme.typography.h3,
                            h4: context.theme.typography.h4,
                            h5: context.theme.typography.h4,
                            h6: context.theme.typography.h4,
                            code: context.theme.typography.mono,
                          ),
                        ),
                      ).expanded(),
                    ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _sdkLabel(ClientSdk sdk) {
    return Row(
      children: [
        sdk.framework.icon().svg(height: 20, width: 20),
        const SizedBox(width: 10),
        Text(sdk.name),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
