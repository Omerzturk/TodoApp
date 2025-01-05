import 'package:flutter/material.dart';
import 'package:todo_app/widgets/form_items.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({
    super.key,
    this.index,
    this.item,
  });
  final int? index;
  final dynamic item;

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  //form için controller kısmı
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  int _result = 0;

  //category kısmı
  String? _selectedCategory;
  final List<String> _categories = [
    'İş',
    'Alışveriş',
    'Spor',
    'Sağlık',
    'Öğrenme'
  ];

  // Renkleri bir listede tutuyoruz
  final List<Color> colors = [
    Colors.blue,
    Colors.red,
    Colors.orange,
    Colors.green
  ];
  // Seçilen rengi takip eden bir değişken
  int? selectedIndex;
  //kullanıcı düzenleme ile gelirse sayfaya tıkladığı itemin değerlerini kutulara ekler
  void _degerAtama(item) {
    _titleController.text = item["title"];
    _noteController.text = item["note"];
    _dateController.text = item["date"];
    _timeController.text = item["time"];
    selectedIndex = item["color"];
    if (item["category"] != "") {
      _selectedCategory = item["category"];
    }
  }

  @override
  void initState() {
    super.initState();
    final item = widget.item;
    if (item != null) {
      _degerAtama(item);
      _result = 1;
    }
  }

//tarih
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: const Locale('tr'),
    );
    if (pickedDate != null) {
      setState(() {
        _dateController.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

//saat
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _timeController.text =
            "${pickedTime.hour}:${pickedTime.minute.toString().padLeft(2, '0')}";
      });
    }
  }

//kayıt kısmı
//------------------------------------------------------
  final Box _missionBox = Hive.box('missionBox');

  // Create new item
  Future<void> _createItem(Map<String, dynamic> newItem) async {
    await _missionBox.add(newItem);
  }

  // Veri güncelleme
  Future<void> _updateItem(int index, Map<String, dynamic> updatedItem) async {
    await _missionBox.putAt(index, updatedItem);
    setState(() {});
  }

//------------------------------------------------------

  // bellek sızıntısı için
  @override
  void dispose() {
    // Bellek sızıntısını önlemek için dispose edilmelidir
    _timeController.dispose();
    _dateController.dispose();
    _noteController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yeni Görev Ekle"),
        centerTitle: true,
      ),
      //kaydet butonu
      floatingActionButton: SizedBox(
        width: 375,
        child: FloatingActionButton(
          onPressed: () {
            final int? index = widget.index;
            if (_result == 1) {
              _updateItem(index!, {
                "title": _titleController.text,
                "note": _noteController.text,
                "date": _dateController.text,
                "time": _timeController.text,
                "category": _selectedCategory ?? "",
                "color": selectedIndex,
              });
              //kutuların içini silme
              _titleController.text = "";
              _noteController.text = "";
              _dateController.text = "";
              _timeController.text = "";
              Navigator.pop(context);
            } else {
              _createItem({
                "title": _titleController.text,
                "note": _noteController.text,
                "date": _dateController.text,
                "time": _timeController.text,
                "category": _selectedCategory ?? "",
                "color": selectedIndex,
              });
              //kutuların içini silme
              _titleController.text = "";
              _noteController.text = "";
              _dateController.text = "";
              _timeController.text = "";
              Navigator.pop(context);
            }
          },
          child: const Text(
            "KAYDET",
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //başlık kısmı
              FormItems(
                type: TextInputType.text,
                titlecontroller: _titleController,
                text: "Başlık",
              ),
              //not kısmı
              FormItems(
                type: TextInputType.text,
                titlecontroller: _noteController,
                text: "Not",
              ),
              //tarih & saat kısmı
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 170,
                      child: tarih(context),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: 170,
                      child: saat(context),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 35),
              //category kısmı
              DropdownButton2(
                underline: const SizedBox(), // Alt çizgiyi kaldırma
                isExpanded: true,
                hint: Text(
                  'Kategori Seçin',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
                items: _categories
                    .map(
                      (category) => DropdownMenuItem<String>(
                        value: category,
                        child: Text(
                          category,
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.color, // Metin rengi
                          ),
                        ),
                      ),
                    )
                    .toList(),
                value: _selectedCategory,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  }
                },
                buttonStyleData: ButtonStyleData(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Theme.of(context)
                              .inputDecorationTheme
                              .enabledBorder
                              ?.borderSide
                              .color ??
                          Colors.grey, // Kenarlık rengi
                    ),
                    color: Theme.of(context)
                        .inputDecorationTheme
                        .fillColor, // Arka plan rengi
                  ),
                ),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context)
                        .cardTheme
                        .color, // Açılır menü arka planı
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),
                iconStyleData: IconStyleData(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    size: 30,
                    color: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.color, // İkon rengi
                  ),
                ),
              ),
              const SizedBox(height: 35),
              //renk kısmı
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(colors.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index; // Seçilen rengi kaydediyoruz
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: colors[index], // Renk listeden çekiliyor
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: selectedIndex == index
                              ? Colors.white
                              : Colors
                                  .transparent, // Seçili renge kenar çizgisi
                          width: 3,
                        ),
                      ),
                      child: selectedIndex == index
                          ? const Icon(Icons.check,
                              color: Colors.white) // Tik işareti
                          : null,
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //saat kısmı
  TextFormField saat(BuildContext context) {
    return TextFormField(
      controller: _timeController,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.timer_outlined),
        labelText: "Saat Seç",
        border: OutlineInputBorder(),
      ),
      readOnly: true, // Kullanıcının manuel yazmasını engeller
      onTap: () => _selectTime(context),
    );
  }

  //tarih kısmı
  TextFormField tarih(BuildContext context) {
    return TextFormField(
      controller: _dateController,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.edit_calendar_rounded),
        labelText: "Tarih Seç",
        border: OutlineInputBorder(),
      ),
      readOnly: true, // Kullanıcının manuel yazmasını engeller
      onTap: () => _selectDate(context),
    );
  }
}
