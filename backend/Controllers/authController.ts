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

const checkPhoneNumber = async (req: Request, res: Response) => {
  try {
    const phone = req.query.phone;
    const user = await User.findOne({ phone });
    if (user) {
      res.status(200).json({message: 'User exists'});
    } else {
      res.status(404).json({message: 'User does not exist'});
    }
  } catch (err) {
    res.status(500).json({error: err});
  }
};

const getUser = async (req: Request, res: Response) => {
  try {
    const user = await User.findById(req.body.userId);
    if (!user) {
      return res.status(400).json({error: 'Authorisation Denied!'});
    }
    res.status(200).json(user);
  } catch (err) {
    res.status(500).json({ error: err });
  }
};

export default {signupUser, loginUser, checkPhoneNumber, getUser};
