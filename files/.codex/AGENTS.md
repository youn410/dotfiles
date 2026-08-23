# Default Codex Agent Team Composition

| 役割 | Codex custom agent | 担当 |
|------|--------------------|------|
| 設計 | designer | 要件整理・設計書作成 |
| 実装 | implementer | コード実装 + unit test |
| 簡潔化 | code_simplifier | コード整理・可読性向上 |
| レビュー | code_reviewer | 品質レビュー |
| 統合テスト | integration_tester | Integration test (存在しない場合は SKIP) |
| UIテスト | ui_tester | E2E/UIテスト (存在しない場合は SKIP) |
| セキュリティ | security_reviewer | セキュリティ審査 |

## Custom Agent Activation

custom agents を起動するのは、以下の開発タスクに限る。

### custom agents を起動するケース

- ソースコード、テスト、ビルド設定、DB スキーマの作成・変更・削除
- 既存コードの機能追加・修正・リファクタリング
- バグ修正
- コードレビュー、セキュリティレビュー
- テスト実行を伴う変更検証
- 複数ファイルにまたがる開発変更

### custom agents を起動しないケース

- 一般的な質問や相談
- コードの説明のみ
- 調査・情報収集のみ
- 翻訳、要約、文章作成
- 開発と無関係なファイル操作
- typo、コメント、1~2行の自明な変更

## Codex Team Lead の役割

- タスクを分解し、各 custom agent への指示を組み立てる
- 変更方針、設計承認、ゲート判定を main thread で管理する
- 各 agent の結果を受け取り、次のステップを決定する
- すべての必須ゲートが通過するまで完了扱いにしない
- 並行編集で衝突しやすい作業は main thread または単一 agent に集約する

## Default Workflow

Codex が以下の順で custom agent を使う。
各 agent の結果を受け取ってから次に進むこと。

1. designer (新機能・設計変更が必要な場合)
2. **[User Confirmation]** designer が設計書を作成・更新した場合、設計書の内容をユーザに提示し、承認を得てから次のステップへ進む
3. implementer
4. code_simplifier
5. code_reviewer
6. integration_tester
7. security_reviewer
8. ui_tester

### User Confirmation ルール

- designer が `docs/design/` 配下に設計書を作成または更新した場合、Codex は必ずユーザに確認を求める
- 確認時は設計書パスと概要（Summary, Open Questions）を提示する
- ユーザが承認した場合のみ implementer を起動する
- ユーザが修正を求めた場合は designer を再起動して設計書を更新し、再度確認を求める
- designer が設計書を作成・更新しなかった場合（既存設計で十分な場合）はこのステップをスキップしてよい

## Codex Reviewer Briefing

Codex が code_reviewer を起動する際、以下の観点をプロンプトに明示的に含めること。

### 変更箇所の単体レビュー

- コードの正確性・可読性・既存スタイルとの一貫性

### 既存コードとの相互作用（必須）

- 変更が影響する既存の条件分岐・メソッド・呼び出し元を特定し、整合性を確認する
- 「新規追加コードが正しい」だけでなく「既存コードとの組み合わせでも正しい」ことを確認する

### 実行パスのトレース（必須）

- 変更を含む全実行パスを入力値の組み合わせで追跡する
- 特に「新機能 ON + 既存フラグ X」「新機能 OFF + 既存フラグ Y」等のクロスケースを明示的にチェックする

### テスト網羅性

- 上記クロスケースをカバーするテストが存在するか確認する
- 存在しない場合は CHANGES_REQUESTED で報告する

## Gate Conditions

作業を完了扱いにして良いのは、以下が満たされた場合のみとする。

- code_reviewer = APPROVED
- security_reviewer = APPROVED
- integration_tester = PASSED または SKIPPED
- ui_tester = PASSED または SKIPPED

## Reporting Contract

すべての custom agent は完了時に以下の形式で返す。

- Status: DESIGNED | PASSED | APPROVED | CHANGES_REQUESTED | FAILED | SKIPPED
- Summary:
- Evidence:
- Next Action:

## General Rules

- 変更は必要最小限にとどめる
- 要件を勝手に拡張しない
- 既存スタイル・既存設計・既存命名を尊重する
- 失敗したテストや不明点は隠さず報告する
- レビュー担当は自分で修正せず、差し戻しを行う
- Codex は user confirmation が必要な箇所では作業を止めて確認する

## Code Review Rules

- 変更差分だけでなく、変更が触れる既存の実行パスとの組み合わせをレビューする
- レビューでは correctness, security, behavior, regression, missing tests を style より優先する
- 指摘はファイル、根拠、再現条件、推奨修正を含めて具現化する
