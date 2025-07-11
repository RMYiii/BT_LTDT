import 'package:flutter/material.dart';
import '../models/books.dart';
import '../models/students.dart';
import '../widgets/book_list_items.dart';
import '../widgets/student_selector.dart';
import '../widgets/loading_button.dart';
class LibraryHomePage extends StatefulWidget {
  const LibraryHomePage({super.key});

  @override
  State<LibraryHomePage> createState() => _LibraryHomePageState();
}

class _LibraryHomePageState extends State<LibraryHomePage> {
  Student currentStudent = Student(name: "Nguyen Van A");

  List<Student> students = [
    Student(name: "Nguyen Van A"),
    Student(name: "Tran Thi B"),
    Student(name: "Le Van C"),
  ];

  List<Book> books = [];
  late List<Book> originalBooks;

  int _selectedIndex = 0;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    originalBooks = [
      Book(title: "Sách 01", isSelected: true),
      Book(title: "Sách 02", isSelected: true),
      Book(title: "Sách 03", isSelected: true),
      Book(title: "Sách 04", isSelected: true),
    ];
    books = List<Book>.from(originalBooks);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showStudentSelectionSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StudentSelectorSheet(
          students: students,
          onStudentSelected: (selectedStudent) {
            setState(() {
              currentStudent = selectedStudent;
            });
          },
        );
      },
    );
  }

  Future<void> _onAddPressed() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      if (books.isEmpty) {
        books = originalBooks
            .map((book) => Book(title: book.title, isSelected: false))
            .toList();
      } else {
        books.removeWhere((book) => !book.isSelected);
      }

      isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Đã cập nhật lại danh sách sách',
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text(
          'Hệ thống\nQuản lý Thư viện',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        toolbarHeight: 80,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Sinh viên',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextField(
                      controller:
                      TextEditingController(text: currentStudent.name),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                      ),
                      style: const TextStyle(fontSize: 16),
                      readOnly: true,
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: _showStudentSelectionSheet,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Thay đổi',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            const Text('Danh sách sách',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: books.isEmpty
                  ? const Center(
                child: Text(
                  'Không có sách',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              )
                  : Column(
                children: books.map((book) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: BookListItem(
                      book: book,
                      onChanged: (value) {
                        setState(() {
                          book.isSelected = value ?? false;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24.0),
            Center(
              child: LoadingButton(
                isLoading: isLoading,
                onPressed: _onAddPressed,
                child: const Text(
                  'Thêm',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[900],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white54,
        selectedLabelStyle: const TextStyle(fontSize: 18),
        unselectedLabelStyle: const TextStyle(fontSize: 14),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: _selectedIndex == 0 ? 32 : 24,
            ),
            label: 'Quản lý',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.description,
              size: _selectedIndex == 1 ? 32 : 24,
            ),
            label: 'DS Sách',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: _selectedIndex == 2 ? 32 : 24,
            ),
            label: 'Sinh viên',
          ),
        ],
      ),
    );
  }
}
