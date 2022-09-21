import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../modules/cubite/cubite.dart';
import '../modules/cubite/states_cubite.dart';
import 'components.dart';

class NavTasks extends StatelessWidget {
  const NavTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Cubity, CubityState>(
        listener: (context, state) {},
        builder: (context, state) {
          var tasks = Cubity.get(context).newTasks;

          return tasksBuilder(tasks, Icons.menu_book_rounded);
        });
  }
}
