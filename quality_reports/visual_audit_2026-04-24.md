Agent completed. agent_id: visual-audit, agent_type: storyteller-critic, status: completed, description: Visual audit all 18 lecture slides, elapsed: 632s, total_turns: 0, duration: 480s

Now I have enough information to compile the full audit. Note that my critical operating instructions prohibit writing output to files — I cannot save to `quality_reports\visual_audit_2026-04-24.md`. I am returning the full report in this response. You should paste/save it yourself.

---

# Talk Review — Visual Audit: ECO 2203 "International Trade and Policy in Agriculture"
**Date:** 2026-04-24
**Reviewer:** storyteller-critic
**Format:** Quarto RevealJS HTML + Beamer PDF (Metropolis 16:9)
**Lectures audited:** 18 (Lecture01–Lecture18)

> **⚠️ File-write notice:** My operational rules prohibit writing output to disk. Copy this report and save it yourself to `D:\Teaching\international trade\quality_reports\visual_audit_2026-04-24.md`.

---

## Cross-Cutting Findings (apply to all lectures)

| Issue | Severity | Scope |
|-------|----------|-------|
| `knitr::opts_chunk$set(echo = knitr::is_html_output())` in every setup chunk | ✅ CORRECT | All 18 |
| `code-fold: true` + `code-summary: "Show R code"` in RevealJS YAML | ✅ CORRECT | All 18 |
| All R `fig-cap` entries include `Source:` attribution | ✅ CORRECT | All 18 |
| **No backup/appendix slides in any lecture** | ❌ MISSING | All 18, −5 each |
| **`scrollable: true` absent from RevealJS YAML** | ❌ MISSING | L10, L11, L12, L13, L14, L15 — overflow text will not scroll in browser |
| ASCII-art tree diagrams placed in ` ``` ``` ` code fences | ⚠️ WARNING | L13, L14, L18 — Beamer renders these in `\verbatim` monospace; use `:::` divs or tikz instead |

---

## Lecture 01: Introduction to International Trade
**Score: 92/100**

### OVERFLOW FRAMES (must fix)
- **Frame "Recent Trade Policy Highlights"**: 5 main numbered bullets, each with 1–2 sub-bullets, plus a 3-item "Agricultural trade–specific provisions" section, plus a `.keybox` — all in a single column. Likely 35+ lines of text in Beamer.
  → **Fix:** Split into two slides: `"FTP 2023–28: Five Pillars"` (numbered list) and `"Agriculture-Specific FTP Provisions"` (3 bullets + keybox).

### OTHER ISSUES
- **Missing backup slides** → add at end (−5)
- "Course Roadmap: 18-Lecture Schedule" has `.smaller` class but 18 table rows — monitor for very small font on projector (borderline).
- "Key Definitions" (BoP + exchange rate slide): two columns, each with 3 sub-sections and ~6 bullet items — borderline dense; could trim 2 bullets per column to speaker notes.

### Score Breakdown
- Starting: 100
- "Recent Trade Policy Highlights" overflow: −3
- Missing backup slides: −5
- **Final: 92/100**

---

## Lecture 02: Features of International Trade
**Score: 92/100**

### OVERFLOW FRAMES (must fix)
- **Frame "Advantages of International Trade for India"**: 7 numbered bullets (4 in left column, 3 in right) — the right column's item 5–7 have sub-items with long text.
  → **Fix:** Move items 6–7 to speaker notes; retain 5 concise bullets max.

### OTHER ISSUES
- "Internal vs International Trade: Key Differences" table (8 rows × 2 cols) uses `.smaller` → acceptable.
- **Missing backup slides** → −5.
- "Government Policy in Agricultural Trade" has 3 items per column with parenthetical detail — borderline; keep as-is given `.scrollable: true` in YAML.

### Score Breakdown
- Starting: 100
- "Advantages" overflow: −3
- Missing backup slides: −5
- **Final: 92/100**

---

## Lecture 03: Theories I (Mercantilism & Absolute Advantage)
**Score: 82/100**

