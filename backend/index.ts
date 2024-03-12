// packages & modules
import express from 'express';
import dotenv from 'dotenv';
import bodyParser from 'body-parser';
import cors from 'cors';

// Initialization
dotenv.config();
const app = express();
const port = process.env.PORT;

// Connection
app.listen(port, () => {
  console.log(`Server is running on localhost:${port}`);
});

// Middlewares
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: true}));
app.use(cors());

// Routes

// API
app.get('/', (req, res) => {
  res.send('Hello World!');
});
