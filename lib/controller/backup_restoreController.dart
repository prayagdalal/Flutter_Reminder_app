import 'dart:convert';

import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:get/get.dart';

import 'dart:async';
import 'dart:developer';
import 'dart:io';

// import 'package:backup_restore/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart' as p;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:reminder_app/controller/task_controller.dart';
import 'package:reminder_app/main.dart';
import 'package:reminder_app/model/taskModel.dart';
import 'package:reminder_app/network/apis.dart';
import 'package:reminder_app/network/globalFile.dart';
import 'package:reminder_app/utills/customtext.dart';

final controllers = Get.put(TaskController());
// final taskController = Get.put(TaskController());f

class backupRestoreController extends GetxController {
  bool _loginStatus = false;

  bool isloading = false;
  String googledriveurl = '';
  double progress = 0;
  var progressdialog = true.obs;

  final googleSignIn = GoogleSignIn.standard(scopes: [
    drive.DriveApi.driveAppdataScope,
    drive.DriveApi.driveFileScope,
  ]);

  @override
  void onInit() {
    _loginStatus = googleSignIn.currentUser != null;
    super.onInit();
  }

  downloadandsavefile() async {
    if (await ConnectivityWrapper.instance.isConnected) {
      progressdialog.value = true;
      try {
        final driveApi = await _getDriveApi();
        if (driveApi == null) {
          return;
        }
        Get.defaultDialog(
            title: "",
            backgroundColor: Color(0x01000000),
            barrierDismissible: true,
            content: Obx(() => Container(
                  color: Color(0x01000000),
                  child: progressdialog.value
                      ? SizedBox(
                          height: 50,
                          child: SpinKitFoldingCube(
                            itemBuilder: (BuildContext context, int index) {
                              return DecoratedBox(
                                decoration: BoxDecoration(
                                  color: index.isEven
                                      ? Colors.grey[350]
                                      : Colors.green,
                                ),
                              );
                            },
                          ),
                        )
                      : AlertDialog(
                          content: Row(
                            children: [
                              Icon(
                                Icons.download_rounded,
                                color: Colors.green,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text("Restore Successfull"),
                            ],
                          ),
                        ),
                )));
        final folder_id = await _getFolderId(driveApi);
        final fileList = await driveApi.files.list(
          spaces: 'drive',
          q: "'$folder_id' in parents",
          $fields: 'files(id, name,size)',
        );

        final dirlist = await _getexternalstoragepath();
        final path = dirlist.path;
        final file = File('$path/backup_restore.txt');

        var res = await driveApi.files.get(fileList.files![0].id.toString(),
            downloadOptions: drive.DownloadOptions.fullMedia);
        drive.Media? mediaStream = res as drive.Media?;

        List<int> dataStore = [];
        mediaStream!.stream.listen((data) {
          print("DataReceived: ${data.length}");
          dataStore.addAll(data);
        }, onDone: () async {
          Directory tempDir = await p.getApplicationSupportDirectory();
          String tempPath = tempDir.path;

          File file = File('$tempPath/test');
          await file.writeAsBytes(dataStore);
          String content = file.readAsStringSync();
          List taskModelRawList = json.decode(content);
          if (taskModelRawList.isNotEmpty) {
            taskModelRawList.forEach((taskModelRawElement) {
              TaskModel taskModelObj = TaskModel.fromJson(taskModelRawElement);
              DBProvider.db.addTask(taskModelObj);
              // DBProvider.db.getTaskList();
            });
          }
          progressdialog.value = false;
          TaskController().fetchTasks();
          Timer(Duration(seconds: 4), () {
            Get.back();
          });
        }, onError: (error) {
          AlertDialog(
            title: Text("Error"),
          );
        });
      } catch (e) {
        print(e);
      }
    } else {
      Get.defaultDialog(
          backgroundColor: Colors.transparent,
          title: "",
          barrierDismissible: true,
          content: AlertDialog(
            insetPadding: EdgeInsets.zero,
            scrollable: true,
            content: Row(
              children: [
                Icon(
                  Icons.wifi_off_outlined,
                  color: Colors.green,
                ),
                SizedBox(
                  width: 7,
                ),
                Text("No Internet Connectivity"),
              ],
            ),
          ));
    }
  }

  uploadToGoogleDrive() async {
    if (await ConnectivityWrapper.instance.isConnected) {
      if (taskController.tasks.length >= 1) {
        DBProvider.db.getdatabaselist();

        progressdialog.value = true;

        final driveApi = await _getDriveApi();
        if (driveApi == null) {
          return;
        }
        Get.defaultDialog(
            backgroundColor: Colors.transparent,
            title: "",
            barrierDismissible: true,
            content: Obx(() => Container(
                  color: Color(0x01000000),
                  child: progressdialog.value
                      ? SizedBox(
                          height: 50,
                          child: SpinKitFoldingCube(
                            itemBuilder: (BuildContext context, int index) {
                              return DecoratedBox(
                                decoration: BoxDecoration(
                                  color: index.isEven
                                      ? Colors.grey[350]
                                      : Colors.green,
                                ),
                              );
                            },
                          ),
                        )
                      : AlertDialog(
                          scrollable: true,
                          content: Row(
                            children: [
                              Icon(
                                Icons.backup,
                                color: Colors.green,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text("Backup successfull"),
                            ],
                          ),
                        ),
                )));

        final folder_id = await _getFolderId(driveApi);
        final fileList = await driveApi.files.list(
          spaces: 'drive',
          q: "'$folder_id' in parents",
          $fields: 'files(id, name,size)',
        );
        try {
          driveApi.files.delete(fileList.files![0].id.toString());
        } catch (e) {
          AlertDialog(
            title: Text("error"),
          );
        }

        try {
          final driveApi = await _getDriveApi();
          if (driveApi == null) {
            return;
          }

          final folderId = await _getFolderId(driveApi);
          if (folderId == null) {
            await Get.defaultDialog(
                content: CustomText(text: "Error, couldn\'t sign in"));
            return;
          }
          String contents = name;
          print(contents);
          final Stream<List<int>> mediaStream =
              Future.value(contents.codeUnits).asStream().asBroadcastStream();

          var media = drive.Media(mediaStream, contents.length);
          var driveFile = drive.File();
          driveFile.name = "backup_restore.txt";
          driveFile.modifiedTime = DateTime.now().toUtc();
          driveFile.parents = [folderId];

          // Upload
          final response =
              await driveApi.files.create(driveFile, uploadMedia: media);
          progressdialog.value = false;
          Timer(Duration(seconds: 4), () {
            Get.back();
          });
        } catch (e) {}
      } else {
        Get.defaultDialog(
            backgroundColor: Colors.transparent,
            title: "",
            barrierDismissible: true,
            content: AlertDialog(
              insetPadding: EdgeInsets.zero,
              scrollable: true,
              content: Row(
                children: [
                  Icon(
                    Icons.warning_amber,
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Text("Cannot Backup data,\n No data found"),
                ],
              ),
            ));
      }
    } else {
      Get.defaultDialog(
          backgroundColor: Colors.transparent,
          title: "",
          barrierDismissible: true,
          content: AlertDialog(
            insetPadding: EdgeInsets.zero,
            scrollable: true,
            content: Row(
              children: [
                Icon(
                  Icons.wifi_off_outlined,
                  color: Colors.green,
                ),
                SizedBox(
                  width: 7,
                ),
                Text("No Internet Connectivity"),
              ],
            ),
          ));
    }
  }

  Future<drive.DriveApi?> _getDriveApi() async {
    final googleUser = await googleSignIn.signIn();
    final headers = await googleUser?.authHeaders;
    if (headers == null) {
      await Get.defaultDialog(
          content: CustomText(text: "Error, couldn\'t sign in"));
      return null;
    }

    final client = GoogleAuthClient(headers);
    final driveApi = drive.DriveApi(client);
    return driveApi;
  }

  Future<String?> _getFolderId(drive.DriveApi driveApi) async {
    const mimeType = "application/vnd.google-apps.folder";
    String folderName = "Reminder";

    try {
      final found = await driveApi.files.list(
        q: "mimeType = '$mimeType' and name = '$folderName'",
        $fields: "files(id, name)",
      );

      final files = found.files;

      // ignore: unnecessary_null_comparison
      if (files == null) {
        await Get.defaultDialog(
            content: CustomText(text: "Error, couldn\'t sign in"));
        return null;
      }

      if (files.isNotEmpty) {
        return files.first.id;
      }

      // Create a folder
      var folder = drive.File();
      folder.name = folderName;
      folder.mimeType = mimeType;
      final folderCreation = await driveApi.files.create(folder);
      return folderCreation.id;
    } catch (e) {
      return null;
    }
  }

  Future<Directory> _getexternalstoragepath() async {
    return p.getApplicationDocumentsDirectory();
  }
}

class GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;
  final _client = new http.Client();

  GoogleAuthClient(this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(_headers);
    return _client.send(request);
  }
}
