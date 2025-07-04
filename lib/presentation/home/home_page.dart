import 'package:flutter/material.dart';
import '../../model/book.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Book> _books = [];

  void _showBookForm({Book? book, int? index}) {
    final titleController = TextEditingController(text: book?.title ?? '');
    final authorController = TextEditingController(text: book?.author ?? '');
    final yearController = TextEditingController(
      text: book?.year != null ? book!.year.toString() : '',
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(book == null ? 'Tambah Buku' : 'Edit Buku'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: authorController,
                  decoration: const InputDecoration(labelText: 'Author'),
                ),
                TextField(
                  controller: yearController,
                  decoration: const InputDecoration(labelText: 'Year'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                final title = titleController.text.trim();
                final author = authorController.text.trim();
                final year = int.tryParse(yearController.text.trim()) ?? 0;
                if (title.isEmpty || author.isEmpty || year == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Harap isi semua field'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                if (title.isNotEmpty && author.isNotEmpty && year > 0) {
                  setState(() {
                    if (book == null) {
                      _books.add(
                        Book(title: title, author: author, year: year),
                      );
                    } else if (index != null) {
                      _books[index] = Book(
                        title: title,
                        author: author,
                        year: year,
                      );
                    }
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Buku berhasil disimpan'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              child: Text(book == null ? 'Tambah' : 'Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _deleteBook(int index) {
    //add confirm dialog
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus Buku'),
          content: const Text('Yakin ingin menghapus buku ini?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _books.removeAt(index);
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Buku berhasil dihapus'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Buku'), centerTitle: true),
      body:
          _books.isEmpty
              ? const Center(child: Text('Belum ada buku.'))
              : ListView.builder(
                itemCount: _books.length,
                itemBuilder: (context, index) {
                  final book = _books[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: ListTile(
                      title: Text(book.title),
                      subtitle: Text(
                        'Author: ${book.author}\nYear: ${book.year}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed:
                                () => _showBookForm(book: book, index: index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _deleteBook(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showBookForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
