import 'package:flutter/material.dart';
import 'package:pos_system/data/model/response/item_response_model.dart';
import 'package:pos_system/ui/widget/customize_modal.dart';

class ItemCard extends StatefulWidget {
  final Item item;
  const ItemCard({super.key, required this.item});

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  int quantity = 0;

  @override
  void initState() {
    super.initState();
    // Logging setiap item yang lagi ditampilkan
    print("🟢 Render item: ${widget.item.name} - Rp ${widget.item.price}");
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Gambar produk
          Expanded(
            flex: 7,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                widget.item.image, // backend ngirim url image
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (ctx, err, st) {
                  print("❌ Gagal load gambar untuk ${widget.item.name}");
                  return Container(
                    color: Colors.grey[200],
                    alignment: Alignment.center,
                    child: const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                  );
                },
              ),
            ),
          ),

          /// Info produk
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Rp ${widget.item.price}",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),

                  /// Bagian action
                  quantity == 0
                      ? SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          quantity = 1;
                        });
                        print("➕ ${widget.item.name} ditambahkan ke order (qty: $quantity)");
                      },
                      child: const Text(
                        "Add to order",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                      : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                if (quantity > 0) quantity--;
                              });
                              print("➖ ${widget.item.name} dikurangi (qty: $quantity)");
                            },
                            icon: const Icon(
                              Icons.remove_circle_outline,
                              size: 30,
                            ),
                          ),
                          Text(
                            "$quantity",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                              print("➕ ${widget.item.name} ditambah (qty: $quantity)");
                            },
                            icon: const Icon(
                              Icons.add_circle_outline,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.black,
                            side: const BorderSide(color: Colors.black),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          onPressed: () async {
                            final result = await showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              builder: (context) =>
                              const CustomizeOrderModal(),
                            );

                            if (result != null) {
                              print("⚡ Customize ${widget.item.name}: $result");
                            }
                          },
                          child: const Text("Customize"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
