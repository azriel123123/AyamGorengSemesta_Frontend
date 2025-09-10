import 'package:flutter/material.dart';
import 'package:pos_system/model/product.dart';
import 'package:pos_system/ui/widget/category_selector.dart';
import 'package:pos_system/ui/widget/product_card.dart';
import 'package:pos_system/ui/widget/sidebar_left.dart';
import 'package:pos_system/ui/widget/sidebar_right.dart';
import 'package:pos_system/ui/widget/sidebar_right_2.dart';
import 'package:pos_system/ui/widget/sidebar_right_3.dart';
import 'package:pos_system/ui/widget/customize_modal.dart';


/// Halaman utama aplikasi POS System.
///
/// Menampilkan struktur utama dengan 3 bagian:
/// - [SidebarLeft]: Navigasi kategori atau menu tambahan.
/// - Konten tengah: berisi daftar produk dalam bentuk grid.
/// - [SidebarRight]: Informasi pesanan saat ini.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    /// Dummy list produk untuk ditampilkan di grid.
    final List<Product> produkList = [
      Product(
        name: "Matcha Green Tea Latte",
        price: 35000,
        imageUrl: "asset/foto2.jpeg",
      ),
      Product(
        name: "Matcha infused green tea",
        price: 25000,
        imageUrl: "asset/foto2.jpeg",
      ),
      Product(
        name: "Matcha infused green tea",
        price: 25000,
        imageUrl: "asset/foto2.jpeg",
      ),
    ];

    return Scaffold(
      // Mencegah UI ketarik ke atas saat keyboard muncul
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Row(
          children: [
            /// Sidebar kiri untuk navigasi
            const SidebarLeft(),

            /// Konten utama (daftar kategori & produk)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Selector kategori
                  const CategorySelector(),
                  const SizedBox(height: 12),

                  /// Grid produk
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        /// Menghitung jumlah kolom grid
                        int crossAxisCount = constraints.maxWidth ~/ 250;
                        if (crossAxisCount < 1) crossAxisCount = 1;

                        return GridView.builder(
                          padding: const EdgeInsets.all(16),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16,
                                childAspectRatio: 0.7,
                              ),
                          itemCount: produkList.length,
                          itemBuilder: (context, index) {
                            return ProductCard(product: produkList[index]);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            /// Sidebar kanan untuk pesanan aktif
            const SidebarOrderDetail(),
          ],
        ),
      ),
    );
  }
}
