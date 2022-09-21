import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nota/components/components.dart';
import 'package:nota/modules/cubite/cubite.dart';
import 'package:nota/modules/cubite/states_cubite.dart';


class MyHome extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  bool isButtomSheet = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => Cubity()..createDatabase(),
        child: BlocConsumer<Cubity, CubityState>(
            listener: (context, state) {},
            builder: (context, state) {
              Cubity cubity = Cubity.get(context);
              return Scaffold(
                key: scaffoldKey,
                appBar: AppBar(
                  backgroundColor: Colors.amber[400],
                  title: const Text('Nota'),
                ),
                bottomNavigationBar: BottomNavigationBar(
                    currentIndex: cubity.navIndex,
                    onTap: (value) {
                      cubity.changNavIndex(value);
                    },
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.archive),
                        label: "Archive",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.menu_book_rounded),
                        label: "Tasks",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.check_circle_outline),
                        label: "Done",
                      ),
                    ]),
                floatingActionButton: FloatingActionButton(
                  child: Icon(cubity.floatIcon),
                  onPressed: () {
                    if (isButtomSheet) {
                      cubity.floatIconAdd(Icons.edit_rounded);
                      scaffoldKey.currentState!
                          .showBottomSheet((context) => Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Form(
                                  key: formKey,
                                  child: Container(
                                    height: 300,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            //STATUS
                                            defultFormField(
                                                controller:
                                                    cubity.textController,
                                                type: TextInputType.text,
                                                lable: "Status",
                                                prefix: Icons
                                                    .format_color_text_outlined,
                                                validate: (String value) {
                                                  if (value.isEmpty) {
                                                    return 'Status is Empty';
                                                  }
                                                  return null;
                                                },
                                                onTap: () {}),
                                            const SizedBox(
                                              height: 25,
                                            ),
                                            //TIME
                                            defultFormField(
                                                controller:
                                                    cubity.timeController,
                                                onTap: () {
                                                  showTimePicker(
                                                          context: context,
                                                          initialTime:
                                                              TimeOfDay.now())
                                                      .then((value) => cubity
                                                              .timeController
                                                              .text =
                                                          value!
                                                              .format(context));
                                                },
                                                type: TextInputType.datetime,
                                                lable: "Time",
                                                prefix: Icons.timer,
                                                validate: (String value) {
                                                  if (value.isEmpty) {
                                                    return 'Time is Empty';
                                                  }
                                                  return null;
                                                }),
                                            const SizedBox(
                                              height: 25,
                                            ),
                                            //DATE
                                            defultFormField(
                                                controller:
                                                    cubity.dateController,
                                                onTap: () {
                                                  showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate:
                                                              DateTime(1990),
                                                          lastDate:
                                                              DateTime(2025))
                                                      .then((value) => cubity
                                                              .dateController
                                                              .text =
                                                          DateFormat.yMMMd()
                                                              .format(value!));
                                                },
                                                type: TextInputType.datetime,
                                                lable: "Date",
                                                prefix:
                                                    Icons.date_range_outlined,
                                                validate: (String value) {
                                                  if (value.isEmpty) {
                                                    return 'Date is Empty';
                                                  }
                                                  return null;
                                                }),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ))
                          .closed
                          .then((value) {
                        cubity.floatIconClosed(Icons.add);
                        isButtomSheet = true;
                      });
                      isButtomSheet = false;
                    } else {
                      cubity.insertDatabase(
                          cubity.textController.text,
                          cubity.timeController.text,
                          cubity.dateController.text);
                      Navigator.pop(context);
                      cubity.floatIconClosed(Icons.add);
                      isButtomSheet = true;
                    }

                    // Navigator.push(
                    //     context, MaterialPageRoute(builder: (context) => NoteScreen()));
                  },
                ),
                body: cubity.navList[cubity.navIndex],
              );
            }));
  }
}
