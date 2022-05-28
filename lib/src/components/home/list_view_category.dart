import 'package:flutter/material.dart';
import 'package:tv_project_update/src/models/channel_model.dart';

class ListViewBuilder {
  Widget listViewBuilder(List _listChannels, Axis scrollDirection) {
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
            child: Container(
                child: Stack(children: [
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Theme.of(context).primaryColor),
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        _listChannels[index]['name'].toString().toUpperCase(),
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ]),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: Image.network(_listChannels[index]['png']).image,
                        fit: BoxFit.cover)),
                height:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.height * 0.14
                        : MediaQuery.of(context).size.height * 0.24),
          ),
        );
      },
    );
  }
}
