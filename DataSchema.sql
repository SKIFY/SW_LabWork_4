-- Створення таблиці User
CREATE TABLE Users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(100) NOT NULL CHECK (email REGEXP '^[^@]+@[^@]+\\.[^@]+$'),
    name VARCHAR(50) NOT NULL CHECK (CHAR_LENGTH(name) BETWEEN 2 AND 50),
    isAuthorized BOOLEAN NOT NULL
);

-- Створення таблиці RegularUser
CREATE TABLE RegularUsers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    userId INT,
    weeklySessionCount INT CHECK (weeklySessionCount BETWEEN 0 AND 10),
    monthlyInviteCount INT CHECK (monthlyInviteCount BETWEEN 0 AND 20),
    FOREIGN KEY (userId) REFERENCES Users(id) ON DELETE CASCADE
);

-- Створення таблиці InvitedUser
CREATE TABLE InvitedUsers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    userId INT,
    invitationStatus ENUM('pending', 'accepted', 'rejected') NOT NULL,
    FOREIGN KEY (userId) REFERENCES Users(id) ON DELETE CASCADE
);

-- Створення таблиці MusicSession
CREATE TABLE MusicSessions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    createdAt DATETIME NOT NULL CHECK (createdAt > NOW()),
    maxParticipants INT CHECK (maxParticipants BETWEEN 1 AND 6),
    status ENUM('active', 'ended', 'paused') NOT NULL
);

-- Створення таблиці Playlist
CREATE TABLE Playlists (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL CHECK (CHAR_LENGTH(name) BETWEEN 1 AND 100),
    description VARCHAR(500) CHECK (CHAR_LENGTH(description) BETWEEN 0 AND 500)
);

-- Створення таблиці Track
CREATE TABLE Tracks (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL CHECK (CHAR_LENGTH(title) BETWEEN 1 AND 200),
    duration INT CHECK (duration > 0)
);

-- Створення таблиці Invitation
CREATE TABLE Invitations (
    id INT PRIMARY KEY AUTO_INCREMENT,
    recipientEmail VARCHAR(100) NOT NULL CHECK (recipientEmail REGEXP '^[^@]+@[^@]+\\.[^@]+$'),
    status ENUM('sent', 'delivered', 'accepted', 'rejected') NOT NULL,
    sentAt DATETIME NOT NULL CHECK (sentAt <= NOW())
);
