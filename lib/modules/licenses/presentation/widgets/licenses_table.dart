import 'package:either_dart/either.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:license_server_admin_panel/modules/app/app.dart';
import 'package:license_server_admin_panel/modules/customers/customers.dart';
import 'package:license_server_admin_panel/modules/licenses/licenses.dart';
import 'package:license_server_admin_panel/modules/products/products.dart';
import 'package:license_server_rest/license_server_rest.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:tap_hover_toggle/tap_hover_toggle.dart';
import 'package:uicons_updated/icons/uicons_solid.dart';

/// A table that displays the licenses.
class LicensesTable extends StatefulWidget {
  /// A table that displays the licenses.
  const LicensesTable({super.key});

  @override
  State<LicensesTable> createState() => _LicensesTableState();
}

class _LicensesTableState extends State<LicensesTable> {
  LicensesTableGrouping _grouping = LicensesTableGrouping.none;

  CheckboxState selectionState = CheckboxState.unchecked;

  final searchController = TextEditingController();
  final selectedItems = <String>{};

  @override
  void initState() {
    searchController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  void selectAll() {
    final licenses = context.read<LicensesRepository>().state.requireData.where((l) => l.licenseKey.containsIgnoreCase(searchController.text));
    selectedItems
      ..clear()
      ..addAll(licenses.map((e) => e.licenseKey));

    setState(() {
      selectionState = CheckboxState.checked;
    });
  }

  void deselectAll() {
    selectedItems.clear();

    setState(() {
      selectionState = CheckboxState.unchecked;
    });
  }

  void onChanged(CheckboxState state) {
    if (state == CheckboxState.checked) {
      selectAll();
    } else {
      deselectAll();
    }
  }

  // ignore: avoid_positional_boolean_parameters
  void selectLicense(bool value, String licenseKey) {
    if (value && !selectedItems.contains(licenseKey)) {
      selectedItems.add(licenseKey);
    } else if (!value && selectedItems.contains(licenseKey)) {
      selectedItems.remove(licenseKey);
    }

    setState(() {
      selectionState = selectedItems.isEmpty
          ? CheckboxState.unchecked
          : selectedItems.length == context.read<LicensesRepository>().state.requireData.length
              ? CheckboxState.checked
              : CheckboxState.indeterminate;
    });
  }

  Either<Map<String, List<LicenseAggregate>>, List<LicenseAggregate>> _groupLicenses() {
    final licenses = context.read<LicensesRepository>();
    final products = context.read<ProductsRepository>();
    final customers = context.read<CustomersRepository>();

    final state = licenses.state.join(products.state).join(customers.state);

    if (!state.hasData) {
      return const Right([]);
    }

    final grouped = <String, List<LicenseAggregate>>{};

    final aggregated = licenses.state.requireData.where((l) => l.licenseKey.containsIgnoreCase(searchController.text)).toList().connect(
          products.state.requireData,
          customers.state.requireData,
        );

    for (final license in aggregated) {
      final key = _grouping == LicensesTableGrouping.customer
          ? license.customer.name
          : _grouping == LicensesTableGrouping.product
              ? license.product.name
              : '';

      if (!grouped.containsKey(key)) {
        grouped[key] = [];
      }

      grouped[key]!.add(license);
    }

    if (_grouping == LicensesTableGrouping.none) {
      return Right(grouped.values.expand((element) => element).toList());
    }

    return Left(grouped);
  }

  void showBulkActions(BuildContext context) {
    showDropdown(
      context: context,
      builder: (context) => DropdownMenu(
        children: [
          MenuLabel(
            leading: const Icon(BootstrapIcons.stars),
            child: Text('Bulk actions (${selectedItems.length})'),
          ),
          const MenuDivider(),
          MenuButton(
            leading: Icon(
              UiconsSolid.gavel,
              color: context.theme.colorScheme.destructive,
            ),
            child: Text(
              'Revoke',
              style: context.theme.typography.semiBold.copyWith(
                color: context.theme.colorScheme.destructive,
              ),
            ),
            onPressed: (context) {
              // showDialog(
              //   context: context,
              //   builder: (_) => RevokeLicenseDialog(
              //     license: license.license,
              //     showToast: createShowToastHandler(context),
              //   ),
              // );
            },
          ),
        ],
      ),
    );
  }

  void select(List<String> licenseKeys, {bool selected = true}) {
    if (selected) {
      selectedItems.addAll(licenseKeys);
    } else {
      selectedItems.removeWhere((element) => licenseKeys.contains(element));
    }

    setState(() {
      selectionState = selectedItems.isEmpty
          ? CheckboxState.unchecked
          : selectedItems.length == context.read<LicensesRepository>().state.requireData.length
              ? CheckboxState.checked
              : CheckboxState.indeterminate;
    });
  }

  @override
  Widget build(BuildContext context) {
    final licenses = context.watch<LicensesRepository>();
    final products = context.watch<ProductsRepository>();
    final customers = context.watch<CustomersRepository>();

    final state = licenses.state.join(products.state).join(customers.state);

    final items = _groupLicenses();

    if (state.hasData && items.fold((e) => e.isEmpty, (e) => e.isEmpty)) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            RadixIcons.magnifyingGlass,
            size: 50,
            color: context.theme.colorScheme.mutedForeground,
          ),
          const SizedBox(height: 25),
          Text(
            'No licenses found',
            style: context.theme.typography.medium.copyWith(
              color: context.theme.colorScheme.mutedForeground,
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 500,
              child: TextField(
                controller: searchController,
                placeholder: 'Filter IDs...',
              ),
            ),
            SizedBox(
              width: 200,
              child: Select<LicensesTableGrouping>(
                itemBuilder: (context, grouping) => Text(grouping.translate(context)),
                onChanged: (grouping) => setState(() => _grouping = grouping ?? LicensesTableGrouping.none),
                value: _grouping,
                popupConstraints: const BoxConstraints(
                  maxHeight: 300,
                  maxWidth: 200,
                ),
                orderSelectedFirst: false,
                children: [
                  SelectItemButton(
                    value: LicensesTableGrouping.customer,
                    child: Text(
                      LicensesTableGrouping.customer.translate(context),
                    ),
                  ),
                  SelectItemButton(
                    value: LicensesTableGrouping.product,
                    child: Text(
                      LicensesTableGrouping.product.translate(context),
                    ),
                  ),
                  SelectItemButton(
                    value: LicensesTableGrouping.none,
                    child: Text(
                      LicensesTableGrouping.none.translate(context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        TapHoverToggle(
          builder: (hover) {
            return MouseRegion(
              cursor: SystemMouseCursors.basic,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: hover ? context.theme.colorScheme.muted.withOpacity(0.5) : null,
                  border: Border.all(color: theme.colorScheme.border),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(theme.radiusMd),
                    topRight: Radius.circular(theme.radiusMd),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Checkbox(state: selectionState, onChanged: onChanged),
                    const SizedBox(width: 25),
                    Expanded(
                      child: Text(
                        context.t.licenses_licensesTable_licenseKeyHeader,
                        style: theme.typography.normal.copyWith(color: theme.colorScheme.mutedForeground),
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      child: Text(
                        context.t.licenses_licensesTable_customerHeader,
                        style: theme.typography.normal.copyWith(color: theme.colorScheme.mutedForeground),
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      child: Text(
                        context.t.licenses_licensesTable_productHeader,
                        style: theme.typography.normal.copyWith(color: theme.colorScheme.mutedForeground),
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      child: Text(
                        context.t.licenses_licensesTable_expirationDateHeader,
                        style: theme.typography.normal.copyWith(color: theme.colorScheme.mutedForeground),
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      child: Text(
                        context.t.licenses_licensesTable_revokedHeader,
                        style: theme.typography.normal.copyWith(color: theme.colorScheme.mutedForeground),
                      ),
                    ),
                    Builder(
                      builder: (context) {
                        return IconButton.ghost(
                          icon: const Icon(RadixIcons.dotsHorizontal),
                          onPressed: selectedItems.isNotEmpty
                              ? () {
                                  showBulkActions(context);
                                }
                              : null,
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        if (state.hasData)
          Expanded(
            child: items.fold<Widget>(
              (e) => CustomScrollView(
                slivers: e.entries
                    .map(
                      (en) => SliverStickyHeader(
                        header: TapHoverToggle(
                          builder: (hover) {
                            return MouseRegion(
                              cursor: SystemMouseCursors.basic,
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: hover ? context.theme.colorScheme.muted.withOpacity(0.5) : context.theme.colorScheme.background,
                                  border: Border(
                                    bottom: BorderSide(
                                      color: context.theme.colorScheme.border,
                                    ),
                                    left: BorderSide(
                                      color: context.theme.colorScheme.border,
                                    ),
                                    right: BorderSide(
                                      color: context.theme.colorScheme.border,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Checkbox(
                                      state: selectedItems.containsAll(en.value.map((e) => e.license.licenseKey).toList())
                                          ? CheckboxState.checked
                                          : selectedItems.any((element) => en.value.map((e) => e.license.licenseKey).contains(element))
                                              ? CheckboxState.indeterminate
                                              : CheckboxState.unchecked,
                                      onChanged: (state) => select(
                                        en.value.map((e) => e.license.licenseKey).toList(),
                                        selected: state == CheckboxState.checked,
                                      ),
                                    ),
                                    const SizedBox(width: 25),
                                    Icon(_grouping == LicensesTableGrouping.customer ? BootstrapIcons.peopleFill : RadixIcons.code),
                                    const SizedBox(width: 8),
                                    Text(en.key),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate(
                            _mapLicenses(en.value, isLast: en.key == e.entries.last.key),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              (l) => ListView(
                children: _mapLicenses(l, isLast: true),
              ),
            ),
          ),
      ],
    );
  }

  List<Widget> _mapLicenses(List<LicenseAggregate> licenses, {bool isLast = false}) {
    return licenses
        .map(
          (license) => LicensesTableRow(
            key: ValueKey(license.hashCode),
            license: license,
            selected: selectedItems.contains(license.license.licenseKey),
            onSelect: (selected) => selectLicense(selected, license.license.licenseKey),
            isLast: licenses.last == license && isLast,
          ),
        )
        .toList();
  }
}

/// Different ways to group the items in the licenses table.
enum LicensesTableGrouping {
  /// Group by [License.customerId].
  customer(_customer),

  /// Group by [License.productId].
  product(_product),

  /// Disable grouping.
  none(_none);

  /// The localized name of this grouping.
  final String Function(BuildContext context) translate;

  const LicensesTableGrouping(this.translate);
}

String _customer(BuildContext context) => context.t.licenses_licensesTable_groupByCustomers;

String _product(BuildContext context) => context.t.licenses_licensesTable_groupByProducts;

String _none(BuildContext context) => context.t.licenses_licensesTable_disableGrouping;