### OVERFLOW FRAMES (must fix)
1. **Frame "The Colonial Trade System: India's Experience"**: Left column has ~10 bullet items (EIC background, drain theory, primary prices, deindustrialisation, famine, silver drain — each with 1–2 sub-items). Right column has a large `.highlightbox` quoting Naoroji + 3 data items. Will definitely overflow Beamer vertically.
   → **Fix:** Split into `"Colonial Trade: The Institutional Structure"` and `"The Drain of Wealth (Naoroji): Evidence"`.

2. **Frame "Neo-Mercantilism Today"**: Left column contains 4 major bullet groups (export-led growth, industrial policy, China model, currency management), each with 2–3 sub-items. Right column has a `.highlightbox` with a long critical analysis paragraph.
   → **Fix:** Split into `"Neo-Mercantilism: Export-Led Development Strategies"` and `"The China Question: Mercantilism or Development Strategy?"`. Move critical analysis to speaker notes.

3. **Frame "Limitations of Absolute Advantage Theory"**: 8 numbered points (4 per column), each with 2–3 lines of text. Very dense for a 16:9 frame.
   → **Fix:** Apply `.smaller` class to slide. Or split into `"Theoretical Limitations (1–4)"` and `"Practical Limitations (5–8)"`.

### OTHER ISSUES
- "Mercantilism vs Smith: Policy Implications" 8-row table uses `.smaller` — borderline; test on projector.
- **Missing backup slides** → −5.

### Score Breakdown
- Starting: 100
- "Colonial Trade System" overflow: −3
- "Neo-Mercantilism Today" overflow: −3
- "Limitations of Absolute Advantage" overflow: −3
- Missing backup slides: −5
- **Final: 86/100**

---

## Lecture 04: Comparative Advantage (Ricardian Model)
**Score: 95/100**

### OVERFLOW FRAMES (must fix)
- None identified. Slides are well-structured with appropriate column splits and figure placement.

### OTHER ISSUES
- "Key Assumptions of the Ricardian Model" — 6-row table is clean.
- "Utility Maximisation Under Trade" — two equations + a 4-step numbered list on one slide; monitor for projector but acceptable at 16:9.
- **Missing backup slides** → −5.

### Score Breakdown
- Starting: 100
- Missing backup slides: −5
- **Final: 95/100**

---

## Lecture 05: Modern Theory (Heckscher-Ohlin)
**Score: 79/100**

### OVERFLOW FRAMES (must fix)
1. **Frame "H-O, Lewis, and India's Agricultural Exports"**: The right column shows "India's agricultural export surge **(FY2024)**" with the figure **\$53.1 billion** — but $53.1B was the **FY2022 record**. The correct FY2024 figure is **$43.7B** (confirmed in L10, L18, APEDA data). Other sub-items (rice $10.4B before export ban, marine $7.8B, spices $4.3B) also reflect FY2022 levels, not FY2024.
   → **Fix (CRITICAL — numbers do not match source data):** Update all values to FY2024 actuals. Change heading to `"FY2022 Record Year"` if that's the intended reference, or update figures to FY2024.

2. **Frame "Explanations for the Leontief Paradox"**: 5 explanations across 2 columns; left column has 3 long explanations with equations, right column has 2 + "Modern verdict" paragraph.
   → **Fix:** Move explanation 3 (Natural resource abundance) and 4 (Demand bias) to speaker notes; show only concise 1-sentence versions on slides. Apply `.smaller` class.

3. **Frame "Lewis (1954): Structural Transformation"**: Left column has formal model with 3 equations + 5 bullet items. Right column has "Implications for agri trade" with 4 items and a formula. Two columns both at near-maximum capacity for 16:9 Beamer.
   → **Fix:** Move the 4 implication bullets to speaker notes; keep only the diagram reference and 2 key take-aways.

### OTHER ISSUES
- **Missing backup slides** → −5.
- `fig-rybczynski` code generates R plot inline — sourced correctly.

### Score Breakdown
- Starting: 100
- Numbers don't match source (H-O, Lewis slide): −20
- "Explanations for Leontief Paradox" overflow: −3
- "Lewis (1954)" overflow: −3
- Missing backup slides: −5
- **Final: 69/100**

---

## Lecture 06: Terms of Trade
**Score: 85/100**

