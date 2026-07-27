i want to use openspec to plan my project with several phases , please suggest 隨著餐飲資訊與外送平台快速發展，使用者雖能取得大量餐廳資料，卻也容易因選項過多而產生「今天要吃什麼」的選擇困難。用餐決策不只受到距離與價格影響，也與當下心情、用餐動機及飲食狀況密切相關。 現有餐廳推薦服務多以類型、評分、價位及距離等固定條件篩選，較少整合使用者當下的心情與需求；推薦、用餐回饋、心情紀錄及飲食管理也常分散於不同平台，難以形成連續且個人化的使用體驗。 本專案提出「MoodFood AI」心情餐廳推薦與飲食紀錄系統，依據使用者位置、心情、用餐動機、價位與距離，即時推薦合適餐廳，並整合收藏、星等回饋、每週心情分析、命運扭蛋及 AI 飲食紀錄，建立從選擇餐廳到餐後紀錄的完整流程。 系統採用 Django、SQLite 與單頁工作台介面開發，透過 Google Places API 取得即時餐廳資料，並利用 OpenAI 生成推薦文案、辨識餐點照片及估算卡路里，作為個人化推薦與統計分析依據。 本專案以不同心情、價位、距離及餐廳數量不足等情境進行測試，驗證首次推薦、換一批、放寬搜尋、扭蛋抽選、照片上傳、熱量估算、收藏與星等回饋等功能。 初步測試顯示，系統能依使用情境提供三間即時餐廳推薦，並透過放寬條件改善結果不足問題；結合心情與飲食紀錄後，可將單次搜尋延伸為持續性的飲食管理，提升推薦實用性與決策效率。

# MoodFood AI｜OpenSpec 分階段專案規劃

## 一、專案願景

MoodFood AI 是一套結合「心情、位置、用餐動機、價格、距離與飲食紀錄」的智慧餐廳推薦系統。

系統不只回答「附近有什麼餐廳」，而是協助使用者完成完整的用餐決策流程：

```text
不知道吃什麼
    ↓
輸入當下心情與需求
    ↓
取得符合情境的餐廳推薦
    ↓
選擇、收藏或重新推薦
    ↓
實際用餐
    ↓
上傳餐點照片與留下評價
    ↓
建立心情與飲食紀錄
    ↓
產生每週分析與個人化建議
```

---

# 二、OpenSpec 專案結構建議

```text
moodfood-ai/
├── AGENTS.md
├── README.md
├── openspec/
│   ├── project.md
│   ├── architecture.md
│   ├── roadmap.md
│   ├── glossary.md
│   │
│   ├── specs/
│   │   ├── user-auth/
│   │   │   └── spec.md
│   │   ├── mood-input/
│   │   │   └── spec.md
│   │   ├── restaurant-search/
│   │   │   └── spec.md
│   │   ├── recommendation-engine/
│   │   │   └── spec.md
│   │   ├── recommendation-workbench/
│   │   │   └── spec.md
│   │   ├── favorites-ratings/
│   │   │   └── spec.md
│   │   ├── mood-history/
│   │   │   └── spec.md
│   │   ├── food-journal/
│   │   │   └── spec.md
│   │   ├── ai-food-analysis/
│   │   │   └── spec.md
│   │   └── weekly-insights/
│   │       └── spec.md
│   │
│   └── changes/
│       ├── phase-01-foundation/
│       ├── phase-02-core-recommendation/
│       ├── phase-03-feedback-loop/
│       ├── phase-04-food-journal/
│       ├── phase-05-ai-insights/
│       └── phase-06-validation-release/
│
├── moodfood/
├── accounts/
├── restaurants/
├── recommendations/
├── journals/
├── analytics/
├── templates/
├── static/
├── tests/
├── manage.py
└── requirements.txt
```

---

# 三、整體開發階段

## Phase 0：需求釐清與專案規格建立

### 階段目標

在撰寫程式之前，先確定 MoodFood AI 解決的核心問題、使用者流程、資料來源與 AI 功能邊界。

### 核心問題

1. 使用者為什麼需要 MoodFood AI？
2. 心情如何影響餐廳推薦？
3. 系統如何判斷餐廳適合某種心情？
4. AI 推薦理由由規則產生，還是由 OpenAI 生成？
5. 餐點辨識與熱量估算是否要標示不確定性？
6. 未登入使用者可以使用哪些功能？
7. 餐廳資料不足時如何處理？
8. 使用者回饋如何影響後續推薦？

### 主要交付物

```text
openspec/project.md
openspec/architecture.md
openspec/roadmap.md
openspec/glossary.md
AGENTS.md
```

### 專案範圍

#### MVP 必須包含

- 使用者輸入位置
- 選擇心情
- 選擇用餐動機
- 設定價位
- 設定搜尋距離
- 呼叫 Google Places API
- 顯示三間餐廳
- 顯示 AI 推薦理由
- 換一批
- 放寬搜尋條件
- 命運扭蛋
- 收藏餐廳
- 星等評價

#### MVP 暫不包含

- 外送平台下單
- 餐廳訂位
- 精準醫療營養診斷
- 自動扣除每日熱量
- 複雜協同過濾模型
- 多城市旅遊行程規劃
- 餐廳業者後台

### 完成條件

- 所有主要名詞具有一致定義
- 每項功能都有明確使用情境
- 每項 AI 功能都有輸入、輸出與錯誤處理
- MVP 與未來功能已清楚分離
- 確認個資、位置與照片的處理原則

---

# Phase 1：系統基礎與資料模型

## 階段目標

建立可以持續擴充的 Django 專案骨架、資料庫模型、基本頁面與測試環境。

## 功能範圍

### 1. Django 專案初始化

建立主要應用：

```text
accounts
restaurants
recommendations
journals
analytics
```

### 2. 使用者系統

第一版可採用 Django 內建帳號系統：

- 註冊
- 登入
- 登出
- 個人基本設定
- 預設價位
- 預設距離
- 飲食偏好

Google Login 可以放在 Phase 3 或 Phase 6。

### 3. 核心資料模型

#### UserPreference

```text
user
default_price_level
default_distance
dietary_preferences
allergies
created_at
updated_at
```

#### MoodRecord

