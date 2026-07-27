## ADDED Requirements

### Requirement: Persist User Preferences
The system SHALL allow users to view and update their default dining preferences (budget level, max distance, food allergies).

#### Scenario: Successfully retrieving preferences
- **WHEN** an authenticated user requests their profile preferences
- **THEN** the system SHALL return their default price level, max search distance, and allergen filters from the database

#### Scenario: Updating user preferences
- **WHEN** an authenticated user sends an update request with new default settings
- **THEN** the system SHALL save the changes to the database and return the updated preference record

---

### Requirement: Recommendation Session Logging
The system SHALL persist search logs (RecommendationSession and RecommendationItem) representing the history of recommendation queries and the specific items returned.

#### Scenario: Creating a recommendation session log
- **WHEN** a recommendation query is completed
- **THEN** the system SHALL create a `RecommendationSession` record containing the query inputs (mood, motivation, budget, location coordinates) and link up to three `RecommendationItem` records representing the returned candidate restaurants
