# README

## テーブル

## User

Column          | Type
--------------- | ------
id              | bigint
name            | string
email           | string
password_digest | string

## Task

Column   | Type
-------- | --------
id       | bigint
user_id  | bigint
label_id | bigint
name     | string
detail   | text
deadline | datetime
priority | integer
status   | integer

## Label

Column | Type
------ | ------
id     | bigint
name   | string

## Task_Label

Column   | Type
-------- | ------
id       | bigint
task_id  | bigint
label_id | bigint
