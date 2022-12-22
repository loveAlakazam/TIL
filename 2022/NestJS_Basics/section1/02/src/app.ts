import * as express from "express";
import { Cat, CatType } from "./app.model";
import { send } from "process";

const app: express.Express = express();
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

// 고양이 전체 데이터 조회
app.get("/cats", (req, res) => {
  try {
    const cats = Cat;
    res.status(200).send({ success: true, data: { cats } });
  } catch (error) {
    res.status(400).send({
      success: false,
      error: error.message,
    });
  }
});

// 특정 고양이 데이터 조회
app.get("/cats/:id", (req, res) => {
  try {
    const params = req.params;
    console.log(params);
    const cat = Cat.find((cat) => {
      return cat.id === params.id;
    });

    console.log(cat);
    if (!cat) {
      throw new Error("Not Found Error");
    }
    return res.status(200).send({ success: true, data: cat });
  } catch (error) {
    res.status(400).send({
      success: false,
      message: error.message,
    });
  }
});

// 새로운 고양이 데이터 추가
app.post("/cats", (req, res) => {
  try {
    const data = req.body;
    Cat.push(data);
    res.status(201).send({
      success: true,
      data: { data },
    });
  } catch (error) {
    res.status(400).send({
      success: false,
      message: error.message,
    });
  }
});

app.listen(port, () => {
  console.log(`project02 - run server on port at ${port}...`);
});