```text
user
mood
dining_motivation
note
recorded_at
```

#### RestaurantSnapshot

Google Places 資料可能改變，因此建議儲存使用當下的快照。

```text
place_id
name
address
latitude
longitude
rating
rating_count
price_level
business_status
photo_reference
data_updated_at
```

#### RecommendationSession

```text
user
latitude
longitude
mood
dining_motivation
price_level
distance
search_radius
result_count
created_at
```

#### RecommendationItem

```text
session
restaurant
rank
recommendation_reason
is_selected
is_skipped
created_at
```

### 技術任務

- 建立 Django settings
- 環境變數管理
- SQLite 資料庫
- Django migrations
- Bootstrap 或自訂 CSS
- 單頁工作台基礎布局
- API 金鑰不得寫入 Git
- 建立 pytest 或 Django TestCase

### OpenSpec Change

```text
openspec/changes/phase-01-foundation/
├── proposal.md
├── design.md
├── tasks.md
└── specs/
    ├── user-auth/
    └── core-data-model/
```

### 驗收條件

- Django 專案可以啟動
- 使用者可以註冊與登入
- 所有核心模型可以正常 migration
- 可以建立測試使用者與測試資料
- 敏感設定使用環境變數
- 首頁工作台可以正常顯示

---

# Phase 2：核心餐廳推薦 MVP

## 階段目標

完成 MoodFood AI 最重要的核心流程：

> 使用者輸入心情與條件，系統推薦三間適合的即時餐廳。

## 使用者流程

```text
開啟工作台
→ 允許取得位置或手動輸入位置
→ 選擇心情
→ 選擇用餐動機
→ 選擇價位
→ 選擇距離
→ 按下「幫我選」
→ 顯示三間餐廳
```

## 心情分類建議

第一版不要使用過多類別，建議先設計六種：

| 心情   | 推薦方向                   |
| ------ | -------------------------- |
| 開心   | 熱鬧、聚餐、特色料理       |
| 疲累   | 快速、方便、舒適、近距離   |
| 壓力大 | 療癒、甜點、咖啡、安靜     |
| 難過   | 溫暖、熟悉、湯品、舒適食物 |
| 想冒險 | 異國料理、新餐廳、特色料理 |
| 平靜   | 清淡、健康、環境安靜       |

## 用餐動機建議

- 快速解決
- 犒賞自己
- 朋友聚餐
- 一個人放鬆
- 約會
- 健康飲食
- 嘗試新口味

## Google Places 搜尋流程

```text
使用者條件
    ↓
轉換成搜尋參數
    ↓
Google Places Nearby Search
    ↓
取得候選餐廳
    ↓
資料清理與排除
    ↓
推薦分數計算
    ↓
選出前三名
    ↓
生成推薦理由
```

## 推薦評分模型

第一版建議使用可解釋的規則式評分，而不是直接讓 OpenAI 決定排名。

```text
recommendation_score =
    distance_score × 0.25
  + rating_score × 0.20
  + rating_count_score × 0.10
  + price_match_score × 0.15
  + mood_match_score × 0.20
  + motivation_match_score × 0.10
```

## 推薦原則

- AI 負責生成自然語言推薦說明
- 後端規則負責餐廳排序
- OpenAI 不直接決定餐廳是否存在
- 餐廳名稱、地址、評分必須來自 Google Places
- 推薦理由不可捏造餐廳未提供的資訊

## 推薦卡片內容

每張推薦卡片至少顯示：

- 餐廳名稱
- 餐廳照片
- Google 評分
- 評論數
- 價位
- 距離
- 地址
- 營業狀態
- 推薦原因
- 收藏按鈕
- 查看地圖按鈕

## 結果不足策略

### 第一層

原條件搜尋。

### 第二層

若少於三間，將距離放寬，例如：

```text
500 公尺 → 1 公里
1 公里 → 2 公里
2 公里 → 3 公里
```

### 第三層

價位放寬一級。

### 第四層

減少心情對料理類型的限制，但保留距離與營業狀態。

### 顯示原則

系統必須明確告知：

> 附近符合原條件的餐廳不足，已將搜尋距離從 1 公里放寬至 2 公里。

不可在未告知使用者的情況下偷偷改變條件。

## OpenSpec Change

```text
openspec/changes/phase-02-core-recommendation/
├── proposal.md
├── design.md
├── tasks.md
└── specs/
    ├── mood-input/
    ├── restaurant-search/
    ├── recommendation-engine/
    └── recommendation-workbench/
```

## 驗收條件

- 使用者可以完成條件輸入
- 系統可以取得即時位置
- Google Places API 可以回傳餐廳
- 正常情況顯示三間餐廳
- 餐廳不足時可放寬條件
- AI 推薦文案不捏造事實
- API 錯誤時顯示可理解的訊息
- 相同餐廳不會在同一批中重複出現

---

# Phase 3：互動、收藏與推薦回饋

## 階段目標

讓推薦不再只是一次性的搜尋，而是建立使用者行為與偏好的回饋循環。

## 功能一：換一批

### 行為規則

- 保留原本搜尋條件
- 排除本次工作階段已顯示過的餐廳
- 再回傳最多三間
- 沒有新結果時提示調整條件

### 驗收情境

```gherkin
Given 使用者已看過第一批三間餐廳
When 使用者按下「換一批」
Then 系統不得再次顯示相同餐廳
And 系統應保留原本心情與搜尋條件
```

## 功能二：命運扭蛋

扭蛋不是重新搜尋，而是從目前符合條件的候選餐廳中隨機選擇一間。

### 建議流程

```text
取得合格候選餐廳
→ 過濾已關閉餐廳
→ 依推薦分數建立加權機率
→ 動畫抽選
→ 顯示結果與推薦原因
```

第一版可以採純隨機；後續可改成加權隨機。

## 功能三：收藏

收藏資料：

```text
user
restaurant
source_session
note
created_at
```

支援：

- 加入收藏
- 取消收藏
- 收藏清單
- 從收藏清單開啟 Google Maps

## 功能四：星等與回饋

### UserRestaurantFeedback

```text
user
restaurant
mood_before
mood_after
rating
would_visit_again
comment
visited_at
```

建議收集：

