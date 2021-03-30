import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

import 'package:path/path.dart' show basename;

class NewMessage extends StatefulWidget {
  final String receiverID;
  final String type;
  NewMessage(this.receiverID, this.type);
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enteredMessage = '';
  final _controller = new TextEditingController();

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = await FirebaseAuth.instance.currentUser();
    final userData = await Firestore.instance
        .collection('${widget.type}')
        .document(user.uid)
        .get();
    Firestore.instance.collection('chat/${user.uid}/${widget.receiverID}').add(
      {
        'type': 0,
        'text': _enteredMessage,
        'createdAt': Timestamp.now(),
        'sender': user.uid,
        'receiver': widget.receiverID,
        'username': userData['username'],
      },
    );
    Firestore.instance.collection('chat/${widget.receiverID}/${user.uid}').add(
      {
        'type': 0,
        'text': _enteredMessage,
        'createdAt': Timestamp.now(),
        'sender': user.uid,
        'receiver': widget.receiverID,
        'username': userData['username'],
      },
    );
    setState(() {
      _controller.clear();
      _enteredMessage = '';
    });

    return;
  }

  Future<String> uploadFile(File file, FileType type, String uid) async {
    String fileName = basename(file.path);
    String path;

    if (type == FileType.image) {
      path = 'image';
    } else if (type == FileType.video) {
      path = 'video';
    } else {
      path = 'any';
    }
    print(path);
    StorageReference reference = FirebaseStorage.instance.ref().child(
        '$path/$uid-$fileName'); // get a reference to the path of the image directory
    String p = await reference.getPath();
    print('uploading to $p');
    StorageUploadTask uploadTask =
        reference.putFile(file); // put the file in the path
    StorageTaskSnapshot result =
        await uploadTask.onComplete; // wait for the upload to complete
    String url = await result.ref
        .getDownloadURL(); //retrieve the download link and return it
    return url;
  }

  Future<void> sendFile(File file, FileType type) async {
    final user = await FirebaseAuth.instance.currentUser();
    String url = await uploadFile(
      file,
      type,
      user.uid,
    );
    print(url);
    int n;
    if (type == FileType.image) {
      n = 1;
    } else if (type == FileType.video) {
      n = 2;
    } else {
      n = 3;
    }
    final userData = await Firestore.instance
        .collection('${widget.type}')
        .document(user.uid)
        .get();
    Firestore.instance.collection('chat/${user.uid}/${widget.receiverID}').add(
      {
        'type': n,
        'text': url,
        'createdAt': Timestamp.now(),
        'sender': user.uid,
        'receiver': widget.receiverID,
        'username': userData['username'],
      },
    );
    Firestore.instance.collection('chat/${widget.receiverID}/${user.uid}').add(
      {
        'type': n,
        'text': url,
        'createdAt': Timestamp.now(),
        'sender': user.uid,
        'receiver': widget.receiverID,
        'username': userData['username'],
      },
    );
  }

  showAttachmentBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.image),
                    title: Text('Image'),
                    onTap: () => showFilePicker(FileType.image)),
                ListTile(
                    leading: Icon(Icons.videocam),
                    title: Text('Video'),
                    onTap: () => showFilePicker(FileType.video)),
                ListTile(
                  leading: Icon(Icons.insert_drive_file),
                  title: Text('File'),
                  onTap: () => showFilePicker(FileType.any),
                ),
              ],
            ),
          );
        });
  }

  showFilePicker(FileType fileType) async {
    File file = await FilePicker.getFile(type: fileType);
    print(file);
    sendFile(file, fileType);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              autocorrect: true,
              textCapitalization: TextCapitalization.sentences,
              enableSuggestions: true,
              decoration: InputDecoration(labelText: 'Send a new message'),
              onChanged: (value) {
                setState(
                  () {
                    _enteredMessage = value;
                  },
                );
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.attach_email),
            onPressed: () => showAttachmentBottomSheet(context),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
          ),
        ],
      ),
    );
  }
}
