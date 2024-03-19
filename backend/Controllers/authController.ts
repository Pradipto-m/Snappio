import {Request, Response} from 'express';
import jwt from 'jsonwebtoken';
import User from '../Models/userModel';

const signupUser = async (req: Request, res: Response) => {
  try {
    const {username, name, phone, email} = req.body;

    const user = await User.create({
      username,
      name,
      phone,
      email,
    });

    await user.save().then(() => {
      res.status(201).json({user});
    }).catch((err: Error) => {
      res.status(500).json({error: err});
    });

  } catch (err) {
    res.status(500).json({error: err});
  }
};

const loginUser = async (req: Request, res: Response) => {
  try {
    const { phone } = req.body;

    const user = await User.findOne({ phone });

    const token = jwt.sign({id: user!._id}, process.env.JWT_KEY!);
    res.status(200).json({token});

  } catch (err) {
    res.status(500).json({error: err});
  }
};

export default {signupUser, loginUser};
