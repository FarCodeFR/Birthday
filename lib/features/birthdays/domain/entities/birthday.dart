import 'dart:typed_data';

class Birthday {
  final String contactId;
  final String name;
  final int day;
  final int month;
  final int? year;
  final Uint8List? photo;
  final String? phone;

  const Birthday({
    required this.contactId,
    required this.name,
    required this.day,
    required this.month,
    this.year,
    this.photo,
    this.phone,
  });

  static DateTime _today() {
    final now = DateTime.now();
    return DateTime.utc(now.year, now.month, now.day);
  }

  DateTime get nextBirthday {
    final today = _today();
    // Crée la date de l'anniversaire pour l'année en cours
    var nextDate = DateTime.utc(today.year, month, day);

    // Si l'anniversaire est déjà passé cette année, on calcule pour l'année prochaine
    if (nextDate.isBefore(today)) {
      nextDate = DateTime.utc(today.year + 1, month, day);
    }
    return nextDate;
  }

  // Nombre de jours restants
  int get daysLeft {
    return nextBirthday.difference(_today()).inDays;
  }
}