### OVERFLOW FRAMES (must fix)
1. **Frame "The Prebisch-Singer Hypothesis"**: Left column: theoretical explanation with 4 reasons (each a sub-heading with 2–3 sentence explanation) plus a boxed formula. Right column: empirical evidence section with 3 sub-items + `.methodbox` with India data table. Total content will overflow Beamer vertically.
   → **Fix:** Split into `"Prebisch-Singer: Theoretical Foundations"` (left column content only) and `"Prebisch-Singer: Evidence and India's Experience"` (right column + India data).

2. **Frame "Arguments Against Free Trade in Agriculture"**: Left column lists 4 economic arguments (each with an example in parentheses + "Agriculture's special status in WTO" section with 3 more items). Right column has a large `.keybox` with 4 "non-economic arguments" (items 5–8) plus a `.highlightbox` with India's tariff stance. Total: 8 numbered arguments + 2 boxes.
   → **Fix:** Split into `"Economic Arguments Against Free Trade"` (left column, items 1–4 + WTO note) and `"Non-Economic and Political Arguments"` (right column keybox + India highlightbox).

### OTHER ISSUES
- "India and Free Trade: A Mixed Record" — two columns with a methodbox header + liberalized/protected lists + tariff table + keybox → borderline; `.scrollable: true` in YAML saves this for RevealJS but not Beamer.
- **Missing backup slides** → −5.

### Score Breakdown
- Starting: 100
- "Prebisch-Singer" overflow: −3
- "Arguments Against Free Trade" overflow: −3
- Missing backup slides: −5
- **Final: 89/100**

---

## Lecture 07: Protectionism I (Tariffs)
**Score: 89/100**

### OVERFLOW FRAMES (must fix)
1. **Frame "The Case for Protection"** (location: Part II section header area): 6 numbered items without a column split. Each item has 2–3 lines of text with parenthetical examples. In Beamer 16:9 at base_size 11, 6 multi-sentence bullets will overflow vertically.
   → **Fix:** Add `.smaller` class, OR move items 5–6 to a second slide `"Case for Protection (cont.)"`, OR split into two columns (1–3 left, 4–6 right).

### OTHER ISSUES
- "Tariff vs Quota: Similarities and Differences" — 7-row table is large. Has no `.smaller` class but columns are narrow (3 cols). Monitor on projector.
- "India's Agricultural Tariff Structure" — two-column layout with bound/applied table (3-row) and selected items table (5-row). Clean.
- **Missing backup slides** → −5.

### Score Breakdown
- Starting: 100
- "The Case for Protection" overflow: −3
- Missing backup slides: −5
- **Final: 92/100**

---

## Lecture 08: Protectionism II (Subsidies, Dumping, VERs)
**Score: 89/100**

### OVERFLOW FRAMES (must fix)
1. **Frame "International Commodity Agreements (ICAs)"**: Contains two tables stacked vertically (Instruments table 3-row + Historical ICAs table 4-row) plus bullet content in a two-column layout with an additional `.highlightbox` below. Total visual elements will overflow Beamer.
   → **Fix:** Move the "Historical ICAs and their fate" table to a new slide `"History of International Commodity Agreements"`. Keep instruments table + conditions on the first slide.

### OTHER ISSUES
- "Types of Dumping" — 3 types split across two columns; right column has a `highlightbox` on "Arbitrage prevention". Dense but manageable with `.smaller`.
- "MSP, FCI, and the Peace Clause" — two columns each with dense text. In-frame `.methodbox` on Peace Clause is long. Borderline; acceptable under `.scrollable: true`.
- The Rice MSP table (line 344–350) has an asterisk footnote — footnotes in Beamer need `\footnote{}` or speaker notes, not `*` inline. **Flag for Beamer rendering.**
- **Missing backup slides** → −5.

### Score Breakdown
- Starting: 100
- "ICAs" overflow: −3
- Missing backup slides: −5
- **Final: 92/100**

---

## Lecture 09: Balance of Trade & Balance of Payments
**Score: 67/100**

