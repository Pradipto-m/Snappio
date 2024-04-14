import express from 'express';
import auth from '../Middlewares/auth';
import uploader from '../Middlewares/uploader';
import postController from '../Controllers/postController';

const postRouter = express.Router();

postRouter.post('/upload', uploader, auth, postController.sharePost);

postRouter.use(auth);

postRouter.get('/all', postController.getAllPosts);

postRouter.put('/react', postController.reactPost);

export default postRouter;