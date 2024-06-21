import express from "express";
import morgan from "morgan";

const app = express();
const PORT = 3000;

app.use(morgan('dev'));

app.get('/', (req, res) => {
  res.send('Hello via Bun!');
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
