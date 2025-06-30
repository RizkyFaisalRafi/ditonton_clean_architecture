import 'package:core/module/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*
 * Setelah membahas struktur objek Domain dan Data, selanjutnya kita akan masuk ke
 * bagian Presentation. Presentation merupakan lapisan terluar dari clean architecture
 * yang dekat dengan sisi pengguna. Di sinilah kita meletakkan kode framework Flutter
 * seperti Widget untuk menyusun UI.
 *
 * Bagian ini merupakan bagian project yang “Flutter banget”. Di sini kita menyusun
 * widget-widget menjadi tampilan antarmuka yang bisa dilihat dan dapat berinteraksi dengan pengguna.
*/
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About App'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            // final customDrawerState =
            //     context.findRootAncestorStateOfType<CustomDrawerState>();
            // customDrawerState?.toggle();
            context.read<CustomDrawerNotifier>().toggle();

          },
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  color: kPrussianBlue,
                  child: Center(
                    child: Image.asset('packages/about/assets/circle_g.png', width: 128),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(32.0),
                  color: kMikadoYellow,
                  child: Text(
                    'Ditonton merupakan sebuah aplikasi katalog film yang dikembangkan oleh Dicoding Indonesia sebagai contoh proyek aplikasi untuk kelas Menjadi Flutter Developer Expert.',
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
