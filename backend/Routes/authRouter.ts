import express from 'express';
import authController from '../Controllers/authController';
import auth from '../Middlewares/auth';
import uploader from '../Middlewares/uploader';

const authRouter = express.Router();

authRouter.post('/signup', authController.signupUser);

authRouter.post('/login', authController.loginUser);

authRouter.get('/find', authController.checkPhone);

authRouter.get('/auth', auth, authController.getUser);

authRouter.post('/avatar', uploader, auth, authController.uploadAvatar);

export default authRouter;