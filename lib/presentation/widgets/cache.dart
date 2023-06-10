// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:polish_dictionary/domain/models/WordItem.dart';
// import 'package:polish_dictionary/presentation/screens/card-screen.dart';
// import 'package:polish_dictionary/presentation/utils/database_helper.dart';
// import 'package:polish_dictionary/presentation/utils/language_preferences.dart';

// class CardCategory extends StatelessWidget {
//   const CardCategory({super.key});

//   @override
//   Widget build(BuildContext context) {
//     List<Word> wordsList = [];
//     Future<List<Word>> word() async {
//       final dbHelper = DatabaseHelper();

//       await dbHelper.initializeDatabase();

//       final List<Word> words = await dbHelper.getAllWords();
//       wordsList = words;
//       return words;
//     }

//     List<String> uniqueCategories = [];

//     wordsList.forEach((word) {
//       if (!uniqueCategories.contains(word.category)) {
//         uniqueCategories.add(word.category);
//       }
//     });
//     return SizedBox(
//       width: double.infinity,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//         child: FutureBuilder<List<Word>>(
//           future: word(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const CircularProgressIndicator();
//             } else if (snapshot.hasError) {
//               return const Center(
//                 child: Text('Ошибка загрузки данных'),
//               );
//             } else {
//               List<Word> wordList = snapshot.data ?? [];
//               return Wrap(
//                 spacing: 8, // Отступ между контейнерами
//                 runSpacing: 8, // Отступ между строками
//                 children: List.generate(wordList.length, (index) {
//                   double containerWidth =
//                       (MediaQuery.of(context).size.width - 16) / 3 - 8;
//                   return Container(
//                     color: Color.fromARGB(255, 181, 181, 181),
//                     height: 130,
//                     width: containerWidth,
//                     child: CupertinoButton(
//                       padding: EdgeInsets.zero,
//                       pressedOpacity: .8,
//                       onPressed: () => {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => CardScreen(
//                               wordList: wordList,
//                             ),
//                           ),
//                         ),
//                       },
//                       child: Card(
//                         child: Column(
//                           children: [
//                             Container(
//                               height: 100,
//                               decoration:
//                                   const BoxDecoration(color: Colors.red),
//                             ),
//                             Text(wordList[index].category)
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 }),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
