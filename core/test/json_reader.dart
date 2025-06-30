import 'dart:io';

String readJson(String name) {
  // Mendapatkan direktori kerja saat ini
  var dir = Directory.current.path;

  // Menangani kasus jika tes dijalankan dari dalam folder /test
  if (dir.endsWith('/test')) {
    dir = dir.replaceAll('/test', '');
  }

  // Membaca file dan mengembalikan isinya sebagai String
  return File('$dir/test/$name').readAsStringSync();
}