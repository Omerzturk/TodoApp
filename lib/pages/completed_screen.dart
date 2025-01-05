import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  final Box _completedBox = Hive.box('completedBox');

  // Veri silme fonksiyonu
  Future<void> _deleteItem(int index) async {
    await _completedBox.deleteAt(index);
    setState(() {}); // UI'yı güncellemek için
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable:
          _completedBox.listenable(), // Hive kutusundaki değişiklikleri dinle
      builder: (context, box, widget) {
        if (box.isEmpty) {}

        final reversedItems = _completedBox.values.toList().reversed.toList();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _completedBox.length,
                itemBuilder: (_, index) {
                  final tersIndex = _completedBox.length - index - 1;
                  final currentItem = reversedItems[index];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(currentItem['time']),
                          Text(currentItem['date'])
                        ],
                      ),
                      title: Text(currentItem['title']),
                      subtitle: Text(currentItem['note']),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteItem(tersIndex),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
