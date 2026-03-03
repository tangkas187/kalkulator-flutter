import 'package:flutter/material.dart';

void main() => runApp(const MateriBangunRuang());

class MateriBangunRuang extends StatelessWidget {
  const MateriBangunRuang({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true, 
        colorSchemeSeed: Colors.blue,
        scaffoldBackgroundColor: Colors.blue[50],
      ),
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', height: 160),
            const SizedBox(height: 20),
            const Text(
              'KALKULATOR BANGUN RUANG',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const MenuList())),
              icon: const Icon(Icons.play_arrow),
              label: const Text('Buka Menu Rumus'),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuList extends StatelessWidget {
  const MenuList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pilih Bangun Ruang'), backgroundColor: Colors.transparent),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          itemMenu(context, 'Kubus', const LayarHitung(tipe: 'Kubus', gbr: 'kubus.png')),
          itemMenu(context, 'Tabung', const LayarHitung(tipe: 'Tabung', gbr: 'tabung.png')),
          itemMenu(context, 'Kerucut', const LayarHitung(tipe: 'Kerucut', gbr: 'kerucut.png')),
        ],
      ),
    );
  }

  Widget itemMenu(BuildContext context, String judul, Widget tujuan) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(judul, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => tujuan)),
      ),
    );
  }
}

class LayarHitung extends StatefulWidget {
  final String tipe;
  final String gbr;
  const LayarHitung({super.key, required this.tipe, required this.gbr});

  @override
  State<LayarHitung> createState() => _LayarHitungState();
}

class _LayarHitungState extends State<LayarHitung> {
  final c1 = TextEditingController();
  final c2 = TextEditingController();
  String hasil = '';

  void hitung() {
    double v1 = double.tryParse(c1.text) ?? 0;
    double v2 = double.tryParse(c2.text) ?? 0;
    double res = 0;

    if (widget.tipe == 'Kubus') res = v1 * v1 * v1;
    if (widget.tipe == 'Tabung') res = 3.14 * v1 * v1 * v2;
    if (widget.tipe == 'Kerucut') res = (1 / 3) * 3.14 * v1 * v1 * v2;

    setState(() => hasil = 'Volume ${widget.tipe}: ${res.toStringAsFixed(2)} cm³');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hitung ${widget.tipe}'), backgroundColor: Colors.transparent),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Image.asset('assets/${widget.gbr}', height: 150),
            const SizedBox(height: 30),
            TextField(
              controller: c1,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: widget.tipe == 'Kubus' ? 'Sisi (cm)' : 'Jari-jari (cm)',
                border: const OutlineInputBorder(),
              ),
            ),
            if (widget.tipe != 'Kubus') ...[
              const SizedBox(height: 15),
              TextField(
                controller: c2,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Tinggi (cm)', 
                  border: OutlineInputBorder()
                ),
              ),
            ],
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: hitung, child: const Text('Hitung Sekarang')),
            ),
            const SizedBox(height: 40),
            Text(hasil, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue)),
          ],
        ),
      ),
    );
  }
}