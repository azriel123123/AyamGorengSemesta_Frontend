import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_system/ui/widget/category_selector.dart';
import 'package:pos_system/ui/widget/product_card.dart';
import 'package:pos_system/ui/widget/sidebar_left.dart';
import 'package:pos_system/ui/widget/sidebar_right_3.dart';
import 'package:pos_system/ui/bloc/item/item_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Row(
          children: [
            /// Sidebar kiri
            const SidebarLeft(),

            /// Konten utama
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Selector kategori (optional)
                  const CategorySelector(),
                  const SizedBox(height: 12),

                  /// Grid item dari API
                  Expanded(
                    child: BlocBuilder<ItemBloc, ItemState>(
                      builder: (context, state) {
                        if (state is ItemLoading) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (state is ItemFailure) {
                          return Center(child: Text("Error: ${state.message}"));
                        } else if (state is ItemSuccess) {
                          final items = state.items;
                          if (items.isEmpty) {
                            return const Center(child: Text("No items available"));
                          }

                          return LayoutBuilder(
                            builder: (context, constraints) {
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
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  return ItemCard(item: items[index]);
                                },
                              );
                            },
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                ],
              ),
            ),

            /// Sidebar kanan
            const SidebarOrderDetail(),
          ],
        ),
      ),
    );
  }
}
