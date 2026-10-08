import 'package:flutter/material.dart';

class Moderate09StarRatingWidgetScreen extends StatefulWidget {
  const Moderate09StarRatingWidgetScreen({super.key});

  @override
  State<Moderate09StarRatingWidgetScreen> createState() =>
      _Moderate09StarRatingWidgetScreenState();
}

class _Moderate09StarRatingWidgetScreenState
    extends State<Moderate09StarRatingWidgetScreen> {
  int _rating = 0;

  final List<String> _ratingTexts = [
    'Tap a star to rate',
    '1/5 - Poor',
    '2/5 - Fair',
    '3/5 - Good',
    '4/5 - Very Good',
    '5/5 - Excellent!'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moderate 9: Star Rating Widget'),
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(24),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Rate Your Experience',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    final starNumber = index + 1;
                    return IconButton(
                      iconSize: 40,
                      icon: Icon(
                        starNumber <= _rating ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                      ),
                      onPressed: () {
                        setState(() {
                          _rating = starNumber;
                        });
                      },
                    );
                  }),
                ),
                const SizedBox(height: 16),
                Text(
                  _ratingTexts[_rating],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: _rating > 0 ? Colors.amber.shade900 : Colors.grey,
                  ),
                ),
                if (_rating > 0) ...[
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _rating = 0;
                      });
                    },
                    child: const Text('Reset Rating'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
