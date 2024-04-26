import { Server, Socket } from "socket.io";

class SocketServer {
  private _io: Server;
  private usersSockets: any = {};

  constructor(server: any) {
    this._io = new Server(server, {
      cors: {
        allowedHeaders: ['ws'],
        origin: 'ws://localhost:3000',
        credentials: true,
      }
    });
  }

  public init () {
    const _namespace = this._io.of('/socket/v1');
    _namespace.on('connection', (socket) => {
      // track connected users
      const userId: string = socket.handshake.query.user!.toString();
      console.log(`${userId} connected as ${socket.id}`);
      this.usersSockets[userId] = socket.id;

      // handle private messages
      socket.on('private', ({receiverId, data, timestamp}) => {
        const socketId = this.usersSockets[receiverId];
        _namespace.to(socketId).emit('private', {senderId: userId, data, timestamp});
      });

      // handle group chats
      socket.on('join', (room) => {
        socket.join(room);
        console.log(`Socket ${socket.id} joined ${room}`);
      });
      socket.on('room', ({roomId, data, timestamp}) => {
        _namespace.to(roomId).emit('room', {senderId: userId, data, timestamp});
      });

      // handle disconnection
      socket.on('disconnect', () => {
        console.log('Socket disconnected', socket.id);
        const userId = Object.keys(this.usersSockets)
          .find(key => this.usersSockets[key] === socket.id);
        delete this.usersSockets[userId!];
      });
    });
  }
}

export default SocketServer;
