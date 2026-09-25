# hotel_rooms

Projet Flutter multi-écrans réalisé pour la certification "Navigation & Routing" du FlutterFire Summer Camp 2026. L'idée : une petite app de gestion de chambres d'hôtel, avec une liste filtrable, une fiche détail par chambre, et un formulaire pour en ajouter.

## Lancer le projet

```bash
git clone https://github.com/angekougo/hotel_rooms
cd hotel_rooms
flutter pub get
flutter run
```

## Lancer les tests

J'ai 5 fichiers de test, rangés en miroir de `lib/` (un dossier `test/` qui suit la même structure que `lib/`, pour s'y retrouver facilement).

```bash
flutter test
```

Ou fichier par fichier, si tu veux isoler quelque chose :

| Fichier | Commande | Ce qu'il couvre |
|---|---|---|
| `test/models/room_test.dart` | `flutter test test/models/room_test.dart` | Le modèle `Room` |
| `test/datas/room_repository_test.dart` | `flutter test test/datas/room_repository_test.dart` | Le `RoomRepository` (ajout, recherche par id) |
| `test/utils/room_filter_test.dart` | `flutter test test/utils/room_filter_test.dart` | La logique de recherche/filtrage |
| `test/screens/rooms_list_screen_test.dart` | `flutter test test/screens/rooms_list_screen_test.dart` | L'écran de liste |
| `test/screens/add_room_screen_test.dart` | `flutter test test/screens/add_room_screen_test.dart` | Le formulaire d'ajout |

---

## Fonctionnalités obligatoires — où les trouver

### Au moins 4 écrans distincts

J'en ai 5. Ils sont déclarés comme routes dans `lib/routes/app_router.dart` (lignes 8-23) :

```dart
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/rooms', builder: (context, state) => const RoomsListScreen()),
    GoRoute(
        path: '/room/:roomId',
        builder: (context, state) {
          final roomId = state.pathParameters['roomId']!;
          return RoomDetailScreen(roomId: roomId);
        }),
    GoRoute(path: '/add-room', builder: (context, state) => const AddRoomScreen()),
  ],
);
```
- `HomeScreen` — accueil, avec le nombre de chambres et quelques-unes en vedette (pas juste une bannière statique).
- `RoomsListScreen` — la liste, avec recherche et filtre.
- `RoomDetailScreen` — le détail d'une chambre.
- `AddRoomScreen` — le formulaire d'ajout.

### Navigation avec GoRouter, routes nommées

`go_router` (voir `pubspec.yaml`), configuré dans `lib/routes/app_router.dart` et branché dans `lib/main.dart` ligne 40 : `routerConfig: appRouter`.

### Écran de liste avec recherche/filtrage

`lib/screens/rooms_list_screen.dart`, lignes 30-36 :
```dart
final allRooms = RoomRepository.getAll();
final filteredRooms = filterRooms(
  allRooms,
  searchQuery: _searchQuery,
  selectedType: _selectedType,
);
final roomTypes = availableRoomTypes(allRooms);
```
J'ai sorti la logique de filtrage dans `lib/utils/room_filter.dart` plutôt que de la laisser inline dans l'écran — ça la rend testable toute seule, sans monter l'UI. Les tests sont dans `test/utils/room_filter_test.dart` (recherche seule, filtre par type seul, les deux combinés, insensibilité à la casse, espaces en trop, liste vide).

Le résultat sert directement à construire la grille (mêmes fichier, lignes 98-111) :
```dart
child: filteredRooms.isEmpty
    ? const Center(child: Text('Aucune chambre trouvée.'))
    : GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(...),
        itemCount: filteredRooms.length,
        itemBuilder: (context, index) {
          final room = filteredRooms[index];
          return CustomRoomCard(room: room, onTap: () => context.push('/room/${room.id}'));
        },
      ),
```

### Écran de détail avec passage de paramètres

Le `roomId` passe par l'URL (`/room/:roomId`) et sert dans `lib/screens/room_detail_screen.dart` ligne 11 :
```dart
final room = RoomRepository.getById(roomId);
```
Avec le cas "id invalide" géré (lignes 13-20), plutôt que de laisser planter l'app :
```dart
if (room == null) {
  return Scaffold(
    appBar: AppBar(title: const Text('Chambre introuvable')),
    body: const Center(child: Text('Cette chambre n\'existe pas ou plus.')),
  );
}
```

### Formulaire avec validation (au moins 3 champs)

`lib/screens/add_room_screen.dart` a 4 champs validés (nom, type, prix, numéro), chacun avec son `validator`. Exemple (lignes 142-147, dans la mise en page mobile) :
```dart
CustomInput(
  controller: _roomNameController,
  label: 'Nom de la chambre',
  validator: (value) => value!.isEmpty ? 'Nom obligatoire' : null,
),
```
Le champ prix vérifie aussi que c'est bien un nombre (lignes 156-166) :
```dart
validator: (value) {
  if (value!.isEmpty) return 'Prix obligatoire';
  if (double.tryParse(value) == null) return 'Entrer un nombre';
  return null;
},
```
Un cinquième champ (image) utilise un `DropdownButtonFormField` plutôt qu'un `CustomInput` — voir la section "Aucune donnée hardcodée" plus bas.
Le tout est testé dans `test/screens/add_room_screen_test.dart` — soumission valide qui ajoute bien la chambre, soumission vide qui n'ajoute rien et affiche les erreurs.

