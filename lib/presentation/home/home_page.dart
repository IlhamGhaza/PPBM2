import 'dart:developer';

import 'package:flutter/material.dart';
import '../../data/datasource/book_remote_datasource.dart';
import '../../data/model/book_response_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final BookRemoteDatasource _datasource = BookRemoteDatasource();
  List<BookResponseModel> _books = [];
  List<BookResponseModel> _filteredBooks = [];
  bool _isLoading = true;
  String? _errorMessage;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadBooks();
    _searchController.addListener(_onSearch);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadBooks() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final books = await _datasource.getBooks();
      setState(() {
        _books = books;
        _filteredBooks = books;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Gagal memuat data: $e';
        _isLoading = false;
      });
      _showSnackBar('Gagal memuat data: $e', isError: true);
    }
  }

  void _onSearch() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredBooks =
          _books.where((book) {
            return (book.title ?? '').toLowerCase().contains(query) ||
                (book.author ?? '').toLowerCase().contains(query) ||
                (book.year?.toString() ?? '').contains(query);
          }).toList();
    });
  }

  void _showBookForm({BookResponseModel? book}) {
    final titleController = TextEditingController(text: book?.title ?? '');
    final authorController = TextEditingController(text: book?.author ?? '');
    final yearController = TextEditingController(
      text: book?.year != null ? book!.year.toString() : '',
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Text(
                  book == null ? 'Tambah Buku' : 'Edit Buku',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Judul Buku',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: authorController,
                  decoration: const InputDecoration(
                    labelText: 'Penulis',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: yearController,
                  decoration: const InputDecoration(
                    labelText: 'Tahun',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Batal'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () async {
                        final title = titleController.text.trim();
                        final author = authorController.text.trim();
                        final yearText = yearController.text.trim();

                        if (title.isEmpty ||
                            author.isEmpty ||
                            yearText.isEmpty) {
                          _showSnackBar('Harap isi semua field', isError: true);
                          return;
                        }

                        try {
                          final parsedYear = int.tryParse(yearText) ?? 0;
                          if (parsedYear == 0) {
                            _showSnackBar('Tahun tidak valid', isError: true);
                            return;
                          }
                          if (book == null) {
                            final newBook = BookResponseModel(
                              title: title,
                              author: author,
                              year: parsedYear,
                            );
                            await _datasource.createBook(newBook);
                            _showSnackBar('Buku berhasil ditambahkan');
                          } else {
                            final updatedBook = book.copyWith(
                              title: title,
                              author: author,
                              year: parsedYear,
                            );
                            await _datasource.updateBook(updatedBook);
                            _showSnackBar('Buku berhasil diperbarui');
                          }
                          await _loadBooks();
                          if (mounted) {
                            Navigator.pop(context);
                          }
                        } catch (e) {
                          if (mounted) {
                            _showSnackBar(
                              'Gagal menyimpan buku: $e',
                              isError: true,
                            );
                          }
                        }
                      },
                      child: Text(book == null ? 'Tambah' : 'Simpan'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _deleteBook(BookResponseModel book) {
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
              onPressed: () async {
                try {
                  await _datasource.deleteBook(book.id!);
                  if (mounted) {
                    Navigator.pop(context);
                    _showSnackBar('Buku berhasil dihapus');
                    await _loadBooks();
                  }
                } catch (e) {
                  if (mounted) {
                    _showSnackBar('Gagal menghapus buku: $e', isError: true);
                  }
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;
    log(message);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6A82FB), Color(0xFFFC5C7D)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          'Daftar Buku',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _loadBooks),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Cari judul, penulis, atau tahun...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child:
                    _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : _errorMessage != null
                        ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _errorMessage!,
                                style: const TextStyle(color: Colors.red),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: _loadBooks,
                                child: const Text('Coba Lagi'),
                              ),
                            ],
                          ),
                        )
                        : _filteredBooks.isEmpty
                        ? const Center(child: Text('Belum ada buku.'))
                        : ListView.separated(
                          itemCount: _filteredBooks.length,
                          separatorBuilder:
                              (context, index) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final book = _filteredBooks[index];
                            return Material(
                              elevation: 2,
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: const Color(0xFF6A82FB),
                                    child: const Icon(
                                      Icons.book,
                                      color: Colors.white,
                                    ),
                                  ),
                                  title: Text(
                                    book.title ?? 'No Title',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 4),
                                      Text(
                                        'Penulis: ${book.author ?? 'Unknown'}',
                                      ),
                                      Text('Tahun: ${book.year ?? 'N/A'}'),
                                    ],
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Color(0xFF6A82FB),
                                        ),
                                        onPressed:
                                            () => _showBookForm(book: book),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () => _deleteBook(book),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showBookForm(),
        icon: const Icon(Icons.add),
        label: const Text('Tambah Buku'),
        backgroundColor: const Color(0xFF6A82FB),
      ),
    );
  }
}
