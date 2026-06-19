#!/bin/bash
# 연구실 운영 Wiki — 암호화 & 배포
# 흐름: src/index.html(원본) → StatiCrypt 암호화 → index.html(배포) → git push
set -e
cd "$(dirname "$0")"

if [ ! -f .password ]; then
  echo "❌ .password 파일이 없습니다. 먼저 비밀번호를 설정하세요:"
  echo "   echo -n '원하는-비번-15자이상' > .password && chmod 600 .password"
  exit 1
fi
PW=$(cat .password)

if ! command -v npx &> /dev/null; then
  echo "❌ Node.js(npx)가 필요합니다. https://nodejs.org 에서 설치하세요."
  exit 1
fi

echo "🔐 src/index.html 암호화 중..."
# -d . : 현재 폴더에 출력  /  -o index.html : 배포용 파일명
npx -y staticrypt src/index.html \
  -p "$PW" --short \
  -d . -o index.html \
  --template-title "연구실 운영 Wiki" \
  --template-instructions "연구실 구성원 전용입니다. 비밀번호를 입력하세요." \
  --template-button "입장"
echo "✅ 암호화 완료 → index.html"

echo "📤 GitHub에 배포 중..."
git add index.html
git commit -m "wiki 업데이트 $(date '+%Y-%m-%d %H:%M')" || echo "(변경 없음)"
git push origin main
echo ""
echo "🎉 완료! ~1분 뒤 반영: https://hongkiyoo.github.io/boom-wiki/"
