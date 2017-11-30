PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE `migration_log` (
`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, `migration_id` TEXT NOT NULL
, `sql` TEXT NOT NULL
, `success` INTEGER NOT NULL
, `error` TEXT NOT NULL
, `timestamp` DATETIME NOT NULL
);
INSERT INTO migration_log VALUES(1,'create migration_log table',replace('CREATE TABLE IF NOT EXISTS `migration_log` (\n`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL\n, `migration_id` TEXT NOT NULL\n, `sql` TEXT NOT NULL\n, `success` INTEGER NOT NULL\n, `error` TEXT NOT NULL\n, `timestamp` DATETIME NOT NULL\n);','\n',char(10)),1,'','2017-11-30 19:11:03');
INSERT INTO migration_log VALUES(2,'create user table',replace('CREATE TABLE IF NOT EXISTS `user` (\n`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL\n, `version` INTEGER NOT NULL\n, `login` TEXT NOT NULL\n, `email` TEXT NOT NULL\n, `name` TEXT NULL\n, `password` TEXT NULL\n, `salt` TEXT NULL\n, `rands` TEXT NULL\n, `company` TEXT NULL\n, `account_id` INTEGER NOT NULL\n, `is_admin` INTEGER NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n);','\n',char(10)),1,'','2017-11-30 19:11:03');
INSERT INTO migration_log VALUES(3,'add unique index user.login','CREATE UNIQUE INDEX `UQE_user_login` ON `user` (`login`);',1,'','2017-11-30 19:11:03');
INSERT INTO migration_log VALUES(4,'add unique index user.email','CREATE UNIQUE INDEX `UQE_user_email` ON `user` (`email`);',1,'','2017-11-30 19:11:03');
INSERT INTO migration_log VALUES(5,'drop index UQE_user_login - v1','DROP INDEX `UQE_user_login`',1,'','2017-11-30 19:11:03');
INSERT INTO migration_log VALUES(6,'drop index UQE_user_email - v1','DROP INDEX `UQE_user_email`',1,'','2017-11-30 19:11:03');
INSERT INTO migration_log VALUES(7,'Rename table user to user_v1 - v1','ALTER TABLE `user` RENAME TO `user_v1`',1,'','2017-11-30 19:11:03');
INSERT INTO migration_log VALUES(8,'create user table v2',replace('CREATE TABLE IF NOT EXISTS `user` (\n`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL\n, `version` INTEGER NOT NULL\n, `login` TEXT NOT NULL\n, `email` TEXT NOT NULL\n, `name` TEXT NULL\n, `password` TEXT NULL\n, `salt` TEXT NULL\n, `rands` TEXT NULL\n, `company` TEXT NULL\n, `org_id` INTEGER NOT NULL\n, `is_admin` INTEGER NOT NULL\n, `email_verified` INTEGER NULL\n, `theme` TEXT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n);','\n',char(10)),1,'','2017-11-30 19:11:03');
INSERT INTO migration_log VALUES(9,'create index UQE_user_login - v2','CREATE UNIQUE INDEX `UQE_user_login` ON `user` (`login`);',1,'','2017-11-30 19:11:03');
INSERT INTO migration_log VALUES(10,'create index UQE_user_email - v2','CREATE UNIQUE INDEX `UQE_user_email` ON `user` (`email`);',1,'','2017-11-30 19:11:03');
INSERT INTO migration_log VALUES(11,'copy data_source v1 to v2',replace('INSERT INTO `user` (`email`\n, `rands`\n, `created`\n, `id`\n, `version`\n, `name`\n, `login`\n, `password`\n, `salt`\n, `company`\n, `updated`\n, `org_id`\n, `is_admin`) SELECT `email`\n, `rands`\n, `created`\n, `id`\n, `version`\n, `name`\n, `login`\n, `password`\n, `salt`\n, `company`\n, `updated`\n, `account_id`\n, `is_admin` FROM `user_v1`','\n',char(10)),1,'','2017-11-30 19:11:03');
INSERT INTO migration_log VALUES(12,'Drop old table user_v1','DROP TABLE IF EXISTS `user_v1`',1,'','2017-11-30 19:11:03');
INSERT INTO migration_log VALUES(13,'Add column help_flags1 to user table','alter table `user` ADD COLUMN `help_flags1` INTEGER NOT NULL DEFAULT 0 ',1,'','2017-11-30 19:11:03');
INSERT INTO migration_log VALUES(14,'Update user table charset','-- NOT REQUIRED',1,'','2017-11-30 19:11:03');
INSERT INTO migration_log VALUES(15,'Add last_seen_at column to user','alter table `user` ADD COLUMN `last_seen_at` DATETIME NULL ',1,'','2017-11-30 19:11:03');
INSERT INTO migration_log VALUES(16,'create temp user table v1-7',replace('CREATE TABLE IF NOT EXISTS `temp_user` (\n`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL\n, `org_id` INTEGER NOT NULL\n, `version` INTEGER NOT NULL\n, `email` TEXT NOT NULL\n, `name` TEXT NULL\n, `role` TEXT NULL\n, `code` TEXT NOT NULL\n, `status` TEXT NOT NULL\n, `invited_by_user_id` INTEGER NULL\n, `email_sent` INTEGER NOT NULL\n, `email_sent_on` DATETIME NULL\n, `remote_addr` TEXT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n);','\n',char(10)),1,'','2017-11-30 19:11:03');
INSERT INTO migration_log VALUES(17,'create index IDX_temp_user_email - v1-7','CREATE INDEX `IDX_temp_user_email` ON `temp_user` (`email`);',1,'','2017-11-30 19:11:03');
INSERT INTO migration_log VALUES(18,'create index IDX_temp_user_org_id - v1-7','CREATE INDEX `IDX_temp_user_org_id` ON `temp_user` (`org_id`);',1,'','2017-11-30 19:11:03');
INSERT INTO migration_log VALUES(19,'create index IDX_temp_user_code - v1-7','CREATE INDEX `IDX_temp_user_code` ON `temp_user` (`code`);',1,'','2017-11-30 19:11:04');
INSERT INTO migration_log VALUES(20,'create index IDX_temp_user_status - v1-7','CREATE INDEX `IDX_temp_user_status` ON `temp_user` (`status`);',1,'','2017-11-30 19:11:04');
INSERT INTO migration_log VALUES(21,'Update temp_user table charset','-- NOT REQUIRED',1,'','2017-11-30 19:11:04');
INSERT INTO migration_log VALUES(22,'create star table',replace('CREATE TABLE IF NOT EXISTS `star` (\n`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL\n, `user_id` INTEGER NOT NULL\n, `dashboard_id` INTEGER NOT NULL\n);','\n',char(10)),1,'','2017-11-30 19:11:04');
INSERT INTO migration_log VALUES(23,'add unique index star.user_id_dashboard_id','CREATE UNIQUE INDEX `UQE_star_user_id_dashboard_id` ON `star` (`user_id`,`dashboard_id`);',1,'','2017-11-30 19:11:04');
INSERT INTO migration_log VALUES(24,'create org table v1',replace('CREATE TABLE IF NOT EXISTS `org` (\n`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL\n, `version` INTEGER NOT NULL\n, `name` TEXT NOT NULL\n, `address1` TEXT NULL\n, `address2` TEXT NULL\n, `city` TEXT NULL\n, `state` TEXT NULL\n, `zip_code` TEXT NULL\n, `country` TEXT NULL\n, `billing_email` TEXT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n);','\n',char(10)),1,'','2017-11-30 19:11:04');
INSERT INTO migration_log VALUES(25,'create index UQE_org_name - v1','CREATE UNIQUE INDEX `UQE_org_name` ON `org` (`name`);',1,'','2017-11-30 19:11:04');
INSERT INTO migration_log VALUES(26,'create org_user table v1',replace('CREATE TABLE IF NOT EXISTS `org_user` (\n`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL\n, `org_id` INTEGER NOT NULL\n, `user_id` INTEGER NOT NULL\n, `role` TEXT NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n);','\n',char(10)),1,'','2017-11-30 19:11:04');
INSERT INTO migration_log VALUES(27,'create index IDX_org_user_org_id - v1','CREATE INDEX `IDX_org_user_org_id` ON `org_user` (`org_id`);',1,'','2017-11-30 19:11:04');
INSERT INTO migration_log VALUES(28,'create index UQE_org_user_org_id_user_id - v1','CREATE UNIQUE INDEX `UQE_org_user_org_id_user_id` ON `org_user` (`org_id`,`user_id`);',1,'','2017-11-30 19:11:04');
INSERT INTO migration_log VALUES(29,'Drop old table account','DROP TABLE IF EXISTS `account`',1,'','2017-11-30 19:11:04');
INSERT INTO migration_log VALUES(30,'Drop old table account_user','DROP TABLE IF EXISTS `account_user`',1,'','2017-11-30 19:11:04');
INSERT INTO migration_log VALUES(31,'Update org table charset','-- NOT REQUIRED',1,'','2017-11-30 19:11:04');
INSERT INTO migration_log VALUES(32,'Update org_user table charset','-- NOT REQUIRED',1,'','2017-11-30 19:11:04');
INSERT INTO migration_log VALUES(33,'create dashboard table',replace('CREATE TABLE IF NOT EXISTS `dashboard` (\n`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL\n, `version` INTEGER NOT NULL\n, `slug` TEXT NOT NULL\n, `title` TEXT NOT NULL\n, `data` TEXT NOT NULL\n, `account_id` INTEGER NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n);','\n',char(10)),1,'','2017-11-30 19:11:04');
INSERT INTO migration_log VALUES(34,'add index dashboard.account_id','CREATE INDEX `IDX_dashboard_account_id` ON `dashboard` (`account_id`);',1,'','2017-11-30 19:11:04');
INSERT INTO migration_log VALUES(35,'add unique index dashboard_account_id_slug','CREATE UNIQUE INDEX `UQE_dashboard_account_id_slug` ON `dashboard` (`account_id`,`slug`);',1,'','2017-11-30 19:11:04');
INSERT INTO migration_log VALUES(36,'create dashboard_tag table',replace('CREATE TABLE IF NOT EXISTS `dashboard_tag` (\n`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL\n, `dashboard_id` INTEGER NOT NULL\n, `term` TEXT NOT NULL\n);','\n',char(10)),1,'','2017-11-30 19:11:04');
INSERT INTO migration_log VALUES(37,'add unique index dashboard_tag.dasboard_id_term','CREATE UNIQUE INDEX `UQE_dashboard_tag_dashboard_id_term` ON `dashboard_tag` (`dashboard_id`,`term`);',1,'','2017-11-30 19:11:04');
INSERT INTO migration_log VALUES(38,'drop index UQE_dashboard_tag_dashboard_id_term - v1','DROP INDEX `UQE_dashboard_tag_dashboard_id_term`',1,'','2017-11-30 19:11:04');
INSERT INTO migration_log VALUES(39,'Rename table dashboard to dashboard_v1 - v1','ALTER TABLE `dashboard` RENAME TO `dashboard_v1`',1,'','2017-11-30 19:11:04');
INSERT INTO migration_log VALUES(40,'create dashboard v2',replace('CREATE TABLE IF NOT EXISTS `dashboard` (\n`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL\n, `version` INTEGER NOT NULL\n, `slug` TEXT NOT NULL\n, `title` TEXT NOT NULL\n, `data` TEXT NOT NULL\n, `org_id` INTEGER NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n);','\n',char(10)),1,'','2017-11-30 19:11:04');
INSERT INTO migration_log VALUES(41,'create index IDX_dashboard_org_id - v2','CREATE INDEX `IDX_dashboard_org_id` ON `dashboard` (`org_id`);',1,'','2017-11-30 19:11:04');
INSERT INTO migration_log VALUES(42,'create index UQE_dashboard_org_id_slug - v2','CREATE UNIQUE INDEX `UQE_dashboard_org_id_slug` ON `dashboard` (`org_id`,`slug`);',1,'','2017-11-30 19:11:04');
INSERT INTO migration_log VALUES(43,'copy dashboard v1 to v2',replace('INSERT INTO `dashboard` (`version`\n, `slug`\n, `data`\n, `org_id`\n, `id`\n, `created`\n, `updated`\n, `title`) SELECT `version`\n, `slug`\n, `data`\n, `account_id`\n, `id`\n, `created`\n, `updated`\n, `title` FROM `dashboard_v1`','\n',char(10)),1,'','2017-11-30 19:11:04');
INSERT INTO migration_log VALUES(44,'drop table dashboard_v1','DROP TABLE IF EXISTS `dashboard_v1`',1,'','2017-11-30 19:11:04');
INSERT INTO migration_log VALUES(45,'alter dashboard.data to mediumtext v1','SELECT 0 WHERE 0;',1,'','2017-11-30 19:11:04');
INSERT INTO migration_log VALUES(46,'Add column updated_by in dashboard - v2','alter table `dashboard` ADD COLUMN `updated_by` INTEGER NULL ',1,'','2017-11-30 19:11:04');
INSERT INTO migration_log VALUES(47,'Add column created_by in dashboard - v2','alter table `dashboard` ADD COLUMN `created_by` INTEGER NULL ',1,'','2017-11-30 19:11:04');
INSERT INTO migration_log VALUES(48,'Add column gnetId in dashboard','alter table `dashboard` ADD COLUMN `gnet_id` INTEGER NULL ',1,'','2017-11-30 19:11:04');
INSERT INTO migration_log VALUES(49,'Add index for gnetId in dashboard','CREATE INDEX `IDX_dashboard_gnet_id` ON `dashboard` (`gnet_id`);',1,'','2017-11-30 19:11:04');
INSERT INTO migration_log VALUES(50,'Add column plugin_id in dashboard','alter table `dashboard` ADD COLUMN `plugin_id` TEXT NULL ',1,'','2017-11-30 19:11:04');
INSERT INTO migration_log VALUES(51,'Add index for plugin_id in dashboard','CREATE INDEX `IDX_dashboard_org_id_plugin_id` ON `dashboard` (`org_id`,`plugin_id`);',1,'','2017-11-30 19:11:04');
INSERT INTO migration_log VALUES(52,'Add index for dashboard_id in dashboard_tag','CREATE INDEX `IDX_dashboard_tag_dashboard_id` ON `dashboard_tag` (`dashboard_id`);',1,'','2017-11-30 19:11:04');
INSERT INTO migration_log VALUES(53,'Update dashboard table charset','-- NOT REQUIRED',1,'','2017-11-30 19:11:04');
INSERT INTO migration_log VALUES(54,'Update dashboard_tag table charset','-- NOT REQUIRED',1,'','2017-11-30 19:11:04');
INSERT INTO migration_log VALUES(55,'create data_source table',replace('CREATE TABLE IF NOT EXISTS `data_source` (\n`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL\n, `account_id` INTEGER NOT NULL\n, `version` INTEGER NOT NULL\n, `type` TEXT NOT NULL\n, `name` TEXT NOT NULL\n, `access` TEXT NOT NULL\n, `url` TEXT NOT NULL\n, `password` TEXT NULL\n, `user` TEXT NULL\n, `database` TEXT NULL\n, `basic_auth` INTEGER NOT NULL\n, `basic_auth_user` TEXT NULL\n, `basic_auth_password` TEXT NULL\n, `is_default` INTEGER NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n);','\n',char(10)),1,'','2017-11-30 19:11:04');
INSERT INTO migration_log VALUES(56,'add index data_source.account_id','CREATE INDEX `IDX_data_source_account_id` ON `data_source` (`account_id`);',1,'','2017-11-30 19:11:04');
INSERT INTO migration_log VALUES(57,'add unique index data_source.account_id_name','CREATE UNIQUE INDEX `UQE_data_source_account_id_name` ON `data_source` (`account_id`,`name`);',1,'','2017-11-30 19:11:04');
INSERT INTO migration_log VALUES(58,'drop index IDX_data_source_account_id - v1','DROP INDEX `IDX_data_source_account_id`',1,'','2017-11-30 19:11:04');
INSERT INTO migration_log VALUES(59,'drop index UQE_data_source_account_id_name - v1','DROP INDEX `UQE_data_source_account_id_name`',1,'','2017-11-30 19:11:04');
INSERT INTO migration_log VALUES(60,'Rename table data_source to data_source_v1 - v1','ALTER TABLE `data_source` RENAME TO `data_source_v1`',1,'','2017-11-30 19:11:04');
INSERT INTO migration_log VALUES(61,'create data_source table v2',replace('CREATE TABLE IF NOT EXISTS `data_source` (\n`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL\n, `org_id` INTEGER NOT NULL\n, `version` INTEGER NOT NULL\n, `type` TEXT NOT NULL\n, `name` TEXT NOT NULL\n, `access` TEXT NOT NULL\n, `url` TEXT NOT NULL\n, `password` TEXT NULL\n, `user` TEXT NULL\n, `database` TEXT NULL\n, `basic_auth` INTEGER NOT NULL\n, `basic_auth_user` TEXT NULL\n, `basic_auth_password` TEXT NULL\n, `is_default` INTEGER NOT NULL\n, `json_data` TEXT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n);','\n',char(10)),1,'','2017-11-30 19:11:04');
INSERT INTO migration_log VALUES(62,'create index IDX_data_source_org_id - v2','CREATE INDEX `IDX_data_source_org_id` ON `data_source` (`org_id`);',1,'','2017-11-30 19:11:05');
INSERT INTO migration_log VALUES(63,'create index UQE_data_source_org_id_name - v2','CREATE UNIQUE INDEX `UQE_data_source_org_id_name` ON `data_source` (`org_id`,`name`);',1,'','2017-11-30 19:11:05');
INSERT INTO migration_log VALUES(64,'copy data_source v1 to v2',replace('INSERT INTO `data_source` (`updated`\n, `org_id`\n, `access`\n, `user`\n, `password`\n, `database`\n, `type`\n, `basic_auth_user`\n, `is_default`\n, `created`\n, `basic_auth`\n, `id`\n, `version`\n, `name`\n, `url`\n, `basic_auth_password`) SELECT `updated`\n, `account_id`\n, `access`\n, `user`\n, `password`\n, `database`\n, `type`\n, `basic_auth_user`\n, `is_default`\n, `created`\n, `basic_auth`\n, `id`\n, `version`\n, `name`\n, `url`\n, `basic_auth_password` FROM `data_source_v1`','\n',char(10)),1,'','2017-11-30 19:11:05');
INSERT INTO migration_log VALUES(65,'Drop old table data_source_v1 #2','DROP TABLE IF EXISTS `data_source_v1`',1,'','2017-11-30 19:11:05');
INSERT INTO migration_log VALUES(66,'Add column with_credentials','alter table `data_source` ADD COLUMN `with_credentials` INTEGER NOT NULL DEFAULT 0 ',1,'','2017-11-30 19:11:05');
INSERT INTO migration_log VALUES(67,'Add secure json data column','alter table `data_source` ADD COLUMN `secure_json_data` TEXT NULL ',1,'','2017-11-30 19:11:05');
INSERT INTO migration_log VALUES(68,'Update data_source table charset','-- NOT REQUIRED',1,'','2017-11-30 19:11:05');
INSERT INTO migration_log VALUES(69,'create api_key table',replace('CREATE TABLE IF NOT EXISTS `api_key` (\n`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL\n, `account_id` INTEGER NOT NULL\n, `name` TEXT NOT NULL\n, `key` TEXT NOT NULL\n, `role` TEXT NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n);','\n',char(10)),1,'','2017-11-30 19:11:05');
INSERT INTO migration_log VALUES(70,'add index api_key.account_id','CREATE INDEX `IDX_api_key_account_id` ON `api_key` (`account_id`);',1,'','2017-11-30 19:11:05');
INSERT INTO migration_log VALUES(71,'add index api_key.key','CREATE UNIQUE INDEX `UQE_api_key_key` ON `api_key` (`key`);',1,'','2017-11-30 19:11:05');
INSERT INTO migration_log VALUES(72,'add index api_key.account_id_name','CREATE UNIQUE INDEX `UQE_api_key_account_id_name` ON `api_key` (`account_id`,`name`);',1,'','2017-11-30 19:11:05');
INSERT INTO migration_log VALUES(73,'drop index IDX_api_key_account_id - v1','DROP INDEX `IDX_api_key_account_id`',1,'','2017-11-30 19:11:05');
INSERT INTO migration_log VALUES(74,'drop index UQE_api_key_key - v1','DROP INDEX `UQE_api_key_key`',1,'','2017-11-30 19:11:05');
INSERT INTO migration_log VALUES(75,'drop index UQE_api_key_account_id_name - v1','DROP INDEX `UQE_api_key_account_id_name`',1,'','2017-11-30 19:11:05');
INSERT INTO migration_log VALUES(76,'Rename table api_key to api_key_v1 - v1','ALTER TABLE `api_key` RENAME TO `api_key_v1`',1,'','2017-11-30 19:11:05');
INSERT INTO migration_log VALUES(77,'create api_key table v2',replace('CREATE TABLE IF NOT EXISTS `api_key` (\n`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL\n, `org_id` INTEGER NOT NULL\n, `name` TEXT NOT NULL\n, `key` TEXT NOT NULL\n, `role` TEXT NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n);','\n',char(10)),1,'','2017-11-30 19:11:05');
INSERT INTO migration_log VALUES(78,'create index IDX_api_key_org_id - v2','CREATE INDEX `IDX_api_key_org_id` ON `api_key` (`org_id`);',1,'','2017-11-30 19:11:05');
INSERT INTO migration_log VALUES(79,'create index UQE_api_key_key - v2','CREATE UNIQUE INDEX `UQE_api_key_key` ON `api_key` (`key`);',1,'','2017-11-30 19:11:05');
INSERT INTO migration_log VALUES(80,'create index UQE_api_key_org_id_name - v2','CREATE UNIQUE INDEX `UQE_api_key_org_id_name` ON `api_key` (`org_id`,`name`);',1,'','2017-11-30 19:11:05');
INSERT INTO migration_log VALUES(81,'copy api_key v1 to v2',replace('INSERT INTO `api_key` (`id`\n, `org_id`\n, `name`\n, `key`\n, `role`\n, `created`\n, `updated`) SELECT `id`\n, `account_id`\n, `name`\n, `key`\n, `role`\n, `created`\n, `updated` FROM `api_key_v1`','\n',char(10)),1,'','2017-11-30 19:11:05');
INSERT INTO migration_log VALUES(82,'Drop old table api_key_v1','DROP TABLE IF EXISTS `api_key_v1`',1,'','2017-11-30 19:11:05');
INSERT INTO migration_log VALUES(83,'Update api_key table charset','-- NOT REQUIRED',1,'','2017-11-30 19:11:05');
INSERT INTO migration_log VALUES(84,'create dashboard_snapshot table v4',replace('CREATE TABLE IF NOT EXISTS `dashboard_snapshot` (\n`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL\n, `name` TEXT NOT NULL\n, `key` TEXT NOT NULL\n, `dashboard` TEXT NOT NULL\n, `expires` DATETIME NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n);','\n',char(10)),1,'','2017-11-30 19:11:05');
INSERT INTO migration_log VALUES(85,'drop table dashboard_snapshot_v4 #1','DROP TABLE IF EXISTS `dashboard_snapshot`',1,'','2017-11-30 19:11:05');
INSERT INTO migration_log VALUES(86,'create dashboard_snapshot table v5 #2',replace('CREATE TABLE IF NOT EXISTS `dashboard_snapshot` (\n`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL\n, `name` TEXT NOT NULL\n, `key` TEXT NOT NULL\n, `delete_key` TEXT NOT NULL\n, `org_id` INTEGER NOT NULL\n, `user_id` INTEGER NOT NULL\n, `external` INTEGER NOT NULL\n, `external_url` TEXT NOT NULL\n, `dashboard` TEXT NOT NULL\n, `expires` DATETIME NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n);','\n',char(10)),1,'','2017-11-30 19:11:05');
INSERT INTO migration_log VALUES(87,'create index UQE_dashboard_snapshot_key - v5','CREATE UNIQUE INDEX `UQE_dashboard_snapshot_key` ON `dashboard_snapshot` (`key`);',1,'','2017-11-30 19:11:05');
INSERT INTO migration_log VALUES(88,'create index UQE_dashboard_snapshot_delete_key - v5','CREATE UNIQUE INDEX `UQE_dashboard_snapshot_delete_key` ON `dashboard_snapshot` (`delete_key`);',1,'','2017-11-30 19:11:05');
INSERT INTO migration_log VALUES(89,'create index IDX_dashboard_snapshot_user_id - v5','CREATE INDEX `IDX_dashboard_snapshot_user_id` ON `dashboard_snapshot` (`user_id`);',1,'','2017-11-30 19:11:05');
INSERT INTO migration_log VALUES(90,'alter dashboard_snapshot to mediumtext v2','SELECT 0 WHERE 0;',1,'','2017-11-30 19:11:05');
INSERT INTO migration_log VALUES(91,'Update dashboard_snapshot table charset','-- NOT REQUIRED',1,'','2017-11-30 19:11:05');
INSERT INTO migration_log VALUES(92,'create quota table v1',replace('CREATE TABLE IF NOT EXISTS `quota` (\n`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL\n, `org_id` INTEGER NULL\n, `user_id` INTEGER NULL\n, `target` TEXT NOT NULL\n, `limit` INTEGER NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n);','\n',char(10)),1,'','2017-11-30 19:11:05');
INSERT INTO migration_log VALUES(93,'create index UQE_quota_org_id_user_id_target - v1','CREATE UNIQUE INDEX `UQE_quota_org_id_user_id_target` ON `quota` (`org_id`,`user_id`,`target`);',1,'','2017-11-30 19:11:05');
INSERT INTO migration_log VALUES(94,'Update quota table charset','-- NOT REQUIRED',1,'','2017-11-30 19:11:05');
INSERT INTO migration_log VALUES(95,'create plugin_setting table',replace('CREATE TABLE IF NOT EXISTS `plugin_setting` (\n`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL\n, `org_id` INTEGER NULL\n, `plugin_id` TEXT NOT NULL\n, `enabled` INTEGER NOT NULL\n, `pinned` INTEGER NOT NULL\n, `json_data` TEXT NULL\n, `secure_json_data` TEXT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n);','\n',char(10)),1,'','2017-11-30 19:11:05');
INSERT INTO migration_log VALUES(96,'create index UQE_plugin_setting_org_id_plugin_id - v1','CREATE UNIQUE INDEX `UQE_plugin_setting_org_id_plugin_id` ON `plugin_setting` (`org_id`,`plugin_id`);',1,'','2017-11-30 19:11:05');
INSERT INTO migration_log VALUES(97,'Add column plugin_version to plugin_settings','alter table `plugin_setting` ADD COLUMN `plugin_version` TEXT NULL ',1,'','2017-11-30 19:11:05');
INSERT INTO migration_log VALUES(98,'Update plugin_setting table charset','-- NOT REQUIRED',1,'','2017-11-30 19:11:05');
INSERT INTO migration_log VALUES(99,'create session table',replace('CREATE TABLE IF NOT EXISTS `session` (\n`key` TEXT PRIMARY KEY NOT NULL\n, `data` BLOB NOT NULL\n, `expiry` INTEGER NOT NULL\n);','\n',char(10)),1,'','2017-11-30 19:11:05');
INSERT INTO migration_log VALUES(100,'Drop old table playlist table','DROP TABLE IF EXISTS `playlist`',1,'','2017-11-30 19:11:05');
INSERT INTO migration_log VALUES(101,'Drop old table playlist_item table','DROP TABLE IF EXISTS `playlist_item`',1,'','2017-11-30 19:11:05');
INSERT INTO migration_log VALUES(102,'create playlist table v2',replace('CREATE TABLE IF NOT EXISTS `playlist` (\n`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL\n, `name` TEXT NOT NULL\n, `interval` TEXT NOT NULL\n, `org_id` INTEGER NOT NULL\n);','\n',char(10)),1,'','2017-11-30 19:11:05');
INSERT INTO migration_log VALUES(103,'create playlist item table v2',replace('CREATE TABLE IF NOT EXISTS `playlist_item` (\n`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL\n, `playlist_id` INTEGER NOT NULL\n, `type` TEXT NOT NULL\n, `value` TEXT NOT NULL\n, `title` TEXT NOT NULL\n, `order` INTEGER NOT NULL\n);','\n',char(10)),1,'','2017-11-30 19:11:05');
INSERT INTO migration_log VALUES(104,'Update playlist table charset','-- NOT REQUIRED',1,'','2017-11-30 19:11:06');
INSERT INTO migration_log VALUES(105,'Update playlist_item table charset','-- NOT REQUIRED',1,'','2017-11-30 19:11:06');
INSERT INTO migration_log VALUES(106,'drop preferences table v2','DROP TABLE IF EXISTS `preferences`',1,'','2017-11-30 19:11:06');
INSERT INTO migration_log VALUES(107,'drop preferences table v3','DROP TABLE IF EXISTS `preferences`',1,'','2017-11-30 19:11:06');
INSERT INTO migration_log VALUES(108,'create preferences table v3',replace('CREATE TABLE IF NOT EXISTS `preferences` (\n`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL\n, `org_id` INTEGER NOT NULL\n, `user_id` INTEGER NOT NULL\n, `version` INTEGER NOT NULL\n, `home_dashboard_id` INTEGER NOT NULL\n, `timezone` TEXT NOT NULL\n, `theme` TEXT NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n);','\n',char(10)),1,'','2017-11-30 19:11:06');
INSERT INTO migration_log VALUES(109,'Update preferences table charset','-- NOT REQUIRED',1,'','2017-11-30 19:11:06');
INSERT INTO migration_log VALUES(110,'create alert table v1',replace('CREATE TABLE IF NOT EXISTS `alert` (\n`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL\n, `version` INTEGER NOT NULL\n, `dashboard_id` INTEGER NOT NULL\n, `panel_id` INTEGER NOT NULL\n, `org_id` INTEGER NOT NULL\n, `name` TEXT NOT NULL\n, `message` TEXT NOT NULL\n, `state` TEXT NOT NULL\n, `settings` TEXT NOT NULL\n, `frequency` INTEGER NOT NULL\n, `handler` INTEGER NOT NULL\n, `severity` TEXT NOT NULL\n, `silenced` INTEGER NOT NULL\n, `execution_error` TEXT NOT NULL\n, `eval_data` TEXT NULL\n, `eval_date` DATETIME NULL\n, `new_state_date` DATETIME NOT NULL\n, `state_changes` INTEGER NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n);','\n',char(10)),1,'','2017-11-30 19:11:06');
INSERT INTO migration_log VALUES(111,'add index alert org_id & id ','CREATE INDEX `IDX_alert_org_id_id` ON `alert` (`org_id`,`id`);',1,'','2017-11-30 19:11:06');
INSERT INTO migration_log VALUES(112,'add index alert state','CREATE INDEX `IDX_alert_state` ON `alert` (`state`);',1,'','2017-11-30 19:11:06');
INSERT INTO migration_log VALUES(113,'add index alert dashboard_id','CREATE INDEX `IDX_alert_dashboard_id` ON `alert` (`dashboard_id`);',1,'','2017-11-30 19:11:06');
INSERT INTO migration_log VALUES(114,'create alert_notification table v1',replace('CREATE TABLE IF NOT EXISTS `alert_notification` (\n`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL\n, `org_id` INTEGER NOT NULL\n, `name` TEXT NOT NULL\n, `type` TEXT NOT NULL\n, `settings` TEXT NOT NULL\n, `created` DATETIME NOT NULL\n, `updated` DATETIME NOT NULL\n);','\n',char(10)),1,'','2017-11-30 19:11:06');
INSERT INTO migration_log VALUES(115,'Add column is_default','alter table `alert_notification` ADD COLUMN `is_default` INTEGER NOT NULL DEFAULT 0 ',1,'','2017-11-30 19:11:06');
INSERT INTO migration_log VALUES(116,'add index alert_notification org_id & name','CREATE UNIQUE INDEX `UQE_alert_notification_org_id_name` ON `alert_notification` (`org_id`,`name`);',1,'','2017-11-30 19:11:06');
INSERT INTO migration_log VALUES(117,'Update alert table charset','-- NOT REQUIRED',1,'','2017-11-30 19:11:06');
INSERT INTO migration_log VALUES(118,'Update alert_notification table charset','-- NOT REQUIRED',1,'','2017-11-30 19:11:06');
INSERT INTO migration_log VALUES(119,'Drop old annotation table v4','DROP TABLE IF EXISTS `annotation`',1,'','2017-11-30 19:11:06');
INSERT INTO migration_log VALUES(120,'create annotation table v5',replace('CREATE TABLE IF NOT EXISTS `annotation` (\n`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL\n, `org_id` INTEGER NOT NULL\n, `alert_id` INTEGER NULL\n, `user_id` INTEGER NULL\n, `dashboard_id` INTEGER NULL\n, `panel_id` INTEGER NULL\n, `category_id` INTEGER NULL\n, `type` TEXT NOT NULL\n, `title` TEXT NOT NULL\n, `text` TEXT NOT NULL\n, `metric` TEXT NULL\n, `prev_state` TEXT NOT NULL\n, `new_state` TEXT NOT NULL\n, `data` TEXT NOT NULL\n, `epoch` INTEGER NOT NULL\n);','\n',char(10)),1,'','2017-11-30 19:11:06');
INSERT INTO migration_log VALUES(121,'add index annotation 0 v3','CREATE INDEX `IDX_annotation_org_id_alert_id` ON `annotation` (`org_id`,`alert_id`);',1,'','2017-11-30 19:11:06');
INSERT INTO migration_log VALUES(122,'add index annotation 1 v3','CREATE INDEX `IDX_annotation_org_id_type` ON `annotation` (`org_id`,`type`);',1,'','2017-11-30 19:11:06');
INSERT INTO migration_log VALUES(123,'add index annotation 2 v3','CREATE INDEX `IDX_annotation_org_id_category_id` ON `annotation` (`org_id`,`category_id`);',1,'','2017-11-30 19:11:06');
INSERT INTO migration_log VALUES(124,'add index annotation 3 v3','CREATE INDEX `IDX_annotation_org_id_dashboard_id_panel_id_epoch` ON `annotation` (`org_id`,`dashboard_id`,`panel_id`,`epoch`);',1,'','2017-11-30 19:11:06');
INSERT INTO migration_log VALUES(125,'add index annotation 4 v3','CREATE INDEX `IDX_annotation_org_id_epoch` ON `annotation` (`org_id`,`epoch`);',1,'','2017-11-30 19:11:06');
INSERT INTO migration_log VALUES(126,'Update annotation table charset','-- NOT REQUIRED',1,'','2017-11-30 19:11:06');
INSERT INTO migration_log VALUES(127,'Add column region_id to annotation table','alter table `annotation` ADD COLUMN `region_id` INTEGER NULL DEFAULT 0 ',1,'','2017-11-30 19:11:06');
INSERT INTO migration_log VALUES(128,'Drop category_id index','DROP INDEX `IDX_annotation_org_id_category_id`',1,'','2017-11-30 19:11:06');
INSERT INTO migration_log VALUES(129,'Add column tags to annotation table','alter table `annotation` ADD COLUMN `tags` TEXT NULL ',1,'','2017-11-30 19:11:06');
INSERT INTO migration_log VALUES(130,'Create annotation_tag table v2',replace('CREATE TABLE IF NOT EXISTS `annotation_tag` (\n`annotation_id` INTEGER NOT NULL\n, `tag_id` INTEGER NOT NULL\n);','\n',char(10)),1,'','2017-11-30 19:11:06');
INSERT INTO migration_log VALUES(131,'Add unique index annotation_tag.annotation_id_tag_id','CREATE UNIQUE INDEX `UQE_annotation_tag_annotation_id_tag_id` ON `annotation_tag` (`annotation_id`,`tag_id`);',1,'','2017-11-30 19:11:06');
INSERT INTO migration_log VALUES(132,'Update alert annotations and set TEXT to empty','UPDATE annotation SET TEXT = '''' WHERE alert_id > 0',1,'','2017-11-30 19:11:06');
INSERT INTO migration_log VALUES(133,'create test_data table',replace('CREATE TABLE IF NOT EXISTS `test_data` (\n`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL\n, `metric1` TEXT NULL\n, `metric2` TEXT NULL\n, `value_big_int` INTEGER NULL\n, `value_double` REAL NULL\n, `value_float` REAL NULL\n, `value_int` INTEGER NULL\n, `time_epoch` INTEGER NOT NULL\n, `time_date_time` DATETIME NOT NULL\n, `time_time_stamp` DATETIME NOT NULL\n);','\n',char(10)),1,'','2017-11-30 19:11:06');
INSERT INTO migration_log VALUES(134,'create dashboard_version table v1',replace('CREATE TABLE IF NOT EXISTS `dashboard_version` (\n`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL\n, `dashboard_id` INTEGER NOT NULL\n, `parent_version` INTEGER NOT NULL\n, `restored_from` INTEGER NOT NULL\n, `version` INTEGER NOT NULL\n, `created` DATETIME NOT NULL\n, `created_by` INTEGER NOT NULL\n, `message` TEXT NOT NULL\n, `data` TEXT NOT NULL\n);','\n',char(10)),1,'','2017-11-30 19:11:06');
INSERT INTO migration_log VALUES(135,'add index dashboard_version.dashboard_id','CREATE INDEX `IDX_dashboard_version_dashboard_id` ON `dashboard_version` (`dashboard_id`);',1,'','2017-11-30 19:11:06');
INSERT INTO migration_log VALUES(136,'add unique index dashboard_version.dashboard_id and dashboard_version.version','CREATE UNIQUE INDEX `UQE_dashboard_version_dashboard_id_version` ON `dashboard_version` (`dashboard_id`,`version`);',1,'','2017-11-30 19:11:06');
INSERT INTO migration_log VALUES(137,'Set dashboard version to 1 where 0','UPDATE dashboard SET version = 1 WHERE version = 0',1,'','2017-11-30 19:11:06');
INSERT INTO migration_log VALUES(138,'save existing dashboard data in dashboard_version table v1',replace('INSERT INTO dashboard_version\n(\n	dashboard_id,\n	version,\n	parent_version,\n	restored_from,\n	created,\n	created_by,\n	message,\n	data\n)\nSELECT\n	dashboard.id,\n	dashboard.version,\n	dashboard.version,\n	dashboard.version,\n	dashboard.updated,\n	COALESCE(dashboard.updated_by, -1),\n	'''',\n	dashboard.data\nFROM dashboard;','\n',char(10)),1,'','2017-11-30 19:11:06');
INSERT INTO migration_log VALUES(139,'alter dashboard_version.data to mediumtext v1','SELECT 0 WHERE 0;',1,'','2017-11-30 19:11:06');
INSERT INTO migration_log VALUES(140,'create tag table',replace('CREATE TABLE IF NOT EXISTS `tag` (\n`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL\n, `key` TEXT NOT NULL\n, `value` TEXT NOT NULL\n);','\n',char(10)),1,'','2017-11-30 19:11:06');
INSERT INTO migration_log VALUES(141,'add index tag.key_value','CREATE UNIQUE INDEX `UQE_tag_key_value` ON `tag` (`key`,`value`);',1,'','2017-11-30 19:11:06');
CREATE TABLE `user` (
`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, `version` INTEGER NOT NULL
, `login` TEXT NOT NULL
, `email` TEXT NOT NULL
, `name` TEXT NULL
, `password` TEXT NULL
, `salt` TEXT NULL
, `rands` TEXT NULL
, `company` TEXT NULL
, `org_id` INTEGER NOT NULL
, `is_admin` INTEGER NOT NULL
, `email_verified` INTEGER NULL
, `theme` TEXT NULL
, `created` DATETIME NOT NULL
, `updated` DATETIME NOT NULL
, `help_flags1` INTEGER NOT NULL DEFAULT 0, `last_seen_at` DATETIME NULL);
INSERT INTO user VALUES(1,0,'admin','admin@localhost','','a5333a2272a30afd8e10d0132096e2ef3b481ad6b896d2d3f8932aaafe421211f2dbc7f1937e0fee9774fd28760ba372b465','UOfTztErvd','3Hq6LwjD7o','',1,1,0,'','2017-11-30 19:11:06','2017-11-30 19:11:06',0,'2017-11-30 19:23:29');
CREATE TABLE `temp_user` (
`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, `org_id` INTEGER NOT NULL
, `version` INTEGER NOT NULL
, `email` TEXT NOT NULL
, `name` TEXT NULL
, `role` TEXT NULL
, `code` TEXT NOT NULL
, `status` TEXT NOT NULL
, `invited_by_user_id` INTEGER NULL
, `email_sent` INTEGER NOT NULL
, `email_sent_on` DATETIME NULL
, `remote_addr` TEXT NULL
, `created` DATETIME NOT NULL
, `updated` DATETIME NOT NULL
);
CREATE TABLE `star` (
`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, `user_id` INTEGER NOT NULL
, `dashboard_id` INTEGER NOT NULL
);
CREATE TABLE `org` (
`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, `version` INTEGER NOT NULL
, `name` TEXT NOT NULL
, `address1` TEXT NULL
, `address2` TEXT NULL
, `city` TEXT NULL
, `state` TEXT NULL
, `zip_code` TEXT NULL
, `country` TEXT NULL
, `billing_email` TEXT NULL
, `created` DATETIME NOT NULL
, `updated` DATETIME NOT NULL
);
INSERT INTO org VALUES(1,0,'Main Org.','','','','','','',NULL,'2017-11-30 19:11:06','2017-11-30 19:11:06');
CREATE TABLE `org_user` (
`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, `org_id` INTEGER NOT NULL
, `user_id` INTEGER NOT NULL
, `role` TEXT NOT NULL
, `created` DATETIME NOT NULL
, `updated` DATETIME NOT NULL
);
INSERT INTO org_user VALUES(1,1,1,'Admin','2017-11-30 19:11:06','2017-11-30 19:11:06');
CREATE TABLE `dashboard_tag` (
`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, `dashboard_id` INTEGER NOT NULL
, `term` TEXT NOT NULL
);
CREATE TABLE `dashboard` (
`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, `version` INTEGER NOT NULL
, `slug` TEXT NOT NULL
, `title` TEXT NOT NULL
, `data` TEXT NOT NULL
, `org_id` INTEGER NOT NULL
, `created` DATETIME NOT NULL
, `updated` DATETIME NOT NULL
, `updated_by` INTEGER NULL, `created_by` INTEGER NULL, `gnet_id` INTEGER NULL, `plugin_id` TEXT NULL);
CREATE TABLE `data_source` (
`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, `org_id` INTEGER NOT NULL
, `version` INTEGER NOT NULL
, `type` TEXT NOT NULL
, `name` TEXT NOT NULL
, `access` TEXT NOT NULL
, `url` TEXT NOT NULL
, `password` TEXT NULL
, `user` TEXT NULL
, `database` TEXT NULL
, `basic_auth` INTEGER NOT NULL
, `basic_auth_user` TEXT NULL
, `basic_auth_password` TEXT NULL
, `is_default` INTEGER NOT NULL
, `json_data` TEXT NULL
, `created` DATETIME NOT NULL
, `updated` DATETIME NOT NULL
, `with_credentials` INTEGER NOT NULL DEFAULT 0, `secure_json_data` TEXT NULL);
INSERT INTO data_source VALUES(1,1,1,'influxdb','homeassistant','proxy','http://${INFLUXDB_SERVER}:8086','','','home_assistant',0,'','',0,X'7b7d','2017-11-30 19:18:55','2017-11-30 19:24:11',0,'{}');
CREATE TABLE `api_key` (
`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, `org_id` INTEGER NOT NULL
, `name` TEXT NOT NULL
, `key` TEXT NOT NULL
, `role` TEXT NOT NULL
, `created` DATETIME NOT NULL
, `updated` DATETIME NOT NULL
);
CREATE TABLE `dashboard_snapshot` (
`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, `name` TEXT NOT NULL
, `key` TEXT NOT NULL
, `delete_key` TEXT NOT NULL
, `org_id` INTEGER NOT NULL
, `user_id` INTEGER NOT NULL
, `external` INTEGER NOT NULL
, `external_url` TEXT NOT NULL
, `dashboard` TEXT NOT NULL
, `expires` DATETIME NOT NULL
, `created` DATETIME NOT NULL
, `updated` DATETIME NOT NULL
);
CREATE TABLE `quota` (
`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, `org_id` INTEGER NULL
, `user_id` INTEGER NULL
, `target` TEXT NOT NULL
, `limit` INTEGER NOT NULL
, `created` DATETIME NOT NULL
, `updated` DATETIME NOT NULL
);
CREATE TABLE `plugin_setting` (
`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, `org_id` INTEGER NULL
, `plugin_id` TEXT NOT NULL
, `enabled` INTEGER NOT NULL
, `pinned` INTEGER NOT NULL
, `json_data` TEXT NULL
, `secure_json_data` TEXT NULL
, `created` DATETIME NOT NULL
, `updated` DATETIME NOT NULL
, `plugin_version` TEXT NULL);
CREATE TABLE `session` (
`key` TEXT PRIMARY KEY NOT NULL
, `data` BLOB NOT NULL
, `expiry` INTEGER NOT NULL
);
CREATE TABLE `playlist` (
`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, `name` TEXT NOT NULL
, `interval` TEXT NOT NULL
, `org_id` INTEGER NOT NULL
);
CREATE TABLE `playlist_item` (
`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, `playlist_id` INTEGER NOT NULL
, `type` TEXT NOT NULL
, `value` TEXT NOT NULL
, `title` TEXT NOT NULL
, `order` INTEGER NOT NULL
);
CREATE TABLE `preferences` (
`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, `org_id` INTEGER NOT NULL
, `user_id` INTEGER NOT NULL
, `version` INTEGER NOT NULL
, `home_dashboard_id` INTEGER NOT NULL
, `timezone` TEXT NOT NULL
, `theme` TEXT NOT NULL
, `created` DATETIME NOT NULL
, `updated` DATETIME NOT NULL
);
CREATE TABLE `alert` (
`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, `version` INTEGER NOT NULL
, `dashboard_id` INTEGER NOT NULL
, `panel_id` INTEGER NOT NULL
, `org_id` INTEGER NOT NULL
, `name` TEXT NOT NULL
, `message` TEXT NOT NULL
, `state` TEXT NOT NULL
, `settings` TEXT NOT NULL
, `frequency` INTEGER NOT NULL
, `handler` INTEGER NOT NULL
, `severity` TEXT NOT NULL
, `silenced` INTEGER NOT NULL
, `execution_error` TEXT NOT NULL
, `eval_data` TEXT NULL
, `eval_date` DATETIME NULL
, `new_state_date` DATETIME NOT NULL
, `state_changes` INTEGER NOT NULL
, `created` DATETIME NOT NULL
, `updated` DATETIME NOT NULL
);
CREATE TABLE `alert_notification` (
`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, `org_id` INTEGER NOT NULL
, `name` TEXT NOT NULL
, `type` TEXT NOT NULL
, `settings` TEXT NOT NULL
, `created` DATETIME NOT NULL
, `updated` DATETIME NOT NULL
, `is_default` INTEGER NOT NULL DEFAULT 0);
CREATE TABLE `annotation` (
`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, `org_id` INTEGER NOT NULL
, `alert_id` INTEGER NULL
, `user_id` INTEGER NULL
, `dashboard_id` INTEGER NULL
, `panel_id` INTEGER NULL
, `category_id` INTEGER NULL
, `type` TEXT NOT NULL
, `title` TEXT NOT NULL
, `text` TEXT NOT NULL
, `metric` TEXT NULL
, `prev_state` TEXT NOT NULL
, `new_state` TEXT NOT NULL
, `data` TEXT NOT NULL
, `epoch` INTEGER NOT NULL
, `region_id` INTEGER NULL DEFAULT 0, `tags` TEXT NULL);
CREATE TABLE `annotation_tag` (
`annotation_id` INTEGER NOT NULL
, `tag_id` INTEGER NOT NULL
);
CREATE TABLE `test_data` (
`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, `metric1` TEXT NULL
, `metric2` TEXT NULL
, `value_big_int` INTEGER NULL
, `value_double` REAL NULL
, `value_float` REAL NULL
, `value_int` INTEGER NULL
, `time_epoch` INTEGER NOT NULL
, `time_date_time` DATETIME NOT NULL
, `time_time_stamp` DATETIME NOT NULL
);
CREATE TABLE `dashboard_version` (
`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, `dashboard_id` INTEGER NOT NULL
, `parent_version` INTEGER NOT NULL
, `restored_from` INTEGER NOT NULL
, `version` INTEGER NOT NULL
, `created` DATETIME NOT NULL
, `created_by` INTEGER NOT NULL
, `message` TEXT NOT NULL
, `data` TEXT NOT NULL
);
CREATE TABLE `tag` (
`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
, `key` TEXT NOT NULL
, `value` TEXT NOT NULL
);
DELETE FROM sqlite_sequence;
INSERT INTO sqlite_sequence VALUES('migration_log',141);
INSERT INTO sqlite_sequence VALUES('user',1);
INSERT INTO sqlite_sequence VALUES('dashboard',0);
INSERT INTO sqlite_sequence VALUES('data_source',1);
INSERT INTO sqlite_sequence VALUES('api_key',0);
INSERT INTO sqlite_sequence VALUES('dashboard_version',0);
INSERT INTO sqlite_sequence VALUES('org',1);
INSERT INTO sqlite_sequence VALUES('org_user',1);
CREATE UNIQUE INDEX `UQE_user_login` ON `user` (`login`);
CREATE UNIQUE INDEX `UQE_user_email` ON `user` (`email`);
CREATE INDEX `IDX_temp_user_email` ON `temp_user` (`email`);
CREATE INDEX `IDX_temp_user_org_id` ON `temp_user` (`org_id`);
CREATE INDEX `IDX_temp_user_code` ON `temp_user` (`code`);
CREATE INDEX `IDX_temp_user_status` ON `temp_user` (`status`);
CREATE UNIQUE INDEX `UQE_star_user_id_dashboard_id` ON `star` (`user_id`,`dashboard_id`);
CREATE UNIQUE INDEX `UQE_org_name` ON `org` (`name`);
CREATE INDEX `IDX_org_user_org_id` ON `org_user` (`org_id`);
CREATE UNIQUE INDEX `UQE_org_user_org_id_user_id` ON `org_user` (`org_id`,`user_id`);
CREATE INDEX `IDX_dashboard_org_id` ON `dashboard` (`org_id`);
CREATE UNIQUE INDEX `UQE_dashboard_org_id_slug` ON `dashboard` (`org_id`,`slug`);
CREATE INDEX `IDX_dashboard_gnet_id` ON `dashboard` (`gnet_id`);
CREATE INDEX `IDX_dashboard_org_id_plugin_id` ON `dashboard` (`org_id`,`plugin_id`);
CREATE INDEX `IDX_dashboard_tag_dashboard_id` ON `dashboard_tag` (`dashboard_id`);
CREATE INDEX `IDX_data_source_org_id` ON `data_source` (`org_id`);
CREATE UNIQUE INDEX `UQE_data_source_org_id_name` ON `data_source` (`org_id`,`name`);
CREATE INDEX `IDX_api_key_org_id` ON `api_key` (`org_id`);
CREATE UNIQUE INDEX `UQE_api_key_key` ON `api_key` (`key`);
CREATE UNIQUE INDEX `UQE_api_key_org_id_name` ON `api_key` (`org_id`,`name`);
CREATE UNIQUE INDEX `UQE_dashboard_snapshot_key` ON `dashboard_snapshot` (`key`);
CREATE UNIQUE INDEX `UQE_dashboard_snapshot_delete_key` ON `dashboard_snapshot` (`delete_key`);
CREATE INDEX `IDX_dashboard_snapshot_user_id` ON `dashboard_snapshot` (`user_id`);
CREATE UNIQUE INDEX `UQE_quota_org_id_user_id_target` ON `quota` (`org_id`,`user_id`,`target`);
CREATE UNIQUE INDEX `UQE_plugin_setting_org_id_plugin_id` ON `plugin_setting` (`org_id`,`plugin_id`);
CREATE INDEX `IDX_alert_org_id_id` ON `alert` (`org_id`,`id`);
CREATE INDEX `IDX_alert_state` ON `alert` (`state`);
CREATE INDEX `IDX_alert_dashboard_id` ON `alert` (`dashboard_id`);
CREATE UNIQUE INDEX `UQE_alert_notification_org_id_name` ON `alert_notification` (`org_id`,`name`);
CREATE INDEX `IDX_annotation_org_id_alert_id` ON `annotation` (`org_id`,`alert_id`);
CREATE INDEX `IDX_annotation_org_id_type` ON `annotation` (`org_id`,`type`);
CREATE INDEX `IDX_annotation_org_id_dashboard_id_panel_id_epoch` ON `annotation` (`org_id`,`dashboard_id`,`panel_id`,`epoch`);
CREATE INDEX `IDX_annotation_org_id_epoch` ON `annotation` (`org_id`,`epoch`);
CREATE UNIQUE INDEX `UQE_annotation_tag_annotation_id_tag_id` ON `annotation_tag` (`annotation_id`,`tag_id`);
CREATE INDEX `IDX_dashboard_version_dashboard_id` ON `dashboard_version` (`dashboard_id`);
CREATE UNIQUE INDEX `UQE_dashboard_version_dashboard_id_version` ON `dashboard_version` (`dashboard_id`,`version`);
CREATE UNIQUE INDEX `UQE_tag_key_value` ON `tag` (`key`,`value`);
COMMIT;
