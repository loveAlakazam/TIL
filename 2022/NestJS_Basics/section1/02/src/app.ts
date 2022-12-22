import catsRouter from "./cats/cats.route";
import * as express from "express";

class Server {
  public app: express.Application;
  public port: number;

  constructor() {
    // app instance 생성
    const app: express.Application = express();
    this.app = app;
    this.port = 8000;
  }

  private setRouter() {
    // 고양이 api 관련 라우터
    this.app.use(catsRouter);
  }

  private setMiddleware() {
    // 선행 미들웨어
    // 밑에있는 모든 api가 실행후에 logging-middleware가 실행됨.
    this.app.use((req, res, next) => {
      console.log(req.rawHeaders[1]);
      console.log("this is logging-middleware");
      next();
    });

    // json 방식으로 리스폰스
    this.app.use(express.json());
    this.app.use(express.urlencoded({ extended: true }));

    // 라우터
    this.setRouter();

    // 404 에러 미들웨어
    this.app.use((req, res, next) => {
      console.log("error middleware");
      res.send({ error: "404 not found" });
    });
  }

  public listen() {
    this.setMiddleware();
    this.app.listen(this.port, async () => {
      console.log(`project02 - run server on port at ${this.port}...`);
    });
  }
}

function init() {
  // 서버 객체 생성
  const server = new Server();

  server.listen();
}

// 서버실행
init();
