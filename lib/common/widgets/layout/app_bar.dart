import 'package:flutter/material.dart';
import 'package:example_app/common/helpers/constants.dart';
import 'package:example_app/common/widgets/layout/margin_row.dart';
import 'package:url_launcher/url_launcher.dart';

const appBarHeight = 70.0;

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context).colorScheme;
    final themeText = Theme.of(context).textTheme;

    return AppBar(
      primary: true,
      toolbarHeight: appBarHeight,
      title: MarginConstrainedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Flutter Starterkit'.toUpperCase(),
              style: themeText.displaySmall?.copyWith(
                color: themeColors.onSurface,
              ),
            ),
            InkWell(
              onTap: () => launchUrl(
                Uri.parse(websiteUrl),
                webOnlyWindowName: '_blank',
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: themeColors.onSurface,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Text(
                  'Github Repo',
                  style: themeText.bodyMedium!.copyWith(
                    color: themeColors.onSurface,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(appBarHeight);
}
