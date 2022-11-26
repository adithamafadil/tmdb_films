import 'package:flutter/material.dart';

class FilmLabel extends StatelessWidget {
  final String label;
  final void Function() onTapSeeAll;
  const FilmLabel({
    Key? key,
    required this.label,
    required this.onTapSeeAll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        TextButton(
          onPressed: onTapSeeAll,
          child: Row(
            children: const [
              Text('Lihat Semua'),
              SizedBox(width: 5),
              Icon(
                Icons.arrow_forward_ios,
                size: 12,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
