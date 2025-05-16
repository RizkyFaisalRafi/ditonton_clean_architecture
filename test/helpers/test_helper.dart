import 'package:ditonton_clean_architecture/common/network_info.dart';
import 'package:ditonton_clean_architecture/data/datasources/db/database_helper.dart';
import 'package:ditonton_clean_architecture/data/datasources/movie_local_data_source.dart';
import 'package:ditonton_clean_architecture/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton_clean_architecture/domain/repositories/movie_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

// Daftarkan kelas yang ingin di-mock pada sebuah fungsi main().
@GenerateMocks(
  [
    MovieRepository,
    MovieRemoteDataSource,
    MovieLocalDataSource,
    DatabaseHelper,
    NetworkInfo,
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
