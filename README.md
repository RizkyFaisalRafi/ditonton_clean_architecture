# a199-flutter-expert-project

[//]: # (# Github: https://github.com/RizkyFaisalRafi/a199-flutter-expert-project)

[//]: # (# [![Codemagic build status]&#40;https://api.codemagic.io/apps/6379c4a01063f44db75df13a/6379c4a01063f44db75df139/status_badge.svg&#41;]&#40;https://codemagic.io/apps/6379c4a01063f44db75df13a/6379c4a01063f44db75df139/latest_build&#41;)

Repository ini merupakan project awal dan akhir submission kelas Flutter Expert Dicoding Indonesia 2025.

---

Run in Git Bash for Coverage
Coverage App:
flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter test --machine > tests.output
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html --legend -t "Clean Architecture Submission Awal Expert" --function-coverage

## Tips Submission Awal

Pastikan untuk memeriksa kembali seluruh hasil testing pada submissionmu sebelum dikirimkan. Karena kriteria pada submission ini akan diperiksa setelah seluruh berkas testing berhasil dijalankan.


## Tips Submission Akhir

Jika kamu menerapkan modular pada project, Anda dapat memanfaatkan berkas `test.sh` pada repository ini. Berkas tersebut dapat mempermudah proses testing melalui *terminal* atau *command prompt*. Sebelumnya menjalankan berkas tersebut, ikuti beberapa langkah berikut:
1. Install terlebih dahulu aplikasi sesuai dengan Operating System (OS) yang Anda gunakan.
    - Bagi pengguna **Linux**, jalankan perintah berikut pada terminal.
        ```
        sudo apt-get update -qq -y
        sudo apt-get install lcov -y
        ```

    - Bagi pengguna **Mac**, jalankan perintah berikut pada terminal.
        ```
        brew install lcov
        ```
    - Bagi pengguna **Windows**, ikuti langkah berikut.
        - Install [Chocolatey](https://chocolatey.org/install) pada komputermu.
        - Setelah berhasil, install [lcov](https://community.chocolatey.org/packages/lcov) dengan menjalankan perintah berikut.
            ```
            choco install lcov
            ```
        - Kemudian cek **Environtment Variabel** pada kolom **System variabels** terdapat variabel GENTHTML dan LCOV_HOME. Jika tidak tersedia, Anda bisa menambahkan variabel baru dengan nilai seperti berikut.
          | Variable | Value|
          | ----------- | ----------- |
          | GENTHTML | C:\ProgramData\chocolatey\lib\lcov\tools\bin\genhtml |
          | LCOV_HOME | C:\ProgramData\chocolatey\lib\lcov\tools |

2. Untuk mempermudah proses verifikasi testing, jalankan perintah berikut.
    ```
    git init
    ```
3. Kemudian jalankan berkas `test.sh` dengan perintah berikut pada *terminal* atau *powershell*.
    ```
    test.sh
    ```
   atau
    ```
    ./test.sh
    ```
   Proses ini akan men-*generate* berkas `lcov.info` dan folder `coverage` terkait dengan laporan coverage.
4. Tunggu proses testing selesai hingga muncul web terkait laporan coverage.