- 1～5 星
- 是否願意再次造訪
- 用餐後心情
- 簡短文字回饋

## 功能五：Google Login

此階段可加入：

- Google OAuth
- 帳號基本資料
- 登入後保留收藏與歷史紀錄

## OpenSpec Change

```text
openspec/changes/phase-03-feedback-loop/
├── proposal.md
├── design.md
├── tasks.md
└── specs/
    ├── recommendation-refresh/
    ├── lucky-capsule/
    ├── favorites-ratings/
    └── google-auth/
```

## 驗收條件

- 換一批不重複顯示既有結果
- 命運扭蛋只從有效候選餐廳抽選
- 使用者可以收藏與取消收藏
- 星等回饋成功寫入資料庫
- 未登入使用者執行收藏時會被引導登入
- 登入後能查看自己的紀錄

---

# Phase 4：AI 飲食紀錄

## 階段目標

讓使用者在用餐後上傳餐點照片，建立飲食日誌，並取得 AI 餐點辨識與熱量估算。

## 使用者流程

```text
選擇推薦餐廳
→ 完成用餐
→ 上傳餐點照片
→ AI 辨識餐點
→ 顯示可能的餐點名稱
→ 估算份量與熱量
→ 使用者修正
→ 儲存飲食紀錄
```

## FoodJournal 模型

```text
user
restaurant
recommendation_session
meal_type
meal_name
photo
estimated_calories
calorie_min
calorie_max
confidence
user_corrected
notes
eaten_at
created_at
```

## FoodAnalysisItem 模型

一張照片可能包含多項食物。

```text
journal
food_name
estimated_portion
estimated_calories
confidence
```

## AI 輸出建議格式

```json
{
  "meal_summary": "牛肉麵與燙青菜",
  "items": [
    {
      "name": "牛肉麵",
      "portion": "約 1 碗",
      "calorie_min": 550,
      "calorie_max": 750,
      "confidence": 0.78
    },
    {
      "name": "燙青菜",
      "portion": "約 1 小盤",
      "calorie_min": 60,
      "calorie_max": 120,
      "confidence": 0.68
    }
  ],
  "total_calorie_min": 610,
  "total_calorie_max": 870,
  "uncertainty_note": "照片無法確認湯汁、用油量及實際份量。"
}
```

## 關鍵設計原則

熱量分析必須標示為估算，不應顯示成精確醫療數字。

推薦呈現：

```text
估計熱量：610～870 kcal
AI 信心程度：中等
實際熱量可能因份量、烹調方式及配料而不同。
```

避免只顯示：

```text
熱量：742 kcal
```

## 使用者修正機制

使用者應能修改：

- 餐點名稱
- 食物項目
- 份量
- 熱量
- 用餐時間
- 餐別

AI 結果是初始建議，不是不可修改的最終答案。

## 圖片處理

- 限制檔案格式
- 限制檔案大小
- 產生安全檔名
- 驗證 MIME type
- 圖片縮圖
- 刪除紀錄時同步處理圖片
- 隱私政策說明照片用途

## OpenSpec Change

```text
openspec/changes/phase-04-food-journal/
├── proposal.md
├── design.md
├── tasks.md
└── specs/
    ├── food-journal/
    ├── photo-upload/
    └── ai-food-analysis/
```

## 驗收條件

- 使用者可上傳合法圖片格式
- 無圖片時不可呼叫視覺分析
- AI 回傳資料必須通過 JSON schema 驗證
- 顯示熱量區間與不確定性
- 使用者可修正 AI 辨識結果
- 分析失敗時仍能手動建立飲食紀錄
- 圖片不得公開給其他使用者

---

# Phase 5：每週心情與飲食分析

## 階段目標

將個別餐廳搜尋、用餐紀錄與心情資料整合為持續性的個人化分析。

## 每週儀表板

建議包含：

### 心情分布

- 本週最常出現的心情
- 各心情出現次數
- 用餐前後心情變化

### 用餐行為

- 本週外食次數
- 最常選擇的料理類型
- 最常使用的價位
- 平均搜尋距離
- 收藏與實際造訪比例

### 飲食紀錄

- 每日估算熱量
- 每週估算總熱量
- 餐別分布
- 高熱量餐點出現頻率
- 照片紀錄完成率

### 推薦成效

- 推薦後實際選擇率
- 換一批使用次數
- 放寬搜尋使用次數
- 命運扭蛋選擇率
- 推薦餐廳平均評分
- 願意再次造訪比例

## AI 每週摘要

建議由程式先計算統計資料，再由 OpenAI 將結果轉為自然語言。

AI 不應直接讀取所有原始資料後自行計算。

### 正確流程

```text
Django ORM 統計
→ 產生結構化摘要
→ OpenAI 生成自然語言分析
→ 儲存每週報告
```

### 範例輸入

```json
{
  "period": "2026-07-20 to 2026-07-26",
  "dominant_mood": "疲累",
  "restaurant_searches": 8,
  "restaurants_visited": 4,
  "average_rating": 4.2,
  "estimated_calories": 10250,
  "most_common_category": "麵食",
  "mood_improvement_rate": 0.75
}
```

### 範例輸出方向

> 本週你多半在感到疲累時尋找餐廳，並且較常選擇距離近、出餐快速的麵食類餐廳。四次實際用餐中，有三次的餐後心情比餐前改善。下週可以在疲累時增加清淡餐點選項，避免連續選擇高油脂餐點。

## 個人化規則

後續推薦可以加入：

- 過去高評分餐廳類型
- 使用者常收藏的料理
- 不喜歡的類型
- 常用搜尋距離
- 特定心情下的歷史選擇
- 願意再次造訪的餐廳特徵

## OpenSpec Change

```text
openspec/changes/phase-05-ai-insights/
├── proposal.md
├── design.md
├── tasks.md
└── specs/
    ├── mood-history/
    ├── weekly-insights/
    └── personalization/
```

## 驗收條件

- 每週統計由後端程式計算
- 圖表與資料庫統計結果一致
- 沒有資料時顯示空狀態
- AI 摘要不得產生不存在的紀錄
- 使用者只能查看自己的分析
- 可依週次切換歷史報告

---

# Phase 6：整合測試、品質改善與發布

