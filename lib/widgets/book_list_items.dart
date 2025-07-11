import 'package:flutter/material.dart';
import '../models/books.dart';

class BookListItem extends StatelessWidget {
  final Book book;
  final ValueChanged<bool?> onChanged;

  const BookListItem({
    Key? key,
    required this.book,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Transform.scale(
            scale: 1.2,
            child: Checkbox(
              value: book.isSelected,
              onChanged: onChanged,
              activeColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              side: const BorderSide(color: Colors.grey, width: 1.5),
            ),
          ),
          const SizedBox(width: 8.0),
          Text(book.title, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
