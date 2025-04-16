import 'package:flutter/material.dart';
import 'package:pairs_game/constants/ui_colors.dart';

class PlayerNameField extends StatefulWidget {
  const PlayerNameField(
      {required this.initialName, required this.onNameChanged, super.key});
  final String initialName;
  final Function(String) onNameChanged;
  @override
  State<PlayerNameField> createState() => _PlayerNameFieldState();
}

class _PlayerNameFieldState extends State<PlayerNameField> {
  bool editing = false;
  late TextEditingController playerNameController;
  late FocusNode playerNameFocusNode;
  @override
  void initState() {
    playerNameController = TextEditingController(text: widget.initialName);
    playerNameFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    playerNameController.dispose();
    playerNameFocusNode.dispose();
    super.dispose();
  }

  toggleEditing() {
    setState(() {
      editing = !editing;
    });
    Future.delayed(
      const Duration(milliseconds: 200),
      () {
        if (editing) {
          playerNameFocusNode.requestFocus();
        } else {
          widget.onNameChanged(playerNameController.text);
          playerNameFocusNode.unfocus();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
              child: Stack(
            children: [
              TextField(
                enabled: editing,
                focusNode: playerNameFocusNode,
                controller: playerNameController,
                onSubmitted: (value) {
                  toggleEditing();
                },
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(right: 80, left: 20),
                    filled: true,
                    fillColor: UIColors.black,
                    hintText: "Enter your name",
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(108, 255, 255, 255),
                      fontSize: 18,
                    ),
                    suffixIcon: Container(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    suffixIconConstraints: BoxConstraints(
                      maxHeight: 60,
                      maxWidth: 60,
                    )),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              Positioned(
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    toggleEditing();
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      color: UIColors.green,
                    ),
                    child: Icon(
                      editing ? Icons.check : Icons.edit,
                      color: UIColors.black,
                    ),
                  ),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