## 階段目標

驗證系統能在不同心情、地點、價位、餐廳不足及 AI 失敗等情境下穩定運作。

## 測試層級

### 1. 單元測試

- 距離計算
- 價位匹配
- 心情映射
- 推薦分數
- 放寬條件
- 餐廳去重
- 熱量區間驗證
- AI JSON 解析

### 2. 整合測試

- Google Places API
- OpenAI API
- 圖片上傳
- Django ORM
- 使用者權限
- 收藏與評分

### 3. 使用者流程測試

#### 情境 A：正常推薦

```text
心情：開心
動機：朋友聚餐
價位：中等
距離：2 公里
預期：顯示三間適合聚餐的餐廳
```

#### 情境 B：疲累且只想吃附近

```text
心情：疲累
動機：快速解決
距離：500 公尺
預期：優先推薦距離近且營業中的餐廳
```

#### 情境 C：餐廳不足

```text
原條件只找到一間
預期：
1. 告知結果不足
2. 提供放寬搜尋
3. 放寬後補足推薦結果
```

#### 情境 D：換一批

```text
預期：
新結果不得包含本工作階段已顯示餐廳
```

#### 情境 E：命運扭蛋

```text
預期：
只從有效候選餐廳抽選
```

#### 情境 F：照片分析

```text
上傳清楚餐點照片
預期：
顯示餐點名稱、熱量範圍、信心程度與不確定性
```

#### 情境 G：AI 分析失敗

```text
OpenAI API timeout
預期：
顯示錯誤訊息，並允許使用者手動建立紀錄
```

#### 情境 H：位置權限拒絕

```text
預期：
提供手動輸入地址或地區的替代方式
```

## 非功能測試

- 行動裝置響應式布局
- 頁面載入速度
- API timeout
- API rate limit
- SQL 查詢效能
- 圖片大小限制
- CSRF 防護
- XSS 防護
- 權限隔離
- 環境變數安全
- 日誌不得記錄 API 金鑰

## OpenSpec Change

```text
openspec/changes/phase-06-validation-release/
├── proposal.md
├── design.md
├── tasks.md
└── specs/
    ├── system-testing/
    ├── security/
    ├── observability/
    └── deployment/
```

## 驗收條件

- 所有核心流程具有自動化測試
- Google Places 與 OpenAI 皆有 mock 測試
- API 失敗不會使整個頁面崩潰
- 不同使用者資料完全隔離
- 手機與桌面版皆可操作
- README 提供完整安裝流程
- 系統可部署到正式環境

---

# 四、建議的版本里程碑

| 版本 | 對應階段  | 可展示成果                   |
| ---- | --------- | ---------------------------- |
| v0.1 | Phase 0–1 | Django 骨架、帳號、資料模型  |
| v0.2 | Phase 2   | 心情條件輸入與三間即時推薦   |
| v0.3 | Phase 3   | 換一批、扭蛋、收藏、星等     |
| v0.4 | Phase 4   | 照片上傳、餐點辨識、熱量估算 |
| v0.5 | Phase 5   | 每週心情與飲食分析           |
| v1.0 | Phase 6   | 完整測試、部署與成果展示     |

---

# 五、各階段依賴關係

```text
Phase 0：規格與架構
    ↓
Phase 1：帳號與資料模型
    ↓
Phase 2：即時餐廳推薦
    ↓
Phase 3：收藏、評分與互動
    ↓
Phase 4：AI 飲食紀錄
    ↓
Phase 5：每週分析與個人化
    ↓
Phase 6：測試與發布
```

可平行開發的部分：

```text
Phase 2 餐廳搜尋 API
        ↘
          前端推薦工作台
        ↗

Phase 4 圖片上傳
        ↘
          AI 餐點分析
        ↗

Phase 5 統計查詢
        ↘
          儀表板視覺化
        ↗
```

---

# 六、每個 OpenSpec Change 的標準格式

## proposal.md

回答「為什麼要做」。

```markdown
# Proposal: Core Restaurant Recommendation

## Problem

使用者面對大量餐廳選項時，難以依據當下心情與用餐需求快速做出決策。

## Proposed Change

新增心情、用餐動機、價位與距離輸入，並整合 Google Places API 產生三間即時餐廳推薦。

## User Value

使用者不需要逐一瀏覽大量餐廳，即可取得符合當下情境的少量推薦。

## Scope

- 心情選擇
- 用餐動機
- 價位
- 搜尋距離
- 即時餐廳資料
- 三間推薦
- 推薦原因

## Out of Scope

- 收藏
- 星等
- 飲食照片
- 每週分析
```

## design.md

回答「如何實作」。

```markdown
# Design: Core Restaurant Recommendation

## Components

- Recommendation Form
- Geolocation Service
- Google Places Client
- Recommendation Scoring Service
- OpenAI Explanation Service
- Recommendation Result View

## Data Flow

User Input
→ Validation
→ Places Search
→ Candidate Normalization
→ Score Calculation
→ Top Three Selection
→ Explanation Generation
→ Response

## Failure Handling

- Location denied
- Places API timeout
- Zero search results
- Fewer than three results
- OpenAI timeout
```

## tasks.md

回答「要做哪些工作」。

```markdown
# Tasks

## Backend

- [ ] 建立 RecommendationSession model
- [ ] 建立 Google Places client
- [ ] 建立推薦評分服務
- [ ] 建立條件放寬策略
- [ ] 建立 OpenAI 推薦文案服務
- [ ] 建立 API 錯誤處理

## Frontend

- [ ] 建立心情選擇器
- [ ] 建立用餐動機選擇器
- [ ] 建立價位與距離控制
- [ ] 建立推薦卡片
- [ ] 建立載入狀態
- [ ] 建立錯誤提示
- [ ] 建立放寬條件提示

## Testing

- [ ] 測試正常三間推薦
- [ ] 測試餐廳不足
- [ ] 測試 API timeout
- [ ] 測試位置權限拒絕
- [ ] 測試推薦結果去重
```

## spec.md

回答「系統必須表現成什麼樣子」。

