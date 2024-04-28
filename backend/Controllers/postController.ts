import { Request, Response } from 'express';
import { v2 as cloudinary } from 'cloudinary';
import path from 'path';
import dataUriParser from 'datauri/parser';
import Posts from '../Models/postModel';
import User from '../Models/userModel';
import mongoose from 'mongoose';

const sharePost = async (req: Request, res: Response) => {
  try {
    const userId = new mongoose.Types.ObjectId(req.body.userId);
    const {content} = req.body;
    if (!content || !userId || !req.file)
      return res.status(400).json('Required data are missing!');

    const parser = new dataUriParser();
    const extName = path.extname(req.file.originalname).toString();
    const image = parser.format(extName, req.file.buffer).content!;

    const upload = await cloudinary.uploader.upload(image, {
      folder: 'Snappio/posts',
      public_id: `${userId}_${new Date().toISOString()}`,
      overwrite: false,
    });

    const newPost = new Posts({
      content,
      postedBy: userId,
      file: upload.secure_url,
    });

    await newPost.save();
    res.status(200).json(newPost);

  } catch (err) {
    res.status(500).json(err);
  }
};

const getAllPosts = async (req: Request, res: Response) => {
  try {
    const userId = new mongoose.Types.ObjectId(req.body.userId);

    const posts = await Posts.aggregate([
      {
        $lookup: {
          from: 'users',
          localField: 'postedBy',
          foreignField: '_id',
          as: 'uploader',
        },
      },
      { $unwind: '$uploader' },
      {
        $project: {
          'content': 1,
          'file': 1,
          'postedBy': '$uploader.username',
          'likes': 1,
          'loved': { $in: [ userId, '$likedBy' ]},
          'timestamp': 1,
        },
      },
      { $sort: { timestamp: -1 }},
    ]);

    res.status(200).json(posts);

  } catch (err) {
    res.status(500).json(err);
  }
};

const reactPost = async (req: Request, res: Response) => {
  try {
    const userId = new mongoose.Types.ObjectId(req.body.userId);
    if (!req.body.postId) return res.status(400).json('PostID is required!');
    const postId = new mongoose.Types.ObjectId(req.body.postId);

    const result = await Posts.aggregate([
      {
        $lookup: {
          from: 'users',
          localField: 'postedBy',
          foreignField: '_id',
          as: 'uploader',
        },
      },
      { $unwind: '$uploader' },
      {
        $set: {
          'uploader.loves': {
            $cond: {
              if: { $in: [ userId, '$likedBy' ]},
              then: { $subtract: [ '$uploader.loves', 1 ]},
              else: { $add: [ '$uploader.loves', 1 ]},
            },
          },
        },
      },
      { $match: { _id: postId }},
      {
        $set: {
          likes: {
            $cond: {
              if: { $in: [userId, "$likedBy"]},
              then: { $subtract: ["$likes", 1]},
              else: { $add: ["$likes", 1]}
            }
          },
          likedBy: {
            $cond: {
              if: { $in: [ userId, '$likedBy' ]},
              then: { $setDifference: [ '$likedBy', [ userId ]]},
              else: { $concatArrays: [ '$likedBy', [ userId ]]},
            },
          },
        },
      },
    ]);

    const { loves } = result[0].uploader;
    const { likes, likedBy } = result[0];
    await User.updateOne({ _id: result[0].postedBy }, { loves });
    await Posts.updateOne({ _id: postId }, { likes, likedBy });

    res.status(200).json({ status: 'success' });
    
  } catch (err) {
    res.status(500).json(err);
  }
};

export default { sharePost, getAllPosts, reactPost };