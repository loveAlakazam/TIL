-- PL/SQL 시작하기전에 사전테스트(1번만 진행.)
SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE('PL/SQL 동작 성공!');
END;
/
COMMIT;

--[문제 2-1] FOR-LOOP이용 구구단 출력하기
-- ANSWER
-- FOR LOOP를 이용한 풀이1
DECLARE
    DAN NUMBER;

BEGIN
    --사용자로부터 단 입력
    DAN:='&단(숫자)';

    FOR N IN 1..9
    LOOP
        DBMS_OUTPUT.PUT_LINE(DAN || 'x' || N || '=' || DAN*N);
    END LOOP;
END;
/


-- FOR LOOP를 이용한 풀이2
BEGIN
    FOR N IN 1..9
    LOOP
        DBMS_OUTPUT.PUT_LINE(N || '단');
        FOR M IN 1..9
        LOOP
            DBMS_OUTPUT.PUT_LINE(N ||'*' || M || '=' || N*M);
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('----------------------------');
    END LOOP;
END;
/

--------------------------------------------------------------
--[문제2-2]
-- 구구단 짝수단 출력 (FOR문)
BEGIN
    FOR N IN 1..9
    LOOP
        DBMS_OUTPUT.PUT_LINE('['|| N || '의 짝수단]');
        FOR M IN 1..9
        LOOP
            --M이 짝수
            IF MOD(M,2)=0
                THEN DBMS_OUTPUT.PUT_LINE(N ||'X' || M ||'='||N*M);
            END IF;
        END LOOP;
    END LOOP;
END;
/

-- 구구단 짝수단 출력(WHILE 문)
DECLARE
    N NUMBER:=1; --초기값
    M NUMBER;
BEGIN
    WHILE N<=9
    LOOP
        DBMS_OUTPUT.PUT_LINE(N || '단의 짝수단');
        M:=1; --M 초기화
        WHILE M<=9
            LOOP
            IF MOD(M,2)=0
                THEN DBMS_OUTPUT.PUT_LINE(N||'*' ||M ||'=' ||N*M);
            END IF;
            M:=M+1;
            END LOOP;
        N:=N+1;
    END LOOP;
END;
/
