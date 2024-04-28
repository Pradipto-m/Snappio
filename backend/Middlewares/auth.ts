import { Request, Response, NextFunction } from "express";
import jwt from "jsonwebtoken";

const auth = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const authToken = req.header('Authorization');
    const token = authToken?.split(' ')[1];
    if (!token)
      return res.status(401).json({ err: 'Unauthorized' });

    const verified: any = jwt.verify(token, process.env.JWT_KEY!);
    if (!verified) {
      return res.status(401).json({ err: 'Unauthorized' });
    }

    req.body.userId = verified.id;
    next();

  } catch (err) {
    res.status(500).json({ error: err });
  }
};

export default auth;