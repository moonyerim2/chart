# Chart Project

This project is a web application for displaying charts based on data fetched via API calls. It uses Spring MVC for the backend, MyBatis for data persistence, and Chart.js for frontend visualizations.

## Table of Contents

- [Setup](#setup)
- [Project Structure](#project-structure)
- [Technologies Used](#technologies-used)
- [API Endpoints](#api-endpoints)
- [Usage](#usage)

## Setup

To set up the project, follow these steps:

1.  **Prerequisites**
    *   Java 11 or higher
    *   Maven 3.6 or higher
    *   MySQL 8.0 or higher
    *   Tomcat 9 or higher

2.  **Database Setup**
    *   Create a MySQL database named `mnm_chart`.
    *   Execute the `src/main/resources/db/schema.sql` and `src/main/resources/db/data.sql` scripts to create tables and populate initial data.
    *   Update `src/main/resources/jdbc.properties` with your database credentials.

3.  **Build the Project**
    ```bash
    mvn clean install
    ```

4.  **Deploy to Tomcat**
    *   Copy the generated `target/mnm.war` file to the `webapps` directory of your Tomcat server.
    *   Start Tomcat.

5.  **Access the Application**
    Open your web browser and navigate to `http://localhost:8080/mnm/` (or your configured context path).

## Project Structure

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
│       │       └── mnm.dashboard.init.js
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

## Technologies Used

*   **Backend**: Spring MVC, MyBatis
*   **Database**: MySQL
*   **Frontend**: JSP, JSTL, Bootstrap 5, Chart.js, jQuery
*   **Build Tool**: Maven

## API Endpoints

### Chart API (`/api/charts`)

*   `GET /api/charts/status`: Get data for the status chart.
*   `GET /api/charts/monthly?year={year}`: Get monthly data for a given year (defaults to current year).
*   `GET /api/charts/users`: Get data for the users chart.
*   `GET /api/charts/resolutionRate`: Get resolution rate data.
*   `GET /api/charts/avgResolutionMinutes?year={year}`: Get average resolution minutes data for a given year (defaults to current year).
*   `GET /api/charts/ping`: Health check endpoint.

### Mnm API (`/api/mnm`)

*   `GET /api/mnm?title={title}&status={status}&page={page}&size={size}`: Get a paginated list of Mnm items with optional filtering.
*   `GET /api/mnm/{id}`: Get details of a single Mnm item by ID.
*   `POST /api/mnm`: Create a new Mnm item.
*   `PUT /api/mnm/{id}`: Update an existing Mnm item by ID.
*   `DELETE /api/mnm/{id}`: Delete an Mnm item by ID.

## Usage

After deploying and accessing the application, you can:

*   **View Dashboard**: Navigate to the dashboard page (`/mnm/dashboard.do`) to see various charts visualizing M&M data.
*   **Manage M&M Items**: Go to the M&M list page (`/mnm/list.do`) to view, add, edit, or delete M&M items.
*   **API Interaction**: Use the provided API endpoints to programmatically interact with the application's data.
    *   **Chart Data**: Fetch chart data from `/api/charts/*` endpoints to integrate with other frontend applications or custom dashboards.
    *   **M&M CRUD**: Perform CRUD operations on M&M items using `/api/mnm/*` endpoints.
