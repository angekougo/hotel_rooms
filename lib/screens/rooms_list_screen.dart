import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_rooms/widgets/custom_room_card.dart';

import '../datas/room_repository.dart';
import '../utils/room_filter.dart';

class RoomsListScreen extends StatefulWidget {
  const RoomsListScreen({super.key});

  @override
  State<RoomsListScreen> createState() => _RoomsListScreenState();
}

class _RoomsListScreenState extends State<RoomsListScreen> {
  String _searchQuery = '';
  String _selectedType = 'Tous';
  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allRooms = RoomRepository.getAll();
    final filteredRooms = filterRooms(
      allRooms,
      searchQuery: _searchQuery,
      selectedType: _selectedType,
    );
    final roomTypes = availableRoomTypes(allRooms);

    final double screenWidth = MediaQuery.of(context).size.width;
    final int crossAxisCount = screenWidth > 600 ? 3 : 2;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton.filled(
              onPressed: () async {
                await context
                    .push('/add-room'); // attend le retour de AddRoomScreen
                setState(() {});
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              focusNode: _searchFocusNode,
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
            items: roomTypes
                .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                .toList(),
            onChanged: (val) => setState(() => _selectedType = val!),
          ),
          if (_searchQuery.isNotEmpty || _selectedType != 'Tous')
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _searchQuery = '';
                      _selectedType = 'Tous';
                      _searchController.clear();
                    });
                  },
                  icon: const Icon(Icons.clear),
                  label: const Text('Réinitialiser les filtres'),
                ),
              ),
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
                        return CustomRoomCard(
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
