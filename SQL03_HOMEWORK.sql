


-- 학생 이름 주소지를 표시하시오. 단, 출력 헤더는 "학생 이름", "주소지"로 하고,
-- 정렬은 이름으로 오름차순 표시하도록 한다.

-- 1번 
SELECT STUDENT_NAME "학생 이름", STUDENT_ADDRESS 주소지 
FROM TB_STUDENT
ORDER BY "학생 이름";


-- 휴학중인 학생들의 이름과 주민번호를 나이가 적은 순서로 화면에 출력

-- 2번

SELECT STUDENT_NAME , STUDENT_SSN 
FROM TB_STUDENT
WHERE ABSENCE_YN NOT LIKE 'N'
ORDER BY STUDENT_SSN DESC;

-- 주소지나 강원도나 경기도인 학생들 중, 1990년대 학번을 가진 학생들의 이름과 학번
-- 주소를 이름의 오름차순으로 화면에 출력
-- 출력헤더에는 "학생이름", "학번", "거주지 주소" 가 출력되도록 한다.

-- 3번


SELECT STUDENT_NAME 학생이름, STUDENT_NO 학번, STUDENT_ADDRESS "거주지 주소"
FROM TB_STUDENT
WHERE STUDENT_NO NOT LIKE 'A%'
AND STUDENT_ADDRESS LIKE '경기도%'
OR STUDENT_ADDRESS LIKE '강원도%'
ORDER BY STUDENT_NAME ;


-- 현재 법학과 교수 중 가장 나이가 많은 사람부터 이름을 확인할 수 있는 SQL 문장 작성
-- 법학과의 '학과코드'는 학과 테이블을 조회해서 찾아내자

-- 4번

SELECT PROFESSOR_NAME, PROFESSOR_SSN 
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO = '005'
ORDER BY PROFESSOR_SSN ASC;


-- 2004년 2학기에 'C3118100' 과목을 수강한 학생들의 학점 조회하려고 함
-- 학점이 높은 학생부터 표시하고, 학점이 같으면 학번이 낮은 학생부터 표시

-- 5번

SELECT STUDENT_NO, TO_CHAR(POINT, '9.00') POINT
FROM TB_GRADE
WHERE CLASS_NO = 'C3118100'
AND TERM_NO = '200402'
ORDER BY POINT DESC;


-- 학생 번호, 학생 이름, 학과 이름을 학생 이름으러 오름차순 정렬해서 출력

-- 6번

SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
FROM TB_STUDENT 
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO);


-- 과목 이름과 과목의 학과 이름을 출력하는 SQL 문장을 작성하시오

-- 7번

SELECT CLASS_NAME , DEPARTMENT_NAME
FROM TB_CLASS
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO);


-- 과목별 교수 이름 찾으려고 한다.
-- 과목 이름과 교수 이름을 출력하는 SQL문을 작성하시오

-- 8번

SELECT CLASS_NAME , PROFESSOR_NAME 
FROM TB_CLASS
JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
JOIN TB_PROFESSOR USING(PROFESSOR_NO);


-- 8번의 결과 중 '인문사호;' 계열에 속한 과목의 교수 이름을 찾으려고 한다.
-- 이에 해당하는 과목 이름과 교수 이름을 출력하는 SQL문을 작성하시오.

-- 9번

SELECT tc.CLASS_NAME , tp.PROFESSOR_NAME 
FROM TB_CLASS tc
JOIN TB_CLASS_PROFESSOR tcp ON(tc.CLASS_NO = tcp.CLASS_NO)
JOIN TB_PROFESSOR tp ON(tp.PROFESSOR_NO  = tcp.PROFESSOR_NO)
JOIN TB_DEPARTMENT td ON(tp.DEPARTMENT_NO = td.DEPARTMENT_NO)
WHERE td.CATEGORY = '인문사회';


-- '음악학과' 학생들의 평점을 구하려고 한다
-- 음악학과 학생들의 '학번', '학생 이름', '전체 평점'을 출력하는 SQL 문장을 작성
-- 단 평점은 소수점 1자리까지만 반올림

-- 10번

SELECT STUDENT_NO 학번 , STUDENT_NAME "학생 이름", ROUND(AVG(POINT),1) "전체 평점"
FROM TB_STUDENT
JOIN TB_GRADE USING(STUDENT_NO)
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '음악학과'
GROUP BY STUDENT_NAME, STUDENT_NO
ORDER BY STUDENT_NO;


-- 학번이 A313047인 학생이 학교에 나오고 있지 않다.
-- 학과 이름, 학생 이름과 지도 교수 이름이 필요
-- SQL 작성
-- 단 출력헤더는 "학과이름", "학생이름", "지도교수이름" 으로 출력


