import { Request, Response } from 'express';
import { v2 as cloudinary } from 'cloudinary';
import path from 'path';
import dataUriParser from 'datauri/parser';
import Posts from '../Models/postModel';
import User from '../Models/userModel';

const sharePost = async (req: Request, res: Response) => {
  try {
    const userId = req.body.userId;
    const {content} = req.body;
    if (!content || !userId || !req.file)
      return res.status(400).json('Required data are missing!');

    const parser = new dataUriParser();
    const extName = path.extname(req.file.originalname).toString();
    const image = parser.format(extName, req.file.buffer).content!;

    const upload = await cloudinary.uploader.upload(image, {
      folder: 'Snappio/posts',
      public_id: `${userId}_${new Date().toJSON()}`,
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
    const userId = req.body.userId;

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
          'content': '$content',
          'file': '$file',
          'postedBy': '$uploader.username',
          'likes': '$likes',
          'loved': { $in: [ userId, '$likedBy' ]},
          'timestamp': '$timestamp',
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
    const userId = req.body.userId;
    const { postId } = req.body;
    if (!postId) return res.status(400).json('PostID is required!');

    const post = await Posts.findById(postId);
    if (!post) return res.status(404).json('Post not found!');
    const uploader = await User.findById(post.postedBy);

    const index = post.likedBy.indexOf(userId);
    if (index > -1) {
      post.likedBy.splice(index, 1);
      post.likes--;
      uploader!.loves--;
    } else {
      post.likedBy.push(userId);
      post.likes++;
      uploader!.loves++;
    }

    await uploader!.save();
    await post.save();
    res.status(200).json(post);

  } catch (err) {
    res.status(500).json(err);
  }
};

export default { sharePost, getAllPosts, reactPost };