# GitHub リポジトリ検索アプリ

## 課題の感想
```
コードを書く前に最も悩んだ部分について少し述べたいと思います。

私は、学習曲線が低く、誰でも理解できるコードを目指しています。

課題で華やかな最新技術や技巧を見せる方法と、華やかではないがシンプルでクリーンなコードを見せる方法があるとすれば、私は今回、本当に分かりやすくて綺麗なコードを見せたかったのです。

ユースケースを作成し、リポジトリインターフェースを作成し、ドメイン層を強化し、ステートマシンのような特殊な技術を使う方法も考えましたが、課題を読む評価者（後に一緒に働く仲間）に私が望む方向性を示したかったのです。

ビルドランナーやフリーズドのようなジェネレーター技術をすべて排除したのも同じ理由です。

その時間を使ってテストコードを少しでも多く書き、レビュー自動化ツールを使用してレビューに合わせて少しずつ改善していく過程をPRに込め、関数や変数の命名に気をつけ、普段使用しているパッケージにセキュリティの問題がないか調査することにも力を入れました。

一週間という短いながらも長い時間の中で多くの学びがありました。良い機会をいただき、心より感謝申し上げます。
```

## 評価ポイント チェックリスト + アピールポイント

#### レビューのしやすさ
- [x] レビューのしやすさ
- [x] README の充実
- [x] 適切なコメント
- [x] GitHub のプルリクエスト機能などの利用

<details>
<summary> もっと見る </summary>

#### Git
- [x] 適切な gitignore の設定
- [x] 適切なコミット粒度
- [x] 適切なブランチ運用
- [x] 簡潔性・可読性・安全性・保守性の高いコード
- [x] Dart の言語機能を適切に使いこなせているか

#### テスト
- [x] テストが導入しやすい構成
- [x] Unit・UI テストがある

#### UI/UX
- [x] エラー発生時の処理
- [x] 画面回転・様々な画面サイズ対応
- [x] Theme の適切な利用・ダークモードの対応
- [x] 多言語対応
- [x] アニメーションなど

#### CI/CD
- [x] ビルド
- [x] テスト
- [x] リント
- [x] フォーマット
- [x] 仮のデプロイ環境

#### 追加アピールポイント
- [x] ユメミリンツの適用
- [x] ユメミロゴのローディングバーの作成と適用
- [x] flutter_configを利用した環境変数の暗号化
- [x] レビュー自動化を利用したセルフレビューおよび改善

#### 参考
- 小規模なアプリに合わせて、必要な技術のみを使用しました。
- パッケージの分離は行いませんでした.
- リバーポッドジェネレーターは使用しませんでした.
- Freezed も同じ理由で使用せず、直接実装しました。
- Build_runnerを使わずにシンプルで分かりやすく実装するよう努めました。
- ドメインレイヤー（ロジックレイヤー）を使用せず、見やすく整理しました。

- 課題用のプロジェクトなので、見やすさを保ちながら、フォルダを過剰に分割しないように努めました。
- `dotenv`はアプリのデコンパイル時に情報が露出する問題があったため、`flutter_config`に置き換えました。

</details>

## プロジェクト概要
GitHub APIを活用してリポジトリを検索し、詳細情報を確認できるFlutterアプリケーションです。

## 主な機能
- GitHubリポジトリのキーワード検索
- 検索結果一覧表示
- リポジトリ詳細情報の確認

## 画面情報

|Search Screen|Search Result List|Detail Screen|
|---|---|---|
|<img width="240" src="https://github.com/user-attachments/assets/a88cf22e-5eb4-4437-a54d-a34524e1afc1">|<img width="240" src="https://github.com/user-attachments/assets/2d6a6c58-c2b1-42c4-b0b0-fdf39569a72c">|<img width="240" src="https://github.com/user-attachments/assets/0e196387-a802-4c3a-9743-638197b45ff9">

|Loading|Error|Language|
|---|---|---|
|<video width="240" src="https://github.com/user-attachments/assets/ae5ce734-58ad-47da-bcf3-45968c0f98c7">|<img width="240" src="https://github.com/user-attachments/assets/d392d417-5eea-4be2-a420-998cbcc8429f">|<img width="240" src="https://github.com/user-attachments/assets/b5dc64bd-2289-4750-acd9-0d7e770b07b4">|

## Architecture / Rule
- Logic Layerは使っていません。
- Assignment Branchをメインにして、sprintで大きく、featureで細かく分けました。
 
|[Flutter Architecture](https://docs.flutter.dev/app-architecture/concepts)|Brach Rule|
|---|---|
|![2025-02-11 22 54 23-photoaidcom-invert](https://github.com/user-attachments/assets/d1fdffa3-dae2-4803-81b4-a94b0764144c)|![34543543-photoaidcom-invert](https://github.com/user-attachments/assets/bfcbaa5a-6bf1-40bb-af02-b9d043459787)|

## アプリのフロー
<details>
  <summary> 表示する </summary>
 
  ```mermaid
flowchart TD
    A[App Start] --> B[Search Screen]
    B --> C{Enter Keyword}
    C --> |Keyword Input| D[GitHub API Search Request]
    D --> E{Search Results Exist?}
    E --> |Yes| F[Display Search Results List]
    E --> |No| G[No Search Results Message]
    F --> H[Select List Item]
    H --> I[Repository Detail Screen]
    I --> J[Display Details]
    J --> |Include Info| K[Repository Name]
    J --> |Include Info| L[Owner Icon]
    J --> |Include Info| M[Project Language]
    J --> |Include Info| N[Star Count]
    J --> |Include Info| O[Watcher Count]
    J --> |Include Info| P[Fork Count]
    J --> |Include Info| Q[Issue Count]
    G --> B
    Q --> B
```

</details>

最後まで読んでいただきありがとうございます。
