CREATE TABLE IF NOT EXISTS "news" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar, "url" text, "body" text, "published_at" datetime, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, "tweeted_at" datetime);
CREATE TABLE sqlite_sequence(name,seq);
CREATE UNIQUE INDEX "index_news_on_title" ON "news" ("title");
CREATE TABLE IF NOT EXISTS "user_agents" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE UNIQUE INDEX "index_user_agents_on_name" ON "user_agents" ("name");
CREATE TABLE IF NOT EXISTS "schema_migrations" ("version" varchar NOT NULL PRIMARY KEY);
CREATE TABLE IF NOT EXISTS "ar_internal_metadata" ("key" varchar NOT NULL PRIMARY KEY, "value" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE IF NOT EXISTS "pages" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "url" text, "crawler_config" text, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, "active" boolean DEFAULT 1);
CREATE TABLE IF NOT EXISTS "url_patterns" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "url" text, "active" boolean DEFAULT 1, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, "title" varchar);
CREATE UNIQUE INDEX "index_url_patterns_on_url" ON "url_patterns" ("url");
CREATE TABLE IF NOT EXISTS "urls" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "url" text, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, "tweeted_at" datetime, "title" varchar);
CREATE UNIQUE INDEX "index_urls_on_url" ON "urls" ("url");
CREATE UNIQUE INDEX "index_pages_on_url" ON "pages" ("url");
INSERT INTO "schema_migrations" (version) VALUES
('20200331175901'),
('20200403140444'),
('20200404093414'),
('20200405114900'),
('20200405120657'),
('20200406104842'),
('20200406122057'),
('20200408103708'),
('20200410195043'),
('20200416200033'),
('20200416200040');


