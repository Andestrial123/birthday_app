import 'package:admin/features/map_point_screen/presentation/coordinates_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MapPointScreenLayout extends StatefulWidget {
  const MapPointScreenLayout({super.key});

  @override
  _MapPointScreenLayoutState createState() => _MapPointScreenLayoutState();
}

class _MapPointScreenLayoutState extends State<MapPointScreenLayout> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _coordinateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _descriptionText = '';

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
    final regex = RegExp(r'^\d{2}\.\d{5},\s?\d{2}\.\d{5}$');
    if (!regex.hasMatch(value)) {
      return 'Please enter valid coordinates';
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _descriptionText = _descriptionController.text;
      });
      FocusScope.of(context).unfocus();
    }
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
                Text(
                  _descriptionText,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
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
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
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