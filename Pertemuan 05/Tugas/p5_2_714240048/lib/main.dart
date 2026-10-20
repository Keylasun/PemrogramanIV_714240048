import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas Pertemuan 5',
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

// ==========================================
// 1. HALAMAN PERTAMA (HomeScreen)
// ==========================================
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final String nama = 'Keyla Sun';
  final String npm = '714240048';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tugas Pertemuan 5'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Foto Profil
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'images/key.jpg',
                      width: 140,
                      height: 140,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Nama Mahasiswa dengan Custom Font
                  Text(
                    nama,
                    style: const TextStyle(
                      fontFamily: 'Oswald',
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // NPM Mahasiswa
                  Text(
                    'NPM: $npm',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Tombol Navigasi ke Halaman Kedua
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                            nama: nama,
                            npm: npm,
                          ),
                        ),
                      );
                    },
                    child: const Text('Lihat Detail Profil'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 2. HALAMAN KEDUA (DetailScreen)
// ==========================================
class DetailScreen extends StatelessWidget {
  final String nama;
  final String npm;

  const DetailScreen({
    super.key,
    required this.nama,
    required this.npm,
  });

  @override
  Widget build(BuildContext context) {
    // GAMBAR LOKAL: Menggunakan nama file poce 1.jpg s/d poce 4.jpg
    final List<String> activityGallery = [
      'images/poce 1.jpg',
      'images/poce 2.jpg',
      'images/poce 3.jpg',
      'images/poce 4.jpg',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Profil'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Menampilkan kembali Nama & NPM dengan Custom Font
              Center(
                child: Column(
                  children: [
                    Text(
                      nama,
                      style: const TextStyle(
                        fontFamily: 'Oswald',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'NPM: $npm',
                      style: const TextStyle(
                        fontFamily: 'Oswald',
                        fontSize: 18,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Deskripsi Singkat
              const Text(
                'Deskripsi Diri:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: const Text(
                  'Mahasiswa D4 Teknik Informatika Universitas Logistik dan Bisnis Internasional (ULBI). Memiliki minat utama di bidang Cyber Security, Data Analytics, serta Pengembangan Aplikasi Web dan Mobile.',
                  style: TextStyle(fontSize: 15, height: 1.4),
                ),
              ),
              const SizedBox(height: 24),

              // Gallery Aktivitas (Horizontal Scroll menggunakan Image.asset)
              const Text(
                'Galeri Aktivitas:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 140,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: activityGallery.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          activityGallery[index],
                          width: 200,
                          height: 140,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 32),

              // Tombol Kembali
              Center(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Kembali'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}