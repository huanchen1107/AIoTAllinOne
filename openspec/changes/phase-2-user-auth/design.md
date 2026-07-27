## Context

Configure local SQLite3 database mappings and implement secure authentication APIs, allowing users to register accounts and log in to get JWT access tokens.

## Goals / Non-Goals

**Goals:**
- Connect to `moodfood.db` using SQLModel engine.
- Define data tables (`User`, `UserPreference`, etc.) as SQLModel classes.
- Hash passwords securely via `passlib[bcrypt]`.
- Build access tokens using `pyjwt` containing the user's ID.
- Create `/api/auth/register` and `/api/auth/login` router endpoints.
- Wire browser `localStorage` JWT token storage into `app.js` login event handlers.

**Non-Goals:**
- Direct mapping of mood selections to Google search queries.
- Making actual network calls to Google Places API or OpenAI.
- Developing food photos image uploads.

## Decisions

### 1. ORM: SQLModel
- **Rationale**: Single model representations mapping to SQLAlchemy schemas, simplifying code and API documentation.

### 2. Encryption: Passlib with bcrypt
- **Rationale**: Secure hashing standard for storing user passwords, with auto-salting to mitigate rainbow table threats.

### 3. Session Security: JWT in LocalStorage
- **Rationale**: Minimal setup overhead for local sandbox prototyping, matching client-side fetch requirements.

## Risks / Trade-offs

- **[Risk] SQLite lock during database initialization** → Double initialization threads might conflict.
  - *Mitigation*: Ensure database engine tables are created once on startup via FastAPI lifecycle events (`lifespan`).
