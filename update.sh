#!/bin/bash
#
# update.sh
# ~/Downloads/tactical_v12_artifact.html を最新版として取得し、
# index.html に反映して GitHub Pages に push するスクリプト。
#
# 使い方:
#   1. 新しい tactical_v12_artifact.html を ~/Downloads に置く
#   2. このフォルダで ./update.sh を実行する

set -euo pipefail

# このスクリプトが置かれているフォルダに移動（どこから実行してもOKにする）
cd "$(dirname "$0")"

SOURCE="$HOME/Downloads/tactical_v12_artifact.html"
DEST="index.html"

# 元ファイルが存在するか確認
if [ ! -f "$SOURCE" ]; then
  echo "❌ エラー: $SOURCE が見つかりません。"
  echo "   ~/Downloads に tactical_v12_artifact.html を置いてから再実行してください。"
  exit 1
fi

echo "📄 $SOURCE を $DEST にコピーします..."
cp "$SOURCE" "$DEST"

# 変更がなければ何もしない
if git diff --quiet -- "$DEST"; then
  echo "ℹ️  index.html に変更はありませんでした。push は行いません。"
  exit 0
fi

# 変更を commit & push
TIMESTAMP="$(date '+%Y-%m-%d %H:%M:%S')"
echo "📦 変更を commit します..."
git add "$DEST"
git commit -m "Update index.html ($TIMESTAMP)"

echo "🚀 GitHub に push します..."
git push

echo ""
echo "✅ 完了しました！"
echo "   公開URL: https://poteto0901.github.io/powerchair-soccer/"
echo "   ※ 反映まで数十秒〜数分かかることがあります。"
