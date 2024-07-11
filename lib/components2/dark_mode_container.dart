import 'package:flutter/material.dart';
import 'package:kemet/providers2/theme_provider.dart';
import 'package:provider/provider.dart';

class DarkMode extends StatefulWidget {
  const DarkMode({Key? key}) : super(key: key);

  @override
  State<DarkMode> createState() => _DarkModeState();
}

class _DarkModeState extends State<DarkMode> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SizedBox(
      width: 354,
      height: 45,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.dark_mode_outlined,
                  size: 20,
                  //color: Colors.black,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Dark Mode',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w600,
                    //color: Colors.black,
                  ),
                ),
              ],
            ),
            Switch(
              value: themeProvider.themeMode == ThemeModeType.dark,
              onChanged: (value) {
                final newThemeMode =
                    value ? ThemeModeType.dark : ThemeModeType.light;
                themeProvider.themeMode = newThemeMode;
              },
              activeColor: Colors.black,
              inactiveThumbColor: Colors.white,
              activeTrackColor: Colors.white,
              inactiveTrackColor: Colors.black,
            ),
            // IconButton(
            //     icon: Icon(GProject.themeNotifier.value == ThemeMode.light
            //         ? Icons.dark_mode
            //         : CupertinoIcons.money_dollar),
            //     onPressed: () {
            //       GProject.themeNotifier.value =
            //           GProject.themeNotifier.value == ThemeMode.light
            //               ? ThemeMode.dark
            //               : ThemeMode.light;
            //     })
          ],
        ),
      ),
    );
  }
}