```markdown
# Recommendation Engine Specification

## Requirement: Generate restaurant recommendations

The system SHALL recommend up to three restaurants based on the user's
location, mood, dining motivation, price preference, and distance limit.

### Scenario: Three restaurants are available

Given the user has provided valid recommendation conditions
And at least three matching restaurants are available
When the user requests recommendations
Then the system shall display exactly three restaurants
And each restaurant shall include a recommendation reason

### Scenario: Fewer than three restaurants are available

Given fewer than three restaurants match the original conditions
When the recommendation search completes
Then the system shall inform the user that results are insufficient
And the system shall offer an option to expand the search conditions

### Scenario: OpenAI explanation generation fails

Given restaurant candidates were retrieved successfully
And the OpenAI request fails
When recommendation results are displayed
Then the system shall still display the restaurant results
And the system shall use a rule-based fallback explanation
```

---

# 七、建議的規格模組

OpenSpec 應以「能力」切分，而不是直接依照 Django 檔案切分。

## Capability 1：Mood Input

負責：

- 心情選擇
- 用餐動機
- 價位
- 距離
- 位置
- 使用者輸入驗證

## Capability 2：Restaurant Search

負責：

- Google Places API
- 搜尋參數轉換
- 餐廳正規化
- 餐廳快照
- 距離計算
- 餐廳不足處理

## Capability 3：Recommendation Engine

負責：

- 心情與餐廳類型映射
- 推薦分數
- 排序
- 去重
- 推薦理由
- fallback 文案

## Capability 4：Recommendation Workbench

負責：

- 單頁工作台
- 推薦卡片
- 換一批
- 放寬搜尋
- 命運扭蛋
- 載入與錯誤狀態

## Capability 5：Favorites and Ratings

負責：

- 收藏
- 取消收藏
- 星等
- 再訪意願
- 餐前與餐後心情

## Capability 6：Food Journal

負責：

- 餐點照片
- 餐別
- 餐點項目
- 份量
- 熱量
- 手動修正

## Capability 7：Weekly Insights

負責：

- 心情統計
- 飲食統計
- 推薦成效
- 每週 AI 摘要
- 歷史週報

---

# 八、AI 功能邊界

## OpenAI 適合負責

- 將結構化推薦原因轉成自然語言
- 辨識餐點照片中的可能食物
- 估算熱量區間
- 生成每週摘要
- 將統計結果轉為易讀建議

## OpenAI 不應負責

- 確認餐廳是否真實存在
- 提供即時營業資訊
- 計算精確距離
- 決定 Google 評分
- 取代資料庫統計
- 提供醫療診斷
- 將熱量估算描述為精確值
- 在缺乏資料時自行補造餐廳資訊

---

# 九、專案風險與對策

| 風險                       | 影響                     | 對策                         |
| -------------------------- | ------------------------ | ---------------------------- |
| Google Places API 費用增加 | 開發與展示成本上升       | 快取結果、限制搜尋頻率       |
| API 回傳餐廳不足           | 無法固定顯示三間         | 分階段放寬距離與條件         |
| OpenAI 回應不穩定          | 推薦文案或 JSON 解析失敗 | Schema 驗證與 fallback       |
| 照片熱量估算不準           | 使用者誤解               | 顯示區間、信心與聲明         |
| 使用者拒絕位置權限         | 無法取得附近餐廳         | 提供手動地址輸入             |
| 餐廳資料重複               | 推薦品質下降             | 使用 place_id 去重           |
| 單頁功能過多               | 使用體驗混亂             | 使用分區、步驟狀態與漸進揭露 |
| 個資與照片外洩             | 隱私風險                 | 權限隔離、私有媒體與刪除機制 |

---

# 十、最推薦的實作順序

第一輪先完成真正能展示核心價值的部分：

```text
1. Django 專案初始化
2. 心情與用餐條件表單
3. 取得使用者位置
4. Google Places API
5. 推薦評分函式
6. 顯示三間餐廳
7. 餐廳不足與放寬搜尋
8. 換一批
9. 命運扭蛋
```

第二輪建立使用者資料：

```text
10. 帳號系統
11. 收藏
12. 星等與餐後回饋
13. 心情歷史
```

第三輪才導入較高風險的 AI 功能：

```text
14. 餐點照片上傳
15. AI 餐點辨識
16. 熱量區間估算
17. 使用者修正
18. 每週統計
19. AI 每週摘要
```

---

# 十一、建議的 MVP Definition of Done

MoodFood AI 的 MVP 只有在符合以下條件時才算完成：

- 使用者可輸入心情、動機、價位與距離
- 可取得位置或手動輸入地點
- 可取得 Google Places 即時餐廳資料
- 正常情況顯示三間餐廳
- 每間餐廳具有合理推薦原因
- 結果不足時可明確放寬搜尋
- 可換一批且不重複
- 可使用命運扭蛋選出餐廳
- 可收藏與評分
- API 失敗時頁面不會崩潰
- 核心規則具有自動化測試
- 手機與桌面瀏覽器皆可正常操作

---

# 十二、專案核心原則

1. **先用規則完成可解釋推薦，再加入 AI。**
2. **餐廳事實資料必須來自 Google Places，不由 AI 生成。**
3. **OpenAI 主要負責語言、圖片理解與摘要。**
4. **所有 AI 結果都需要驗證、fallback 與不確定性說明。**
5. **先完成用餐決策閉環，再建立飲食分析。**
6. **每一個 Phase 都應該可以獨立測試與展示。**
7. **每次 Change 只處理一個清楚、可驗收的能力。**
8. **不要讓 OpenSpec 變成文件堆積，規格必須直接對應測試與程式行為。**

# MoodFood AI｜四方共同規劃版

## 一、四個角色先提出不同意見

### 1. 專業工程師的觀點

專業工程師最在意的不是功能數量，而是：

- 核心流程能否穩定運作
- Google Places 與 OpenAI 中斷時是否仍可使用
- 餐廳資料是否可靠
- 功能之間是否存在清楚依賴關係
- 測試是否能證明系統有效
- 是否花太多時間做低價值功能

工程師的核心建議：

> 第一版不要一開始就做完整帳號、飲食管理、複雜個人化與大量圖表。先證明「心情能改變推薦結果」，再逐步增加功能。

---

### 2. 資深饕客的觀點

