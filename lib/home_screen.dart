import 'package:ai_resume_app/doc_resume_screen.dart';
import 'package:ai_resume_app/pdf_resume_screen.dart';
import 'package:ai_resume_app/text_resume_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_button/group_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Smart Resume Analyzer",
          style: GoogleFonts.ubuntu(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          SizedBox(height: 78),
          Center(
            child: Text(
              "Choose Resume Type",
              style: GoogleFonts.playfairDisplay(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 75),
          Column(
            children: [
              Row(
                children: [
                  Radio<String>(
                    value: "Text",
                    activeColor: Colors.grey.withOpacity(.8),
                    groupValue: selectedType,
                    onChanged: (value) {
                      setState(() {
                        selectedType = value;
                      });
                    },
                  ),
                  SizedBox(width: 2),
                  Text(
                    "Text",
                    style: GoogleFonts.ubuntu(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Radio<String>(
                    value: "PDF",
                    activeColor: Colors.grey.withOpacity(.8),
                    groupValue: selectedType,
                    onChanged: (value) {
                      setState(() {
                        selectedType = value;
                      });
                    },
                  ),
                  SizedBox(width: 2),
                  Text(
                    "PDF",
                    style: GoogleFonts.ubuntu(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Radio<String>(
                    value: "DOC",
                    activeColor: Colors.grey.withOpacity(.8),
                    groupValue: selectedType,
                    onChanged: (value) {
                      setState(() {
                        selectedType = value;
                      });
                    },
                  ),
                  SizedBox(width: 2),
                  Text(
                    "DOC",
                    style: GoogleFonts.ubuntu(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 80),
              InkWell(
                onTap: () {
                  if (selectedType != null) {
                    if (selectedType == "PDF") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PdfResumeScreen(),
                        ),
                      );
                    } else if (selectedType == "Text") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TextResumeScreen(),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DocResumeScreen(),
                        ),
                      );
                    }
                  }
                },
                child: Center(
                  child: Container(
                    height: 55,
                    width: 195,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                      border: BoxBorder.all(color: Colors.white, width: 2),
                    ),
                    child: Center(
                      child: Text(
                        "Navigate",
                        style: GoogleFonts.ubuntu(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