### OVERFLOW FRAMES (must fix)
1. **Frame "Introduction: Why the BoP Matters" — CRITICAL NUMBER MISMATCH**: The slide text states:
   > Merchandise exports: **$778B** | Merchandise imports: **$854B** | Trade deficit: **-$76B** (goods only) → *much larger if oil/gold included: -$238B*
   
   This is internally inconsistent: $778B − $854B = −$76B (correct arithmetic), but the waterfall chart later in the same lecture (`fig-ca-waterfall`) uses **exports = $437B, imports = $677B, deficit = -$238B**, which matches DGCI&S/RBI FY2024 data and is consistent with L01, L10's chart, and L18.
   
   **The $778B figure is wrong.** India's FY2024 merchandise exports were ~$437B (DGCI&S). $778B appears to be merchandise + services trade value, or a copy-paste error.
   → **Fix (CRITICAL):** Change intro slide values to: exports $437B, imports $677B, deficit -$240B. Remove the confusing parenthetical.

2. **Frame "BoP Structure: Three Accounts"**: Left column has Account 1 (CA: 4 sub-items), Account 2 (KA: 2 sub-items), Account 3 (FA: 4 sub-items). Right column has a `.methodbox` with 2 accounting examples (each 4 lines) plus the BoP identity. Total: ~18 text items in a single frame.
   → **Fix:** Split into `"Current Account: Structure"` (Account 1 + 2 in left, accounting rule right) and `"Financial Account: Structure"` (Account 3 + BoP identity box).

### OTHER ISSUES
- "National Income Identity Approach": four separate equations + rearrangement + two boxed results + the `keybox` with India-specific decomposition. Very math-dense. Works in RevealJS (scrollable) but will overflow Beamer.
  → Apply `.smaller` and move India-specific decomposition to speaker notes in Beamer.
- "Official Reserves and RBI Intervention" — 5-row table in left + `.highlightbox` in right with 7 sub-items → borderline.
- **Missing backup slides** → −5.

### Score Breakdown
- Starting: 100
- Numbers don't match source data (exports $778B vs $437B, internal inconsistency): −20
- "Introduction: Why the BoP Matters" overflow (secondary to number issue): no additional deduction
- "BoP Structure: Three Accounts" overflow: −3
- Missing backup slides: −5
- **Final: 72/100**

---

## Lecture 10: India's External Sector
**Score: 79/100**

### OVERFLOW FRAMES (must fix)
1. **Frame "Overview of India's External Sector" — NUMBER MISMATCH**: Slide text says "**Merchandise exports:** $778 billion" — same incorrect figure as L09. The R chart on the very next slide (`fig-export-composition`) titles itself "Total: ~$437B", exposing the contradiction directly within the same lecture.
   → **Fix (CRITICAL):** Change the overview slide value to $437B (consistent with chart and DGCI&S FY2024 data). Also update the subtitle in the Merchandise Export Composition table (which correctly shows $778B total but should say ~$437B).

### OTHER ISSUES
- **Missing `scrollable: true`** in RevealJS YAML — add under `revealjs:` section.
- **Missing `smaller: false`** in RevealJS YAML.
- "Agricultural Exports FY2024" two-column table split (4+4 rows) — clean, no overflow.
- "Agricultural Imports FY2024" — clean.
- **Missing backup slides** → −5.

### Score Breakdown
- Starting: 100
- Numbers don't match (exports $778B vs $437B): −20
- Missing backup slides: −5
- **Final: 75/100**

---

## Lecture 11: Foreign Exchange — Rates and Determination
**Score: 84/100**

### OVERFLOW FRAMES (must fix)
1. **Frame "Appreciation vs Depreciation"**: Left column ("INR Depreciation") has 6 bullet items with emoji icons (✅ ❌), each with 1–2 sentences of explanatory text. Right column ("INR Appreciation") also has 6 bullet items. Total: ~12 substantive bullet items with prose.
   → **Fix:** Apply `.smaller` class to slide, AND move the last 2 items in each column to a new slide `"Exchange Rate Effects: Agriculture Summary Table"` (replacing the prose with a concise 4-row comparison table).

2. **Frame "Determinants Summary Table"**: 8-row × 4-column table with a `.callout-note` block below. The callout box contains a 3-sentence explanation. Borderline for Beamer.
   → **Fix:** Move `.callout-note` to speaker notes for Beamer output. Apply `.smaller` to slide.

