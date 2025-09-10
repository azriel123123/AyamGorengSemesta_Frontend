import 'package:flutter/material.dart';

class OrderItem extends StatelessWidget {
  final String name;
  final int qty;
  final int price;
  final String img;

  const OrderItem({
    super.key,
    required this.name,
    required this.qty,
    required this.price,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(img, width: 40, height: 40, fit: BoxFit.cover),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(color: Colors.white)),
                Text("Rp $price",
                    style:
                        const TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.remove_circle,
                    color: Colors.red, size: 18),
              ),
              Text("$qty", style: const TextStyle(color: Colors.white)),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add_circle,
                    color: Colors.white, size: 18),
              ),
            ],
          )
        ],
      ),
    );
  }
}
