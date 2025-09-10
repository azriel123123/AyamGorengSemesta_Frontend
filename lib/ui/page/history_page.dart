import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pos_system/ui/widget/history_card.dart';
import '../widget/sidebar_left.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  final TextEditingController _tanggalController = TextEditingController();

  @override
  void dispose() {
    _tanggalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const SidebarLeft(),

          // Konten kanan
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header atas
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome back 👋",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text("Be ready to give our best service!"),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            "Order history",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            DateFormat("dd MMM yyyy").format(DateTime.now()),
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Tombol filter + kolom tanggal
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 150,
                        child: TextField(
                          controller: _tanggalController,
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: "dd/MM/yyyy",
                            suffixIcon: const Icon(
                              Icons.calendar_today,
                              size: 18,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                          ),
                          onTap: () async {
                            DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null) {
                              setState(() {
                                _tanggalController.text = DateFormat(
                                  'dd/MM/yyyy',
                                ).format(picked);
                              });
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton.icon(
                        onPressed: () {
                          debugPrint("Filter by: ${_tanggalController.text}");
                        },
                        icon: const Icon(Icons.filter_list),
                        label: const Text("Filter"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown[700],
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // List order (grid horizontal)
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        OrderCard(
                          meja: "Table 18",
                          customer: "Vinicius saputra",
                          waktu: "3:00 P.M.",
                          items: [
                            {
                              "qty": 3,
                              "nama": "Matcha infused green tea",
                              "harga": 75000,
                            },
                          ],
                          subtotal: 500000,
                          pajak: 50000,
                        ),
                        OrderCard(
                          meja: "Table 18",
                          customer: "Vinicius saputra",
                          waktu: "3:00 P.M.",
                          items: [
                            {
                              "qty": 3,
                              "nama": "Matcha infused green tea",
                              "harga": 75000,
                            },
                          ],
                          subtotal: 500000,
                          pajak: 50000,
                        ),
                        OrderCard(
                          meja: "Table 18",
                          customer: "Vinicius saputra",
                          waktu: "3:00 P.M.",
                          items: [
                            {
                              "qty": 3,
                              "nama": "Matcha infused green tea",
                              "harga": 75000,
                            },
                          ],
                          subtotal: 500000,
                          pajak: 50000,
                        ),
                        OrderCard(
                          meja: "Table 18",
                          customer: "Vinicius saputra",
                          waktu: "3:00 P.M.",
                          items: [
                            {
                              "qty": 3,
                              "nama": "Matcha infused green tea",
                              "harga": 75000,
                            },
                          ],
                          subtotal: 500000,
                          pajak: 50000,
                        ),
                      ],
                    ),
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
