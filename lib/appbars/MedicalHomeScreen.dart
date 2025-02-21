import 'package:flutter/material.dart';

class MedicalHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Medical App',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications, color: Colors.white),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome Back! 👋',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'How can we assist you today?',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 20),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: medicalOptions.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.1,
              ),
              itemBuilder: (context, index) {
                return _buildMedicalOption(
                  icon: medicalOptions[index]['icon'],
                  title: medicalOptions[index]['title'],
                  context: context,
                  items: medicalOptions[index]['items'] ?? [], // ✅ Fix: Ensure items is never null
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicalOption({
    required IconData icon,
    required String title,
    required BuildContext context,
    required List<String> items,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemListScreen(title: title, items: items),
          ),
        );
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: const LinearGradient(
              colors: [Colors.greenAccent, Colors.green],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: Colors.white),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemListScreen extends StatelessWidget {
  final String title;
  final List<String> items;

  const ItemListScreen({required this.title, required this.items, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.green,
      ),
      body: items.isEmpty
          ? const Center(
        child: Text("No items available", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              title: Text(items[index], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              leading: const Icon(Icons.medical_services, color: Colors.green),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${items[index]} selected')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// Medical options with lists
final List<Map<String, dynamic>> medicalOptions = [
  {"icon": Icons.local_hospital, "title": "Doctors", "items": ["Dr. John Doe", "Dr. Sarah Smith", "Dr. Emily Johnson"]},
  {"icon": Icons.calendar_today, "title": "Appointments", "items": ["Dentist - 10 AM", "Physician - 2 PM", "Eye Checkup - 5 PM"]},
  {"icon": Icons.receipt_long, "title": "Reports", "items": ["Blood Test", "MRI Scan", "X-Ray"]},
  {"icon": Icons.medication, "title": "Medicines", "items": ["Paracetamol", "Ibuprofen", "Vitamin C"]},
  {"icon": Icons.health_and_safety, "title": "Health Tips", "items": ["Drink Water", "Exercise Daily", "Eat Healthy"]},
  {"icon": Icons.support, "title": "Emergency Help", "items": ["Call 911", "Find Nearby Hospital", "First Aid Guide"]},
];
