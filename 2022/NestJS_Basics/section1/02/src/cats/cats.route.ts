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

// UPDATE[PUT]: 전체 업데이트
router.put("/cats/:id", (req, res) => {
  try {
    const params = req.params;
    const body = req.body;

    const cat = Cat.forEach((cat) => {
      if (cat.id === params.id) {
        cat = body; // 수정
        return res.status(201).send({
          success: true,
          data: cat,
        });
      }
    });

    throw new Error("고양이 데이터가 존재하지 않아서 실패하였습니다.");
  } catch (error) {
    res.status(400).send({
      success: false,
      message: error.message,
    });
  }
});

// UPDATE[PATCH]: 고양이 데이터를 부분적으로 업데이트
router.patch("/cats/:id", (req, res) => {
  try {
    const params = req.params;
    const body = req.body;

    let result;
    const cat = Cat.forEach((cat) => {
      if (cat.id === params.id) {
        cat = { ...cat, ...body }; // body에 해당된 부분만 수정
        result = cat;
        return res.status(201).send({
          success: true,
          data: result,
        });
      }
    });

    throw new Error("고양이 데이터가 존재하지 않아서 실패하였습니다.");
  } catch (error) {
    res.status(400).send({
      success: false,
      message: error.message,
    });
  }
});

// DELETE: 고양이 데이터 삭제
router.delete("/cats/:id", (req, res) => {
  try {
    const params = req.params;
    console.log(params);
    const cats = Cat.filter((cat) => cat.id !== params.id);

    return res.status(201).send({
      success: true,
      data: cats,
    });
  } catch (error) {
    res.status(400).send({
      success: false,
      message: error.message,
    });
  }
});

export default router;
