# hotel_rooms

> **Projet Flutter — App multi-écrans avec navigation**
> Projet certifiant réalisé dans le cadre du *FlutterFire Summer Camp 2026*
> dans le but de valide ma maîtrise des widgets Flutter et de la navigation en construisant une app complète.

> Ce projet est validé avec un score ≥ 70/100 pour obtenir ta certification et débloquer les cours suivants.

## Fonctionnalités
- **4 écrans principaux**: Accueil, Liste de chambres, Détails d'une chambre, Formulaire d'ajout d'une chambre.
- **Navigation**: GoRouter avec passage de paramètre.
- **Liste avec option de recherche et filtrage**: Effectuer des recherches à l'aide de texte et filtrage via une liste déroulante.
- **Formulaire d'ajout d'une chambre avec validation**: champs obligatoire, validation de format numérique.
- **Thème mode**: Switcher en thème sombre et clair en un clic à l'aide d'un floatingActionButton
- **Adaptation responsible**: Grille de deux (2) chambres par ligne horizontale sur mobile et trois (3) sur tablettes.

## Critères Techniques validés
- **Widgets de base utilisés (x8+)** : `ListView`, `GridView`, `Stack`, `Card`, `ClipRRect`, `Form`, `DropdownButton`, `InkWell`, Etc. .
- **Architecture Propre** : Séparation stricte UI/Données (`lib/models`, `lib/data`, `lib/screens` & `test`).
- **Widgets Réutilisables (x3)** : `CustomButton`, `CustomInput`, `CustomRoomCard`.
- **Test**: Ajout de quatres (4) fichiers de tests, (`test/add_room_screen_test.dart`, `test/room_repository_test.dart`;`test/room_repository_test.dart` & `test/rooms_list_screen_test.dart`).

## Instructions de Lancement
1. **Cloner le dépôt** :
   ```bash
   git clone https://github.com/angekougo/hotel_rooms
   cd hotel_rooms
   ```
2. **Installer les dépendances** :
   ```bash
   flutter pub get
   ```
3. **Lancer l'application** :
   ```bash
   flutter run
   ```

