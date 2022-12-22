import * as express from "express";
import { Cat, CatType } from "app.model";

const app: express.Express = express();
const port: number = 8000;

app.get("/", (req: express.Request, res: express.Response) => {
  console.log(req);
  res.send("hello World");
  return res.send({ cat: Cat });
});

app.listen(port, () => {
  console.log(`run server on port at ${port}...`);
});
