import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/pages/add_new_task_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/pages/completed_screen.dart';
import 'package:todo_app/pages/mission_screen.dart';
import 'package:todo_app/theme/theme_notifier.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final Box _missionBox = Hive.box('missionBox');
  late TabController _tabController;

  // Veri silme fonksiyonu
  Future<void> deleteItem(int index) async {
    await _missionBox.deleteAt(index);
    setState(() {}); // UI'yı güncellemek için
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        centerTitle: true,
        title: const Text("Görev Listesi"),
        leading: IconButton(
          icon: Icon(
            themeNotifier.isDarkTheme ? Icons.light_mode : Icons.dark_mode,
          ),
          onPressed: () {
            themeNotifier.toggleTheme(); // Tema durumunu değiştir.
          },
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Text("Yapılacaklar"),
            Text("Tamamlananlar"),
          ],
          labelColor: Colors.white, // Aktif sekme rengi
          unselectedLabelColor: Theme.of(context).secondaryHeaderColor,
          indicatorColor: Colors.white, // Alt çizginin rengini ayarlar
        ),
      ),
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddNewTaskScreen()),
            );
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          MissionScreen(),
          CompletedScreen(),
        ],
      ),
    );
  }
}
