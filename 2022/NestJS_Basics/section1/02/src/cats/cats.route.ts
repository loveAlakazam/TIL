import { Router } from "express";
import { Cat } from "./cats.model";

const router = Router();

// 고양이 전체 데이터 조회
router.get("/cats", (req, res) => {
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
router.get("/cats/:id", (req, res) => {
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
router.post("/cats", (req, res) => {
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

export default router;
