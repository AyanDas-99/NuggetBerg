import 'package:flutter/material.dart';

class NuggetCard extends StatelessWidget {
  const NuggetCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOU4ZwXLhqyebgok9yT4o0-vskE_hwEvZDtA&usqp=CAU',
                height: 200,
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Text(
                  'How to get rich in your 20s',
                  style: TextStyle(fontWeight: FontWeight.w200, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
