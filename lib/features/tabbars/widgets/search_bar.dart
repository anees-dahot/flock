import 'package:flutter/material.dart';

import '../../search/screens/search_screen.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.89,
      height: size.height * 0.05,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(SearchScreen.routeName, arguments: true);
              },
              child: Container(
                width: size.width * 0.80,
                height: size.height * 0.05,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(Icons.search, color: Colors.grey),
                    ),
                    Text(
                      'Search',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.message))
        ],
      ),
    );
  }
}
