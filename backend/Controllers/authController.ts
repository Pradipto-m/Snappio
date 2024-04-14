import {Request, Response} from 'express';
import { v2 as cloudinary } from 'cloudinary';
import jwt from 'jsonwebtoken';
import dataUriParser from 'datauri/parser';
import path from 'path';
import User from '../Models/userModel';

const signupUser = async (req: Request, res: Response) => {
  try {
    const {username, name, phone, email} = req.body;
    if (await User.findOne({username: username})) {
      return res.status(400).json({error: 'Username already exists!'});
    }

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

const checkPhone = async (req: Request, res: Response) => {
  try {
    const phone: string = req.query.phone!.toString();
    const user = await User.findOne({phone});
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

const uploadAvatar = async (req: Request, res: Response) => {
  try {
    const user = await User.findById(req.body.userId);
    if (!user) {
      return res.status(400).json({error: 'Authorisation Denied!'});
    }
    if (!req.file || !req.file.buffer) {
      return res.status(400).json({error: 'File data missing.'});
    }

    const parser = new dataUriParser();
    const extName = path.extname(req.file.originalname).toString();
    const image = parser.format(extName, req.file.buffer).content!;

    const upload = await cloudinary.uploader.upload(
      image,
      {resource_type: 'image',
      public_id: `Snappio/users/${user._id}_${user.username}`,
      overwrite: true}
    );

    user.avatar = upload.secure_url;
    await user.save().then(() => {
      res.status(200).json({user});
    });

  } catch (err) {
    res.status(500).json({err});
  }
};

export default {signupUser, loginUser, checkPhone, getUser, uploadAvatar};
