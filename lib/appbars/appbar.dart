import 'package:flutter/material.dart';

class MedicalPage extends StatefulWidget {
  const MedicalPage({super.key});

  @override
  _MedicalPageState createState() => _MedicalPageState();
}

class _MedicalPageState extends State<MedicalPage> {
  int _selectedIndex = 1;
  List<Map<String, String>> medications = [
    {'name': 'Paracetamol', 'instructions': 'Take 1 tablet after breakfast'},
    {'name': 'Vitamin C', 'instructions': 'Take 1 tablet in the afternoon'},
    {'name': 'Ibuprofen', 'instructions': 'Take 1 tablet after dinner'},
    {'name': 'Ibuprofen', 'instructions': 'Take 1 tablet after dinner'},
    {'name': 'Ibuprofen', 'instructions': 'Take 1 tablet after dinner'},
    {'name': 'Ibuprofen', 'instructions': 'Take 1 tablet after dinner'},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addMedication(String name, String instructions) {
    setState(() {
      medications.add({'name': name, 'instructions': instructions});
    });
  }

  void _removeMedication(int index) {
    setState(() {
      medications.removeAt(index);
    });
  }

  void _showAddMedicationDialog() {
    TextEditingController nameController = TextEditingController();
    TextEditingController instructionsController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Medication'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Medication Name'),
              ),
              TextField(
                controller: instructionsController,
                decoration: InputDecoration(labelText: 'Instructions'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    instructionsController.text.isNotEmpty) {
                  _addMedication(
                      nameController.text, instructionsController.text);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: Text('Medication',
            style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold)),
        leading: Icon(Icons.arrow_back_ios, color: Colors.black),
        actions: [
          Icon(Icons.heart_broken, color: Colors.red),
          SizedBox(width: 10),
          Icon(Icons.medical_services, color: Colors.green),
          SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today’s Medications',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: medications.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(medications[index]['name']!),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      _removeMedication(index);
                    },
                    background: Container(
                      decoration: BoxDecoration(
                        color: Colors.red[300],
                        borderRadius: BorderRadius.circular(15), // Add border radius
                      ),
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20),
                      margin: EdgeInsets.symmetric(vertical: 5), // Add margin for better spacing
                      child: Icon(Icons.delete, color: Colors.white, size: 30),
                    ),
                    child: medicationCard(
                      medications[index]['name']!,
                      medications[index]['instructions']!,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddMedicationDialog,
        backgroundColor: Colors.greenAccent[700],
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget medicationCard(String title, String subtitle) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: ListTile(
        leading: Icon(Icons.medical_services, color: Colors.green, size: 35),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.check_circle, color: Colors.green, size: 30),
      ),
    );
  }
}
