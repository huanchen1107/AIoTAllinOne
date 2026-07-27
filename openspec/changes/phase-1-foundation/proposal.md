## Why

Establish the foundational Django project codebase, initial sqlite database models, basic single-page workbench skeleton, and authentication framework for MoodFood AI, ensuring a clean, modular structure for subsequent recommendation phases.

## What Changes

- Initialize the Django project structure and core applications (`accounts`, `restaurants`, `recommendations`, `journals`, `analytics`).
- Set up Django's built-in local authentication flow (sign up, sign in, sign out).
- Define the database models for UserPreferences, MoodRecord, RestaurantSnapshot, RecommendationSession, and RecommendationItem.
- Design the baseline UI shell (single-page workbench layout using Bootstrap/HTML/CSS) to preview components.
- Establish clean environment variable configurations to avoid hardcoding secrets.

## Capabilities

### New Capabilities
- `user-auth`: Local authentication flow allowing registration, login, and profile preference configurations (default budget level, preferred dining distance, food allergens).
- `core-data-model`: Core database tables to track user preferences, location, search sessions, moods, restaurant snapshot details, and recommendation results.

### Modified Capabilities
<!-- None: Greenfield project setup -->

## Impact

- **Affected Systems**: Django application setup, database migration files, base templates, and local configuration files.
- **Dependencies**: Django (v4.2+ or latest stable), python-dotenv, SQLite.
