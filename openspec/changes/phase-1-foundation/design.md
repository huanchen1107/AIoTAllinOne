## Context

Establish the skeleton of the project. Phase 1 focuses entirely on setting up FastAPI to serve static files and coding the frontend mockup layout (HTML/CSS/JS) to define the look and feel of the single-page workbench.

## Goals / Non-Goals

**Goals:**
- Set up a basic FastAPI server layout.
- Configure FastAPI's StaticFiles mount to serve the `/static` directory on the root path `/`.
- Build the mockup single-page workbench layout using Tailwind CSS CDN.
- Form mockups: Mood/Motivation form, 3 static restaurant cards, and a toggle-able login panel.

**Non-Goals:**
- Connecting to database engines or configuring SQLModel/SQLite3.
- Implementing registration/login authentication endpoints or session tokens.
- Making live Google Places or OpenAI API calls.

## Decisions

### 1. Framework: FastAPI
- **Rationale**: Clean, modern Python micro-framework to serve the backend router and statically host the files.

### 2. Frontend layout: Tailwind CSS via CDN
- **Rationale**: Allows rapid, modern, utility-first CSS styling directly in `index.html` without requiring node/npm build tools.

### 3. Static Mounting
- **Rationale**: Using FastAPI's `StaticFiles` middleware mounted at the root path (`/`) allows immediately loading `index.html` on startup.

## Risks / Trade-offs

- **[Risk] Serving static files at root blocks API routes** → Mounting static files at `/` can accidentally intercept `/api` paths if not ordered correctly.
  - *Mitigation*: Mount specific `/api` routes in FastAPI *before* mounting the root StaticFiles handler.
