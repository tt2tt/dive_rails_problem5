# README

## テーブル

Userテーブル

Column          | Type
--------------- | ------
id              | bigint
name            | string
email           | string
password_digest | string

Taskテーブル

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

Labelテーブル

Column | Type
------ | ------
id     | bigint
name   | string

Task_Labelテーブル

Column   | Type
-------- | ------
id       | bigint
task_id  | bigint
label_id | bigint

## Herokuへデプロイ

Herokuへログイン

'''$ heroku login'''

Herokuにアプリの作成

'''$ heroku create'''

Herokuへデプロイ

'''$ git push heroku master'''

データベースの移行

'''$ heroku run rails db:migrate'''
