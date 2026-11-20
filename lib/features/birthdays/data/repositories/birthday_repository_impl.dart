import 'package:birthday/features/birthdays/data/data_sources/contacts_service.dart';
import 'package:birthday/features/birthdays/data/models/birthday_model.dart';
import 'package:birthday/features/birthdays/domain/entities/birthday.dart';
import 'package:birthday/features/birthdays/domain/repositories/birthday_repository.dart';

/// Fournit la liste des anniversaires à partir des contacts du téléphone.
class BirthdayRepositoryImpl implements BirthdayRepository {
  /// Renvoie les anniversaires des contacts.
  @override
  Future<List<Birthday>> getBirthdays() async {
    final contacts = await loadContacts();
    return contacts.where((c) => c.events.isNotEmpty).map(BirthdayModel.fromContact).toList();
  }
}
