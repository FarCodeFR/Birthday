import 'package:birthday/features/birthdays/data/repositories/birthday_repository_impl.dart';
import 'package:birthday/features/birthdays/domain/entities/birthday.dart';
import 'package:birthday/features/birthdays/domain/repositories/birthday_repository.dart';
import 'package:birthday/features/birthdays/presentation/widgets/birthday_card.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final BirthdayRepository _repository = BirthdayRepositoryImpl();
  late final Future<List<Birthday>> _birthdaysFuture;

  // Initialisé une fois
  @override
  void initState() {
    super.initState();
    _birthdaysFuture = _repository.getBirthdays();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      body: FutureBuilder<List<Birthday>>(
        future: _birthdaysFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text('Erreur lors du chargement des données'));
          }

          final birthdays = snapshot.data!;

          return Column(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: scheme.primaryContainer,
                  borderRadius: const BorderRadiusGeometry.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: SafeArea(
                  child: Text(
                    'Les \nanniversaires',
                    textAlign: TextAlign.center,
                    style: text.headlineLarge?.copyWith(
                      color: scheme.onPrimaryContainer,
                      fontWeight: FontWeight.w900,
                      height: 1.1,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: birthdays.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Aucun anniversaire trouvé'),
                            const SizedBox(height: 12),
                            FilledButton.icon(
                              icon: const Icon(Icons.settings),
                              label: const Text('Autoriser l\'accès aux contacts'),
                              onPressed: openAppSettings,
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(top: 10, bottom: 20),
                        itemCount: birthdays.length,
                        itemBuilder: (context, index) => BirthdayCard(birthdays[index]),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
