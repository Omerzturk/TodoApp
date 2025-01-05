import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/widgets/bottom_sheet_helper.dart';

class MissionScreen extends StatefulWidget {
  const MissionScreen({super.key});

  @override
  State<MissionScreen> createState() => _MissionScreenState();
}

class _MissionScreenState extends State<MissionScreen> {
  //görev kayıt kısmı
  final Box _missionBox = Hive.box('missionBox');
  final Box _completedBox = Hive.box('completedBox');

  List<bool> isCheckedList = [];

  //renk kısmı
  final List<Color> colors = [
    Colors.blue,
    Colors.red,
    Colors.orange,
    Colors.green
  ];

  @override
  void initState() {
    super.initState();
    _updateCheckedList();
  }

  //görev listesini güncelleme
  void _updateCheckedList() {
    isCheckedList = List.generate(_missionBox.length, (index) => false);
  }

  //görev silme
  Future<void> deleteItem(int index) async {
    await _missionBox.deleteAt(index);
    setState(() {});
  }

  //görevi tamamalandı olarak ayarlama
  Future<void> completedBoxAddItem(Map<String, dynamic> newItem) async {
    await _completedBox.add(newItem);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //görev listesinde veri varsa gösteriyoruz yoksa boş kalmasını sağlıyoruz
    return ValueListenableBuilder(
      valueListenable: _missionBox.listenable(),
      builder: (context, box, widget) {
        if (box.isEmpty) {}

        _updateCheckedList();
        final reversedItems = _missionBox.values.toList().reversed.toList();

        return ListView.builder(
          itemCount: _missionBox.length,
          itemBuilder: (_, index) {
            final tersIndex = _missionBox.length - index - 1;
            final currentItem = reversedItems[index];

            //görevleri gösteriyoruz
            return GestureDetector(
              onTap: () {
                //seçilen görev ile ilgili özelliklerin çıkmasını  sağlıyoruz
                showBottomSheetDialog(context, tersIndex, currentItem,
                    _missionBox, _completedBox);
              },
              child: Stack(
                children: [
                  Card(
                    color: currentItem["color"] == null
                        ? Theme.of(context).cardTheme.color
                        : colors[currentItem["color"]],
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(currentItem["title"],
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Row(
                            children: [
                              // Saat verisi kontrolü
                              if (currentItem["time"] != "") ...[
                                const Icon(Icons.access_time),
                                Text(currentItem["time"]),
                                const SizedBox(
                                  width: 20,
                                ),
                              ],
                              // Saat verisi kontrolü
                              if (currentItem["date"] != "") ...[
                                const Icon(Icons.calendar_today),
                                Text(currentItem["date"]),
                              ],
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(currentItem["note"]),
                        ],
                      ),
                    ),
                  ),
                  // Sağ üst köşe için kategori etiketi
                  if (currentItem["category"] != "") ...[
                    Positioned(
                      right: 10,
                      top: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          currentItem["category"] ?? "Kategori Yok",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                  ]
                ],
              ),
            );
          },
        );
      },
    );
  }
}
