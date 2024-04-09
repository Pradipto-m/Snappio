import express from 'express';
import auth from '../Middleware/auth';
import uploader from '../Middleware/uploader';
import postController from '../Controllers/postController';

const postRouter = express.Router();

postRouter.post('/api/v1/posts/upload',
  uploader, auth, postController.sharePost);

postRouter.get('/api/v1/posts/all', auth, postController.getAllPosts);

postRouter.put('/api/v1/posts/react', auth, postController.reactPost);

export default postRouter;