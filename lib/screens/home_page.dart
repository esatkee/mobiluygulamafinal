import 'dart:ui';
import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_drawer.dart';
import '../constants/constants.dart';
import '../constants/texts.dart';
import 'diary_deatil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> _notes = [
    {
      'date': '26 December, 2024',
      'weekday': 'Thursday',
      'text': 'I finally tackled my messy desk today. It took longer than I expected, but now ev...'
    },
    {
      'date': '25 December, 2024',
      'weekday': 'Wednesday',
      'text': 'I spent the afternoon baking cookies, and it was so much fun. The kitchen smelle...'
    },
    {
      'date': '24 December, 2024',
      'weekday': 'Tuesday',
      'text': 'I had a long chat with an old friend today. We reminisced about the silly things we...'
    },
  ];

  void addNote(Map<String, String> note) {
    setState(() => _notes.add(note));
  }

  void showNoteDetailDialog(BuildContext context, Map<String, String> note) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        note['date'] ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: AppConstants.largeTextSize
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.of(context).pop()
                      )
                    ],
                  ),
                  const SizedBox(height: AppConstants.defaultPadding),
                  Text(
                    note['text'] ?? '',
                    style: TextStyle(fontSize: AppConstants.mediumTextSize),
                  ),
                  const SizedBox(height: AppConstants.largePadding),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EditNotePage(note: note)),
                          ).then((updatedNote) {
                            if (updatedNote != null && updatedNote is Map<String, String>) {
                              setState(() {
                                int index = _notes.indexOf(note);
                                if (index != -1) _notes[index] = updatedNote;
                              });
                            }
                          });
                        },
                        child: Text(AppTexts.edit),
                      ),
                      const SizedBox(width: AppConstants.defaultPadding),
                      TextButton(
                        onPressed: () {
                          setState(() => _notes.remove(note));
                          Navigator.of(context).pop();
                        },
                        child: Text(AppTexts.delete),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: CustomAppBar(title: AppTexts.appTitle),
      drawer: DrawerMenu(onAddNote: addNote),
      body: _notes.isEmpty
          ? Center(child: Text(AppTexts.noDiary))
          : ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                final note = _notes[index];
                return Card(
                  color: AppConstants.cardColor,
                  margin: const EdgeInsets.symmetric(
                    horizontal: AppConstants.defaultPadding,
                    vertical: AppConstants.smallPadding,
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(AppConstants.defaultPadding),
                    title: Text(
                      '${note['date']} - ${note['weekday']}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppConstants.mediumTextSize,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: AppConstants.smallPadding),
                      child: Text(note['text'] ?? ''),
                    ),
                    onTap: () => showNoteDetailDialog(context, note),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newNote = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditNotePage()),
          );
          if (newNote != null && newNote is Map<String, String>) {
            setState(() => _notes.add(newNote));
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
