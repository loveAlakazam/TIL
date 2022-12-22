import { Router } from "express";
import { Cat } from "./cats.model";
import * as catsService from "./cats.service";

const router = Router();

// 고양이 전체 데이터 조회
router.get("/cats", catsService.getAllCats);

// 특정 고양이 데이터 조회
router.get("/cats/:id", catsService.getOneCatById);

// 새로운 고양이 데이터 추가
router.post("/cats", catsService.createNewCat);

// UPDATE[PUT]: 전체 업데이트
router.put("/cats/:id", catsService.updateCatInfos);

// UPDATE[PATCH]: 고양이 데이터를 부분적으로 업데이트
router.patch("/cats/:id", catsService.updateCatPartialInfo);

// DELETE: 고양이 데이터 삭제
router.delete("/cats/:id", catsService.deleteCat);

export default router;
