import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:url_launcher/url_launcher.dart';

// Permission
Future<bool> askForPermission() async {
  final status = await FlutterContacts.permissions.request(PermissionType.read);
  return status == PermissionStatus.granted || status == PermissionStatus.limited;
}

// Contact
Future<List<Contact>> loadContacts() async {
  // Request contact
  if (await askForPermission()) {
    final contacts = await FlutterContacts.getAll(
      properties: {
        ContactProperty.name,
        ContactProperty.event,
        ContactProperty.photoThumbnail,
        ContactProperty.phone,
      },
    );
    return contacts;
  } else {
    return List<Contact>.empty();
  }
}

Future<void> appeler(String numero) async {
  final uri = Uri(scheme: 'tel', path: numero);
  await launchUrl(uri);
}

Future<void> envoyerSms(String numero) async {
  final uri = Uri(scheme: 'sms', path: numero);
  await launchUrl(uri);
}
