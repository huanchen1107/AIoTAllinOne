## Why

Establish the foundational FastAPI project codebase, database configurations using SQLModel/SQLAlchemy with local SQLite3, user authentication using JWT, and the base single-page workbench UI skeleton, ensuring a clean, lightweight structure for subsequent phases.

## What Changes

- Initialize the FastAPI project directory structure (routers for `auth`, `recommendations`, `journals`).
- Set up SQLite3 database connectivity using SQLAlchemy/SQLModel.
- Implement user registration and login endpoints generating JWT access tokens.
- Define data models for `User`, `UserPreference`, `MoodRecord`, `RestaurantSnapshot`, `RecommendationSession`, and `RecommendationItem`.
- Set up a static file mount in FastAPI to serve the frontend web page (`index.html`, `styles.css`, `app.js`).
- Design the baseline UI shell (single-page workbench layout using HTML, Tailwind/Bootstrap CSS via CDN, and vanilla JS) to preview components.
- Establish environment variable configurations (.env) to store JWT secrets and database paths safely.

## Capabilities

### New Capabilities
- `user-auth`: Local authentication flow allowing registration, login, and token storage in browser local storage.
- `core-data-model`: Core database tables to track user preferences, location, search sessions, moods, restaurant snapshot details, and recommendation results.

### Modified Capabilities
<!-- None: Greenfield project setup -->

## Impact

- **Affected Systems**: Backend server configuration, database schema creation, static assets, and local environment setup.
- **Dependencies**: fastapi, uvicorn, sqlmodel, python-dotenv, PyJWT (or jose), passlib (with bcrypt).
