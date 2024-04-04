// packages & modules
import express from 'express';
import mongoose from 'mongoose';
import { v2 as cloudinary } from 'cloudinary';
import dotenv from 'dotenv';
import bodyParser from 'body-parser';
import cors from 'cors';
import authRouter from './Routes/authRouter';
import postRouter from './Routes/postRouter';

// Initialization
dotenv.config();
const app = express();
const port = process.env.PORT;
const db = process.env.DB_URL;

// Connections
app.listen(port, () => {
  console.log(`Server is running on localhost:${port}`);
});

mongoose.connect(db!).then(() => {
  console.log('Database connection successful');
}).catch((err) => {console.log(err)});

cloudinary.config({
  cloud_name: process.env.CLOUD_NAME,
  api_key: process.env.CLOUD_KEY,
  api_secret: process.env.CLOUD_SECRET
});

// Middlewares
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: true}));
app.use(cors({
  origin: 'http://localhost:8000',
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
}));

// Routes
app.use(authRouter);
app.use(postRouter);

// APIs
app.get('/', (req, res) => {
  res.send('Hello World!');
});
