import 'package:flutter/material.dart';

class SidebarPayment extends StatefulWidget {
  const SidebarPayment({super.key});

  @override
  State<SidebarPayment> createState() => _SidebarPaymentState();
}

class _SidebarPaymentState extends State<SidebarPayment> {
  String selectedTable = "Table 5";
  String customerName = "Jude gunawan";
  String selectedMethod = "Cash";

  final List<String> tables = ["Table 1", "Table 2", "Table 5", "Table 10"];
  final List<Map<String, dynamic>> paymentMethods = [
    {"icon": Icons.account_balance_wallet, "title": "E - Wallet"},
    {"icon": Icons.money, "title": "Cash"},
    {"icon": Icons.credit_card, "title": "Debit"},
  ];

  void _editCustomer() {
    final nameController = TextEditingController(text: customerName);
    String tempTable = selectedTable;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Customer & Table"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Customer Name",
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: tempTable,
                items: tables
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) {
                  tempTable = val!;
                },
                decoration: const InputDecoration(
                  labelText: "Select Table",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  customerName = nameController.text;
                  selectedTable = tempTable;
                });
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPaymentCard(String title, IconData icon) {
    final isSelected = selectedMethod == title;
    return GestureDetector(
      onTap: () {
        setState(() => selectedMethod = title);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon,
                color: isSelected ? Colors.black : Colors.white, size: 28),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
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
          // Header table & cust
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
                onPressed: _editCustomer,
                icon: const Icon(Icons.edit, color: Colors.white),
              ),
            ],
          ),
          Text(
            customerName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 30),

          // Payment methods
          ...paymentMethods.map((pm) => _buildPaymentCard(pm["title"], pm["icon"])),

          const Spacer(),

          // Continue button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // TODO: action lanjut payment
              },
              child: const Text("Continue Payment"),
            ),
          ),
        ],
      ),
    );
  }
}