-- 11번

SELECT DEPARTMENT_NAME 학과이름, STUDENT_NAME 학생이름, PROFESSOR_NAME 지도교수이름
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
JOIN TB_PROFESSOR ON (COACH_PROFESSOR_NO = PROFESSOR_NO)
WHERE STUDENT_NO = 'A313047';


-- 2007년도에 '인간관계론' 과목을 수강한 학생을 찾아
-- 학생이름과 수강학기를 표시하는 SQL문을 작성

-- 12번

SELECT STUDENT_NAME, TERM_NO TERM_NAME
FROM TB_STUDENT TS
JOIN TB_GRADE TG ON (TS.STUDENT_NO = TG.STUDENT_NO)
JOIN TB_CLASS TC ON (TC.CLASS_NO = TG.CLASS_NO)
WHERE CLASS_NAME = '인간관계론' AND TERM_NO LIKE '2007%';


-- 예체능 계열 과목 중 과목 담당교수를 한 명도 배정받지 못한 과목을 찾아
-- 그 과목 이름과 학과 이름을 출력하는 SQL문장을 작성하시오.

-- 13번

SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS TC
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
LEFT JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
WHERE CATEGORY = '예체능'AND PROFESSOR_NO IS NULL;



-- 서반아어학과 학생들의 지도교수를 게시하고자 한다.
-- 학생 이름과 지도 교수 이름을 찾고, 만일 지도 교수가 없는 학생일 경우
-- '지도교수 미지정' 으로 표시하도록 SQL문을 작성
-- 출력헤더는 "학생이름", "지도교수" 로 표시하며 고학번 학생이 먼저 표시되도록 한다

-- 14번


SELECT STUDENT_NAME 학생이름 , 
NVL(PROFESSOR_NAME, '지도교수 미지정') 지도교수
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
LEFT JOIN TB_PROFESSOR ON(COACH_PROFESSOR_NO = PROFESSOR_NO)
WHERE DEPARTMENT_NAME = '서반아어학과';


-- 휴학생이 아닌, 학생 중 평점이 4.0 이상인 학생 찾기
-- 그 학생의 학번, 이름, 학과 이름, 평점을 출력하는 SQL문 작성

-- 15번

SELECT STUDENT_NO 학번 , STUDENT_NAME 이름  , 
DEPARTMENT_NAME "학과 이름" , ROUND(AVG(POINT), 8) 평점
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
JOIN TB_GRADE USING(STUDENT_NO)
WHERE ABSENCE_YN = 'N'
GROUP BY STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
HAVING ROUND(AVG(POINT), 8) >= 4.0
ORDER BY STUDENT_NO;


-- 환경조경학과 전공과목들의 과목 별 평점을 파악할 수 있는 SQL문 작성

-- 16번


SELECT CLASS_NO, CLASS_NAME , ROUND(AVG(POINT),8) "AVG(POINT)"
FROM TB_CLASS
JOIN TB_GRADE USING (CLASS_NO)
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '환경조경학과' 
AND CLASS_TYPE LIKE '%전공%'
GROUP BY CLASS_NO , CLASS_NAME;


-- 최경희 학생과 같은 과 학생들의 이름과 주소를 출력하는 SQL문을 작성하시오

-- 17번


SELECT STUDENT_NAME , STUDENT_ADDRESS 
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NO = '038';


-- 국어국문학과에서 총 평점이 가장 높은 학생의 이름과 학번을 표시하는 SQL문을 작성

-- 18번



SELECT STUDENT_NO, STUDENT_NAME 
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
JOIN TB_GRADE USING(STUDENT_NO)
WHERE DEPARTMENT_NO = '001'
GROUP BY STUDENT_NO, STUDENT_NAME;



-- '환경조경학과'가 속한 같은 계열 학과들의 학과 별 전공과목 평점을
-- 파악하기 위한 적절한 SQL 문을 찾아내시오
-- 단 출력헤더는 "계역 학과명", "전공평점"으로 표시하고
-- 평점은 소수점 한 자리까지만 반올림 표시

-- 19번


SELECT DEPARTMENT_NAME "계열 학과명", ROUND(AVG(POINT),1) 전공평점
FROM TB_DEPARTMENT
JOIN TB_CLASS TC USING(DEPARTMENT_NO)
JOIN TB_GRADE TG ON(TC.CLASS_NO = TG.CLASS_NO )
WHERE CATEGORY LIKE '자연%'
GROUP BY DEPARTMENT_NAME
ORDER BY "계열 학과명";














