import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_project_update/src/components/home/category_button_widget.dart';
import 'package:tv_project_update/src/components/home/hot_channels.dart';
import 'package:tv_project_update/src/components/home/list_view_category.dart';
import 'package:tv_project_update/src/components/home/list_view_horizontal.dart';
import 'package:tv_project_update/src/pages/drawer/drawer.dart';
import 'package:tv_project_update/src/pages/home/last_channels.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

late String nameCategory = 'variedades';

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          title: const Text('VêTV'),
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('channels').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).accentColor,
                ),
              );
            }

            return Column(
              children: [
                Container(
                  child: Builder(builder: (context) {
                    return Consumer<HotChannels>(
                      builder: (context, value, child) {
                        return value.lastChannel.isEmpty
                            ? Column(
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 20,
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Em alta',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .accentColor,
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Icon(
                                            Icons.trending_up,
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('recommended')
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      return Expanded(
                                        flex: 1,
                                        child: Container(
                                          child: HorizontalListViewBuilder()
                                              .horizontalListViewBuilder(
                                            snapshot.data!.docs.map((channel) {
                                              return channel;
                                            }).toList(),
                                            Axis.horizontal,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 20,
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Continuar assistindo',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .accentColor,
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Icon(Icons.play_circle,
                                              color: Theme.of(context)
                                                  .accentColor),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                        child: LastChannels()
                                            .lastChannels(value.lastChannel)),
                                  ),
                                ],
                              );
                      },
                    );
                  }),
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: double.infinity,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Categorias',
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Container(
                  height: 60,
                  width: double.infinity,
                  child: ListView(scrollDirection: Axis.horizontal, children: [
                    const SizedBox(
                      width: 10,
                    ),
                    CategoryWidget(
                      nameCategory: 'Variedades',
                      fnSetstate: () {
                        setState(() {
                          nameCategory = 'variedades';
                        });
                      },
                    ),
                    CategoryWidget(
                      nameCategory: 'Religioso',
                      fnSetstate: () {
                        setState(() {
                          nameCategory = 'religioso';
                        });
                      },
                    ),
                    CategoryWidget(
                      nameCategory: 'Jornalismo',
                      fnSetstate: () {
                        setState(() {
                          nameCategory = 'jornalismo';
                        });
                      },
                    ),
                    CategoryWidget(
                      nameCategory: 'Desenhos',
                      fnSetstate: () {
                        setState(() {
                          nameCategory = 'religioso';
                        });
                      },
                    ),
                    CategoryWidget(
                      nameCategory: 'Religioso',
                      fnSetstate: () {
                        setState(() {
                          nameCategory = 'religioso';
                        });
                      },
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(color: Theme.of(context).accentColor),
                ),
                Expanded(
                  flex: 3,
                  child: ListViewBuilder().listViewBuilder(
                      snapshot.data!.docs.where((channel) {
                        return channel['category'] == nameCategory;
                      }).toList(),
                      Axis.vertical),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
