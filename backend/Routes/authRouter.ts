import express from 'express';
import authController from '../Controllers/authController';

const authRouter = express.Router();

authRouter.post('/api/v1/user/signup', authController.signupUser);

authRouter.post('/api/v1/user/login', authController.loginUser);

authRouter.get('/api/v1/user/find', authController.checkPhoneNumber);

export default authRouter;