### OTHER ISSUES
- **Missing `scrollable: true`** in RevealJS YAML — add to YAML.
- "Limitations of PPP" — 5 numbered items, each with a long paragraph → borderline; works with `.scrollable: true` in RevealJS once added.
- "RBI Intervention in the Forex Market" — two-column layout with a 4-row table + `.keybox` with 5 sub-items — dense but manageable.
- **Missing backup slides** → −5.

### Score Breakdown
- Starting: 100
- "Appreciation vs Depreciation" overflow: −3
- "Determinants Summary Table" + callout: −3
- Missing backup slides: −5
- **Final: 89/100**

---

## Lecture 12: Foreign Exchange Market — Instruments and Policy
**Score: 80/100**

### OVERFLOW FRAMES (must fix)
1. **Frame "Exchange Rate Systems: A Taxonomy"**: A **6-row × 5-column table** (System | Description | Examples | Pros | Cons). In Beamer 16:9, five prose-filled columns will cause severe horizontal overflow — text in the "Description", "Pros", and "Cons" columns will run off the page or be rendered in extremely small font.
   → **Fix:** Split into two slides: `"Exchange Rate Systems (I): Free Float and Managed Float"` showing rows 1–2 with 3 columns (System, Description, India Relevance) and `"Exchange Rate Systems (II): Fixed, Crawling Peg, Currency Board, Union"` for rows 3–6. Drop the `Pros/Cons` columns; move to speaker notes.

2. **Frame "Fixed vs Flexible: Trade-offs for Agricultural Economies"**: Two very long columns (4 ✅/❌ items each with 2-sentence explanations) PLUS a `.methodbox` block below about India's 1991 crisis containing ~120 words of continuous prose.
   → **Fix:** Remove the `.methodbox` "India's 1991 crisis" from this slide entirely — it belongs on the dedicated `"India and the Impossible Trinity"` slide or as a case-study slide. Trim each column to 3 bullets with at most one sub-line each.

3. **Frame "The Impossible Trinity"**: `Statement`, `Mathematical intuition` (paragraph), a `4-line formula block`, a 5-row comparison table AND a `.keybox`. Six distinct visual elements on one slide.
   → **Fix:** Split into `"The Impossible Trinity: Statement and Diagram"` (statement + formula + keybox) and `"The Impossible Trinity: Country Examples"` (5-row table).

### OTHER ISSUES
- **Missing `scrollable: true`** in RevealJS YAML — add.
- "Mundell-Fleming: Policy Effectiveness Summary" — 3-row table + two paragraph blocks — manageable with `.smaller`.
- **Missing backup slides** → −5.

### Score Breakdown
- Starting: 100
- "Exchange Rate Systems" wide table overflow: −3
- "Fixed vs Flexible" overflow: −3
- "Impossible Trinity" overflow: −3
- Missing backup slides: −5
- **Final: 86/100**

---

## Lecture 13: WTO — Origin, Structure and Functions
**Score: 87/100**

### OVERFLOW FRAMES (must fix)
1. **Frame "The Uruguay Round (1986–1994)"**: Right column contains a raw `code block` (triple-backtick fence) listing Uruguay Round achievements:
   ```
    Tariff cuts on industrial goods: ~40%
    Agriculture: brought under discipline
    ...
   ```
   In Beamer, this renders as a `\verbatim` environment in monospace font. It looks unprofessional and is semantically wrong (not code).
   → **Fix:** Replace code fence with a proper bullet list or `:::` div. Use `::: {.methodbox}` or `- item` syntax.

### OTHER ISSUES
- **Missing `scrollable: true`** in RevealJS YAML — add.
- "GATT to WTO: A Brief History" — `.smaller` class applied to slide with 5-row table + two column boxes. Acceptable.
- "WTO at a Glance" — 7-row × 2-col table uses `.smaller` — OK.
- **Missing backup slides** → −5.

### Score Breakdown
- Starting: 100
- Code fence misuse (renders as verbatim in Beamer): −3
- Missing backup slides: −5
- **Final: 92/100**

---

## Lecture 14: Agreement on Agriculture
**Score: 87/100**

