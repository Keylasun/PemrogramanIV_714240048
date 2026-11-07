import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:file_picker/file_picker.dart';
import '../models/contact_model.dart';

/// Halaman Daftar Kontak — CRUD lengkap dengan validasi
/// Menerapkan: Form, TextFormField, DatePicker, ColorPicker,
/// FilePicker, ListView, SnackBar, AlertDialog, setState
class ContactScreen extends StatefulWidget {
  final List<ContactModel> contacts;
  final VoidCallback onContactsChanged;

  const ContactScreen({
    super.key,
    required this.contacts,
    required this.onContactsChanged,
  });

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  // ═══ PORSCHE BRAND PALETTE ═══
  static const Color porscheRed = Color(0xFFD5001C);
  static const Color porscheBlack = Color(0xFF111111);
  static const Color porscheDarkGrey = Color(0xFF1A1A1A);
  static const Color porscheGold = Color(0xFFC5A059);

  // ═══ FORM STATE ═══
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dateController = TextEditingController();

  DateTime? _selectedDate;
  Color _currentColor = porscheRed; // Warna bawaan Porsche Guards Red
  String? _selectedFileName;
  String? _selectedFilePath;
  Uint8List? _selectedFileBytes;
  int? _editingIndex; // null = mode tambah, int = mode edit

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  // ═══════════════════════════════════════════
  // FUNGSI VALIDASI (sesuai ketentuan soal no. 3)
  // ═══════════════════════════════════════════

