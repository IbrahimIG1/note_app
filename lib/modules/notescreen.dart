// import 'package:bloc/bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:nota_project/modules/cubite/states_cubite.dart';
// import 'package:path/path.dart';
// 
// import 'cubite/cubite.dart';
// 
// class NoteScreen extends StatelessWidget {
//   late TextEditingController controller1;
//   late TextEditingController controller2;
//   //var Controller2 = TextEditingController;
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => Cubity()..createDatabase(),
//       child: BlocConsumer<Cubity, CubityState>(
//         listener: (context, state) {},
//         builder: (context, state) {
//           Cubity cubity = Cubity.get(context);
//           return Scaffold(
//             appBar: AppBar(),
//             body: ListView(
//               children: [
//                 Form(
//                   child: Column(
//                     children: [
//                       TextFormField(
//                         controller: controller1,
//                         decoration: const InputDecoration(
//                             hintText: 'العنوان',
//                             hintStyle: TextStyle(
//                               fontSize: 24,
//                               color: Colors.grey,
//                             ),
//                             enabledBorder: InputBorder.none),
//                       ),
//                       TextFormField(
//                         controller: controller2,
//                         keyboardType: TextInputType.text,
//                         //focusNode: FocusNode(skipTraversal: true),
//                         decoration: const InputDecoration(
//                             hintText: 'ابدأ فى الكتابة',
//                             hintStyle: TextStyle(
//                               fontSize: 15,
//                               color: Colors.grey,
//                             ),
//                             enabledBorder: InputBorder.none),
//                         maxLines: 300,
//                         minLines: 200,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             floatingActionButton: FloatingActionButton(
//               child: const Icon(Icons.done),
//               onPressed: () {
//                 cubity.insertDatabase(controller1.text, controller2.text);
//                 Navigator.pop(context);
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
