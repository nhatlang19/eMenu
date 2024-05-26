import 'package:emenu/config/themes/app_text_styles.dart';
import 'package:emenu/modules/order/bloc/menu_bloc.dart';
import 'package:emenu/modules/order/bloc/submenu_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MenuGridRight extends StatelessWidget {
  const MenuGridRight({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Column(
        children: [
          Container(
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  iconSize: 50.0,
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                BlocBuilder<MenuBloc, MenuState>(
                    buildWhen: (previous, current) =>
                        previous.menu.defaultValue != current.menu.defaultValue,
                    builder: (context, state) {
                      return Expanded(
                          child: Center(
                              child: Text(
                        state.menu.description,
                        style: AppTextStyles.tableTitleWhite,
                      )));
                    }),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, 'CartPage');
                      },
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_bag,
                            color: Colors.white,
                            size: 50.0,
                          ),
                          Text(
                            'View Order',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: BlocBuilder<SubMenuBloc, SubmenuState>(
                    // buildWhen: (previous, current) =>
                    //     previous.menu.defaultValue != current.menu.defaultValue,
                    builder: (context, state) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5, // Number of columns in the grid
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                    ),
                    itemCount:
                        state.submenus.length, // Number of items in the grid
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.white,
                        elevation: 0,
                        margin: const EdgeInsets.all(2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(height: 5),
                            Stack(children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                                child: Center(
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'https://images.unsplash.com/photo-1602881917760-7379db593981?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Zm9vZCUyMGJvd2x8ZW58MHx8MHx8fDA%3D',
                                    placeholder: (context, url) => Center(
                                        child: const CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        Center(child: Icon(Icons.error)),
                                    height: 110,
                                    width: 110,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 5,
                                left: 5,
                                child: Icon(
                                  Icons.add_circle_outline,
                                  color: Colors.grey[400],
                                  size: 30,
                                ),
                              ),
                            ]),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  state.submenus[index].description,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                })),
          ),
        ],
      ),
    );
  }
}
