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
      title: 'BRIS Workspace',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: const Color(0xFF6C63FF),
        scaffoldBackgroundColor: const Color(0xFFF4F6FA),
      ),
      home: const DashboardScreen(),
    );
  }
}

// ================= Halaman Utama (Dashboard) =================
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final String _totalRevenue = "Rp 12.450.000";
  final int _lowStockAlert = 4;

  final List<Map<String, dynamic>> _transactions = [
    {
      "title": "Plafon PVC Glossy",
      "qty": 15,
      "total": "Rp 1.350.000",
      "type": "Keluar",
    },
    {
      "title": "Fitting Lampu Minimalis",
      "qty": 50,
      "total": "Rp 500.000",
      "type": "Masuk",
    },
    {
      "title": "Baja Ringan 0.75",
      "qty": 30,
      "total": "Rp 2.100.000",
      "type": "Keluar",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat Datang',
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                      const Text(
                        'BRIS Workspace',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C63FF).withAlpha(26),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.notifications_none,
                        color: Color(0xFF6C63FF),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NotifikasiScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Analytics Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6C63FF), Color(0xFF3F3D56)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Pendapatan Bulan Ini',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _totalRevenue,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Icon(
                          Icons.warning_amber_rounded,
                          color: Colors.amber,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '$_lowStockAlert Produk hampir habis!',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              const Text(
                'Menu Utama',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 1.4,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildMenuCard(
                    Icons.point_of_sale,
                    "Kasir / POS",
                    Colors.blue,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const KasirScreen(),
                        ),
                      );
                    },
                  ),
                  _buildMenuCard(
                    Icons.inventory_2_outlined,
                    "Stok Gudang",
                    Colors.orange,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StokGudangScreen(),
                        ),
                      );
                    },
                  ),
                  _buildMenuCard(
                    Icons.people_outline,
                    "Kelola Tim",
                    Colors.green,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const KelolaTimScreen(),
                        ),
                      );
                    },
                  ),
                  _buildMenuCard(
                    Icons.bar_chart_rounded,
                    "Laporan",
                    Colors.purple,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LaporanScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 28),

              const Text(
                'Aktivitas Terkini',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _transactions.length,
                itemBuilder: (context, index) {
                  final item = _transactions[index];
                  final isOut = item['type'] == 'Keluar';
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: isOut
                              ? Colors.red[50]
                              : Colors.green[50],
                          child: Icon(
                            isOut ? Icons.arrow_upward : Icons.arrow_downward,
                            color: isOut ? Colors.red : Colors.green,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                '${item['qty']} item',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          item['total'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isOut ? Colors.black87 : Colors.green,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    IconData icon,
    String title,
    Color color,
    VoidCallback onTap,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: color, size: 28),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ================= Halaman Kasir / POS =================
class KasirScreen extends StatefulWidget {
  const KasirScreen({super.key});

  @override
  State<KasirScreen> createState() => _KasirScreenState();
}

class _KasirScreenState extends State<KasirScreen> {
  final List<Map<String, dynamic>> _cart = [];
  final List<Map<String, dynamic>> _availableProducts = [
    {"name": "Plafon PVC Super", "price": 45000},
    {"name": "Baja Ringan C75", "price": 75000},
    {"name": "List Profile PVC", "price": 20000},
  ];

  void _addToCart(Map<String, dynamic> product) {
    setState(() {
      final existingIndex = _cart.indexWhere(
        (item) => item['name'] == product['name'],
      );
      if (existingIndex >= 0) {
        _cart[existingIndex]['qty']++;
      } else {
        _cart.add({
          "name": product['name'],
          "price": product['price'],
          "qty": 1,
        });
      }
    });
  }

  int _calculateTotal() {
    return _cart.fold(
      0,
      (sum, item) => sum + (item['price'] * item['qty'] as int),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kasir POS')),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Pilih Produk',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _availableProducts.length,
              itemBuilder: (context, index) {
                final p = _availableProducts[index];
                return GestureDetector(
                  onTap: () => _addToCart(p),
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          p['name'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Rp ${p['price']}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(height: 32),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Keranjang Belanja',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: _cart.isEmpty
                ? const Center(
                    child: Text('Keranjang kosong. Tap produk di atas.'),
                  )
                : ListView.builder(
                    itemCount: _cart.length,
                    itemBuilder: (context, index) {
                      final item = _cart[index];
                      return ListTile(
                        title: Text(item['name']),
                        subtitle: Text('${item['qty']} x Rp ${item['price']}'),
                        trailing: Text(
                          'Rp ${item['qty'] * item['price']}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Total Bayar',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      'Rp ${_calculateTotal()}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6C63FF),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: _cart.isEmpty
                      ? null
                      : () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Transaksi Berhasil Disimpan!'),
                            ),
                          );
                          setState(() => _cart.clear());
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C63FF),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Bayar Sekarang'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ================= Halaman Stok Gudang =================
class StokGudangScreen extends StatefulWidget {
  const StokGudangScreen({super.key});

  @override
  State<StokGudangScreen> createState() => _StokGudangScreenState();
}

class _StokGudangScreenState extends State<StokGudangScreen> {
  final List<Map<String, dynamic>> _inventory = [
    {"name": "Plafon PVC Glossy White", "stock": 120, "unit": "Lembar"},
    {"name": "Baja Ringan 0.75mm", "stock": 14, "unit": "Batang"},
    {"name": "Ornamen Lampu Kotak", "stock": 3, "unit": "Pcs"},
  ];

  final _nameController = TextEditingController();
  final _stockController = TextEditingController();

  void _addNewItem() {
    if (_nameController.text.isNotEmpty && _stockController.text.isNotEmpty) {
      setState(() {
        _inventory.add({
          "name": _nameController.text,
          "stock": int.parse(_stockController.text),
          "unit": "Pcs",
        });
      });
      _nameController.clear();
      _stockController.clear();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stok Gudang BRIS')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _inventory.length,
        itemBuilder: (context, index) {
          final item = _inventory[index];
          final isLow = item['stock'] <= 15;
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              title: Text(
                item['name'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isLow ? Colors.red[100] : Colors.green[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${item['stock']} ${item['unit']}',
                  style: TextStyle(
                    color: isLow ? Colors.red[800] : Colors.green[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 20,
                right: 20,
                top: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Nama Barang'),
                  ),
                  TextField(
                    controller: _stockController,
                    decoration: const InputDecoration(labelText: 'Jumlah Stok'),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _addNewItem,
                    child: const Text('Tambah ke Gudang'),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ================= Halaman Kelola Tim =================
class KelolaTimScreen extends StatefulWidget {
  const KelolaTimScreen({super.key});

  @override
  State<KelolaTimScreen> createState() => _KelolaTimScreenState();
}

class _KelolaTimScreenState extends State<KelolaTimScreen> {
  final List<Map<String, String>> _team = [
    {"name": "Admin Utama", "role": "Admin", "initial": "A"},
    {"name": "Staf Gudang", "role": "Warehouse", "initial": "W"},
    {"name": "Kasir Toko", "role": "Cashier", "initial": "C"},
  ];

  final _teamNameController = TextEditingController();
  String _selectedRole = "Admin";

  void _addMember() {
    if (_teamNameController.text.isNotEmpty) {
      setState(() {
        _team.add({
          "name": _teamNameController.text,
          "role": _selectedRole,
          "initial": _teamNameController.text[0].toUpperCase(),
        });
      });
      _teamNameController.clear();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kelola Anggota Tim')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _team.length,
        itemBuilder: (context, index) {
          final member = _team[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color(0xFF6C63FF),
                foregroundColor: Colors.white,
                child: Text(member['initial']!),
              ),
              title: Text(
                member['name']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Akses: ${member['role']}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () => setState(() => _team.removeAt(index)),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    left: 20,
                    right: 20,
                    top: 20,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _teamNameController,
                        decoration: const InputDecoration(
                          labelText: 'Nama Anggota',
                        ),
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        value: _selectedRole,
                        items: ["Admin", "Owner", "Warehouse", "Cashier"].map((
                          role,
                        ) {
                          return DropdownMenuItem(
                            value: role,
                            child: Text(role),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setModalState(() {
                            _selectedRole = value!;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'Hak Akses',
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _addMember,
                        child: const Text('Tambah Anggota'),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                );
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ================= Halaman Laporan / Analytics (FIXED OVERFLOW) =================
class LaporanScreen extends StatelessWidget {
  const LaporanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Laporan & Grafik Mini')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Grafik Penjualan Mingguan',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              height: 220,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildBar(40, 'Sen'),
                  _buildBar(70, 'Sel'),
                  _buildBar(110, 'Rab'),
                  _buildBar(80, 'Kam'),
                  _buildBar(130, 'Jum'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Statistik Performa',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard('Omset', 'Rp 45.2M', Colors.green),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    'Pesanan',
                    '312 Transaksi',
                    Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBar(double height, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: height,
          width: 24,
          decoration: BoxDecoration(
            color: const Color(0xFF6C63FF),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildStatCard(String title, String val, Color col) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 8),
          Text(
            val,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: col,
            ),
          ),
        ],
      ),
    );
  }
}

// ================= Halaman Notifikasi =================
class NotifikasiScreen extends StatelessWidget {
  const NotifikasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> notifications = [
      {
        "title": "Stok Kritis!",
        "desc": "Baja Ringan 0.75mm tersisa 14 batang lagi di gudang.",
        "time": "10 Menit lalu",
      },
      {
        "title": "Transaksi Baru",
        "desc": "Kasir Berhasil melakukan checkout sebesar Rp 1.350.000.",
        "time": "1 Jam lalu",
      },
      {
        "title": "Sistem Update",
        "desc": "BRIS Workspace berhasil diperbarui ke versi stabil terbaru.",
        "time": "Kemarin",
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Notifikasi Masuk')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notif = notifications[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.amberAccent,
                child: Icon(Icons.info_outline, color: Colors.black87),
              ),
              title: Text(
                notif['title']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(notif['desc']!),
              trailing: Text(
                notif['time']!,
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ),
          );
        },
      ),
    );
  }
}
