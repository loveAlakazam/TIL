import catsRouter from "./cats/cats.route";
import * as express from "express";

const app: express.Express = express();
app.use(express.urlencoded({ extended: true }));
app.use(express.json());
const port: number = 8000;

app.get("/", (req: express.Request, res: express.Response) => {
  res.send("hello World");
});

// 밑에있는 모든 api가 실행후에 logging-middleware가 실행됨.
app.use((req, res, next) => {
  console.log(req.rawHeaders);
  console.log("this is logging-middleware");
  next();
});

// 고양이 api 관련 라우터
app.use(catsRouter);

app.listen(port, async () => {
  console.log(`project02 - run server on port at ${port}...`);
});
