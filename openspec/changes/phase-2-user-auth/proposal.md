## Why

Implement the SQLModel database framework with local SQLite3 and build the user authentication endpoints (sign up, sign in), connecting the frontend login UI to the backend JWT session tokens.

## What Changes

- Configure SQLModel engine and session handlers for SQLite3 database (`moodfood.db`).
- Define the SQLModel database tables for `User`, `UserPreference`, `MoodRecord`, `RestaurantSnapshot`, `RecommendationSession`, and `RecommendationItem`.
- Set up auto-creation of database tables on FastAPI startup.
- Build passlib password hashing and PyJWT token generation functions.
- Create `/api/auth/register` and `/api/auth/login` router endpoints.
- Update `static/app.js` to submit the login and registration forms, store the JWT token in `localStorage`, and redirect users on success.

## Capabilities

### New Capabilities
- `user-auth`: FastAPI registration and login API endpoints with JWT session persistence.
- `core-data-model`: Core database schema configuration using SQLModel for SQLite3 database tables.

### Modified Capabilities
<!-- None: Greenfield project setup extension -->

## Impact

- **Affected Systems**: Database initialization, API auth router endpoints, frontend session handling.
- **Dependencies**: sqlmodel, passlib[bcrypt], pyjwt.
