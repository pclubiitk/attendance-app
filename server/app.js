import express from "express";
import morgan from "morgan";
import connectDB from "./database/connectDB";

require("dotenv").config()
connectDB();

const app = express();
const PORT = 3000;
const userRouter = require("./routes/userRoutes");

app.use(cors({
  credentials: true,
  origin: true
}));
app.use(morgan('dev'));
app.use(express.json());

app.use("/user",userRouter);

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
