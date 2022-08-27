
// import 'dart:async';
// import 'package:flutter/services.dart';
// import 'package:nfc_manager/nfc_manager.dart';
// import 'package:flutter_nfc_kit/flutter_nfc_kit.dart' as ios;
// import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
// import 'package:nfc_in_flutter/nfc_in_flutter.dart';
// import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
// import 'package:uuid/uuid.dart';
// import 'dart:io' show Platform;

// class ScanRepository {
//   final bool isAndroid = Platform.isAndroid;
//   final bool isIos = Platform.isIOS;
//   final Uuid uuid = Uuid();
//   StreamController<String>? uuidStream;
  
//   Stream<String> getUuid() => uuidStream!.stream;
  
//   Future<Future<Object>> isNfcSupported() async {
//     //you don't really have to check the platform here, you can use
//     // only one plugin to check if NFC is available, i am just showing the 2 methods that are available
//       if(isIos) {
//         return ios.FlutterNfcKit.nfcAvailability;
//       } else if (isAndroid) {
//         return NFC.isNDEFSupported;
//       } else {
//         throw ;
//       }
//   }
  
//   Future<void> init() async {
//     // Closing the uuidStream first to be sure it's not already listening
//     await uuidStream?.close();
//     uuidStream = StreamController<String>();
//     if(isIos) {
//       try{
//         final ios.NFCTag tag = await FlutterNfcKit.poll(
//           timeout: const Duration(seconds: 50),
//           iosAlertMessage: 'This is the part that can be customized',
//         );
//         await ios.FlutterNfcKit.setIosAlertMessage("One moment please, i am doing some stuff");
//         if (tag.type == ios.NFCTagType.mifare_ultralight){
//           final ndefRecords = await ios.FlutterNfcKit.readNDEFRecords();
//           //We'll need to decode here the records with de ndef package
//           String? reliqiumUuid;
//           for(ndef.NDEFRecord record in ndefRecords){
//             // i want to check it's a textRecord:
//             if (record is ndef.TextRecord) {
//               reliqiumUuid = record.text;
//             }
//           }
//           if(reliqiumUuid == null) {
//             await _writeNdefRecord();
//           } else {
//             uuidStream!.add(reliqiumUuid);
//           }
//         }
//         await ios.FlutterNfcKit.finish(iosAlertMessage: "All Done!");
//       // ignore: nullable_type_in_catch_clause
//       } on PlatformException catch(error) {
//         if(error.message!.contains(writeErrorMessage)) {
//           //Handle here reading error
//         } else if (error.message!.contains(readErrorMessage)){
//           //Handle here writing error
//         } else {
//           // Handle here the other type of errors
//         }
//         await ios.FlutterNfcKit.finish(iosAlertMessage: "Error!");
//       }
//     } else if (isAndroid) {
//       NDEFMessage message = await NFC.readNDEF(once: true).first;
//       final reliqiumUuid = message.records[0];
//       if(reliqiumUuid == null) {
//         await _writeNDEFRecord;
//       }else {
//         uuidStream!.add(reliqiumUuid);
//       }
//     } else {
//       throw UnimplementedError();
//     }
//   }
  
//   Future<void> _writeNDEFRecord() {
//     if(isIOS){
//       final idToStore = uuid.v4();
//       await ios.FlutterNfcKit.writeNDEFRecords([
//         ndef.TextRecord(text: idToStore, language: 'en'),
//         // You may want to add this MimeRecord to avoid
//         // some boring behavior from Android devices
//         // be sure to replace the string with your 
//         // android package name
//         ndef.MimeRecord(decodedType: 'Content-type',
//         payload: Uint8List.fromList(
//           'vnd.com.yourdomain.appname'.codeUnits)),
//       ]);
//       uuidStream.add(idToStore);
//     } else if (isAndroid){
//       final idToStore = uuid.v4();
//       final NDEFMessage newMessage = NDEFMessage.withRecords([
//         NDEFRecord.text(id),
//         NDEFRecord.type("Content-type", "vnd.app.reliqium.reliqium")
//       ]);
//       final resultWriting = NFC.writeNDEF(newMessage)
//         .handleError((e, _) {
//         //handle error here, i am returning null to be able to retry
//       });
//       resultWriting.takeWhile((tag) => tag != null).listen((NDEFTag tag) {
//         // the text is stored in tag.id
//         // now you have to send your new id if you need it,
//         // i am normally using a Stream<String> so i am doing something like:
//         uuidStream.add(tag.id);
//       });
//     }
//   }
  
//   Future<void> close() {
//     await uuidStream?.close();
//   }
// }