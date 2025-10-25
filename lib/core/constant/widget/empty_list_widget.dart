import 'package:flutter/material.dart';

class EmptyResults extends StatelessWidget {
  const EmptyResults();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Opacity(
        opacity: 0.6,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.find_in_page, size: 40),
            SizedBox(height: 8),
            Text('No matches'),
          ],
        ),
      ),
    );
  }
}
