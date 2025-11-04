-- user-scoped tables
CREATE TABLE IF NOT EXISTS settings (
  user_id TEXT PRIMARY KEY,
  json TEXT NOT NULL,
  updated_at INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS gifts (
  user_id TEXT NOT NULL,
  gift_id TEXT NOT NULL,
  media_url TEXT,
  json TEXT NOT NULL,
  updated_at INTEGER NOT NULL,
  PRIMARY KEY (user_id, gift_id)
);
CREATE INDEX IF NOT EXISTS idx_gifts_user ON gifts(user_id);

CREATE TABLE IF NOT EXISTS profile (
  user_id TEXT PRIMARY KEY,
  name TEXT,
  username TEXT,
  email TEXT,
  avatar_url TEXT,
  cover_url TEXT,
  json TEXT NOT NULL,
  updated_at INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS contacts (
  user_id TEXT NOT NULL,
  contact_id TEXT NOT NULL,
  json TEXT NOT NULL,
  updated_at INTEGER NOT NULL,
  PRIMARY KEY(user_id, contact_id)
);
CREATE INDEX IF NOT EXISTS idx_contacts_user ON contacts(user_id);

CREATE TABLE IF NOT EXISTS pins (
  user_id TEXT NOT NULL,
  chat_id TEXT NOT NULL,
  last_message_id TEXT,
  json TEXT NOT NULL,
  updated_at INTEGER NOT NULL,
  PRIMARY KEY (user_id, chat_id)
);
CREATE INDEX IF NOT EXISTS idx_pins_user ON pins(user_id);

CREATE TABLE IF NOT EXISTS community_suggested_users (
  user_id TEXT NOT NULL,
  suggested_user_id TEXT NOT NULL,
  json TEXT NOT NULL,
  updated_at INTEGER NOT NULL,
  PRIMARY KEY (user_id, suggested_user_id)
);

CREATE TABLE IF NOT EXISTS community_suggested_groups (
  user_id TEXT NOT NULL,
  group_id TEXT NOT NULL,
  json TEXT NOT NULL,
  updated_at INTEGER NOT NULL,
  PRIMARY KEY (user_id, group_id)
);

CREATE TABLE IF NOT EXISTS community_suggested_pages (
  user_id TEXT NOT NULL,
  page_id TEXT NOT NULL,
  json TEXT NOT NULL,
  updated_at INTEGER NOT NULL,
  PRIMARY KEY (user_id, page_id)
);

CREATE TABLE IF NOT EXISTS groups_mine (
  user_id TEXT NOT NULL,
  group_id TEXT NOT NULL,
  json TEXT NOT NULL,
  updated_at INTEGER NOT NULL,
  PRIMARY KEY (user_id, group_id)
);

CREATE TABLE IF NOT EXISTS pages_mine (
  user_id TEXT NOT NULL,
  page_id TEXT NOT NULL,
  json TEXT NOT NULL,
  updated_at INTEGER NOT NULL,
  PRIMARY KEY (user_id, page_id)
);

CREATE TABLE IF NOT EXISTS articles (
  user_id TEXT NOT NULL,
  article_id TEXT NOT NULL,
  json TEXT NOT NULL,
  updated_at INTEGER NOT NULL,
  PRIMARY KEY (user_id, article_id)
);


