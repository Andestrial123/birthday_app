import 'package:admin/features/main_screen/domain/main_cubit.dart';
import 'package:admin/features/map_point_screen/presentation/coordinates_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/models/base_model.dart';
import 'package:shared/models/map_model/map_model.dart';

class MapPointScreenLayout extends StatefulWidget {
  const MapPointScreenLayout({super.key});

  @override
  MapPointScreenLayoutState createState() => MapPointScreenLayoutState();
}

class MapPointScreenLayoutState extends State<MapPointScreenLayout> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _coordinateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _coordinateController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String? _validateCoordinates(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter coordinates';
    }
    final regex = RegExp(r'^\d{2}\.\d{6},\s?\d{2}\.\d{6}$');
    if (!regex.hasMatch(value)) {
      return 'Please enter valid coordinates';
    }
    return null;
  }

  void _submitForm() {
    context.read<MainCubit>().sendMapEvent(BaseModel(
        challengeType: ChallengeType.mapSearching,
        data: MapModel(
            title: _descriptionController.text,
            coords: _coordinateController.text).toJson()));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Point Screen Layout'),
      ),
      body: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                TextFormField(
                  controller: _coordinateController,
                  decoration: InputDecoration(
                    labelText: 'Coordinates',
                    hintText: 'Enter coordinates',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.,\s]')),
                    CoordinatesInputFormatter(),
                  ],
                  validator: _validateCoordinates,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    hintText: 'Enter description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
