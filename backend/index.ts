// packages & modules
import express from 'express';
import mongoose from 'mongoose';
import dotenv from 'dotenv';
import bodyParser from 'body-parser';
import cors from 'cors';
import authRouter from './Routes/authRouter';

// Initialization
dotenv.config();
const app = express();
const port = process.env.PORT;
const db = process.env.DB_URL;

// Connection
app.listen(port, () => {
  console.log(`Server is running on localhost:${port}`);
});
mongoose.connect(db!).then(() => {
  console.log('Database connection successful');
}).catch((err) => {console.log(err)});

// Middlewares
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: true}));
app.use(cors());

// Routes
app.use(authRouter);

// API
app.get('/', (req, res) => {
  res.send('Hello World!');
});
