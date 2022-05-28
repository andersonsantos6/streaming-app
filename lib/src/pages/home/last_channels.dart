import 'package:flutter/material.dart';

import '../../models/channel_model.dart';

class LastChannels {
  Widget lastChannels(List<Channel> _listChannels) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: _listChannels.length,
      itemBuilder: ((context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: InkWell(
              onTap: () => Navigator.of(context).pushNamed(
                '/player',
                arguments: Channel(
                  name: _listChannels[index].name,
                  category: _listChannels[index].category,
                  desc: _listChannels[index].desc,
                  png: _listChannels[index].png,
                  stream: _listChannels[index].stream,
                ),
              ),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: 300,
                child: Stack(children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Image.network(
                      _listChannels[index].png,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        _listChannels[index].name.toString().toUpperCase(),
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
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
      }),
    );
  }
}
