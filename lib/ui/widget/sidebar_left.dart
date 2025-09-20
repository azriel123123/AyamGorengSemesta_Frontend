import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_system/data/datasource/auth_local_datasource.dart';
import 'package:pos_system/ui/bloc/logout/logout_bloc.dart';

/// Sidebar kiri aplikasi POS System.
///
/// Berfungsi sebagai panel navigasi utama:
/// - Menampilkan logo/nama brand.
/// - Menyediakan menu navigasi utama (home, item, history).
/// - Menampilkan informasi user yang sedang bertugas.
/// - Tombol logout di bagian bawah (sudah pakai BLoC).
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

          /// Tombol logout dengan BlocConsumer
          BlocConsumer<LogoutBloc, LogoutState>(
            listener: (context, state) async {
              if (state is LogoutSuccess) {
                /// Hapus data auth
                await AuthLocalDatasource().removeAuthData();

                /// Kasih notif berhasil
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Logout berhasil!"),
                    backgroundColor: Colors.green,
                  ),
                );

                /// Navigasi ke login
                Navigator.pushReplacementNamed(context, "/login");
              }

              if (state is LogoutFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is LogoutLoading) {
                return const Padding(
                  padding: EdgeInsets.all(12),
                  child: CircularProgressIndicator(color: Colors.red),
                );
              }

              return TextButton.icon(
                onPressed: () {
                  context.read<LogoutBloc>().add(LogoutButtonPressed());
                },
                icon: const Icon(Icons.logout, color: Colors.red),
                label: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.red),
                ),
              );
            },
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
