## ADDED Requirements

### Requirement: User registration API endpoint
The system SHALL provide a POST endpoint at `/api/auth/register` to register new users with email, password, and optional username.

#### Scenario: Successful user registration
- **WHEN** a client sends a POST request to `/api/auth/register` with a unique email and valid password
- **THEN** the system SHALL create the user record in the database and return a `201 Created` status code with a success message

#### Scenario: Registration fails due to duplicate email
- **WHEN** a client sends a POST request to `/api/auth/register` with an email that is already registered
- **THEN** the system SHALL return a `400 Bad Request` status code with an error message indicating the email is taken

---

### Requirement: User login API endpoint
The system SHALL provide a POST endpoint at `/api/auth/login` to authenticate users and generate a JWT access token.

#### Scenario: Successful login
- **WHEN** a client sends a POST request to `/api/auth/login` with correct username/email and password credentials
- **THEN** the system SHALL return a `200 OK` status code with a JSON payload containing the JWT access token and user preferences

#### Scenario: Login fails with invalid credentials
- **WHEN** a client sends a POST request to `/api/auth/login` with incorrect credentials
- **THEN** the system SHALL return a `401 Unauthorized` status code with an error message
