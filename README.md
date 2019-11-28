# CinemaLog

## 概要
就職活動用に映画の共有SNSを開発いたしました上映中と上映予定の映画を表示しており、
映画に対してコメントできるようになっています。
今後は、映画を行きたい人同士でマッチングできる機能を追加していきたいです！
また、ポートフォリオを簡単に見て頂けるように簡単ログイン機能を追加しております。

## heroku URL
```url
https://cinema-logs.herokuapp.com/
```

## 機能
- ユーザー管理機能
  - 新規ユーザー登録
  - ログイン（簡単ログイン機能を含む）
  - プロフィール編集(S3 アップロード)
  - プロフィール参照
  - ユーザー一覧表示
- 投稿管理機能
  - 新規投稿
  - 投稿編集・削除
  - 投稿一覧表示
- 映画情報管理
  - TMDbという外部APIから情報を取得
  - 1日1回情報を更新(開発環境：cron 本番：heroku_scheduler)

## 使用技術
- 言語
  - Ruby（2.5.5）
- フレームワーク
  - Ruby on Rails（5.2.3）
- DB
  - mysql
- フロントエンド
  - slim
  - Material icon
  - Sass
- デプロイ環境（CI/CD）
  - heroku
  - CircleCI
  - Docker
- 使用した主なgem
  - devise（ユーザー認証）
  - RSpec（単体テスト・結合テスト）
  - kaminari(ページネイション)
  - faraday(HTTPクライアントライブラリ)

## 今後、挑戦したこと
- AWS（ECR、ECS、RDS、Route53、ELB）で構築
- マッチング機能開発
- インフラのコード化
