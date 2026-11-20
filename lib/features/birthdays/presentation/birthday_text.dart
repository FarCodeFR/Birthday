/// Textes affichés à l'utilisateur pour un anniversaire.
class BirthdayText {
  static String daysLeft(int days) => switch (days) {
    0 => "Aujourd'hui ! 🎉",
    1 => 'Demain !',
    _ => 'Dans $days j',
  };
}
