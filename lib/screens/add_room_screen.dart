import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_rooms/widgets/custom_button.dart';
import 'package:hotel_rooms/widgets/custom_input.dart';

class AddRoomScreen extends StatefulWidget {
  const AddRoomScreen({super.key});

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends State<AddRoomScreen> {
  final _formKey = GlobalKey<FormState>();
  final _roomNameController = TextEditingController();
  final _roomTypeController = TextEditingController();
  final _roomPriceController = TextEditingController();
  final _roomNumberController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _roomNameController.dispose();
    _roomPriceController.dispose();
    _roomNumberController.dispose();
    _roomTypeController.dispose();
  }

  void _submitData() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Chambre ajoutée avec succès !')),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Scaffold(
        appBar: AppBar(title: const Text('Ajouter une Chambre')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                if (isTablet) ...[
                  Row(
                    children: [
                      Expanded(
                          child: CustomInput(
                        controller: _roomNameController,
                        label: 'Nom de la chambre',
                        validator: (value) =>
                            value!.isEmpty ? 'Nom obligatoire' : null,
                      )),
                      const SizedBox(width: 16),
                      Expanded(
                          child: CustomInput(
                            controller: _roomTypeController,
                        label: 'Type de chambre',
                        validator: (value) => value!.isEmpty
                            ? 'Type de chambre obligatoire'
                            : null,
                      ))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: CustomInput(
                            controller: _roomPriceController,
                            keyboardType: TextInputType.number,
                              label: 'Prix par nuit',
                              validator: (value) {
                                if (value!.isEmpty) return 'Prix obligatoire';
                                if (int.tryParse(value) == null) return 'Entrer un nombre';
                                return null;
                              })),
                      const SizedBox(width: 16),
                      Expanded(
                          child: CustomInput(
                            controller: _roomNumberController,
                            keyboardType: TextInputType.number,
                        label: 'Numéro de chambre',
                        validator: (value) => value!.isEmpty
                            ? 'Type de chambre obligatoire'
                            : null,
                      ))
                    ],
                  ),
                ] else ...[
                  CustomInput(
                    controller: _roomNameController,
                    label: 'Nom de la chambre',
                    validator: (value) =>
                        value!.isEmpty ? 'Nom obligatoire' : null,
                  ),
                  const SizedBox(height: 16),
                  CustomInput(
                    controller: _roomTypeController,
                    label: 'Type de chambre',
                    validator: (value) =>
                        value!.isEmpty ? 'Nom obligatoire' : null,
                  ),
                  const SizedBox(height: 16),
                  CustomInput(
                    controller: _roomPriceController,
                    label: 'Prix par nuit',
                    validator: (value) {
                      if (value!.isEmpty) return 'Prix obligatoire';
                      if (int.tryParse(value) == null) return 'Entrer un nombre';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomInput(
                    controller: _roomNumberController,
                    label: 'Numéro de chambre',
                    validator: (value) =>
                        value!.isEmpty ? 'Nom obligatoire' : null,
                  ),
                ],
                const SizedBox(height: 24),
                CustomButton(
                    text: 'Enregister',
                    onPressed: () {
                      _submitData();
                    })
              ],
            ),
          ),
        ));
  }
}
