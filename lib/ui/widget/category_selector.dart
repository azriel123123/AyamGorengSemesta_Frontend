import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      "Cakes & sweets",
      "Coffee & tea",
      "Lunch pack",
      "Salads",
      "Lunch pack",
      
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Welcome back 👋",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Text("Be ready to give our best service!"),
          const SizedBox(height: 16),
          // Categories
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categories
                  .map(
                    (c) => Container(
                      margin: const EdgeInsets.only(right: 12),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: c == "Coffee & tea"
                              ? Colors.black
                              : Colors.white,
                          foregroundColor: c == "Coffee & tea"
                              ? Colors.white
                              : Colors.black,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                              color: c == "Coffee & tea"
                                  ? Colors.black
                                  : Colors.grey.shade300,
                            ),
                          ),
                        ),
                        onPressed: () {},
                        icon: const Icon(Icons.fastfood),
                        label: Text(c),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 12),
          // Dropdown + Search
          Row(
            children: [
              Expanded(
                flex: 2,
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  value: "Matcha",
                  items: ["Matcha", "Chocolate", "Vanilla"]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (val) {},
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 3,
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: "Search menu",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
