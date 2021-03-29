# ActorConnection ( アクター・コネクション )

## アプリ URL
### [Actor Connection (AWS)](http://13.115.1.52)
### [Actor Connection (Heroku)](https://actor-connection.herokuapp.com)

## 概要
舞台・戯曲・映画のレビューアプリです。<br>
タグ機能により、映画と舞台が繋がります。<br>
さらにお気に入り傾向からおすすめ作品を表示！<br>

### シンプルな舞台情報
<img width="1173" alt="スクリーンショット 2021-02-24 11 18 57" src="https://user-images.githubusercontent.com/70884785/108937820-58ad7e80-7692-11eb-9fa4-c269bb904742.png">

### 人気の映画を紹介
<img width="1138" alt="スクリーンショット 2021-02-24 11 41 31" src="https://user-images.githubusercontent.com/70884785/108939577-4719a600-7695-11eb-9c1f-dbd4baa372e9.png">

## 使用技術
- Ruby 3.0.0
- Ruby on Rails 6.0.3.4
- Bootstrap 4.5.3
- Google Maps API
- JS
  - jquery 3.5.1
  - infinite-scroll 4.0.1
  - select2 4.1.0
- Gem
  - devise (ログイン機能)
  - socialization (お気に入り機能)
  - kaminari (ページング)
  - ridgepole (Schemafileの作成)
  - rubocop (コード整形)

## デプロイ
- EC2
- Nginx
- Puma
![AWS構成図](https://user-images.githubusercontent.com/70884785/111867891-54872f00-89ba-11eb-9a77-1ae7db77953e.png)

## データベース
- RDS
- postgreSQL
![ER図](https://user-images.githubusercontent.com/70884785/111099230-66b33880-8588-11eb-8be1-7e97e1ccb227.png)

## 開発環境
- Docker

## テスト
- RSpec
- Coverage 1211 / 1298 LOC (93.3%) covered.

## 監視システム
- Sentry

## 機能一覧
- ログイン機能
- ユーザー登録
  - プロフィール画像登録
- お気に入り登録
- おすすめ機能
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

## Qiita URL
### [Qiita](https://qiita.com/KON-ch)

## Twitter URL
### [Twitter](https://twitter.com/KON_chNNN)