### OVERFLOW FRAMES (must fix)
1. **Frame "AoA Structure: The Three Pillars + S&DT"**: Left column contains an **ASCII art tree diagram** inside a triple-backtick code fence:
   ```
   AGREEMENT ON AGRICULTURE
   │
   ├── PILLAR 1: MARKET ACCESS
   │   ├── Tariffication of NTBs
   ...
   ```
   In Beamer, this renders as a `\verbatim` monospace block that is fine for code but is semantically wrong here — it is a **conceptual diagram**, not code. In RevealJS it renders in monospace too.
   → **Fix:** Convert to nested bullet points using `:::` divs and Quarto list syntax, OR use a proper three-column panel layout with `:::columns` for the three pillars. The tree structure adds no value over a clear bullet hierarchy.

### OTHER ISSUES
- **Missing `scrollable: true`** in RevealJS YAML — add.
- "Tariffication: Converting NTBs to Tariffs" — 3-row reduction commitment table + left column explanatory text + right column highlightbox — borderline; `.smaller` applied.
- **Missing backup slides** → −5.

### Score Breakdown
- Starting: 100
- Code fence used for conceptual diagram (not code): −3
- Missing backup slides: −5
- **Final: 92/100**

---

## Lecture 15: SPS Measures and Codex Alimentarius
**Score: 90/100**

### OVERFLOW FRAMES (must fix)
1. **Frame "Three International Standard-Setting Bodies"**: Three-column layout, each column containing a full-height coloured box (`.keybox`, `.methodbox`, `.highlightbox`) with: organisation name, founding date, coverage bullet list (5–8 items), member count, India representation note. All three boxes simultaneously compete for vertical space in Beamer.
   → **Fix:** Convert to two slides: `"Codex Alimentarius and OIE"` (two columns) and `"IPPC and Standards Hierarchy"` (IPPC in left, SPS decision tree in right). Reduce each box to 4 bullet items maximum.

### OTHER ISSUES
- **Missing `scrollable: true`** in RevealJS YAML — add.
- "WTO SPS Agreement: Core Principles" — two columns each with a large box containing 2–3 principles + explanatory text. Dense but structured; `.smaller` would help.
- "Opening Case: MDH-Everest Spice Scandal" — good hook structure; dense right column but within limits.
- **Missing backup slides** → −5.

### Score Breakdown
- Starting: 100
- "Three International Standard-Setting Bodies" overflow: −3
- Missing backup slides: −5
- **Final: 92/100**

---

## Lecture 16: Export Procedures and Documentation
**Score: 87/100**

### OVERFLOW FRAMES (must fix)
1. **Frame "The Ten Key Export Documents"**: Left column lists 6 documents (each with a 2–3 sentence description), right column lists 4 documents (each with a 2–3 sentence description). Total ~10 items with substantive prose. Even with `.scrollable: true` in RevealJS, in **Beamer** this frame will overflow.
   → **Fix:** Split into two slides: `"Export Documents: Proof of Transaction (1–3)"` (Commercial Invoice, Packing List, Bill of Lading) and `"Export Documents: Compliance and Customs (4–10)"` (Certificate of Origin through Shipping Bill). Use a 2-column layout with concise 1-line descriptions; move detailed explanation to speaker notes.

### OTHER ISSUES
- "Letter of Credit: Reducing Counterparty Risk" — 7-step numbered list in left column + LC types table in right column — borderline; acceptable in `.scrollable` RevealJS.
- `scrollable: true` is present in YAML ✅.
- **Missing backup slides** → −5.

### Score Breakdown
- Starting: 100
- "Ten Key Export Documents" overflow (Beamer only): −3
- Missing backup slides: −5
- **Final: 92/100**

---

## Lecture 17: Agricultural Export Promotion Organizations
**Score: 89/100**

### OVERFLOW FRAMES (must fix)
1. **Frame "APEDA: Mandate and Structure"**: Left column contains the scheduled products list as a single continuous paragraph of 14 product groups (separated only by `·` bullets inline), plus a `.keybox`. Right column has a `.methodbox` with APEDA governance details (chairperson, board composition, budget, staff count) and a "Funding mechanism" section. Very text-heavy.
   → **Fix:** Replace the inline dot-list of 14 product groups with "APEDA covers **14 product groups** including fresh produce, processed foods, meat, dairy, cereals, and marine products (see APEDA Act Schedule)." Move the full list to speaker notes. Trim right column `.methodbox` to 4 key facts + table.

