# TheaterConnection ( シアター・コネクション )

### [Theater Coneection (Heroku)](https://actor-connection.herokuapp.com)

## 概要
舞台・戯曲・映画のレビューアプリです。<br>
タグ機能により、映画と舞台が繋がります。<br>
さらにお気に入り傾向からおすすめ作品を表示！<br>
<img width="1173" alt="スクリーンショット 2021-02-24 11 18 57" src="https://user-images.githubusercontent.com/70884785/108937820-58ad7e80-7692-11eb-9fa4-c269bb904742.png">

## 使用技術
- Ruby 3.0.0
- Ruby on Rails 6.0.3.4
- Bootstrap 4.5.3
- Google Maps API
- gem
  - devise (ログイン機能)
  - socialization (お気に入り機能)
  - kaminari (ページング)
  - ridgepole (Schemafileの作成)

## 開発環境
- Docker

## データベース
- postgreSQL

## 機能一覧
- ログイン機能
- ユーザー登録
  - プロフィール画像登録
- お気に入り登録
- レビュー投稿
- 検索機能
  - キーワード検索
  - 絞り込み検索
- タイムライン表示
- 情報登録機能
  - 舞台情報登録
  - 戯曲情報登録
  - 映画情報登録
- 劇場付近マップ
