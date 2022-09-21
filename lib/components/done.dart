import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../modules/cubite/cubite.dart';
import '../modules/cubite/states_cubite.dart';
import 'components.dart';

class NavDone extends StatelessWidget {
  const NavDone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Cubity, CubityState>(
        listener: (context, state) {},
        builder: (context, state) {
          var tasks = Cubity.get(context).doneTasks;

          return tasksBuilder(tasks, Icons.check_circle_outline);
        });
  }
}
