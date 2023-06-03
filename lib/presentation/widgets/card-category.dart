import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polish_dictionary/presentation/screens/card-screen.dart';

class CardCategory extends StatelessWidget {
  const CardCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Beginner",
              style: GoogleFonts.roboto(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Wrap(
              spacing: 8, // Отступ между контейнерами
              runSpacing: 8, // Отступ между строками
              children: List.generate(6, (index) {
                double containerWidth =
                    (MediaQuery.of(context).size.width - 16) / 3 - 8;
                // Рассчитываем ширину контейнера с учетом отступов
                return Container(
                  color: Color.fromARGB(255, 181, 181, 181),
                  height: 130,
                  width: containerWidth,
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    pressedOpacity: .8,
                    onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CardScreen()))
                    },
                    child: Card(
                      child: Column(
                        children: [
                          Container(
                            height: 100,
                            decoration: const BoxDecoration(color: Colors.red),
                          ),
                          const Text("Basic")
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
