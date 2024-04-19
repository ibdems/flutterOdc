import 'package:chatapp/utils.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  MessagePage({super.key, required this.message});

  late Map message;

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Message"),
      ),
      body: Text(messages[0]['message']),
      
    );
  }
}