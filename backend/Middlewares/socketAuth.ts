import jwt from "jsonwebtoken";
import { Socket } from "socket.io";

const validate = (token: string, socket: Socket, next: any) => {
  const verified: any = jwt.verify(token, process.env.JWT_SOCKET!);
  if (!verified)
    return next(new Error('Unauthorized'));

  socket.data.user = verified.user;
  next();
};

export default validate;