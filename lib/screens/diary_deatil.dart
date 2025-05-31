import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_drawer.dart';
import '../constants/constants.dart';
import '../constants/texts.dart';

class EditNotePage extends StatefulWidget {
  final Map<String, String>? note;

  EditNotePage({this.note});

  @override
  _EditNotePageState createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.note?['text'] ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final bool isEditing = widget.note != null;

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: CustomAppBar(
        title: isEditing ? AppTexts.editNote : AppTexts.newNote,
        backgroundColor: AppConstants.cardColor,
        showBackButton: true,
      ),
      drawer: const DrawerMenu(),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              maxLines: null,
              decoration: InputDecoration(
                hintText: AppTexts.writeNote,
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: AppConstants.smallPadding),
            if (isEditing && (widget.note?['image']?.isNotEmpty ?? false))
              Image.asset(widget.note!['image']!, fit: BoxFit.cover),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Icon(Icons.search),
                Icon(Icons.camera_alt),
                Icon(Icons.image),
                Icon(Icons.edit),
              ],
            ),
            const SizedBox(height: AppConstants.smallPadding),
            Padding(
              padding: const EdgeInsets.only(bottom: AppConstants.largePadding),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppConstants.cardColor,
                        elevation: 4,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(AppTexts.cancel),
                    ),
                  ),
                  const SizedBox(width: AppConstants.smallPadding),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppConstants.cardColor,
                        elevation: 4,
                      ),
                      onPressed: () {
                        if (_textController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(AppTexts.noteEmpty)),
                          );
                          return;
                        }

                        final now = DateTime.now();
                        final formattedDate = DateFormat('d MMMM, yyyy').format(now);
                        final weekday = DateFormat('EEEE').format(now);

                        Navigator.pop(context, {
                          'date': isEditing ? widget.note!['date'] ?? formattedDate : formattedDate,
                          'weekday': isEditing ? widget.note!['weekday'] ?? weekday : weekday,
                          'text': _textController.text,
                          'image': isEditing ? widget.note!['image'] ?? '' : '',
                        });
                      },
                      child: Text(AppTexts.publish),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
