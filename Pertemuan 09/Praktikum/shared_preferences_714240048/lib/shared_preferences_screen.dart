import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesScreen extends StatefulWidget {
  const SharedPreferencesScreen({super.key});

  @override
  State<SharedPreferencesScreen> createState() =>
      _SharedPreferencesScreenState();
}

class _SharedPreferencesScreenState extends State<SharedPreferencesScreen> {
  final TextEditingController _saveController = TextEditingController();
  final TextEditingController _getController = TextEditingController();

  @override
  void dispose() {
    _saveController.dispose();
    _getController.dispose();
    super.dispose();
  }

  Future<void> _saveValue() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('sp_value', _saveController.text);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data berhasil disimpan!')),
    );
  }

  Future<void> _getValue() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _getController.text = prefs.getString('sp_value') ?? 'null';
    });
  }

  Future<void> _deleteValue() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('sp_value');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data berhasil dihapus!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared Preferences'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Save Data to SharedPreferences',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _saveController,
                decoration: const InputDecoration(
                  hintText: 'Masukkan data...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  fillColor: Color.fromARGB(255, 242, 254, 255),
                  filled: true,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _saveValue,
                child: const Text('Save'),
              ),
              const SizedBox(height: 30),
              const Text(
                'Read Data from SharedPreferences',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _getController,
                readOnly: true,
                decoration: const InputDecoration(
                  hintText: 'Hasil akan tampil di sini...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  fillColor: Color.fromARGB(255, 242, 254, 255),
                  filled: true,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _getValue,
                child: const Text('Get Value'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _deleteValue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text('Delete Value'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
