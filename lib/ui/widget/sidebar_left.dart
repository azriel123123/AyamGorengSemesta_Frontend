import 'package:flutter/material.dart';

/// Sidebar kiri aplikasi POS System.
/// 
/// Berfungsi sebagai panel navigasi utama:
/// - Menampilkan logo/nama brand.
/// - Menyediakan menu navigasi utama (home, item, history).
/// - Menampilkan informasi user yang sedang bertugas.
/// - Tombol logout di bagian bawah.
class SidebarLeft extends StatelessWidget {
  const SidebarLeft({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 32),

          /// Logo & nama brand restoran
          Column(
            children: const [
              Icon(Icons.public, size: 40, color: Colors.black),
              SizedBox(height: 8),
              Text(
                "AYAM GORENG",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "SEMESTA",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),

          const SizedBox(height: 32),

          /// Menu navigasi utama
          _menuItem(Icons.home, "Main menu"),
          _menuItem(Icons.inventory, "Item management"),
          _menuItem(Icons.history, "Order history"),

          const Spacer(),

          /// Informasi kasir yang sedang bertugas
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.black,
              child: Icon(Icons.person, color: Colors.white),
            ),
            title: const Text("Bratney Ashley"),
            subtitle: const Text("On Shift"),
          ),

          const SizedBox(height: 16),

          /// Tombol logout
          TextButton.icon(
            onPressed: () {
              // TODO: Tambahkan logika logout
            },
            icon: const Icon(Icons.logout, color: Colors.red),
            label: const Text("Logout", style: TextStyle(color: Colors.red)),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  /// Widget builder untuk item menu sidebar.
  /// 
  /// [icon] → ikon menu.  
  /// [title] → judul menu.  
  static Widget _menuItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(title),
      onTap: () {
        // TODO: Tambahkan navigasi sesuai [title]
      },
    );
  }
}
