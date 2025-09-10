import 'package:flutter/material.dart';

class CustomizeOrderModal extends StatefulWidget {
  const CustomizeOrderModal({super.key});

  @override
  State<CustomizeOrderModal> createState() => _CustomizeOrderModalState();
}

class _CustomizeOrderModalState extends State<CustomizeOrderModal> {
  String size = "L";
  String sugar = "Normal";
  List<String> topping = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(width: 8),
              const Text(
                "Customize order",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Size
          const Text("Size"),
          Wrap(
            spacing: 10,
            children: ["XL", "L", "M", "S"].map((s) {
              final selected = size == s;
              return ChoiceChip(
                label: Text(s),
                selected: selected,
                onSelected: (_) {
                  setState(() => size = s);
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 16),

          // Topping
          const Text("Topping (Rp 5000)"),
          Wrap(
            spacing: 10,
            children: ["Pearl", "Jelly", "Red beans"].map((t) {
              final selected = topping.contains(t);
              return FilterChip(
                label: Text(t),
                selected: selected,
                onSelected: (value) {
                  setState(() {
                    if (selected) {
                      topping.remove(t);
                    } else {
                      topping.add(t);
                    }
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 16),

          // Sugar
          const Text("Sugar"),
          Wrap(
            spacing: 10,
            children: ["Low sugar", "Normal", "Xtra sugar"].map((s) {
              final selected = sugar == s;
              return ChoiceChip(
                label: Text(s),
                selected: selected,
                onSelected: (_) {
                  setState(() => sugar = s);
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 20),

          // Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  "size": size,
                  "sugar": sugar,
                  "topping": topping,
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
              child: const Text("Continue"),
            ),
          ),
        ],
      ),
    );
  }
}
