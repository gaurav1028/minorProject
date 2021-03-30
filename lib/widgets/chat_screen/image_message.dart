import 'dart:io';

import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:minorProject/widgets/util/modalSheet.dart';
import 'package:minorProject/widgets/util/videoPlayer.dart';

class ImageMessage extends StatelessWidget {
  final bool isself;
  final int type;
  final chatDoc;

  const ImageMessage(this.isself, this.type, this.chatDoc, {Key key})
      : super(key: key);

  void showVideoPlayer(parentContext, String videoUrl) async {
    await showModalBottomSheetApp(
        context: parentContext,
        builder: (BuildContext bc) {
          return VideoPlayerWidget(videoUrl);
        });
  }

  /*
  Supporting only for android for now
   */
  void downloadFile(String fileUrl) async {
    final Directory downloadsDirectory =
        await DownloadsPathProvider.downloadsDirectory;
    final String downloadsPath = downloadsDirectory.path;
    await FlutterDownloader.enqueue(
      url: fileUrl,
      savedDir: downloadsPath,
      showNotification:
          true, // show download progress in status bar (for Android)
      openFileFromNotification:
          true, // click on notification to open downloaded file (for Android)
    );
  }

  @override
  Widget build(BuildContext context) {
    if (type == 1) {
      return ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: FadeInImage(
              placeholder: AssetImage('placeholder.png'),
              image: NetworkImage(chatDoc['text'])));
    } else if (type == 2) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Container(
                  width: 130,
                  color: Colors.deepOrange,
                  height: 80,
                ),
                Column(
                  children: <Widget>[
                    Icon(
                      Icons.videocam,
                      color: Colors.red,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Video',
                      style: TextStyle(
                        fontSize: 20,
                        color: isself
                            ? Colors.grey[300]
                            : Theme.of(context).accentColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
                height: 40,
                child: IconButton(
                    icon: Icon(
                      Icons.play_arrow,
                      color: isself
                          ? Colors.grey[300]
                          : Theme.of(context).accentColor,
                    ),
                    onPressed: () => showVideoPlayer(context, chatDoc['text'])))
          ],
        ),
      );
    } else if (type == 3) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Container(
                  width: 130,
                  color: Colors.grey[300],
                  height: 80,
                ),
                Column(
                  children: <Widget>[
                    Icon(
                      Icons.insert_drive_file,
                      color: Colors.grey[300],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'File',
                      style: TextStyle(
                        fontSize: 20,
                        color: isself
                            ? Colors.grey[300]
                            : Theme.of(context).accentColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
                height: 40,
                child: IconButton(
                    icon: Icon(
                      Icons.file_download,
                      color: isself
                          ? Colors.grey[300]
                          : Theme.of(context).accentColor,
                    ),
                    onPressed: () => downloadFile(chatDoc['text'])))
          ],
        ),
      );
    }
  }
}
