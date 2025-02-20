import 'package:flutter/material.dart';
import 'appbars/appbar.dart'; // Import your custom app bar

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medical App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomeScreen(), // Set HomeScreen as the main screen
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Default to the "Home" tab

  // List of screens for each bottom navigation item
  final List<Widget> _pages = [
    MedicalHomeScreen(), // Medical-related Home UI
    MedicalPage(), // Medications Page
    UserProfileScreen(), // Profile Page
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Display selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            label: 'Medical Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services),
            label: 'Medications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// -------------------- Medical Home Screen --------------------
class MedicalHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Medical App', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          Icon(Icons.notifications, color: Colors.white),
          SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome Back!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('How can we help you today?', style: TextStyle(fontSize: 16, color: Colors.black54)),
            SizedBox(height: 20),

            // Medical Services Grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  _buildMedicalOption(Icons.local_hospital, "Doctors"),
                  _buildMedicalOption(Icons.calendar_today, "Appointments"),
                  _buildMedicalOption(Icons.receipt_long, "Reports"),
                  _buildMedicalOption(Icons.medication, "Medicines"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicalOption(IconData icon, String title) {
    return GestureDetector(
      onTap: () {
        print('$title Clicked');
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.green),
            SizedBox(height: 10),
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

// -------------------- Profile Screen --------------------
class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Profile', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile.png'), // Change to a valid image
            ),
            SizedBox(height: 10),

            // User Info
            Text('John Doe', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text('johndoe@example.com', style: TextStyle(fontSize: 16, color: Colors.grey)),

            SizedBox(height: 20),

            _buildProfileItem(Icons.phone, 'Phone', '+123 456 7890'),
            _buildProfileItem(Icons.cake, 'Age', '28'),
            _buildProfileItem(Icons.location_city, 'City', 'New York, USA'),

            SizedBox(height: 20),

            // Edit Profile Button
            ElevatedButton.icon(
              onPressed: () {
                print('Edit Profile Clicked');
              },
              icon: Icon(Icons.edit),
              label: Text('Edit Profile'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),

            SizedBox(height: 20),

            // Logout Button
            ElevatedButton.icon(
              onPressed: () {
                print('Logout Clicked');
              },
              icon: Icon(Icons.logout),
              label: Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String label, String value) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.green, size: 30),
        title: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value),
      ),
    );
  }
}
