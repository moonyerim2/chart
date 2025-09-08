# 차트 프로젝트

이 프로젝트는 API 호출을 통해 가져온 데이터를 기반으로 차트를 표시하는 웹 애플리케이션입니다. 백엔드에는 Spring MVC, 데이터 영속성에는 MyBatis, 프론트엔드 시각화에는 Chart.js를 사용합니다.

## 목차

- [설정](#설정)
- [프로젝트 구조](#프로젝트-구조)
- [사용된 기술](#사용된-기술)
- [API 엔드포인트](#api-엔드포인트)
- [사용법](#사용법)

## 설정

프로젝트를 설정하려면 다음 단계를 따르세요:

1.  **전제 조건**
    *   Java 11 이상
    *   Maven 3.6 이상
    *   MySQL 8.0 이상
    *   Tomcat 9 이상

2.  **데이터베이스 설정**
    *   `mnm_chart`라는 이름의 MySQL 데이터베이스를 생성합니다.
    *   `src/main/resources/db/schema.sql` 및 `src/main/resources/db/data.sql` 스크립트를 실행하여 테이블을 생성하고 초기 데이터를 채웁니다.
    *   `src/main/resources/jdbc.properties`를 데이터베이스 자격 증명으로 업데이트합니다.

3.  **프로젝트 빌드**
    ```bash
    mvn clean install
    ```

4.  **Tomcat에 배포**
    *   생성된 `target/mnm.war` 파일을 Tomcat 서버의 `webapps` 디렉토리에 복사합니다.
    *   Tomcat을 시작합니다.

5.  **애플리케이션 접속**
    웹 브라우저를 열고 `http://localhost:8080/mnm/` (또는 구성된 컨텍스트 경로)로 이동합니다.

## 프로젝트 구조

```
src
├── main
│   ├── java
│   │   └── egovframework
│   │       └── example
│   │           └── mnm
│   │               ├── controller
│   │               │   ├── ChartApiController.java
│   │               │   ├── MnmApiController.java
│   │               │   └── MnmController.java
│   │               ├── dao
│   │               │   └── MnmDAO.java
│   │               ├── service
│   │               │   ├── impl
│   │               │   │   └── MnmServiceImpl.java
│   │               │   └── MnmService.java
│   │               └── vo
│   │                   ├── MnmVO.java
│   │                   └── UserVO.java
│   ├── resources
│   │   ├── db
│   │   │   ├── data.sql
│   │   │   ├── schema.sql
│   │   │   └── seed_36m.sql
│   │   ├── jdbc.properties
│   │   └── mappers
│   │       └── MnmMapper.xml
│   └── webapp
│       ├── index.html
│       ├── resources
│       │   ├── css
│       │   │   └── custom.css
│       │   └── js
│       │       ├── common.js
│       │       ├── mnm.dashboard.api.js
│       │       ├── mnm.dashboard.charts.js
│       │       ├── mnm.dashboard.init.js
│       └── WEB-INF
│           ├── jsp
│           │   ├── include
│           │   │   ├── footer.jsp
│           │   │   └── header.jsp
│           │   └── mnm
│           │       ├── dashboard.jsp
│           │       └── list.jsp
│           ├── spring
│           │   ├── appServlet
│           │   │   └── servlet-context.xml
│           │   └── root-context.xml
│           └── web.xml
```

## 사용된 기술

*   **백엔드**: Spring MVC, MyBatis
*   **데이터베이스**: MySQL
*   **프론트엔드**: JSP, JSTL, Bootstrap 5, Chart.js, jQuery
*   **빌드 도구**: Maven

## API 엔드포인트

### 차트 API (`/api/charts`)

*   `GET /api/charts/status`: 상태 차트 데이터를 가져옵니다.
*   `GET /api/charts/monthly?year={year}`: 주어진 연도의 월별 데이터를 가져옵니다 (기본값은 현재 연도).
*   `GET /api/charts/users`: 사용자 차트 데이터를 가져옵니다.
*   `GET /api/charts/resolutionRate`: 해결률 데이터를 가져옵니다.
*   `GET /api/charts/avgResolutionMinutes?year={year}`: 주어진 연도의 평균 해결 시간(분) 데이터를 가져옵니다 (기본값은 현재 연도).
*   `GET /api/charts/ping`: 상태 확인 엔드포인트입니다.

### Mnm API (`/api/mnm`)

*   `GET /api/mnm?title={title}&status={status}&page={page}&size={size}`: 선택적 필터링이 적용된 M&M 항목의 페이지별 목록을 가져옵니다.
*   `GET /api/mnm/{id}`: ID로 단일 M&M 항목의 세부 정보를 가져옵니다.
*   `POST /api/mnm`: 새로운 M&M 항목을 생성합니다.
*   `PUT /api/mnm/{id}`: ID로 기존 M&M 항목을 업데이트합니다.
*   `DELETE /api/mnm/{id}`: ID로 M&M 항목을 삭제합니다.

## 사용법

애플리케이션을 배포하고 접속한 후 다음을 수행할 수 있습니다:

*   **대시보드 보기**: 대시보드 페이지 (`/mnm/dashboard.do`)로 이동하여 M&M 데이터를 시각화하는 다양한 차트를 확인합니다.
*   **M&M 항목 관리**: M&M 목록 페이지 (`/mnm/list.do`)로 이동하여 M&M 항목을 보고, 추가하고, 편집하거나 삭제합니다.
*   **API 상호 작용**: 제공된 API 엔드포인트를 사용하여 애플리케이션의 데이터와 프로그래밍 방식으로 상호 작용합니다.
    *   **차트 데이터**: `/api/charts/*` 엔드포인트에서 차트 데이터를 가져와 다른 프론트엔드 애플리케이션 또는 사용자 지정 대시보드와 통합합니다.
    *   **M&M CRUD**: `/api/mnm/*` 엔드포인트을 사용하여 M&M 항목에 대한 CRUD 작업을 수행합니다.
