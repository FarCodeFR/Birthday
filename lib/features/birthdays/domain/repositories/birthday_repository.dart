import 'package:birthday/features/birthdays/domain/entities/birthday.dart';

/// Fournit la liste des anniversaires à partir des contacts du téléphone.
abstract class BirthdayRepository {
  Future<List<Birthday>> getBirthdays();
}
