## 1. Project Initialization & Dependencies

- [ ] 1.1 Create the python virtual environment and verify python installation.
- [ ] 1.2 Create `requirements.txt` containing dependencies: `fastapi`, `uvicorn`, `sqlmodel`, `python-dotenv`, `pyjwt`, `passlib[bcrypt]`.
- [ ] 1.3 Create the project directories: `backend`, `backend/routers`, `static`.
- [ ] 1.4 Create `.env` to declare `DATABASE_URL=sqlite:///./moodfood.db` and `JWT_SECRET=supersecretkey`.

## 2. Database Configuration & Models

- [ ] 2.1 Write `backend/database.py` to initialize SQLModel engine and session helper.
- [ ] 2.2 Define database tables in `backend/models.py` including `User`, `UserPreference`, `MoodRecord`, `RestaurantSnapshot`, `RecommendationSession`, and `RecommendationItem`.
- [ ] 2.3 Add startup event handlers in `backend/main.py` to auto-create database tables on server start.

## 3. Authentication & Session Routing

- [ ] 3.1 Implement security helpers in `backend/auth_utils.py` for hashing passwords (passlib) and generating JWT tokens (pyjwt).
- [ ] 3.2 Implement registration endpoint `POST /api/auth/register` in `backend/routers/auth.py` creating user and blank preferences.
- [ ] 3.3 Implement login endpoint `POST /api/auth/login` returning user access tokens.
- [ ] 3.4 Implement a GET preference endpoint `GET /api/user/preferences` requiring JWT auth dependency.

## 4. Single-Page Static Frontend Shell

- [ ] 4.1 Set up static file mounting in `backend/main.py` using `StaticFiles` middleware pointing to `static/` directory.
- [ ] 4.2 Create static web pages: `static/index.html`, `static/app.js`, and `static/styles.css` utilizing Bootstrap CSS via CDN.
- [ ] 4.3 Implement vanilla JS frontend logic in `static/app.js` with placeholders for login, registration, preferences, and recommendation cards.

## 5. Verification & Testing

- [ ] 5.1 Create mock test suite `tests/test_auth.py` using FastAPI's `TestClient` to verify registration and login responses.
- [ ] 5.2 Test launching the backend server and accessing http://localhost:8000.
