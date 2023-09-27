import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Snackbar {
  static void show(BuildContext context, String message, ContentType type) {
    final snackbar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
          title: type == ContentType.success ? "Succes" : "Error",
          message: message,
          contentType: type),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackbar);
  }
}
