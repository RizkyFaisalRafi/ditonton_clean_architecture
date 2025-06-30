import 'package:core/module/core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

enum ErrorType { noConnection, noResult, invalidQuery, emptyQuery, serverError }

ErrorType detectErrorType(String message) {
  if (message.contains("Failed to connect to the network")) {
    return ErrorType.noConnection;
  } else if (message.contains('No results found')) {
    return ErrorType.noResult;
  } else if (message.contains('Query contains invalid characters')) {
    return ErrorType.invalidQuery;
  } else if (message.contains('Query cannot be empty')) {
    return ErrorType.emptyQuery;
  } else {
    return ErrorType.serverError;
  }
}

class ErrorStateWidget extends StatelessWidget {
  final String message;
  final String title;

  const ErrorStateWidget({
    super.key,
    required this.message,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final errorType = detectErrorType(message);
    String asset;
    String displayMessage;

    switch (errorType) {
      case ErrorType.noConnection:
        asset = noConnectionLottiePath;
        displayMessage = 'No Internet Connection!';
        break;
      case ErrorType.noResult:
        asset = noResultsFoundLottiePath;
        displayMessage = '$title Search Not Found!';
        break;
      case ErrorType.invalidQuery:
        asset = errorLottiePath;
        displayMessage = 'Invalid Character $title Search!';
        break;
      case ErrorType.emptyQuery:
        asset = whereQueryLottiePath;
        displayMessage = '$title Search Cannot be empty!';
        break;
      case ErrorType.serverError:
        asset = errorLottiePath;
        displayMessage = '$title Server Failure!';
        break;
    }
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(asset, width: 300, height: 300),

            Text(displayMessage, style: kSubtitle),
          ],
        ),
      ),
    );
  }
}

class ErrorStateWidget2 extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorStateWidget2({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 60, color: Colors.red),
            SizedBox(height: 12),
            Text(
              message,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              key: Key('elevated_button_ErrorStateWidget2'),
              onPressed: onRetry,
              child: Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

class EmptyStateWidget extends StatelessWidget {
  final String message;

  const EmptyStateWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(whereQueryLottiePath, width: 180, height: 150),
          Text(
            message,
            style: kSubtitle.copyWith(fontSize: 16, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
