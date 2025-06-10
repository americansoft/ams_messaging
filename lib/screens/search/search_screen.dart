import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Simulated search results
  final List<Map<String, String>> _allItems = [
    {'name': 'Ali', 'type': 'Contact'},
    {'name': 'Flutter Devs', 'type': 'Group'},
    {'name': 'Mona', 'type': 'Contact'},
    {'name': 'Design Team', 'type': 'Group'},
  ];

  List<Map<String, String>> _filteredItems = [];

  void _search(String query) {
    setState(() {
      _filteredItems = _allItems
          .where((item) => item['name']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _filteredItems = _allItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
          ),
          onChanged: _search,
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: _filteredItems.isEmpty
          ? const Center(child: Text('No results found'))
          : ListView.builder(
        itemCount: _filteredItems.length,
        itemBuilder: (context, index) {
          final item = _filteredItems[index];
          final isGroup = item['type'] == 'Group';

          return ListTile(
            leading: CircleAvatar(
              backgroundColor: isGroup ? Colors.indigo : Colors.deepPurple,
              child: Icon(
                isGroup ? Icons.group : Icons.person,
                color: Colors.white,
              ),
            ),
            title: Text(item['name']!),
            subtitle: Text(item['type']!),
            onTap: () {
              Navigator.pushNamed(context, isGroup ? '/group-info' : '/chat');
            },
          );
        },
      ),
    );
  }
}
