import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/control/cubit/appCubit.dart';
import 'package:flutter_task/model/hive_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../control/cubit/appStates.dart';
import '../model/user_model.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final formKey = GlobalKey<FormState>();

  final _users = Hive.box('users');
  List<HiveUser> hiveUsers = [];

  fillHiveUsers() {
    if (hiveUsers.length != _users.length) {
      for (int i = 0; i < _users.length; i++) {
        hiveUsers.add(_users.getAt(i));
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    fillHiveUsers();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context).dataModel;
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text('Add players'),
            titleTextStyle: const TextStyle(
              fontSize: 18,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
            centerTitle: true,
          ),
          body: (state is GetUserLoadingState)
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 80,
                        child: ListView.separated(
                            separatorBuilder: (context, index) => const SizedBox(
                                  width: 20,
                                ),
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (context, index) =>
                                (index + 1 > _users.length)
                                    ? buildUser(null, false, index)
                                    : (_users.getAt(index) == null)
                                        ? buildUser(
                                            _users.getAt(index), false, index)
                                        : buildUser(
                                            _users.getAt(index), true, index)),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          color: const Color(0xffF8F8F8),
                          height: 46,
                          child: TextField(
                            onSubmitted: (value) {
                              AppCubit.get(context).filterUsers(text: value);

                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              hintText: 'Search By player name',
                              hintStyle: const TextStyle(
                                color: Color(0xff979797),
                              ),
                              prefixStyle: const TextStyle(
                                color: Color(0xff979797),
                              ),
                              prefixIconConstraints:
                                  const BoxConstraints(minHeight: 17, minWidth: 17),
                              prefixIcon: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Icon(Icons.search),
                              ),
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Flexible(
                        child: ListView.separated(
                            itemBuilder: (context, index) => buildUserList(
                                (AppCubit.get(context).filteredUsers.isNotEmpty)
                                    ? AppCubit.get(context).filteredUsers[index]
                                    : cubit!.users[index],
                                index),
                            separatorBuilder: (context, index) => const SizedBox(
                                  height: 15,
                                ),
                            itemCount:
                                (AppCubit.get(context).filteredUsers.isNotEmpty)
                                    ? AppCubit.get(context).filteredUsers.length
                                    : AppCubit.get(context)
                                        .dataModel!
                                        .users
                                        .length),
                      )
                    ],
                  ),
                ),
        );
      },
    );
  }

  Widget buildUser(HiveUser? user, bool itemExisted, int userIndex ) => Column(
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      width: 1,
                      color: Colors.black,
                    )),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  radius: 25,
                  child: (itemExisted)
                      ? Image(
                          image: NetworkImage(
                            user!.image,
                          ),
                        )
                      : const Icon(
                          (Icons.person_add_alt_outlined),
                        ),
                ),
              ),
              InkWell(
                onTap: () {
                  _users.deleteAt(userIndex);


                  setState(() {});
                },
                child: const CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.close,
                    color: Colors.red,
                    size: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          (user != null)
              ? Visibility(
                  visible: itemExisted,
                  child: Text(
                    user.firstName,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              : Container(),
        ],
      );

  Widget buildUserList(Users model, int index) => Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(model.image),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            '${model.firstName} ${model.lastName}',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          (
                  hiveUsers
                  .where((element) => element.id == model.id)
                  .toList()
                  .isNotEmpty
          )
              ? GestureDetector(
                  onTap: () {
                    _users.deleteAt(hiveUsers.indexOf(hiveUsers.where((element) => element.id == model.id).toList()[0]));
                    hiveUsers.removeAt(hiveUsers.indexOf(hiveUsers.where((element) => element.id == model.id).toList()[0]));
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.red,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: const Text(
                      'remove',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ))
              : GestureDetector(
                  onTap: () {
                    final _users = Hive.box('users');
                    final image = HiveUser(
                      index: _users.length,
                      image: model.image,
                      id: model.id,
                      firstName: model.firstName,
                      lastName: model.lastName,
                    );
                    _users.add(image);
                    hiveUsers.add(image);
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xff545ADF),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: const Text(
                      'Add',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
        ],
      );
}
