import 'package:birthday/features/birthdays/data/data_sources/contacts_service.dart';
import 'package:birthday/features/birthdays/domain/entities/birthday.dart';
import 'package:flutter/material.dart';
import 'package:birthday/features/birthdays/presentation/birthday_text.dart';

class BirthdayCard extends StatelessWidget {
  final Birthday birthday;
  const BirthdayCard(this.birthday, {super.key});

  @override
  Widget build(BuildContext context) {
    final daysLeft = birthday.daysLeft;
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return GestureDetector(
      // Au tap on ouvre le showAction menu bottom
      onTap: () => _showActions(context),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: scheme.surfaceContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            //* Avatar (Image ou Initiales)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 50,
                height: 50,
                child: birthday.photo != null
                    ? Image.memory(birthday.photo!, fit: BoxFit.cover)
                    : Center(
                        child: Text(
                          birthday.name.characters.first.toUpperCase(),
                          style: text.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 14),

            //* Informations (Expanded pour occuper tout l'espace du milieu)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    birthday.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis, // "Jean-Christophe Dup…"
                    style: text.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    birthday.year != null
                        ? 'Né(e) en ${birthday.year} (${DateTime.now().year - birthday.year!} ans)'
                        : 'Anniversaire',
                    style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),

            //* Séparateur vertical
            Container(
              height: 36,
              width: 1,
              color: scheme.outlineVariant,
              margin: const EdgeInsets.symmetric(horizontal: 20),
            ),

            //* Décompte de jours
            SizedBox(
              width: 90,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    BirthdayText.daysLeft(daysLeft),
                    textAlign: TextAlign.center,
                    style: text.titleSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: daysLeft == 0 ? scheme.tertiary : scheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Restants',
                    style: text.labelSmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showActions(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: scheme.surfaceContainer,
      builder: (BuildContext sheetContext) {
        return SizedBox(
          height: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(birthday.name, style: text.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 15),
                if (birthday.phone != null) ...[
                  FilledButton.icon(
                    icon: const Icon(Icons.call),
                    label: const Text('Appeler'),
                    style: FilledButton.styleFrom(minimumSize: const Size(220, 48)),
                    onPressed: () {
                      Navigator.pop(sheetContext);
                      appeler(birthday.phone!);
                    },
                  ),
                  const SizedBox(height: 15),
                  FilledButton.tonalIcon(
                    icon: const Icon(Icons.sms),
                    label: const Text('Envoyer un SMS'),
                    style: FilledButton.styleFrom(minimumSize: const Size(220, 48)),
                    onPressed: () {
                      Navigator.pop(sheetContext);
                      envoyerSms(birthday.phone!);
                    },
                  ),
                ] else
                  Text(
                    'Aucun numéro de téléphone',
                    style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
