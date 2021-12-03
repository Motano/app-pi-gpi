abstract class Listamensajes {}

class Message implements Listamensajes {
  final String body;
  final bool isMe;
  Message(this.body, this.isMe);
}
