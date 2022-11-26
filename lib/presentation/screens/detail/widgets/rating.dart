import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  final double voteAverage;
  const Rating({Key? key, required this.voteAverage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(5, (i) => i + 1)
            .map((i) => Icon(
                  i <= (voteAverage / 2).round()
                      ? Icons.star
                      : Icons.star_border,
                  color: Colors.amber,
                  size: 20,
                ))
            .toList(),
        const SizedBox(width: 8),
        Text(
          '$voteAverage',
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
