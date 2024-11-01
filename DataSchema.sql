-- Створення таблиці USERS
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    user_email VARCHAR(100) NOT NULL
    CHECK (user_email REGEXP '^[^@]+@[^@]+\\.[^@]+$'),
    user_name VARCHAR(50) NOT NULL
    CHECK (CHAR_LENGTH(user_name) BETWEEN 2 AND 50),
    is_authorized BOOLEAN NOT NULL
);
-- Створення таблиці REGULAR_USERS
CREATE TABLE regular_users (
    regular_user_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    weekly_session_count INT
    CHECK (weekly_session_count BETWEEN 0 AND 10),
    monthly_invite_count INT
    CHECK (monthly_invite_count BETWEEN 0 AND 20),
FOREIGN KEY (user_id) REFERENCES users(user_id)
    ON DELETE CASCADE
);
-- Створення таблиці INVITED_USERS
CREATE TABLE invited_users (
    invited_user_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    invitation_status ENUM('pending', 'accepted', 'rejected') NOT NULL,
FOREIGN KEY (user_id) REFERENCES users(user_id)
    ON DELETE CASCADE
);
-- Створення таблиці MUSIC_SESSIONS
CREATE TABLE music_sessions (
    session_id INT PRIMARY KEY AUTO_INCREMENT,
    created_at DATETIME NOT NULL
    CHECK (created_at > NOW()),
    max_participants INT
    CHECK (max_participants BETWEEN 1 AND 6),
    session_status ENUM('active', 'ended', 'paused') NOT NULL
);
-- Створення таблиці PLAYLISTS
CREATE TABLE playlists (
    playlist_id INT PRIMARY KEY AUTO_INCREMENT,
    playlist_name VARCHAR(100) NOT NULL
    CHECK (CHAR_LENGTH(playlist_name) BETWEEN 1 AND 100),
    playlist_description VARCHAR(500)
    CHECK (CHAR_LENGTH(playlist_description) BETWEEN 0 AND 500)
);
-- Створення таблиці TRACKS
CREATE TABLE tracks (
    track_id INT PRIMARY KEY AUTO_INCREMENT,
    track_title VARCHAR(200) NOT NULL
    CHECK (CHAR_LENGTH(track_title) BETWEEN 1 AND 200),
    track_duration INT
    CHECK (track_duration > 0)
);
-- Створення таблиці INVITATIONS
CREATE TABLE invitations (
    invitation_id INT PRIMARY KEY AUTO_INCREMENT,
    recipient_email VARCHAR(100) NOT NULL
    CHECK (recipient_email REGEXP '^[^@]+@[^@]+\\.[^@]+$'),
invitation_status ENUM('sent', 'delivered', 'accepted', 'rejected') NOT NULL,
    sent_at DATETIME NOT NULL
    CHECK (sent_at <= NOW())
);
