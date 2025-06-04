import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../common/constants.dart';

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
    if (message.contains("Failed to connect to the network")) {
      return Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/image_lottie/no_connection.json',
                width: 300,
                height: 300,
              ),
              Text(
                'No Internet Connection!',
                // AppLocalizations.of(context)!.noInternetConnection,
                style: kSubtitle,
              ),
            ],
          ),
        ),
      );
    } else if (message.contains('No results found')) {
      return Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/image_lottie/no_results_found.json',
                width: 300,
                height: 300,
              ),
              Text(
                '$title Search Not Found!',
                // AppLocalizations.of(context)!.anErrorOccurredOnTheServer,
                style: kSubtitle,
              ),
            ],
          ),
        ),
      );
    } else if (message.contains('Query contains invalid characters')) {
      return Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/image_lottie/error.json',
                width: 300,
                height: 300,
              ),
              Text(
                'Invalid Character $title Search!',
                // AppLocalizations.of(context)!.anErrorOccurredOnTheServer,
                style: kSubtitle,
              ),
            ],
          ),
        ),
      );
    } else if (message.contains('Query cannot be empty')) {
      /// Query Cannot Be Empty
      return Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/image_lottie/where_query.json',
                width: 300,
                height: 300,
              ),
              Text(
                '$title Search Cannot be empty!',
                // AppLocalizations.of(context)!.anErrorOccurredOnTheServer,
                style: kSubtitle,
              ),
            ],
          ),
        ),
      );
    } else {
      /// Error All
      return Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/image_lottie/error.json',
                width: 300,
                height: 300,
              ),
              Text(
                'Terjadi Kesalahan Pada Server!',
                // AppLocalizations.of(context)!.anErrorOccurredOnTheServer,
                style: kSubtitle,
              ),
            ],
          ),
        ),
      );
    }
  }
}
