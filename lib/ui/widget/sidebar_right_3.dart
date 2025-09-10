import 'package:flutter/material.dart';

class SidebarOrderDetail extends StatefulWidget {
  const SidebarOrderDetail({super.key});

  @override
  State<SidebarOrderDetail> createState() => _SidebarOrderDetailState();
}

class _SidebarOrderDetailState extends State<SidebarOrderDetail> {
  String selectedTable = "Table 5";
  String customerName = "Jude gunawan";

  List<Map<String, dynamic>> orders = [
    {
      "name": "Matcha infused",
      "price": 75000,
      "qty": 3,
      "image":
          "https://i.pinimg.com/736x/2d/3a/cb/2d3acbd37ec7a95ad9384813252b44ef.jpg",
    },
    {
      "name": "Ayam goreng",
      "price": 15000,
      "qty": 2,
      "image":
          "https://i.pinimg.com/736x/2d/3a/cb/2d3acbd37ec7a95ad9384813252b44ef.jpg",
    },
    {
      "name": "Nasi putih",
      "price": 10000,
      "qty": 2,
      "image":
          "https://i.pinimg.com/736x/2d/3a/cb/2d3acbd37ec7a95ad9384813252b44ef.jpg",
    },
    {
      "name": "Dadar padang",
      "price": 10000,
      "qty": 2,
      "image":
          "https://i.pinimg.com/736x/2d/3a/cb/2d3acbd37ec7a95ad9384813252b44ef.jpg",
    },
  ];

  void _increaseQty(int index) {
    setState(() {
      orders[index]["qty"]++;
    });
  }

  void _decreaseQty(int index) {
    setState(() {
      if (orders[index]["qty"] > 1) {
        orders[index]["qty"]--;
      }
    });
  }

  void _removeOrder(int index) {
    setState(() {
      orders.removeAt(index);
    });
  }

  int get subtotal {
    return orders.fold(
      0,
      (sum, item) => sum + (item["price"] as int) * (item["qty"] as int),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tax = (subtotal * 0.1).toInt();
    final total = subtotal + tax;

    return Container(
      width: 320,
      color: Colors.black,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Expanded(
                child: Text(
                  selectedTable,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit, color: Colors.white),
              ),
            ],
          ),
          Text(
            customerName,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 20),

          const Text(
            "Detail order",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          // List order
          Expanded(
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final item = orders[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          item["image"],
                          width: 55,
                          height: 55,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item["name"],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "${item["qty"]}x",
                              style: const TextStyle(color: Colors.white70),
                            ),
                            Text(
                              "Rp ${item["price"].toString()}",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              minimumSize: const Size(70, 28),
                            ),
                            onPressed: () => _removeOrder(index),
                            child: const Text("Remove", style: TextStyle(color: Colors.white),),
                          ),
                          
                          Row(
                            children: [
                              IconButton(
                                onPressed: () => _decreaseQty(index),
                                icon: const Icon(
                                  Icons.remove_circle,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                onPressed: () => _increaseQty(index),
                                icon: const Icon(
                                  Icons.add_circle,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          const Divider(color: Colors.white54),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Subtotal",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              Text(
                "Rp $subtotal",
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Tax 10%",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              Text(
                "Rp $tax",
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
          const Divider(color: Colors.white54, thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Rp $total",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Button print + complete
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white),
                foregroundColor: Colors.white,
              ),
              onPressed: () {},
              icon: const Icon(Icons.receipt_long),
              label: const Text("Print Receipt"),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
              onPressed: () {},
              child: const Text("Complete Payment"),
            ),
          ),
        ],
      ),
    );
  }
}