2. **Frame "APEDA's Key Functions in Practice"**: Left column has 3 numbered sections (Financial Assistance, Quality Standards, Market Intelligence) with detailed sub-bullets. Right column has a 4-row protocol table plus a `.highlightbox` success story paragraph. ~20 lines of text.
   → **Fix:** Move "Market Intelligence" section (Function 3) to speaker notes. Convert Financial Assistance sub-bullets to 3 items max. This reduces the left column to two sections only.

### OTHER ISSUES
- "The Institutional Architecture" table (10 rows × 3 columns) is clean and manageable.
- `scrollable: true` is present in YAML ✅.
- **Missing backup slides** → −5.

### Score Breakdown
- Starting: 100
- "APEDA Mandate and Structure" overflow: −3
- "APEDA Key Functions" overflow: −3
- Missing backup slides: −5
- **Final: 89/100**

---

## Lecture 18: India's Agricultural Trade and Foreign Trade Policy
**Score: 87/100**

### OVERFLOW FRAMES (must fix)
1. **Frame "The Full Chain: Course Synthesis Diagram"**: The left column uses a triple-backtick code fence to display an ASCII flowchart (`Comparative Advantage → Specialisation → Gains from Trade → ...`). In **Beamer** this renders as `\verbatim` monospace code — looks like programming output, not a conceptual map.
   → **Fix:** Replace the code fence with a proper nested bullet list under a `.methodbox` or `.keybox` div, OR create a proper Quarto diagram using `mermaid` (```{mermaid}```) which renders cleanly in both RevealJS and Beamer.

### OTHER ISSUES
- "Opening Reflection" — left column has a block quote + narrative paragraph; right column has a nested 9-item bullet list inside a `.highlightbox`. The right column list is long but the `.scrollable: true` in YAML handles RevealJS. Beamer is tight but manageable if font size is adequate.
- "India's Agricultural Trade: The Big Picture" — a 3-row comparison table + bullet list + highlightbox → clean.
- `scrollable: true` is present in YAML ✅.
- **Missing backup slides** → −5.

### Score Breakdown
- Starting: 100
- "Full Chain" code fence misuse: −3
- Missing backup slides: −5
- **Final: 92/100**

---

## Summary Score Table

| Lecture | Title | Score |
|---------|-------|-------|
| L01 | Introduction to International Trade | 92/100 |
| L02 | Features of International Trade | 92/100 |
| L03 | Theories I: Mercantilism & Absolute Advantage | 86/100 |
| L04 | Comparative Advantage (Ricardian Model) | 95/100 |
| L05 | Modern Theory: Heckscher-Ohlin | **69/100** ⚠️ |
| L06 | Terms of Trade | 89/100 |
| L07 | Protectionism I: Tariffs | 92/100 |
| L08 | Protectionism II: Subsidies, Dumping, VERs | 92/100 |
| L09 | Balance of Trade & Balance of Payments | **72/100** ⚠️ |
| L10 | India's External Sector | **75/100** ⚠️ |
| L11 | Foreign Exchange — Rates and Determination | 89/100 |
| L12 | Foreign Exchange Market — Instruments and Policy | 86/100 |
| L13 | WTO — Origin, Structure and Functions | 92/100 |
| L14 | Agreement on Agriculture | 92/100 |
| L15 | SPS Measures and Codex Alimentarius | 92/100 |
| L16 | Export Procedures and Documentation | 92/100 |
| L17 | Agricultural Export Promotion Organizations | 89/100 |
| L18 | India's Agricultural Trade and Foreign Trade Policy | 92/100 |

**Aggregate average: 88.2/100**

---

## ⚡ Priority Fix List — Top 10 Overflow/Quality Issues Before April 25

