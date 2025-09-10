import 'package:flutter/material.dart';

class SidebarRight extends StatefulWidget {
  const SidebarRight({super.key});

  @override
  State<SidebarRight> createState() => _SidebarRightState();
}

class _SidebarRightState extends State<SidebarRight> {
  String? _selectedTable = "Table 5";

  // Data pesanan disimpan di list biar qty bisa berubah
  List<Map<String, dynamic>> orders = [
    {
      "name": "Matcha infused green tea",
      "qty": 3,
      "price": 75000,
      "img": "asset/foto.JPG",
    },
    {"name": "Ayam goreng", "qty": 2, "price": 15000, "img": "asset/foto.JPG"},
    {"name": "Nasi putih", "qty": 2, "price": 10000, "img": "asset/foto.JPG"},
    {"name": "Dadar padang", "qty": 2, "price": 30000, "img": "asset/foto.JPG"},
  ];

  void _incrementQty(int index) {
    setState(() {
      orders[index]["qty"]++;
    });
  }

  void _decrementQty(int index) {
    setState(() {
      if (orders[index]["qty"] > 1) {
        orders[index]["qty"]--;
      } else {
        orders.removeAt(index); // hapus item kalo qty udah 0
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      color: Colors.black,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderSection(),
          const SizedBox(height: 35),
          _buildCustomerInput(),
          const SizedBox(height: 8),
          _buildTableDropdown(),
          const SizedBox(height: 30),
          _buildOrderList(),
          const Divider(color: Colors.black, height: 55),
          _buildPaymentButton(),
        ],
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Current Order",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 8),
        Text(
          "Monday 16 June 2026",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        SizedBox(height: 4),
        Text(
          "Cashier on duty: Bratney Ashley",
          style: TextStyle(color: Colors.white70, fontSize: 15),
        ),
      ],
    );
  }

  Widget _buildCustomerInput() {
    return const TextField(
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: "Customer name",
        hintStyle: TextStyle(color: Colors.white54),
        filled: true,
        fillColor: Colors.white12,
        border: OutlineInputBorder(borderSide: BorderSide.none),
        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      ),
    );
  }

  Widget _buildTableDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        underline: const SizedBox(),
        dropdownColor: Colors.black,
        style: const TextStyle(color: Colors.white),
        value: _selectedTable,
        items: const [
          "Table 1",
          "Table 2",
          "Table 5",
          "Table 10",
        ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: (val) {
          setState(() => _selectedTable = val);
        },
      ),
    );
  }

  Widget _buildOrderList() {
    return Expanded(
      child: orders.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.receipt_long, size: 60, color: Colors.white54),
                  SizedBox(height: 12),
                  Text(
                    "Belum ada pesanan",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final item = orders[index];
                return OrderItemCard(
                  name: item["name"],
                  qty: item["qty"],
                  price: item["price"],
                  imgPath: item["img"],
                  onIncrement: () => _incrementQty(index),
                  onDecrement: () => _decrementQty(index),
                );
              },
            ),
    );
  }

  Widget _buildPaymentButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        onPressed: () {
          // TODO: navigate ke payment
        },
        child: const Text("Continue to Payment"),
      ),
    );
  }
}

class OrderItemCard extends StatelessWidget {
  final String name;
  final int qty;
  final int price;
  final String imgPath;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const OrderItemCard({
    super.key,
    required this.name,
    required this.qty,
    required this.price,
    required this.imgPath,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(
              imgPath,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
                Text(
                  "Rp $price",
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: onDecrement,
                icon: const Icon(
                  Icons.remove_circle,
                  color: Colors.red,
                  size: 20,
                ),
              ),
              Text(
                "$qty",
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
              IconButton(
                onPressed: onIncrement,
                icon: const Icon(
                  Icons.add_circle,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
