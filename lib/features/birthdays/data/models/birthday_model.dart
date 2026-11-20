import 'package:birthday/features/birthdays/domain/entities/birthday.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

/// Fait le lien entre un contact du téléphone et l'entité [Birthday].
class BirthdayModel {
  /// Convertit un contact en [Birthday] à partir de son premier événement.
  static Birthday fromContact(Contact contact) {
    final event = contact.events.first;
    return Birthday(
      contactId: contact.id ?? '',
      name: contact.displayName ?? '',
      day: event.day,
      month: event.month,
      year: event.year,
      phone: contact.phones.isNotEmpty ? contact.phones.first.number : null,
      photo: contact.photo?.thumbnail,
    );
  }
}
