import 'dart:io';

import 'package:ai_resume_app/ai_response_pdf.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';

class PdfResumeScreen extends StatefulWidget {
  const PdfResumeScreen({super.key});

  @override
  State<PdfResumeScreen> createState() => _PdfResumeScreenState();
}

class _PdfResumeScreenState extends State<PdfResumeScreen> {
  File? selectedPdf;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "PDF Resume",
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
              "Upload PDF",
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
                  allowedExtensions: ["pdf"],
                );
                if (result != null) {
                  setState(() {
                    selectedPdf = File(result.files.single.path!);
                  });
                }
              },
              child: Text("Pick PDF"),
            ),
            SizedBox(height: 30),
            if (selectedPdf != null)
              Text(
                "Selected File \n${selectedPdf!.path.split("/").last}",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            SizedBox(height: 30),
            if (selectedPdf != null)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AiResponsePdf(pdfFile: selectedPdf!),
                    ),
                  );
                },
                child: Text("Upload PDF"),
              ),
          ],
        ),
      ),
    );
  }
}