饕客不會因為系統寫了一段漂亮文案，就相信推薦真的好。

饕客在意的是：

- 為什麼推薦這一間
- 三間餐廳是否真的有差異
- 是否只會推薦高評分熱門店
- 能不能找到特色小店
- 是否考慮評論數、評分可信度及營業狀態
- 「疲累」「療癒」「想冒險」是否真的產生不同結果
- 推薦理由是否具體，而不是空泛形容詞

饕客的核心建議：

> 推薦結果必須具有「選擇理由」與「差異性」，不能只是從附近餐廳中隨機挑三間，再讓 AI 補文案。

---

### 3. 成功餐飲老闆的觀點

餐飲老闆關心的是系統會不會真正帶來顧客，而不是只有漂亮介面。

老闆在意：

- 使用者最後有沒有真的前往餐廳
- 哪一類心情最容易轉換成到店
- 哪些推薦理由最有效
- 是否總是偏向連鎖、高評分或評論數多的餐廳
- 新店、小店是否有曝光機會
- 系統是否可能顯示錯誤營業資訊
- 推薦是否可能傷害餐廳形象
- 未來是否能提供餐廳端價值

老闆的核心建議：

> 不要只追蹤「使用者看了什麼」，還要記錄「使用者最後選了什麼、是否真的前往、是否願意再訪」。

但第一版不必開發餐廳老闆後台。

---

### 4. 產品負責人的觀點

產品負責人需要平衡：

- 必須有明確核心價值
- 必須能準時完成
- 必須有 AI 亮點
- 展示時必須容易理解
- 功能不能過度分散

產品核心主張：

> MoodFood AI 不是飲食健康平台，也不是另一個 Google Maps，而是「依照當下情境，幫助使用者在幾分鐘內完成用餐決策」。

---

# 二、四方共同確認的核心問題

MoodFood AI 第一版只需要證明三件事：

## 問題一：能否減少選擇困難？

系統不提供幾十間結果，只提供三間具有明確差異的選擇。

## 問題二：心情是否真的影響推薦？

同一個地點，選擇不同心情，結果或排序應該發生合理變化。

## 問題三：推薦是否能轉換成實際決策？

使用者應能：

```text
看到推薦
→ 比較三間
→ 換一批或放寬條件
→ 使用命運扭蛋
→ 選擇其中一間
→ 開啟地圖並前往
→ 用餐後留下簡單回饋
```

只要先把這三件事做好，專案就已經具有完整價值。

---

# 三、重新排序後的開發原則

不單純按照「簡單到困難」排序，而是使用四項指標：

| 指標       | 說明                                   |
| ---------- | -------------------------------------- |
| 核心重要性 | 沒有此功能，專案是否仍然成立           |
| 展示效果   | 成果發表時是否容易讓人理解與記住       |
| 開發成本   | 所需時間、整合難度與錯誤風險           |
| 長期價值   | 是否能累積資料、改善推薦或產生商業價值 |

開發順序採用：

> 高重要性、高展示效果、低至中等成本優先；高成本但價值不明確者刪除或延後。

---

# 四、建議保留的六個 Phase

## Phase 1：可互動的推薦原型

### 目的

先建立完整畫面與使用流程，不急著串接外部 API。

### 功能

- 單頁推薦工作台
- 五種心情
- 四種用餐動機
- 價位選擇
- 距離選擇
- 使用假餐廳資料顯示三張推薦卡
- 推薦原因
- 選擇餐廳按鈕
- 手機與桌面版布局

### 為什麼第一個做

工程師認為這能先驗證：

- 操作流程是否順暢
- 使用者是否看得懂心情與動機的差別
- 三張卡片資訊是否過多
- 單頁工作台是否適合手機

饕客則可以先檢查：

- 推薦理由是否具體
- 三間餐廳是否有區別
- 資訊是否足夠做決策

### 不做

- 登入
- 真實 API
- AI
- 收藏
- 資料統計

### 完成標準

使用者可以在一分鐘內完成：

```text
選擇心情
→ 設定條件
→ 查看三間餐廳
→ 選擇其中一間
```

### 評估

- 難度：低
- 重要性：高
- 展示效果：中
- CP 值：非常高

---

## Phase 2：Google Places 即時推薦引擎

### 目的

把原型變成真正可用的附近餐廳推薦系統。

### 功能

- 瀏覽器定位
- 手動輸入地點
- Google Places API
- 取得營業狀態、評分、評論數、地址、照片與價位
- 距離計算
- 資料清理
- 重複餐廳排除
- 推薦分數計算
- 顯示三間餐廳
- 一鍵開啟 Google Maps

### 四方共同認為這是最重要的 Phase

工程師觀點：

- 這是系統核心資料來源。
- 必須先處理 API timeout、配額與空結果。

饕客觀點：

- 只按距離與評分排序不夠。
- 推薦結果必須有差異。

老闆觀點：

- 不應永遠只推薦評論數最多的連鎖店。
- 需要保留優質小店的曝光機會。

### 推薦結果多樣性規則

三間餐廳不能只是排序前三名，建議分成：

1. **最符合目前需求**
2. **最穩妥的熱門選擇**
3. **具有探索感的特色選擇**

例如：

```text
第一間：距離最近且符合「疲累、快速解決」
第二間：評分與評論數較可靠
第三間：稍遠一點，但料理特色更明顯
```

### 推薦分數建議

```text
基礎適合度
＝距離
＋價格符合度
＋評分可信度
＋心情匹配
＋用餐動機匹配
＋營業狀態
```

另外加入：

```text
多樣性調整
＋特色店探索分數
－同類型重複懲罰
```

### 完成標準

- 同一位置可取得真實餐廳
- 正常情況提供三間推薦
- 三間不完全相同類型
- 餐廳資料來自 Google Places
- 推薦排序由後端規則決定
- API 失敗時有明確替代訊息

### 評估

- 難度：中
- 重要性：最高
- 展示效果：高
- CP 值：最高

---

## Phase 3：心情推薦的可解釋性

### 目的

證明 MoodFood AI 與一般附近餐廳搜尋不同。

### 功能

