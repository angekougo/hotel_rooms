import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../datas/room_mock.dart';
import '../widgets/room_card.dart';

class RoomsListScreen extends StatefulWidget {
  const RoomsListScreen({super.key});

  @override
  State<RoomsListScreen> createState() => _RoomsListScreenState();
}

class _RoomsListScreenState extends State<RoomsListScreen> {
  String _searchQuery = '';
  String _selectedType = 'Tous';

  @override
  Widget build(BuildContext context) {
    final filteredRooms = rooms
        .where((r) {
          final macthesSearch = r.name.toLowerCase().contains(_searchQuery.toLowerCase());
          final matchesType = _selectedType == 'Tous' || r.type == _selectedType;
          return macthesSearch && matchesType;
        }).toList();

    final double screenWidth = MediaQuery.of(context).size.width;
    final int crossAxisCount = screenWidth > 600 ? 3 : 2;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton.filled(
              onPressed: () {
                context.push('/add-room');
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Rechercher une chambre',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          DropdownButton<String>(
            value: _selectedType,
            items: ['Tous', 'Standard', 'Deluxe', 'Suite', 'Studio']
                .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                .toList(),
            onChanged: (val) => setState(() => _selectedType = val!),
          ),
          Expanded(
            child: filteredRooms.isEmpty
                ? const Center(child: Text('Aucune chambre trouvée.'))
                : Padding(
                    padding: const EdgeInsets.all(16),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: filteredRooms.length,
                      itemBuilder: (context, index) {
                        final room = filteredRooms[index];
                        return RoomCard(
                          room: room,
                          onTap: () {
                            context.push('/room/${room.id}');
                          },
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
