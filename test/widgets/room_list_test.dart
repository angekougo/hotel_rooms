import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_rooms/models/room.dart';
import 'package:hotel_rooms/models/room_status.dart';
void main() {
  group('Tests d\'affichage de la liste des chambres', () {
    
    // 1. Création des données mockées (Faux jeu de données)
    final List<Room> mockRooms = [
      Room(
        id: '1',
        number: '101',
        name: 'Suite Présidentielle',
        type: 'Suite',
        description: 'Vue mer',
        pricePerNight: 250,
        imageUrl: 'https://example.com',
        status: RoomStatus.available,
      ),
      Room(
        id: '2',
        number: '102',
        name: 'Chambre Standard',
        type: 'Standard',
        description: 'Lit double',
        pricePerNight: 85,
        imageUrl: 'https://example.com',
        status: RoomStatus.occupied,
      ),
    ];

    testWidgets('Doit afficher tous les éléments de la liste de chambres mockée', (WidgetTester tester) async {
      // 2. Construire l'arbre de widgets avec notre liste mockée
      // (Ici on utilise un ListView direct, remplacez par votre widget d'écran si nécessaire)
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView.builder(
              itemCount: mockRooms.length,
              itemBuilder: (context, index) {
                final room = mockRooms[index];
                return ListTile(
                  title: Text(room.name),
                  subtitle: Text('Chambre ${room.number} • ${room.pricePerNight}CFA/nuit'),
                );
              },
            ),
          ),
        ),
      );

      // 3. Vérifier que les informations du premier mock sont bien affichées
      expect(find.text('Suite Présidentielle'), findsOneWidget);
      expect(find.text('Chambre 101 • 250CFA/nuit'), findsOneWidget);

      // 4. Vérifier que les informations du second mock sont aussi affichées
      expect(find.text('Chambre Standard'), findsOneWidget);
      expect(find.text('Chambre 102 • 85CFA/nuit'), findsOneWidget);
    });
    
  });
}
