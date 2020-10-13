# 동적SQL

- **검색기능** / **다중입력 처리** 등을 수행할 경우

<BR>

# 지원 구문 종류

|지원구문|
|:--:|
|if|
|choose (when, otherwise)|
|trim (where, set)|
|foreach|


- 조건(`<if>`)을 이용해서 title을 넣을 것인지 안넣을 것인지를 동적으로 결정할 수 있다.

- `test` 는 jstl core태그에서 볼 수 있다.
- if조건이 만족하지 않은 경우도 생각해야된다!
- writer과 title이 같이 있는경우는 만족하지만
- title만 있는경우에는..? and로 묶어야되잖아?
- WHERE가 쓰고 싶은데... 어떨때는 WHERE SQL 조건절이 들어가고 어떨때는 필요없고


<br>

```sql
<select id="searchBoard" resultType="arrayList">
  SELECT *
  FROM BOARD
  <where>
    <if test="writer != null">

    </if>
    <if test="title !=null">
      AND TITLE =#{title}
    </if>
  </where>

</select>
```

## <where>태그와 WHERE

- 단순히 WHERE만을 추가하지만 만일 태그안의 내용이 AND나 OR로 시작할 경우 `AND` 또는 `OR` 제거한다.

- 앞의 조건을 만족하지 않아서 조건에 쓰이지 않으면 AND나 OR을 지워줘.

- trim
  - where구문과 같다.
  - 태그 안의 내용이 완성될 때 처음 시작할 단어(prefix)와 시작시 제거해야할 단어(prefixOverrides)를 명시해 where와 같은 내용으로 구현.

- set
  - 마지막에 쉼표로 끝나면 지워버리자.

- foreach
  - insert할때 많이 쓰임.
  - 한번에 여러개 insert를 할때
  - 전체에 대한 하나!

  ```SQL

  ```

  - 여러개

  ```sql
  insert into member values <foreach> </foreach>;

  -- insert into member values (값1), (), ()
  --                           (), (), ()


  <foreach> insert into  member values () </foreach>
  -- insert into member values ()
  -- insert into member values ()

  -- 그러면 foreach는 insert를 여러번 할 수 없을까?
  -- nope! insert all 로 하면 됨!

  ```

<br>

# bind구문



```SQL

```
