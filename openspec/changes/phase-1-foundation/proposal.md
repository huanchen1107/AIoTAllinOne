## Why

Establish the foundational project structure, mount static file serving, and create the baseline single-page workbench HTML/CSS/JS shell, allowing us to preview the user interface before implementing database logic.

## What Changes

- Initialize the FastAPI project directory structure.
- Set up a static file mount in FastAPI to serve raw static assets from `/static`.
- Build the baseline UI shell (single-page dashboard layout using HTML, Tailwind CSS via CDN, and vanilla JS).
- Present mockup components: a mood/motivation input form, static restaurant cards (3 mock cards), and placeholder login/preferences settings toggles.

## Capabilities

### New Capabilities
- `static-workbench`: The single-page workbench layout served statically, representing the visual mockups of the mood selector and restaurant cards.

### Modified Capabilities
<!-- None: Greenfield project setup -->

## Impact

- **Affected Systems**: Backend server configuration, static web templates.
- **Dependencies**: fastapi, uvicorn.
