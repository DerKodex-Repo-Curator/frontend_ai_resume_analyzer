import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class TextResumeScreen extends StatefulWidget {
  const TextResumeScreen({super.key});
  @override
  State<TextResumeScreen> createState() => _TextResumeScreenState();
}

class _TextResumeScreenState extends State<TextResumeScreen> {
  String? aifeedback;
  TextEditingController resumecontroller = TextEditingController();
  bool loading = false;
  bool showbutton = false;
  @override
  void initState() {
    super.initState();
    resumecontroller.addListener(() {
      setState(() {
        showbutton = resumecontroller.text.isNotEmpty;
      });
    });
  }

  Future<void> sendResumeToAIStream() async {
    String text = resumecontroller.text;
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please enter your resume"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    setState(() {
      loading = true;
      aifeedback = "";
    });
    try {
      final url = Uri.parse("http://192.168.0.33:8000/analyze-text-stream");
      final request = http.Request("POST", url);
      request.headers['Content-Type'] = 'application/json';
      request.body = jsonEncode({"text": text});
      final response = await request.send();
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
                await Future.delayed(
                  Duration(milliseconds: 20),
                ); // speed of animation
              }
            },
            onDone: () {
              setState(() {
                loading = false;
              });
            },
          );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
      );
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Text Resume",
          style: GoogleFonts.ubuntu(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 20),
            Card(
              color: Colors.blueGrey.withOpacity(.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                padding: EdgeInsets.all(8),
                child: TextFormField(
                  controller: resumecontroller,
                  maxLines: 15,
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: "Paste or type your resume here...",
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            if (showbutton)
              ElevatedButton(
                onPressed: loading ? null : sendResumeToAIStream,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  side: BorderSide(color: Colors.white, width: 2),
                ),
                child: loading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                        "Submit",
                        style: GoogleFonts.ubuntu(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
              ),
            SizedBox(height: 30),
            if (aifeedback != null)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    aifeedback!,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
