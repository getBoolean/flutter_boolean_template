import 'package:flutter/material.dart';
import 'package:flutter_boolean_template/src/features/settings/data/dto/human_name_enum.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

Future<ReturnT?> showOptionsMenu<ReturnT, OptionT extends HumanReadableEnum>(
  BuildContext context, {
  required OptionT current,
  required List<OptionT> options,
  required String title,
}) async {
  return await WoltModalSheet.show<ReturnT>(
    context: context,
    useRootNavigator: true,
    pageListBuilder: (BuildContext context) {
      final theme = Theme.of(context);
      return [
        SliverWoltModalSheetPage(
          topBarTitle: Center(
            child: Text(
              title,
              style: theme.textTheme.titleMedium,
            ),
          ),
          isTopBarLayerAlwaysVisible: true,
          leadingNavBarWidget: const Padding(
            padding: EdgeInsets.all(16.0),
            child: CloseButton(),
          ),
          mainContentSlivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                for (final eachOption in options)
                  ListTile(
                    title: Text(
                      eachOption.humanName,
                      style: current == eachOption
                          ? const TextStyle(
                              fontWeight: FontWeight.bold,
                            )
                          : null,
                    ),
                    onTap: () {
                      Navigator.of(context).pop(eachOption);
                    },
                    trailing:
                        current == eachOption ? const Icon(Icons.check) : null,
                  ),
              ]),
            ),
          ],
        ),
      ];
    },
  );
}