  /// Validasi nama: minimal 2 kata, hanya huruf dan spasi,
  /// setiap kata diawali huruf kapital (3b)
  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nama wajib diisi';
    }
    final trimmed = value.trim();
    final words = trimmed.split(RegExp(r'\s+'));

    if (words.length < 2) {
      return 'Nama harus terdiri dari minimal dua kata';
    }
    for (final word in words) {
      if (!RegExp(r'^[a-zA-Z]+$').hasMatch(word)) {
        return 'Nama hanya boleh mengandung huruf dan spasi';
      }
      if (!RegExp(r'^[A-Z]').hasMatch(word)) {
        return 'Setiap kata pada nama harus diawali huruf kapital';
      }
    }
    return null;
  }

  /// Validasi nomor telepon: hanya digit 0-9, diawali 62,
  /// panjang total 8-13 digit (3c)
  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nomor telepon wajib diisi';
    }
    final phone = value.trim();
    if (!RegExp(r'^[0-9]+$').hasMatch(phone)) {
      return 'Nomor telepon hanya boleh berisi angka 0-9';
    }
    if (!phone.startsWith('62')) {
      return 'Nomor telepon harus diawali dengan 62 (tanpa +)';
    }
    if (phone.length < 8 || phone.length > 13) {
      return 'Panjang nomor telepon harus 8-13 digit (termasuk 62)';
    }
    return null;
  }

  /// Validasi tanggal: harus sudah dipilih (3d)
  String? _validateDate(String? value) {
    if (_selectedDate == null || value == null || value.isEmpty) {
      return 'Tanggal wajib dipilih melalui Date Picker';
    }
    return null;
  }

  // ═══════════════════════════════════════════
  // FUNGSI PICKER — Tanggal, Warna, Berkas
  // ═══════════════════════════════════════════

  /// Date Picker (ketentuan 2e)
  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: porscheRed,
              onPrimary: Colors.white,
              surface: porscheDarkGrey,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    // Membatalkan dialog tidak menghapus pilihan sebelumnya (3d)
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  /// Color Picker (ketentuan 2e)
  void _pickColor() {
    Color tempColor = _currentColor;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: const Row(
            children: [
              Icon(Icons.palette, color: porscheRed, size: 22),
              SizedBox(width: 8),
              Text(
                'PORSCHE PAINT SELECTOR',
                style: TextStyle(
                  fontFamily: 'Oswald',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _currentColor,
              onColorChanged: (color) {
                tempColor = color;
              },
              labelTypes: const [],
              pickerAreaHeightPercent: 0.7,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child:
                  const Text('CANCEL', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: porscheRed,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _currentColor = tempColor;
                });
                Navigator.of(context).pop();
              },
              child: const Text('APPLY COLOR'),
            ),
          ],
        );
      },
    );
  }

  /// File Picker (ketentuan 2f)
  Future<void> _pickFile() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        withData: true, // Agar bytes terbaca di semua platform
      );

      // Membatalkan dialog tidak menghapus pilihan sebelumnya (3d)
      if (result != null && result.files.single.name.isNotEmpty) {
        setState(() {
          _selectedFileName = result.files.single.name;
          _selectedFileBytes = result.files.single.bytes;
          if (!kIsWeb) {
            _selectedFilePath = result.files.single.path;
          }
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal memilih berkas: $e'),
          backgroundColor: porscheRed,
        ),
      );
    }
  }

  // ═══════════════════════════════════════════
  // FUNGSI SUBMIT, EDIT, HAPUS (ketentuan 2b-2d)
  // ═══════════════════════════════════════════

  /// Submit / Update kontak (2b, 2c)
  void _submitForm() {
    final isFormValid = _formKey.currentState!.validate();
    final isFileValid = _selectedFileName != null &&
        (_selectedFileBytes != null ||
            (_selectedFilePath != null && !kIsWeb));

    // Validasi gagal → tampilkan SnackBar (3a)
    if (!isFormValid || !isFileValid) {
      List<String> errors = [];
      final nameErr = _validateName(_nameController.text);
      final phoneErr = _validatePhone(_phoneController.text);
      final dateErr = _validateDate(_dateController.text);

      if (nameErr != null) errors.add('• $nameErr');
      if (phoneErr != null) errors.add('• $phoneErr');
      if (dateErr != null) errors.add('• $dateErr');
      if (!isFileValid) errors.add('• Berkas belum dipilih');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'DATA TIDAK VALID',
                style: TextStyle(
                  fontFamily: 'Oswald',
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                errors.join('\n'),
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
          backgroundColor: porscheRed,
          duration: const Duration(seconds: 4),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
      return;
    }

    // Bersihkan spasi berlebih pada nama
    final cleanName =
        _nameController.text.trim().split(RegExp(r'\s+')).join(' ');
    final cleanPhone = _phoneController.text.trim();

    final newContact = ContactModel(
      name: cleanName,
      phoneNumber: cleanPhone,
      date: _selectedDate!,
      color: _currentColor,
      fileName: _selectedFileName!,
      filePath: _selectedFilePath,
      fileBytes: _selectedFileBytes,
    );

    setState(() {
      if (_editingIndex == null) {
        // Mode tambah (2b)
        widget.contacts.add(newContact);
      } else {
        // Mode edit — simpan perubahan tanpa menambah baru (2c)
        widget.contacts[_editingIndex!] = newContact;
        _editingIndex = null;
      }
      _resetForm();
    });

    widget.onContactsChanged();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              _editingIndex == null
                  ? 'Kontak berhasil ditambahkan!'
                  : 'Kontak berhasil diperbarui!',
              style: const TextStyle(fontFamily: 'Oswald'),
            ),
          ],
        ),
        backgroundColor: Colors.green[700],
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  /// Reset semua field formulir
  void _resetForm() {
    _nameController.clear();
    _phoneController.clear();
    _dateController.clear();
    _selectedDate = null;
    _currentColor = porscheRed;
    _selectedFileName = null;
    _selectedFilePath = null;
    _selectedFileBytes = null;
    _editingIndex = null;
    _formKey.currentState?.reset();
  }

  /// Isi formulir dengan data kontak yang akan di-edit (2c)
  void _editContact(int index) {
    final contact = widget.contacts[index];
    setState(() {
      _editingIndex = index;
      _nameController.text = contact.name;
      _phoneController.text = contact.phoneNumber;
      _selectedDate = contact.date;
      _dateController.text = DateFormat('dd-MM-yyyy').format(contact.date);
      _currentColor = contact.color;
      _selectedFileName = contact.fileName;
      _selectedFilePath = contact.filePath;
      _selectedFileBytes = contact.fileBytes;
    });

    // Scroll ke atas agar form terlihat
    Scrollable.ensureVisible(
      _formKey.currentContext!,
      duration: const Duration(milliseconds: 300),
    );
  }

  /// Konfirmasi hapus dengan AlertDialog (2d)
  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: const Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: porscheRed, size: 24),
              SizedBox(width: 8),
              Text(
                'KONFIRMASI HAPUS',
                style: TextStyle(
                  fontFamily: 'Oswald',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          content: Text(
            'Apakah Anda yakin ingin menghapus kontak "${widget.contacts[index].name}"?',
            style: const TextStyle(fontSize: 14),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'BATAL',
                style: TextStyle(
                  fontFamily: 'Oswald',
                  color: Colors.grey,
                  letterSpacing: 1,
                ),
              ),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: porscheRed,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  widget.contacts.removeAt(index);
                  // Jika sedang edit kontak yang dihapus, reset form
                  if (_editingIndex == index) {
                    _resetForm();
                  } else if (_editingIndex != null && _editingIndex! > index) {
                    _editingIndex = _editingIndex! - 1;
                  }
                });
                widget.onContactsChanged();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      'Kontak berhasil dihapus',
                      style: TextStyle(fontFamily: 'Oswald'),
                    ),
                    backgroundColor: Colors.grey[800],
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                );
              },
              icon: const Icon(Icons.delete_outline, size: 18),
              label: const Text('HAPUS'),
            ),
          ],
        );
      },
    );
  }

  /// Widget preview avatar — tampilkan gambar jika JPG/JPEG/PNG (2a, 2f)
  Widget _buildPreviewAvatar(ContactModel contact) {
    if (contact.isImageFile) {
      if (contact.fileBytes != null) {
        return Image.memory(
          contact.fileBytes!,
          width: 52,
          height: 52,
          fit: BoxFit.cover,
        );
      } else if (!kIsWeb &&
          contact.filePath != null &&
          File(contact.filePath!).existsSync()) {
        return Image.file(
          File(contact.filePath!),
          width: 52,
          height: 52,
          fit: BoxFit.cover,
        );
      }
    }
    // Ikon default untuk berkas non-gambar
    return Container(
      width: 52,
      height: 52,
      color: porscheBlack,
      child: const Icon(
        Icons.insert_drive_file_outlined,
        color: porscheGold,
        size: 24,
      ),
    );
  }

  // ═══════════════════════════════════════════
  // BUILD UI
  // ═══════════════════════════════════════════

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: porscheBlack,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 4,
              height: 20,
              color: porscheRed,
            ),
            const SizedBox(width: 10),
            const Text(
              'CLIENT REGISTRY',
              style: TextStyle(
                fontFamily: 'Oswald',
                fontWeight: FontWeight.w700,
                letterSpacing: 3,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: [
          if (_editingIndex != null)
            TextButton.icon(
              onPressed: () {
                setState(() => _resetForm());
              },
              icon: const Icon(Icons.close, color: porscheGold, size: 18),
              label: const Text(
                'BATAL',
                style: TextStyle(
                  fontFamily: 'Oswald',
                  color: porscheGold,
                  fontSize: 11,
                  letterSpacing: 1,
                ),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── FORM SECTION ──
            _buildFormSection(),
            const SizedBox(height: 28),
            // ── CONTACT LIST SECTION ──
            _buildContactListSection(),
          ],
        ),
      ),
    );
  }

  /// Formulir input kontak
  Widget _buildFormSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(18),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // Form header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            decoration: BoxDecoration(
              color: _editingIndex == null
                  ? porscheBlack
                  : porscheGold.withAlpha(30),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(14)),
            ),
            child: Row(
              children: [
                Icon(
                  _editingIndex == null ? Icons.person_add : Icons.edit_note,
                  color: _editingIndex == null ? porscheGold : porscheBlack,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  _editingIndex == null
                      ? 'REGISTER NEW CLIENT'
                      : 'EDITING CLIENT #${_editingIndex! + 1}',
                  style: TextStyle(
                    fontFamily: 'Oswald',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                    fontSize: 13,
                    color:
                        _editingIndex == null ? Colors.white : porscheBlack,
                  ),
                ),
              ],
            ),
          ),
          // Form body
          Padding(
            padding: const EdgeInsets.all(18),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── 1. NAMA ──
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                      hintText: 'Contoh: Ferdinand Porsche',
                      prefixIcon:
                          Icon(Icons.person_outline, color: porscheBlack),
                    ),
                    validator: _validateName,
                    textCapitalization: TextCapitalization.words,
                  ),
                  const SizedBox(height: 14),

                  // ── 2. NOMOR TELEPON ──
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      hintText: 'Contoh: 628122221122',
                      prefixIcon: Icon(Icons.phone_outlined, color: porscheBlack),
                    ),
                    validator: _validatePhone,
                  ),
                  const SizedBox(height: 14),

                  // ── 3. TANGGAL (readOnly + DatePicker) ──
                  TextFormField(
                    controller: _dateController,
                    readOnly: true,
                    onTap: _pickDate,
                    decoration: const InputDecoration(
                      labelText: 'Date',
                      hintText: 'Tap untuk memilih tanggal',
                      prefixIcon:
                          Icon(Icons.calendar_today_outlined, color: porscheBlack),
                      suffixIcon: Icon(Icons.arrow_drop_down),
                    ),
                    validator: _validateDate,
                  ),
                  const SizedBox(height: 18),

                  // ── 4. COLOR PICKER ──
                  const Text(
                    'COLOR',
                    style: TextStyle(
                      fontFamily: 'Oswald',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: _pickColor,
                    child: Container(
                      height: 56,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: _currentColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black12, width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: _currentColor.withAlpha(60),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.palette_outlined,
                              color: _currentColor.computeLuminance() > 0.5
                                  ? Colors.black54
                                  : Colors.white70,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'TAP TO CHANGE',
                              style: TextStyle(
                                fontFamily: 'Oswald',
                                color:
                                    _currentColor.computeLuminance() > 0.5
                                        ? Colors.black54
                                        : Colors.white70,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // ── 5. FILE PICKER ──
                  const Text(
                    'FILE ATTACHMENT',
                    style: TextStyle(
                      fontFamily: 'Oswald',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: _pickFile,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: _selectedFileName != null
                            ? Colors.green.withAlpha(15)
                            : Colors.grey.withAlpha(20),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _selectedFileName != null
                              ? Colors.green.withAlpha(60)
                              : Colors.black12,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _selectedFileName != null
                                ? Icons.check_circle_outline
                                : Icons.upload_file_outlined,
                            color: _selectedFileName != null
                                ? Colors.green[700]
                                : porscheBlack,
                            size: 22,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _selectedFileName ?? 'Pilih berkas...',
                                  style: TextStyle(
                                    fontFamily: 'Oswald',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    color: _selectedFileName != null
                                        ? porscheBlack
                                        : Colors.grey,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                if (_selectedFileName == null)
                                  const Text(
                                    'Gambar atau dokumen',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.folder_open_outlined,
                            color: Colors.grey[400],
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Preview gambar jika file terpilih adalah gambar
                  if (_selectedFileName != null &&
                      _isImageFile(_selectedFileName!)) ...[
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: _buildSelectedFilePreview(),
                    ),
                  ],

                  const SizedBox(height: 24),

                  // ── 6. TOMBOL SUBMIT / UPDATE ──
                  Row(
                    children: [
                      if (_editingIndex != null) ...[
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              setState(() => _resetForm());
                            },
                            icon: const Icon(Icons.close, size: 18),
                            label: const Text(
                              'CANCEL',
                              style: TextStyle(
                                fontFamily: 'Oswald',
                                letterSpacing: 1,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.grey[700],
                              padding:
                                  const EdgeInsets.symmetric(vertical: 14),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                      Expanded(
                        flex: _editingIndex != null ? 2 : 1,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: porscheRed,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            elevation: 3,
                          ),
                          onPressed: _submitForm,
                          icon: Icon(
                            _editingIndex == null
                                ? Icons.save_outlined
                                : Icons.update,
                            size: 20,
                          ),
                          label: Text(
                            _editingIndex == null ? 'SUBMIT' : 'UPDATE',
                            style: const TextStyle(
                              fontFamily: 'Oswald',
                              fontWeight: FontWeight.w700,
                              letterSpacing: 2,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Daftar kontak dengan ListView (2a)
  Widget _buildContactListSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Row(
          children: [
            Container(width: 4, height: 22, color: porscheRed),
            const SizedBox(width: 10),
            const Text(
              'REGISTERED CLIENTS',
              style: TextStyle(
                fontFamily: 'Oswald',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
                color: porscheBlack,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: porscheBlack,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${widget.contacts.length}',
                style: const TextStyle(
                  fontFamily: 'Oswald',
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // Contact list atau empty state
        widget.contacts.isEmpty
            ? _buildEmptyState()
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.contacts.length,
                itemBuilder: (context, index) {
                  return _buildContactCard(index);
                },
              ),
      ],
    );
  }

  /// Empty state ketika belum ada kontak
  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black.withAlpha(10)),
      ),
      child: Column(
        children: [
          Icon(Icons.contact_phone_outlined,
              color: Colors.grey[300], size: 56),
          const SizedBox(height: 14),
          Text(
            'BELUM ADA DATA',
            style: TextStyle(
              fontFamily: 'Oswald',
              color: Colors.grey[400],
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Mulai registrasi klien pertama Anda',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  /// Kartu kontak individual (2a)
  Widget _buildContactCard(int index) {
    final contact = widget.contacts[index];
    final isEditing = _editingIndex == index;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isEditing ? porscheGold : Colors.black.withAlpha(10),
          width: isEditing ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar / preview gambar
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: _buildPreviewAvatar(contact),
            ),
            const SizedBox(width: 14),

            // Detail kontak
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama
                  Text(
                    contact.name,
                    style: const TextStyle(
                      fontFamily: 'Oswald',
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: porscheBlack,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Nomor telepon
                  Row(
                    children: [
                      const Icon(Icons.phone_outlined,
                          size: 13, color: Colors.black38),
                      const SizedBox(width: 4),
                      Text(
                        contact.phoneNumber,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  // Tanggal berformat dd-MM-yyyy (2a)
                  Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined,
                          size: 13, color: Colors.black38),
                      const SizedBox(width: 4),
                      Text(
                        DateFormat('dd-MM-yyyy').format(contact.date),
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  // Nama berkas (2a)
                  Row(
                    children: [
                      Icon(
                        contact.isImageFile
                            ? Icons.image_outlined
                            : Icons.attach_file_outlined,
                        size: 13,
                        color: Colors.black38,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          contact.fileName,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black45,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Indikator warna (2a)
                  Container(
                    height: 8,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: contact.color,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.black12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // Tombol edit & hapus
            Column(
              children: [
                _buildActionButton(
                  icon: Icons.edit_outlined,
                  color: porscheBlack,
                  tooltip: 'Ubah Kontak',
                  onPressed: () => _editContact(index),
                ),
                const SizedBox(height: 4),
                _buildActionButton(
                  icon: Icons.delete_outline,
                  color: porscheRed,
                  tooltip: 'Hapus Kontak',
                  onPressed: () => _confirmDelete(index),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required String tooltip,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(6),
        child: Tooltip(
          message: tooltip,
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              border: Border.all(color: color.withAlpha(40)),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, size: 18, color: color),
          ),
        ),
      ),
    );
  }

  /// Helper: cek apakah file adalah gambar
  bool _isImageFile(String fileName) {
    final ext = fileName.toLowerCase();
    return ext.endsWith('.jpg') ||
        ext.endsWith('.jpeg') ||
        ext.endsWith('.png');
  }

  /// Preview gambar yang sedang dipilih di form
  Widget _buildSelectedFilePreview() {
    if (_selectedFileBytes != null) {
      return Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black12),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.memory(
            _selectedFileBytes!,
            fit: BoxFit.cover,
          ),
        ),
      );
    } else if (!kIsWeb &&
        _selectedFilePath != null &&
        File(_selectedFilePath!).existsSync()) {
      return Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black12),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(
            File(_selectedFilePath!),
            fit: BoxFit.cover,
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}

