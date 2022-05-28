import 'package:flutter/cupertino.dart';
import 'package:tv_project_update/src/models/channel_model.dart';

class HotChannels extends ChangeNotifier {
  final List<Channel> _lastChannel = [];

  List<Channel> get lastChannel {
    return _lastChannel;
  }

  autoSaveHotChannels(Channel channel) {
    int count = 0;
    bool duplicated = false;

    while (count < lastChannel.length) {
      if (channel.name == lastChannel[count].name) {
        duplicated = true;
      }
      count++;
    }
    if (duplicated == false) {
      _lastChannel.add(channel);
    }
    notifyListeners();
  }
}
