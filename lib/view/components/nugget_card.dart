import 'package:flutter/material.dart';
import 'package:nugget_berg/view/tabs/home/components/main_content.dart';

class NuggetCard extends StatelessWidget {
  const NuggetCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const Material(child: MainContent()),
          ));
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOU4ZwXLhqyebgok9yT4o0-vskE_hwEvZDtA&usqp=CAU',
              height: 200,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black,
                    Colors.transparent,
                  ],
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Expanded(
                  child: Text(
                    'How to get rich in your 20s',
                    style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
