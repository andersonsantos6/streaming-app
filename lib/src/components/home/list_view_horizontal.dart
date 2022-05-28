import 'package:flutter/material.dart';
import 'package:tv_project_update/src/models/channel_model.dart';

class HorizontalListViewBuilder {
  Widget horizontalListViewBuilder(List _listChannels, Axis scrollDirection) {
    return ListView.builder(
      scrollDirection: scrollDirection,
      itemCount: _listChannels.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => Navigator.of(context).pushNamed(
            '/player',
            arguments: Channel(
              name: _listChannels[index]['name'],
              category: _listChannels[index]['category'],
              desc: _listChannels[index]['desc'],
              png: _listChannels[index]['png'],
              stream: _listChannels[index]['stream'],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: 300,
                child: Stack(children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Image.network(
                      _listChannels[index]['png'],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(255, 242, 12, 31),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        _listChannels[index]['name'].toString().toUpperCase(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
