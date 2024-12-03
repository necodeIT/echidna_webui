import 'package:echidna_webui/modules/app/app.dart';
import 'package:echidna_webui/modules/licenses/licenses.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:tap_hover_toggle/tap_hover_toggle.dart';
import 'package:uicons_updated/uicons.dart';

/// A row in the [LicensesTable].
class LicensesTableRow extends StatelessWidget {
  /// A row in the [LicensesTable].
  const LicensesTableRow({
    super.key,
    required this.license,
    required this.selected,
    required this.onSelect,
    required this.isLast,
  });

  /// The license to display.
  final LicenseAggregate license;

  /// Whether the row is selected.
  final bool selected;

  /// Called when the row is selected.
  // ignore: avoid_positional_boolean_parameters
  final void Function(bool) onSelect;

  /// Whether the row is the last row in the table.
  final bool isLast;

  void _goToLicenseDetails() {
    Modular.to.navigate('/licenses/${license.license.licenseKey}');
  }

  @override
  Widget build(BuildContext context) {
    final licenses = context.watch<LicensesRepository>();

    return FutureBuilder(
      future: licenses.getStatus(license.license),
      builder: (context, snapshot) {
        final skeletonBase = Container(
          width: double.infinity,
          height: 20,
          decoration: BoxDecoration(
            color: context.theme.colorScheme.muted.withOpacity(0.5),
            borderRadius: BorderRadius.circular(context.theme.radiusSm),
          ),
        );

        final expirationDate = skeletonBase.asSkeleton(
          snapshot: snapshot,
          replacement: snapshot.hasData
              ? Text(
                  snapshot.data!.expirationDate != null
                      ? LicenseCard.formatter.format(snapshot.data!.expirationDate!)
                      : context.t.licenses_licensesTableRow_na,
                )
              : null,
        );

        final status = skeletonBase.asSkeleton(
          snapshot: snapshot,
          replacement: snapshot.hasData
              ? Row(
                  children: [
                    if (!snapshot.data!.active)
                      Icon(BootstrapIcons.xCircleFill, color: context.theme.colorScheme.destructive)
                    else
                      Icon(BootstrapIcons.checkCircleFill, color: context.theme.colorScheme.primary),
                    const SizedBox(width: 10),
                    Text(snapshot.data!.active ? context.t.licenses_licenseCard_active : context.t.licenses_licenseCard_inactive),
                  ],
                )
              : null,
        );

        return TapHoverToggle(
          onClick: _goToLicenseDetails,
          builder: (hover) {
            return MouseRegion(
              cursor: SystemMouseCursors.basic,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: hover ? context.theme.colorScheme.muted.withOpacity(0.5) : null,
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
                  borderRadius: isLast
                      ? BorderRadius.only(
                          bottomLeft: Radius.circular(context.theme.radiusMd),
                          bottomRight: Radius.circular(context.theme.radiusMd),
                        )
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Checkbox(
                      state: selected ? CheckboxState.checked : CheckboxState.unchecked,
                      onChanged: (state) => onSelect(state == CheckboxState.checked),
                    ),
                    const SizedBox(width: 25),
                    Expanded(
                      child: Text(
                        license.license.licenseKey,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      child: Text(license.customer.name),
                    ),
                    const Spacer(),
                    Expanded(
                      child: Text(license.product.name),
                    ),
                    const Spacer(),
                    Expanded(
                      child: expirationDate,
                    ),
                    const Spacer(),
                    Expanded(
                      child: status,
                    ),
                    Builder(
                      builder: (context) {
                        return IconButton.ghost(
                          icon: const Icon(RadixIcons.dotsHorizontal),
                          onPressed: () {
                            showDropdown(
                              context: context,
                              builder: (_) {
                                return SizedBox(
                                  width: 100,
                                  child: DropdownMenu(
                                    children: [
                                      MenuButton(
                                        leading: const Icon(BootstrapIcons.infoCircle),
                                        child: Text(context.t.global_details),
                                        onPressed: (context) {
                                          _goToLicenseDetails();
                                        },
                                      ),
                                      MenuButton(
                                        leading: Icon(
                                          UiconsSolid.gavel,
                                          color: context.theme.colorScheme.destructive,
                                        ),
                                        child: Text(
                                          context.t.licenses_licensesTableRow_revoke,
                                          style: context.theme.typography.semiBold.copyWith(
                                            color: context.theme.colorScheme.destructive,
                                          ),
                                        ),
                                        onPressed: (_) {
                                          showDialog(
                                            context: context,
                                            builder: (_) => RevokeLicenseDialog(
                                              licenses: [license.license],
                                              showToast: createShowToastHandler(context),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
