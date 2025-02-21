import 'package:flutter/material.dart';

class MedicalPage extends StatefulWidget {
  const MedicalPage({super.key});

  @override
  _MedicalPageState createState() => _MedicalPageState();
}

class _MedicalPageState extends State<MedicalPage> {
  List<Map<String, String>> medications = [
    {'name': 'Paracetamol', 'instructions': 'Take 1 tablet after breakfast'},
    {'name': 'Vitamin C', 'instructions': 'Take 1 tablet in the afternoon'},
    {'name': 'Ibuprofen', 'instructions': 'Take 1 tablet after dinner'},
  ];

  void _addMedication(String name, String instructions) {
    if (name.isNotEmpty && instructions.isNotEmpty) {
      setState(() {
        medications.add({'name': name, 'instructions': instructions});
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$name added successfully!')),
      );
    }
  }

  void _removeMedication(int index) {
    String removedMed = medications[index]['name']!;
    setState(() {
      medications.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$removedMed removed!')),
    );
  }

  void _showAddMedicationDialog() {
    TextEditingController nameController = TextEditingController();
    TextEditingController instructionsController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text('Add Medication', style: TextStyle(fontWeight: FontWeight.bold)),
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
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              onPressed: () {
                _addMedication(nameController.text, instructionsController.text);
                Navigator.of(context).pop();
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
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Medication',
            style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Icon(Icons.favorite_border, color: Colors.red),
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
              "Today's Medications",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: medications.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      _removeMedication(index);
                    },
                    background: Container(
                      decoration: BoxDecoration(
                        color: Colors.red[300],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20),
                      margin: EdgeInsets.symmetric(vertical: 5),
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
