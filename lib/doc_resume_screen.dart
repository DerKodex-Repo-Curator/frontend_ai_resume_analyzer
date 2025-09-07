import 'dart:io';
import 'package:ai_resume_app/ai_response_docx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';

class DocResumeScreen extends StatefulWidget {
  const DocResumeScreen({super.key});

  @override
  State<DocResumeScreen> createState() => _PdfResumeScreenState();
}

class _PdfResumeScreenState extends State<DocResumeScreen> {
  File? selecteddoc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "DOCX Resume",
          style: GoogleFonts.ubuntu(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Upload DOCX",
              style: GoogleFonts.ubuntu(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ["docx"],
                );
                if (result != null) {
                  setState(() {
                    selecteddoc = File(result.files.single.path!);
                  });
                }
              },
              child: Text("Pick DOCX"),
            ),
            SizedBox(height: 30),
            if (selecteddoc != null)
              Text(
                "Selected File \n${selecteddoc!.path.split("/").last}",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            SizedBox(height: 30),
            if (selecteddoc != null)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AiResponseDocx(docxFile: selecteddoc!),
                    ),
                  );
                },
                child: Text("Upload Doc"),
              ),
          ],
        ),
      ),
    );
  }
}
