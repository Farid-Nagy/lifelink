import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  // بيانات تجريبية
  int usersCount = 720; // عدد المستخدمين
  int hospitalsCount = 90; // عدد المستشفيات
  int bagsAvailable = 450; // المخزون
  int bagsReserved = 320; // المحجوز
  int bagsToDeliver = 100; // سيتم التوصيل
  int bagsDelivered = 280; // تم التوصيل

  void _navigateAndCloseDialog(BuildContext context, String routeName) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
    Navigator.of(context).pushNamed(routeName);
  }

  Widget _buildDashboardCard(
    String title,
    int count,
    IconData icon,
    Color color,
  ) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 16),
            Text(
              "$count",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("   Admin Home   "),
        backgroundColor: const Color(0xFF00A7B3),
        iconTheme: IconThemeData(color: Colors.white),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu_open, color: Colors.white, size: 30),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        titleTextStyle: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: "Cairo",
        ),
      ),

      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF00A7B3)),
              accountName: const Text("Admin"),
              accountEmail: const Text("admin@lifelink.com"),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.admin_panel_settings,
                  color: Colors.black,
                  size: 40,
                ),
              ),
            ),

            //ListTile(
            // leading: const Icon(Icons.dashboard),
            // title: const Text("Dashboard"),
            // onTap: () {
            //  Navigator.pop(context);
            //},
            //),
            ListTile(
              leading: const Icon(Icons.inventory),
              title: const Text("Blood Inventory"),
              onTap: () {
                _navigateAndCloseDialog(context, "bloodInventoryAdmin");
              },
            ),

            ListTile(
              leading: const Icon(Icons.people),
              title: const Text("Users"),
              onTap: () {},
            ),

            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text("Reports"),
              onTap: () {},
            ),

            const Spacer(),
            const Divider(),

            ListTile(
              leading: const Icon(Icons.logout, color: Color(0xFF00A7B3)),
              title: const Text("Logout"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildDashboardCard(
              "Users",
              usersCount,
              Icons.people,
              Colors.orange,
            ),
            _buildDashboardCard(
              "Hospitals",
              hospitalsCount,
              Icons.local_hospital,
              Colors.red,
            ),
            _buildDashboardCard(
              "Available",
              bagsAvailable,
              Icons.inventory,
              Colors.blue,
            ),
            _buildDashboardCard(
              "Reserved",
              bagsReserved,
              Icons.pending_actions,
              Colors.green,
            ),
            _buildDashboardCard(
              "To Deliver",
              bagsToDeliver,
              Icons.local_shipping,
              Colors.amber,
            ), // عربية توصيل
            _buildDashboardCard(
              "Delivered",
              bagsDelivered,
              Icons.check_circle,
              Colors.purple,
            ),
          ],
        ),
      ),
    );
  }
}
