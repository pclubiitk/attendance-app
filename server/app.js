const express = require("express");
const morgan = require("morgan");
const cors = require("cors");

const app = express();
const PORT = 3000;
const userRouter = require("./routes/userRoutes");
// const eventRoutes = require(".routes/eventRoutes")
app.use(cors({
  credentials: true,
  origin: true
}));
app.use(morgan('dev'));

app.use(express.json());
app.use(express.urlencoded({extended: true}))
app.use("/user",userRouter);
// app.use("/event", eventRoutes)

app.listen(PORT, () => {
  console.log(`Server is running on ports ${PORT}`);
});
