import 'package:provider/provider.dart';
import 'package:tv_project_update/src/components/home/hot_channels.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

import '../../models/channel_model.dart';

class VideoApp extends StatefulWidget {
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late final channelArguments =
      ModalRoute.of(context)!.settings.arguments as Channel;
  late final VideoPlayerController _controller =
      VideoPlayerController.network(channelArguments.stream);

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Provider.of<HotChannels>(
        context,
        listen: false,
      ).autoSaveHotChannels(channelArguments);

      _controller
        ..initialize().then((_) {
          setState(() {
            _controller.play();
          });
        });
    });
  }

  Future<bool> onBackPressed() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Deseja sair?',
            style: TextStyle(color: Theme.of(context).primaryColor)),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Text(
              'Sim',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          FlatButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text('Não',
                style: TextStyle(color: Theme.of(context).primaryColor)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onBackPressed(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          appBar: MediaQuery.of(context).orientation == Orientation.portrait
              ? AppBar(
                  elevation: 0,
                  backgroundColor: Theme.of(context).primaryColor,
                  title: Text(channelArguments.name.toUpperCase()),
                )
              : null,
          body: MediaQuery.of(context).orientation == Orientation.portrait
              ? _controller.value.isInitialized
                  ? Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              _controller.value.isPlaying
                                  ? _controller.pause()
                                  : _controller.play();
                            });
                          },
                          child: AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: Stack(children: [
                              VideoPlayer(_controller),
                              Center(
                                child: Container(
                                  child: _controller.value.isPlaying
                                      ? null
                                      : const Icon(
                                          Icons.pause_circle,
                                          color: Colors.white,
                                          size: 50,
                                        ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Sobre o Canal',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          channelArguments.desc.length >= 800
                                              ? channelArguments.desc
                                                      .substring(0, 800) +
                                                  ' ...'
                                              : channelArguments.desc,
                                          style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.6),
                                            fontSize: 12,
                                          ),
                                          textAlign: TextAlign.justify,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  : Center(
                      child: CircularProgressIndicator(
                          color: Theme.of(context).accentColor),
                    )
              : Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    },
                    child: _controller.value.isBuffering
                        ? const CircularProgressIndicator()
                        : AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: Stack(children: [
                              VideoPlayer(_controller),
                              Center(
                                child: Container(
                                  child: _controller.value.isPlaying
                                      ? null
                                      : const Icon(
                                          Icons.pause_circle,
                                          color: Colors.white,
                                          size: 50,
                                        ),
                                ),
                              ),
                            ]),
                          ),
                  ),
                ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }
}
