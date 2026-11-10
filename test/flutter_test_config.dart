import 'dart:async';
import 'dart:io';

import 'package:copiere_interfata_lab2/widgets/common/app_svg_icon.dart';
import 'package:flutter/services.dart';

/// Loads the app's real Poppins font for widget tests (instead of the
/// square "Ahem" test font) so text is measured realistically. Poppins is
/// also registered as "Roboto", which is a system font not bundled in assets.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  const files = [
    'assets/fonts/Poppins-Regular.ttf',
    'assets/fonts/Poppins-Medium.ttf',
    'assets/fonts/Poppins-SemiBold.ttf',
    'assets/fonts/Poppins-Bold.ttf',
  ];
  for (final family in ['Poppins', 'Roboto']) {
    final loader = FontLoader(family);
    for (final f in files) {
      loader.addFont(
        Future.value(ByteData.sublistView(File(f).readAsBytesSync())),
      );
    }
    await loader.load();
  }
  SvgCache.networkEnabled = false; // no real HTTP in tests
  await testMain();
}