### Gestion du thème clair/sombre

`lib/main.dart`, lignes 17-39 :
```dart
ThemeMode _themeMode = ThemeMode.light;

void _toggleTheme() {
  setState(() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  });
}
// ...
theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange, brightness: Brightness.light), ...),
darkTheme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange, brightness: Brightness.dark)),
themeMode: _themeMode,
```
Le bouton pour basculer est un `FloatingActionButton` global (lignes 43-46).

---

## Exigences techniques — où les trouver

### Au moins 8 widgets différents

| Widget | Fichier | Ligne |
|---|---|---|
| `ListView` | `lib/screens/add_room_screen.dart` | 68 |
| `GridView.builder` | `lib/screens/rooms_list_screen.dart` | 102 |
| `Stack` | `lib/screens/home_screen.dart` | 12 |
| `Card` | `lib/widgets/custom_room_card.dart` | 13 |
| `ClipRRect` | `lib/widgets/custom_room_card.dart` | 21 |
| `Form` | `lib/screens/add_room_screen.dart` | 65 |
| `DropdownButtonFormField` / `DropdownButton` | `add_room_screen.dart` / `rooms_list_screen.dart` | 118 / 72 |
| `InkWell` | `lib/widgets/custom_room_card.dart` | 16 |
| `TextField` | `lib/screens/rooms_list_screen.dart` | 57 |
| `TextFormField` | `lib/widgets/custom_input.dart` | 18 |
| `Image.asset` | `lib/screens/home_screen.dart` | 15 |
| `FloatingActionButton` | `lib/main.dart` | 43 |
| `LayoutBuilder` | `home_screen.dart` / `room_detail_screen.dart` | 20 / 26 |

### Au moins 3 widgets réutilisables dans `widgets/`

`CustomButton`, `CustomInput`, `CustomRoomCard` — chacun autonome, sans dépendance à un écran en particulier. `CustomRoomCard` par exemple sert à la fois dans `RoomsListScreen` et dans `HomeScreen`.

### Responsive : mobile et tablette

Les 4 écrans s'adaptent, avec le même seuil (600px) partout :

| Écran | Fichier | Ligne | Comment |
|---|---|---|---|
| `HomeScreen` | `home_screen.dart` | 20 | `LayoutBuilder` |
| `RoomsListScreen` | `rooms_list_screen.dart` | 38-39 | `MediaQuery`, grille 2 → 3 colonnes |
| `RoomDetailScreen` | `room_detail_screen.dart` | 26-28 | `LayoutBuilder`, empilé → côte à côte |
| `AddRoomScreen` | `add_room_screen.dart` | 59 | `MediaQuery`, champs empilés → en paires |

### Aucune donnée hardcodée dans les widgets

Tout passe par `lib/datas/room_repository.dart` :
```dart
static List<Room> getAll() => List.unmodifiable(_rooms);
static Room? getById(String id) { ... }
static void add(Room room) { ... }
```
Et `AddRoomScreen` ne fixe plus une image par défaut en dur — l'utilisateur la choisit dans un menu déroulant (`DropdownButtonFormField`, lignes 118-140 en tablette et 175-197 en mobile, puisque les deux mises en page ont chacune leur propre bloc), stockée dans `_selectedImage` (déclarée ligne 23, utilisée ligne 45).

---

## Architecture
```
lib/
├── datas/
│   └── room_repository.dart      # seule source de données (RoomRepository)
├── models/
│   ├── room.dart
│   └── room_status.dart
├── routes/
│   └── app_router.dart           # configuration GoRouter
├── screens/
│   ├── home_screen.dart
│   ├── rooms_list_screen.dart
│   ├── room_detail_screen.dart
│   └── add_room_screen.dart
├── utils/
│   └── room_filter.dart          # logique de recherche/filtrage, testée à part
├── widgets/
│   ├── custom_button.dart
│   ├── custom_input.dart
│   └── custom_room_card.dart
└── main.dart

test/
├── datas/
│   └── room_repository_test.dart
├── models/
│   └── room_test.dart
├── screens/
│   ├── rooms_list_screen_test.dart
│   └── add_room_screen_test.dart
└── utils/
    └── room_filter_test.dart
```

## Ce que je changerais si je continuais ce projet

- `RoomRepository` garde tout en mémoire, rien ne survit à un redémarrage. Passer par `Provider` ou `Riverpod`, et une vraie source de données (SQLite ou une API), serait la suite logique.
- Pas de CI/CD pour l'instant — pas demandé par l'énoncé, mais utile pour un vrai projet.