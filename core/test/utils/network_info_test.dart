import 'package:core/module/core.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock untuk DataConnectionChecker
class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  late NetworkInfoImpl networkInfo;
  late MockDataConnectionChecker mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfo = NetworkInfoImpl(mockDataConnectionChecker);
  });

  group('isConnected', () {
    test(
      'should forward the call to DataConnectionChecker.hasConnection (connected)',
          () async {
        // Arrange
        when(() => mockDataConnectionChecker.hasConnection)
            .thenAnswer((_) async => true);

        // Act
        final result = await networkInfo.isConnected;

        // Assert
        verify(() => mockDataConnectionChecker.hasConnection).called(1);
        expect(result, true);
      },
    );

    test(
      'should forward the call to DataConnectionChecker.hasConnection (disconnected)',
          () async {
        // Arrange
        when(() => mockDataConnectionChecker.hasConnection)
            .thenAnswer((_) async => false);

        // Act
        final result = await networkInfo.isConnected;

        // Assert
        verify(() => mockDataConnectionChecker.hasConnection).called(1);
        expect(result, false);
      },
    );
  });
}