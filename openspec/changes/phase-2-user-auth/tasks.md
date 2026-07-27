## 1. Database & Models Setup

- [ ] 1.1 Create `backend/database.py` mapping to local SQLite3 engine and session generator.
- [ ] 1.2 Create `backend/models.py` with SQLModel schemas for `User`, `UserPreference`, `MoodRecord`, `RestaurantSnapshot`, `RecommendationSession`, and `RecommendationItem`.
- [ ] 1.3 Update `backend/main.py` lifespan startup events to auto-generate the SQLite database tables.

## 2. Cryptography & Security Helpers

- [ ] 2.1 Write security utilities in `backend/auth_utils.py` to hash passwords using passlib and verify hashes.
- [ ] 2.2 Write token generators in `backend/auth_utils.py` using PyJWT to encode and decode access tokens.

## 3. Auth API Routers

- [ ] 3.1 Implement registration endpoint `POST /api/auth/register` in `backend/routers/auth.py` (checking for duplicate emails and hash password).
- [ ] 3.2 Implement login endpoint `POST /api/auth/login` returning user access tokens.
- [ ] 3.3 Register the auth router in `backend/main.py`.
- [ ] 3.4 Implement a GET endpoint `/api/user/preferences` requiring JWT auth validation dependency.

## 4. Frontend API Connection

- [ ] 4.1 Update `static/app.js` login and registration event handlers to perform `fetch` API calls to `POST /api/auth/login` and `POST /api/auth/register`.
- [ ] 4.2 Save access tokens to `localStorage` on successful auth.
- [ ] 4.3 Hide the login overlay and display the main workbench dashboard on login success.

## 5. Verification & Tests

- [ ] 5.1 Write API unit tests `tests/test_auth.py` executing FastAPI `TestClient` to verify duplicate registration failures.
- [ ] 5.2 Test the login endpoint with mock credentials.
