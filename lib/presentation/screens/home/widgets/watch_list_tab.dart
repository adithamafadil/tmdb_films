import 'package:flutter/material.dart';

class WatchlistTab extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final void Function() onTap;

  const WatchlistTab({
    Key? key,
    required this.label,
    required this.icon,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  TextStyle _labelStyle() {
    return const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: 50,
          child: Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, size: isActive ? 26 : null),
                    const SizedBox(width: 12),
                    Text(
                      label,
                      style: isActive ? _labelStyle() : null,
                    )
                  ],
                ),
              ),
              if (isActive) const Divider(height: 5, color: Colors.white)
            ],
          ),
        ),
      ),
    );
  }
}