- 心情轉換成可計算的推薦偏好
- 用餐動機映射
- 結構化推薦理由
- OpenAI 將結構化理由轉為自然語言
- OpenAI 失敗時使用規則式文案
- 顯示「為什麼適合你」
- 顯示「可能的取捨」

### 推薦理由必須包含事實

不好的理由：

> 這是一間很療癒、很適合你的餐廳。

好的理由：

> 你目前選擇「疲累」與「快速解決」。這間餐廳距離約 450 公尺，目前營業中，價位符合你的設定，而且屬於能快速完成用餐的麵食類型。

### 加入饕客要求的「取捨說明」

例如：

> 距離稍遠，但評分與評論數較穩定，適合你想犒賞自己的情境。

或：

> 評論數不算多，但距離近，而且料理類型與你想嘗試新口味的需求相符。

### AI 的正確角色

OpenAI 可以負責：

- 語言表達
- 將規則資料整理成自然推薦文案
- 根據情境產生較有溫度的說明

OpenAI 不負責：

- 捏造餐廳特色
- 判斷餐廳是否存在
- 自行修改營業資訊
- 直接決定餐廳排名

### 驗收測試

在相同位置、價位與距離下：

```text
疲累＋快速解決
```

與：

```text
想冒險＋嘗試新口味
```

應產生不同排序或不同餐廳組合。

### 評估

- 難度：中
- 重要性：最高
- 展示效果：非常高
- CP 值：非常高

---

## Phase 4：決策完成工具

### 目的

解決使用者看到三間推薦後，仍然無法選擇的問題。

### 功能

- 換一批
- 同一工作階段避免重複
- 放寬搜尋
- 命運扭蛋
- 最終選擇確認
- 開啟 Google Maps
- 紀錄使用者最後選擇

### 4.1 換一批

規則：

- 保留原搜尋條件
- 排除已顯示餐廳
- 不可一直循環出現相同結果

### 4.2 放寬條件

建議順序：

```text
先放寬距離
→ 再放寬價位
→ 最後降低料理類型限制
```

系統必須明確顯示：

> 原條件只找到一間餐廳，建議將距離由 1 公里放寬到 2 公里。

### 4.3 命運扭蛋

四方共同決定保留，但不要過度開發。

第一版：

- 從前三名或前五名合格餐廳抽選
- 不需複雜機率模型
- 使用簡單動畫
- 顯示抽中的理由
- 使用者仍可重新抽選一次

### 4.4 最終選擇

這是餐飲老闆最重視的資料。

需要記錄：

- 使用者看過哪些餐廳
- 最後選擇哪一間
- 使用了換一批、放寬條件還是扭蛋
- 是否開啟地圖

這些資料比單純瀏覽次數更有價值。

### 評估

- 難度：低至中
- 重要性：高
- 展示效果：最高
- CP 值：最高

---

## Phase 5：用餐回饋與簡單個人化

### 目的

讓系統從一次性推薦，進化成具有學習能力的產品。

### 保留功能

- 收藏餐廳
- 1～5 星評分
- 是否實際造訪
- 是否願意再次造訪
- 餐後心情
- 一句簡短回饋
- 查看過去選擇

### 為什麼要加入餐後心情

MoodFood AI 的特色不是一般餐廳星等，而是：

> 這間餐廳是否真的改善了使用者當下的用餐情境與心情。

例如：

```text
用餐前：壓力大
用餐後：放鬆
餐廳評分：4 星
願意再訪：是
```

這比單純「餐廳好不好吃」更符合專案主題。

### 簡單個人化

第一版只用規則加權：

- 曾經評分較高的料理類型加分
- 願意再訪的類型加分
- 多次略過的類型減分
- 不喜歡的價位或距離減分
- 特定心情下成功改善心情的料理類型加分

### 不做複雜模型

不做：

- 協同過濾
- 深度推薦模型
- 強化學習
- 大型使用者相似度分析

原因：

- 資料量太少
- 冷啟動嚴重
- 不容易證明比規則式更有效
- 開發成本高

### 評估

- 難度：中
- 重要性：高
- 展示效果：中高
- CP 值：高

---

## Phase 6：AI 餐點照片紀錄

### 目的

形成展示亮點，並讓「餐廳推薦」延伸到「餐後紀錄」。

### 建議只做精簡版本

- 上傳一張餐點照片
- 辨識主要餐點
- 列出可能食物項目
- 顯示熱量範圍
- 顯示辨識信心
- 使用者可修正
- 將照片與本次餐廳選擇連結

### 饕客的要求

不能只輸出模糊結果：

> 這是一份亞洲料理，約 600 大卡。

應盡量拆解：

```text
可能餐點：紅燒牛肉麵
主要內容：
- 麵條
- 牛肉
- 青菜
- 湯底

估計熱量：650～850 kcal
不確定因素：麵量、牛肉份量及湯底油脂
```

### 工程師的要求

- AI 回傳必須使用結構化 JSON
- 必須進行 schema 驗證
- 分析失敗時允許手動輸入
- 圖片大小與格式必須限制
- 不可將 AI 估算描述成精確數值

### 老闆的觀點

此功能對餐廳老闆的直接價值有限，但對展示很吸睛，因此應：

- 保留
- 縮小
- 放後期
- 不可影響核心推薦功能完成

### 評估

- 難度：高
- 重要性：中
- 展示效果：最高
- CP 值：中高，但必須控制範圍

---

# 五、建議刪除或延後的功能

## 1. 完整健康管理

刪除：

- BMI
- 減重目標
- 每日營養目標
- 醫療建議
- 蛋白質、脂肪、碳水精密分析
- 飲食警告

理由：

- 偏離核心主題
- 容易涉及健康風險
- 照片無法提供足夠精確資訊
- 開發與驗證成本高

---

## 2. 複雜每週 AI 報告

原方案包含太多圖表與分析，建議不做完整版本。

最多保留簡化洞察：

- 最常出現的心情
- 最常選擇的料理
- 哪些料理較容易改善餐後心情
- 推薦到實際選擇的轉換率

不做：

- 大量儀表板
- PDF 報告
- 每日營養管理
- 複雜趨勢預測

---

## 3. Google Login 前期開發

開發初期使用 Django 帳號或測試帳號。

Google Login 放在部署前處理。

理由：

