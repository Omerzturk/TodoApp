import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/pages/add_new_task_screen.dart';

void showBottomSheetDialog(BuildContext context, int index, Map currentItem,
    Box missionBox, Box completedBox) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Tamamlandı'),
              onTap: () {
                completedBox.add({
                  "title": currentItem["title"],
                  "note": currentItem["note"],
                  "desc": currentItem["desc"],
                  "date": currentItem["date"],
                  "time": currentItem["time"],
                });
                missionBox.deleteAt(index);
                Navigator.pop(context); // Kapat
              },
            ),
            ListTile(
              title: const Text('Düzenle'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddNewTaskScreen(
                      index: index,
                      item: currentItem,
                    ),
                  ),
                ).then((_) {
                  // Düzenleme ekranından dönüldüğünde bottomsheet'i kapat
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              title: const Text('Sil'),
              onTap: () {
                missionBox.deleteAt(index);
                Navigator.pop(context); // Kapat
              },
            ),
            ListTile(
              title: const Text('Kapat'),
              onTap: () {
                Navigator.pop(context); // Kapat
              },
            ),
          ],
        ),
      );
    },
  );
}
