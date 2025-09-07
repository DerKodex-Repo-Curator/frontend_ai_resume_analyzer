import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class AiResponseDocx extends StatefulWidget {
  final File docxFile;
  const AiResponseDocx({super.key, required this.docxFile});
  @override
  State<AiResponseDocx> createState() => _AiResponseDocxState();
}

class _AiResponseDocxState extends State<AiResponseDocx> {
  String? aifeedback;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    sendDocxToAIStream();
  }

  Future<void> sendDocxToAIStream() async {
    setState(() {
      loading = true;
      aifeedback = "";
    });
    try {
      var request = http.MultipartRequest(
        "POST",
        Uri.parse("http://192.168.0.33:8000/analyze-file-stream"),
      );
      request.files.add(
        await http.MultipartFile.fromPath(
          "file", // must match FastAPI param name
          widget.docxFile.path,
          contentType: MediaType(
            "application",
            "vnd.openxmlformats-officedocument.wordprocessingml.document",
          ),
        ),
      );
      var response = await request.send();
      String buffer = "";
      response.stream
          .transform(utf8.decoder)
          .listen(
            (chunk) async {
              buffer += chunk;
              while (buffer.isNotEmpty) {
                setState(() {
                  aifeedback = (aifeedback ?? "") + buffer[0];
                });
                buffer = buffer.substring(1);
                await Future.delayed(const Duration(milliseconds: 20));
              }
            },
            onDone: () {
              setState(() {
                loading = false;
              });
            },
            onError: (e) {
              setState(() {
                loading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Error: $e"),
                  backgroundColor: Colors.red,
                ),
              );
            },
          );
    } catch (e) {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "DOCX Resume Feedback",
          style: GoogleFonts.ubuntu(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (loading)
              Center(
                child: Container(
                  height: 60,
                  width: 160,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Center(
                    child: Text(
                      "Analyzing...",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 20),
            if (aifeedback != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    aifeedback!,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
