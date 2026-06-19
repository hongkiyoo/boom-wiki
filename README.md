# 연구실 운영 Wiki

랩 멤버용 비공개 운영 위키. 단일 HTML 파일을 **StatiCrypt로 암호화**해 GitHub Pages로 배포합니다.
(research-dashboard 와 동일한 방식)

> 이 README는 public repo 첫 페이지에 노출됩니다 — **민감한 정보는 적지 마세요.**

## 보는 사람용

`https://hongkiyoo.github.io/boom-wiki/` 접속 → 비밀번호 입력 → 위키.
비번은 운영조교 / PI 에게 문의.

## 폴더 구조

```
src/index.html   ← 원본(평문). 여기서 내용을 편집. git에 올라가지 않음(.gitignore)
index.html       ← 암호화된 배포본. 이것만 GitHub Pages가 서빙
.password        ← 비밀번호 평문. git에 올라가지 않음
update.command   ← 암호화 + 배포 스크립트
```

내용은 `src/index.html` 안의 `PAGES` 배열만 고치면 됩니다. 각 항목이 한 페이지입니다.

## 운영자용 (최초 셋업, 한 번만)

```bash
# 1. repo 클론 후 폴더로 이동
git clone git@github.com:hongkiyoo/boom-wiki.git
cd boom-wiki

# 2. 비밀번호 설정 (15자 이상 권장)
echo -n "원하는-긴-비밀번호" > .password
chmod 600 .password

# 3. 첫 배포
./update.command      # macOS는 더블클릭도 가능
```

그 다음 GitHub repo → Settings → Pages 에서
Source: Deploy from a branch / Branch: main / 폴더: /(root) → Save.

## 일상 (내용 수정할 때)

1. `src/index.html` 의 `PAGES` 배열 편집 (페이지 추가/수정)
2. `./update.command` 실행 (더블클릭)
3. ~1분 뒤 사이트 반영

## 비번 변경

```bash
echo -n "새-긴-비번-15자이상" > .password
chmod 600 .password
./update.command      # 새 비번으로 재암호화 + 배포
```

기존 비번을 알던 사람은 새 비번을 받기 전까지 못 봅니다.

## 새 페이지 추가하는 법

`src/index.html` 의 `PAGES` 배열에 항목 하나 추가:

```js
{ id: "고유id", group: "02. 행정", label: "사이드바에-표시될-이름",
  title: "페이지-제목",
  meta: { owner: "담당자", updated: "2026-06-19", cycle: "매 학기" },
  body: `<h2>소제목</h2><p>내용…</p>` },
```

- `group` 이 같으면 사이드바에서 같은 묶음으로 표시됩니다.
- 체크리스트는 `<ul class="checklist">…</ul>`.
- 강조 박스는 `<div class="callout">…</div>`.

## 권한 모델

- **읽기:** 비밀번호만 있으면 누구나 (구성원 전체)
- **편집:** GitHub repo collaborator(Write) + 위 스크립트 실행 가능한 사람
- repo → Settings → Collaborators 에서 편집자 추가

> 주의: StatiCrypt는 "비밀번호를 아는 사람"만 막습니다. 비번이 유출되면 누구나 볼 수 있으니,
> 정말 민감한 정보(미공개 연구 데이터 등)는 이 위키에 넣지 마세요.
