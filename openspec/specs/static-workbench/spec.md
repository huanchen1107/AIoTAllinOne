# static-workbench Specification

## Purpose
TBD - created by archiving change phase-1-foundation. Update Purpose after archive.
## Requirements
### Requirement: Serve static assets on root path
The system MUST mount a static directory to host and serve the frontend files (`index.html`, `styles.css`, `app.js`) at the root URL `/`.

#### Scenario: User visits the home page
- **WHEN** a client accesses the root URL `http://localhost:8000/`
- **THEN** the system SHALL return the contents of `index.html` with a status code of `200 OK`

---

### Requirement: Display interactive workbench mockups
The static home page MUST display visual placeholders mapping to the core user journey.

#### Scenario: Inspecting the workbench elements
- **WHEN** the home page is loaded in a browser
- **THEN** it SHALL display a form with mood inputs (5 options) and dining motivation inputs (4 options)
- **AND** it SHALL display three static mock restaurant recommendation cards showing name, address, price, and mock recommendation reason