| # | Lecture | Frame Title | Issue | Fix |
|---|---------|-------------|-------|-----|
| 1 | **L09** | "Introduction: Why the BoP Matters" | **CRITICAL:** Slide text cites exports = $778B / deficit = -$76B; same lecture's waterfall chart uses $437B / -$238B. Directly contradictory numbers visible within the same lecture. | Change intro text to: exports $437B, imports $677B, deficit -$240B. Remove parenthetical referencing -$238B as a separate figure. |
| 2 | **L10** | "Overview of India's External Sector" | **CRITICAL:** States "Merchandise exports: $778 billion" — directly contradicted by the chart on the next slide (titled "Total: ~$437B"). | Change to $437B in text slide. Ensure all FY2024 export references are consistent across the deck. |
| 3 | **L05** | "H-O, Lewis, and India's Agricultural Exports" | **CRITICAL DATA ERROR:** Right column labels FY2024 data as "$53.1 billion total agri-food exports" — this is the FY2022 record. FY2024 = $43.7B. Rice sub-item ($10.4B) also reflects pre-ban FY2022 volume. | Either re-label as "FY2022 (Record Year)" or update all sub-figures to FY2024 actuals ($43.7B total, rice $12.2B combined). |
| 4 | **L12** | "Exchange Rate Systems: A Taxonomy" | **HARD OVERFLOW:** 6-row × 5-column table (System, Description, Examples, Pros, Cons). Beamer will clip or reduce to illegible font sizes. | Split into two slides with 3 columns each (drop Pros/Cons to speaker notes). |
| 5 | **L11** | "Appreciation vs Depreciation" | **OVERFLOW:** 14 bullet items with emoji and prose in two columns. | Apply `.smaller` class AND trim to 5+5 items; move excess to `"Exchange Rate Impact: Summary Table"` follow-up slide. |
| 6 | **L03** | "The Colonial Trade System: India's Experience" | **OVERFLOW:** ~10 sub-items in left column + large quote box in right. | Split into two slides: "Colonial Trade: Institutional Context" and "Naoroji's Drain Theory: Data." |
| 7 | **L09** | "BoP Structure: Three Accounts" | **OVERFLOW:** Three full account descriptions (CA, KA, FA) with 4+ sub-items each, plus double-entry accounting examples, all on one frame. | Split into "Current & Capital Account" and "Financial Account & Reserve Changes." |
| 8 | **L16** | "The Ten Key Export Documents" | **OVERFLOW (Beamer):** 10 documents with 2–3 sentence descriptions each across two columns = ~25 lines of text. | Split into two slides (documents 1–5 and 6–10). One-line descriptions only; detail in speaker notes. |
| 9 | **L14** | "AoA Structure: The Three Pillars + S&DT" | **RENDERING BUG:** ASCII art in ` ``` ``` ` code fence renders as `\verbatim` monospace in Beamer — looks like source code. | Replace code fence with proper Quarto nested bullets or a `:::columns` layout for the three pillars. |
| 10 | **L06** | "Arguments Against Free Trade in Agriculture" | **OVERFLOW:** 8 numbered arguments (4 economic + 4 non-economic/political) across two columns, each with parenthetical examples + WTO section + two colour boxes. | Split into "Economic Arguments for Agricultural Protection" and "Food Security and Political Economy Arguments." |

---

## Systemic Recommendations (Apply Before Teaching Starts)

1. **Fix the $778B/$437B data error** in L09 and L10 immediately — students will notice the contradiction within the same lecture session. This is the single most urgent correction.

2. **Add `scrollable: true` to L10, L11, L12, L13, L14, L15 RevealJS YAML** — without it, overflow content in RevealJS is simply invisible during class.

3. **Create a backup slide section** in each lecture (add `## {.appendix}` divider at the end) with 2–4 anticipatable Q&A slides (derivations skipped in class, sensitivity checks, alternative data). The current 0/18 backup slide rate will hurt during any engaged class Q&A.

4. **Replace all ASCII-art code fences** (L13 Uruguay Round achievements, L14 AoA tree, L18 course synthesis chain) with proper Quarto list/`mermaid` syntax — these render unprofessionally in Beamer.

5. **Update L05 FY2022 → FY2024 data** in the H-O/Lewis integration slide before first use — the lecture is currently teaching with stale data that contradicts the FY2024 figures students will see in L10 and L18.