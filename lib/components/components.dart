import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../modules/cubite/cubite.dart';

Widget defultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String lable,
  required IconData prefix,
  Function? onSubmit,
  required Function validate,
  Function? onTap,
}) =>
    TextFormField(
        controller: controller,
        keyboardType: type,
        onFieldSubmitted: (s) {
          onSubmit!();
        },
        validator: (v) {
           return validate(v);
        },
        onTap: () {
          onTap!();
        },
        decoration: InputDecoration(
          labelText: lable,
          prefixIcon: Icon(prefix),
          border: const OutlineInputBorder(),
        ));

Widget navItems(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction) {
        Cubity.get(context).deleteDatabase(model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              child: Text("${model['time']}"),
            ),
            const SizedBox(
              width: 14,
            ),
            Expanded(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text(
                  "${model['title']}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${model['date']}",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
              ]),
            ),
            IconButton(
                color: Colors.green,
                onPressed: () {
                  Cubity.get(context)
                      .updateDatabase(status: 'done', id: model['id']);
                },
                icon: const Icon(Icons.check_circle_rounded)),
            IconButton(
                color: Colors.black45,
                onPressed: () {
                  Cubity.get(context)
                      .updateDatabase(status: 'archived', id: model['id']);
                },
                icon: const Icon(Icons.archive)),
          ],
        ),
      ),
    );

Widget tasksBuilder (List<Map> tasks ,IconData icon)=>ConditionalBuilder(
              condition: tasks.isNotEmpty,
              builder: (context) => ListView.separated(
                  itemBuilder: (context, index) =>
                      navItems(tasks[index], context),
                  separatorBuilder: (context, index) => Container(),
                  itemCount: tasks.length),
              fallback: (context) =>
                  Center(child: columnWhenEmpty(icon)));

Widget columnWhenEmpty(IconData icon) {
  return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        Icon(
          icon,
          size: 80,
          color: Colors.grey,
        ),
        const Text(
          'No Items Yet . Please Enter Any Tasks',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        )
      ],
    );
}