- 不影響核心價值
- 展示效果低
- OAuth 設定可能消耗時間

---

## 4. 餐廳老闆後台

第一版不做餐廳端帳號與後台。

未來若產品化，可加入：

- 店家認領
- 餐廳資料修正
- 心情情境標籤
- 推薦轉換統計
- 優惠活動

目前直接使用 Django Admin 即可。

---

## 5. 餐廳訂位與外送下單

刪除：

- 訂位
- 點餐
- 付款
- 外送平台整合

理由：

- 第三方整合成本高
- 偏離核心研究問題
- 展示價值不成比例
- 涉及更多交易與責任問題

---

## 6. 過多心情與用餐動機

### 心情保留五種

- 開心
- 疲累
- 壓力大
- 難過
- 想冒險

### 用餐動機保留四種

- 快速解決
- 犒賞自己
- 與人聚餐
- 嘗試新口味

未來再依使用資料增加。

---

# 六、四方共同同意的優先順序

| 順序 | Phase                   |   重要性 | 展示效果 |   難度 | 結論           |
| ---- | ----------------------- | -------: | -------: | -----: | -------------- |
| 1    | 可互動推薦原型          |       高 |       中 |     低 | 立即做         |
| 2    | Google Places 即時推薦  |     最高 |       高 |     中 | 核心必做       |
| 3    | 心情映射與推薦理由      |     最高 |     很高 |     中 | 差異化必做     |
| 4    | 換一批、放寬、扭蛋      |       高 |     最高 | 低至中 | 高 CP 必做     |
| 5    | 最終選擇與地圖轉換紀錄  |       高 |       高 |     低 | 必做           |
| 6    | 收藏、評分、餐後心情    |       高 |     中高 |     中 | 建議做         |
| 7    | 簡單個人化加權          |     中高 |       高 |     中 | 有資料後做     |
| 8    | AI 餐點照片辨識         |       中 |     最高 |     高 | 展示加分       |
| 9    | 簡化版每週洞察          |       中 |     中高 |     中 | 最後有餘力再做 |
| 10   | Google Login 與正式部署 | 發布必要 |       低 |     中 | 最後處理       |

---

# 七、推薦的實際版本切分

## Version 0.1：操作原型

完成：

- 單頁工作台
- 心情與用餐動機
- 假資料三間推薦
- 推薦卡片
- 手機版介面

展示重點：

> 使用者如何從不知道吃什麼，完成第一次選擇。

---

## Version 0.2：真實即時推薦

完成：

- 定位
- Google Places
- 推薦分數
- 三間多樣化推薦
- Google Maps

展示重點：

> 推薦來自真實世界資料，不是預先寫死的餐廳。

---

## Version 0.3：MoodFood 核心差異化

完成：

- 心情映射
- 用餐動機映射
- 可解釋推薦理由
- 不同情境產生不同結果

展示重點：

> 相同位置，因心情與需求不同，推薦也會改變。

---

## Version 0.4：決策完成體驗

完成：

- 換一批
- 去重
- 放寬搜尋
- 命運扭蛋
- 最終選擇
- 開啟地圖

展示重點：

> 系統不是只列出餐廳，而是真的幫助使用者做完決定。

---

## Version 0.5：回饋閉環

完成：

- 收藏
- 星等
- 是否造訪
- 是否再訪
- 餐後心情
- 簡單個人化

展示重點：

> 推薦結果會隨著使用者回饋逐步改善。

---

## Version 0.6：AI 視覺亮點

完成：

- 餐點照片
- AI 餐點辨識
- 熱量範圍
- 使用者修正

展示重點：

> 從餐前推薦延伸到餐後紀錄，形成完整使用流程。

---

# 八、最推薦的成果展示流程

## 場景一：疲累的上班日

```text
心情：疲累
動機：快速解決
預算：NT$200～400
距離：1 公里
```

系統推薦三間：

- 最近且快速
- 評價最穩定
- 稍有特色但仍符合條件

---

## 場景二：結果不足

系統只找到一間。

顯示：

> 目前 1 公里內只有一間符合條件的餐廳。是否將距離放寬至 2 公里？

使用者同意後補足結果。

---

## 場景三：仍然無法決定

使用者點選命運扭蛋。

系統從合格候選餐廳中選出一間，並說明：

> 這間距離不遠、目前營業中，而且符合你今天想快速解決的需求。

---

## 場景四：實際選擇

使用者按下「就吃這間」，系統：

- 記錄最終選擇
- 開啟 Google Maps
- 保留本次推薦情境

---

## 場景五：餐後回饋

使用者記錄：

```text
實際造訪：是
評分：4 星
餐後心情：比用餐前放鬆
願意再訪：是
```

---

## 場景六：AI 餐點照片

使用者上傳照片。

AI 回傳：

```text
可能餐點：雞腿便當
估計熱量：700～900 kcal
辨識信心：中等
```

使用者可以修正後儲存。

---

# 九、四方最後的共同結論

## 專業工程師

> 先做可靠的推薦與錯誤處理，再做 AI 視覺功能。系統即使沒有 OpenAI，也必須能完成餐廳推薦。

## 資深饕客

> 三間推薦必須有差異，而且推薦理由要來自可驗證資訊。不要用華麗文字掩蓋普通的排序結果。

## 成功餐飲老闆

> 真正有價值的資料不是瀏覽量，而是使用者最後選擇了哪間、是否前往、是否願意再訪。

## 產品負責人

> 第一版集中完成「心情輸入—三間推薦—完成決策—餐後回饋」。照片辨識是加分功能，不應拖延核心系統。

---

# 十、建議正式採用的精簡主線

```text
Phase 1
互動原型

Phase 2
真實餐廳資料與三間推薦

Phase 3
心情情境與可解釋推薦

Phase 4
換一批、放寬條件與命運扭蛋

Phase 5
最終選擇、收藏與餐後回饋

Phase 6
簡單個人化

Phase 7
AI 餐點照片紀錄

Phase 8
簡化洞察與正式部署
```

專案主軸固定為：

> 心情與情境輸入
> → 三間具有差異性的餐廳推薦
> → 幫助完成最終決策
> → 記錄實際用餐結果
> → 逐步改善後續推薦
