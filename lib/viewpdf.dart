///[Dont Remove it ]
///
///It is a File that helps to view the pdf which is being sent
///
///Before using it make sure that you add printing ,open_file as a dependency
///
///
// import 'dart:async';
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;

// import 'package:printing/printing.dart';

// import 'invoice.dart';

// class MyApp extends StatefulWidget {
//   @override
//   MyAppState createState() {
//     return MyAppState();
//   }
// }

// class MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
//   Future<void> _saveAsFile(
//     BuildContext context,
//     LayoutCallback build,
//     PdfPageFormat pageFormat,
//   ) async {
//     final Uint8List bytes = await build(pageFormat);

//     final Directory appDocDir = await getApplicationDocumentsDirectory();
//     final String appDocPath = appDocDir.path;
//     final File file = File(appDocPath + '/' + 'document.pdf');
//     print('Save as file ${file.path} ...');
//     await file.writeAsBytes(bytes);
//     OpenFile.open(file.path);
//   }

//   @override
//   Widget build(BuildContext context) {
//     pw.RichText.debug = true;

//     final actions = <PdfPreviewAction>[
//       if (!kIsWeb)
//         PdfPreviewAction(
//           icon: const Icon(Icons.save),
//           onPressed: _saveAsFile,
//         )
//     ];

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Pdf Printing Example'),
//       ),
//       body: PdfPreview(
//         maxPageWidth: 700,
//         build: generateInvoice,
//         actions: actions,
//       ),
//     );
//   }
// }
