## Context

MoodFood AI is a greenfield spec-driven development project. Phase 1 establishes the structural backend API foundation using FastAPI, local SQLite3 storage via SQLModel, a JWT-based user authentication system, and a statically served single-page frontend.

## Goals / Non-Goals

**Goals:**
- Set up a clean, scalable FastAPI project layout.
- Configure SQLite3 database connection and migrations/schema creation using SQLModel.
- Implement `/api/auth/register` and `/api/auth/login` endpoints returning JWT access tokens.
- Design database models for User, UserPreference, MoodRecord, RestaurantSnapshot, RecommendationSession, and RecommendationItem.
- Set up the static directory mount to serve standard `index.html`, `app.js`, and `styles.css` directly from FastAPI.
- Deliver a baseline HTML5 CSS shell representing the single-page workbench.

**Non-Goals:**
- Integration with the Google Places API or fetching live restaurants.
- Integration with the OpenAI API for generating reasons or analyzing images.
- Developing actual charts, food journals, or weekly trend pages.

## Decisions

### 1. Framework: FastAPI
- **Rationale**: FastAPI is extremely lightweight, natively asynchronous, and generates interactive swagger documentation automatically, facilitating fast integration.

### 2. ORM: SQLModel
- **Rationale**: SQLModel bridges SQLAlchemy and Pydantic. It allows using a single class definition for both API validation (Pydantic schema) and database row persistence (SQLAlchemy model), eliminating redundant declarations.

### 3. Session Persistence: JWT in LocalStorage
- **Rationale**: Storing the JWT in `localStorage` and passing it via the `Authorization` header is the simplest authentication configuration for a vanilla HTML/JS single-page frontend.

### 4. Frontend Delivery: FastAPI Static Files Mount
- **Rationale**: Statically serving the single-page application directly from a `/static` directory via FastAPI eliminates CORS issues and simplifies deployment by keeping it on a single port.

## Risks / Trade-offs

- **[Risk] LocalStorage XSS Vulnerability** → Storing tokens in local storage exposes them to potential cross-site scripting (XSS) attacks.
  - *Mitigation*: Ensure all client-side rendering uses secure text insertion (`textContent` or innerText) instead of raw `innerHTML`. We will evaluate migrating to secure HTTP-only cookies in later phases.
- **[Risk] SQLite Concurrent Write Bottlenecks** → SQLite can experience table lock exceptions during simultaneous writes.
  - *Mitigation*: SQLite is fully adequate for Phase 1 local execution and single-user demonstration. We can upgrade to PostgreSQL later by swapping the SQLModel database engine connection string.
