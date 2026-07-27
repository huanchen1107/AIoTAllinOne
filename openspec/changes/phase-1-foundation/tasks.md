## 1. Environment & Setup

- [x] 1.1 Create the python virtual environment and verify python installation.
- [x] 1.2 Create `requirements.txt` containing dependencies: `fastapi`, `uvicorn`, `sqlmodel`, `python-dotenv`, `pyjwt`, `passlib[bcrypt]`.
- [x] 1.3 Create the project directories: `backend`, `backend/routers`, `static`.
- [x] 1.4 Create `.env` to declare `DATABASE_URL=sqlite:///./moodfood.db` and `JWT_SECRET=supersecretkey`.

## 2. Server Configuration

- [ ] 2.1 Write the entrypoint script `backend/main.py` configuring a FastAPI instance.
- [ ] 2.2 Add FastAPI `StaticFiles` mounting middleware in `backend/main.py` mapping `/static` files to the root url `/`.

## 3. Frontend Layout Mockups

- [ ] 3.1 Create static placeholder files: `static/index.html`, `static/styles.css`, and `static/app.js`.
- [ ] 3.2 Design the HTML dashboard layout inside `static/index.html` using Tailwind CSS CDN.
- [ ] 3.3 Add the static HTML controls: Mood options (5 buttons), Motivation options (4 options), Budget, and Distance fields.
- [ ] 3.4 Design the mock restaurant cards layout: display 3 static mock cards showing a name, mock photo, rating, and placeholder recommendation reason.
- [ ] 3.5 Design a slide-in login form overlay for authentication preview.

## 4. Launch & Verification

- [ ] 4.1 Start the FastAPI local server using uvicorn.
- [ ] 4.2 Open `http://localhost:8000` in the browser and verify the single-page workbench loads successfully.
