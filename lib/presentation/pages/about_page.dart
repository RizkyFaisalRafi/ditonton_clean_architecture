import 'package:ditonton_clean_architecture/common/constants.dart';
import 'package:flutter/material.dart';

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
  static const ROUTE_NAME = '/about';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  color: kPrussianBlue,
                  child: Center(
                    child: Image.asset(
                      'assets/images/circle-g.png',
                      width: 128,
                    ),
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
          SafeArea(
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back),
            ),
          )
        ],
      ),
    );
  }
}