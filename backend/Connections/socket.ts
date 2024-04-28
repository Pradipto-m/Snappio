import { Server } from "socket.io";
import validate from "../Middlewares/socketAuth";

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
    const _nsp = this._io.of('/socket/v1');

    // socket authentication middleware
    _nsp.use( async (socket, next) => {
      if (!socket.handshake.auth.token) {
        return next(new Error('Unauthorized'));
      }
      const token = socket.handshake.auth.token;
      await validate(token, socket, next);
    });

    _nsp.on('connection', (socket) => {
      // track connected users
      const userId: string = socket.data.user;
      console.log(`${userId} connected as ${socket.id}`);
      this.usersSockets[userId] = socket.id;

      // handle private messages
      socket.on('private', ({receiverId, data, timestamp}) => {
        const socketId = this.usersSockets[receiverId];
        _nsp.to(socketId).emit('private', {senderId: userId, data, timestamp});
      });

      // handle group chats
      socket.on('join', (room) => {
        socket.join(room);
        console.log(`Socket ${socket.id} joined ${room}`);
      });
      socket.on('room', ({roomId, data, timestamp}) => {
        _nsp.to(roomId).emit('room', {senderId: userId, data, timestamp});
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
