# CV template & content notes

Internal reference for building **job-tailored CVs** from this template. Not part of any CV itself.

- `my-resume.cls` / `my-resume-zh.sty` — originally forked from a GitHub resume template (now deleted — it was an unmodified upstream clone with nothing left referencing it, so it was removed entirely). Fully self-contained: compiles standalone with plain `xelatex` run from this directory, no external dependencies.
- `吴筱琦_英文版.tex` / `吴筱琦_中文版.tex` in this folder — the **master CV**: every experience, not trimmed to any job. Source of truth for a tailoring pass, not something to hand to an employer as-is (it runs longer than 2 pages by design). `吴筱琦_中英合并版.pdf` is the same merge-PDF convention as the tailored directions (see step 9 in the Tailoring workflow below) — Chinese pages followed by English pages, via `pdfunite`; regenerate after any edit to either language.
- `photo.jpg` — ID photo used top-right in the header via `\photoheader`. Reuse this same file path for any tailored CV built in a sibling folder (copy it over, or reference `../template/photo.jpg`).
- **Fonts**:
  - **Latin**: `my-resume.cls` currently sets **Arimo** (a metric-compatible Arial clone) via `\setmainfont{Arimo}`, since real Arial isn't installed on this machine. Real Arial *can* be installed legitimately via Ubuntu's official `ttf-mscorefonts-installer` package (`sudo apt-get install ttf-mscorefonts-installer` — needs a terminal with real sudo access, this sandboxed session doesn't have one). Once installed, change the class to `\setmainfont{Arial}` and recompile.
  - **CJK**: `my-resume-zh.sty` uses **HarmonyOS Sans SC** (Huawei's free-for-commercial-use font) as the Microsoft YaHei substitute — not Noto Sans CJK SC as originally used. Real Microsoft YaHei is a proprietary Windows system font with no legitimate free-download channel, so it was ruled out; HarmonyOS Sans SC was chosen instead because it's explicitly licensed for free embedding/redistribution (see `fonts/HARMONYOS_SANS_LICENSE.txt`, from Huawei Device Co., Ltd., official source: `https://developer.harmonyos.com/cn/docs/design/des-guides/font-0000001157868583`, obtained via the `harmonyos-sans` npm package which mirrors Huawei's own zip) and is visually closer to YaHei's humanist-sans style than Noto Sans CJK SC. Font files (Regular + Bold only, ~16MB) are bundled directly in `fonts/` and loaded by explicit path in `my-resume-zh.sty`, so this folder needs no system font installation to compile. If you ever obtain a real, legitimately-licensed `msyh.ttc`/`msyhbd.ttc` (e.g. from your own Windows/Office install), swap the family name in `my-resume-zh.sty` for `Microsoft YaHei` instead.

## Template usage

Start a new tailored CV as a new `.tex` file, copying the preamble from the master CV in this folder:

```latex
% English
\documentclass{my-resume}
\usepackage{linespacing_fix}
\usepackage{cite}
\begin{document}
...
```

```latex
% Chinese — add my-resume-zh after the class
\documentclass{my-resume}
\usepackage{my-resume-zh}
\usepackage{linespacing_fix}
\usepackage{cite}
\begin{document}
...
```

Compile with `TEXINPUTS=".:":` not required — `my-resume.cls`/`my-resume-zh.sty` are self-contained; just run `xelatex <file>.tex` from the same directory (or pass `-output-directory` to keep a job's folder separate).

### Command cheat-sheet (from `my-resume.cls`)

| Command | Args | Use |
|---|---|---|
| `\photoheader{content}{photofile}{width}` | 3 | Header block: `content` (typically `\name{}` + `\contactInfo{}`) on the left, ID photo on the right at `width` (e.g. `2.6cm`) — both blocks use `minipage[c]` so they're **vertically centered** relative to each other (not top-aligned — a plain `minipage[t]` looked wrong here because the photo is much taller than one line of `\Huge` name text, leaving a large gap above the name). **Chinese CVs only** — see `\headerNoPhoto` below for English |
| `\headerNoPhoto{content}` | 1 | Same header, no photo — `content` rendered full-width. **Used for every English CV** (master and all tailored directions) — a photo isn't customary on English-language/Western-market CVs, so English versions drop it while Chinese versions keep `\photoheader`. Same `content` argument as `\photoheader`'s first argument (`\name{}` + `\contactInfo{}`), just called without the photo file/width args |
| `\name{name}` | 1 | Big bold name, left-aligned (used inside `\photoheader`) |
| `\contactInfo{phone}{email}{location}{tagline}` | 4 | Row 1: dot-free phone/email pair. Location (arg 3) and tagline (arg 4) each render on their own full-width line below — not side by side, that read cramped once the tagline got long. **Location convention**: prefix arg 3 with a label, e.g. `现居城市：伦敦/苏州` (ZH) / `Currently based in: London / Suzhou` (EN). Args 3–4 optional (blank line if empty) — used inside `\photoheader` |
| `\section{title}` | 1 | Bold section heading + rule (e.g. "Education", "Research \& Project Experience") |
| `\entry{org/title}{date}{role/subtitle}{location}` | 4 | **The workhorse command for every entry.** **One line**: bold org/title + role/subtitle on the left, location + date on the right, e.g. "**Shanghai Sunherb Pharmaceutical Technology Co., Ltd.** Analytical Engineer · Analytical Department ⋯⋯ Shanghai 2024.07 - 2024.09". Wrap-safe (`tabularx`): if the combined left-hand text is long, it wraps to a second line rather than jamming into the date. Any arg may be empty (e.g. `{}` for no location) — **in Education/Internship entries, put the degree/role+department in arg 3**; **in Research \& Project Experience entries, leave arg 3 empty and follow with `\role{tools}{}` on its own line instead** (see next row). Arg 3 (role/subtitle) renders at `\fontsize{11.5}{14}\selectfont` — a modest step above the 11pt body text, not full `\large` (12pt read as too big a jump) |
| `\role{tools}{}` | 2 | Used **only in Research \& Project Experience**, directly below an `\entry` whose 3rd arg was left empty — puts the tools/methods list on its own italic line under the project title, rather than crammed onto the entry's single line (project titles are usually already long, so combining title+tools on one line got cramped) |
| `itemize` (via `enumitem`) | — | 1–3 bullets per entry below `\entry`, each starting with `\textbf{Lead-in}: ...` (see Writing-style rule 4 below), `parsep=0.2ex` for tight spacing. Global `topsep=0.1em` keeps every list tight against its `\entry`/`\role` header — **except** the Skills section, which needs its own explicit `\entrySkillsSep` (see next row) since it has no `\entry` above it to naturally create breathing room |
| `\entrySkillsSep` | 0 | Place directly after `\section{Skills \& Other}` / `\section{技能/其他}`, before the `itemize` begins — adds back the gap the global tight `topsep` removes, since the Skills list sits right under a bare section heading rather than under an `\entry`/`\role` line. **Every Skills section in every CV must have this** or its first bullet will look jammed against the heading |
| `\datedsection{title}{date}` | 2 | Legacy: section heading with right-aligned date (rarely needed — sections don't carry dates in this template) |
| `\datedsubsection{title}{date}` | 2 | Legacy one-line heading, kept for backward compatibility — prefer `\entry` for new content since it avoids the `\hfill`-wrap bug (see below) |
| `\datedline{text}{date}` | 2 | Legacy plain left/right-aligned line — same `\hfill`-wrap bug as `\datedsubsection`, avoid for anything that might wrap |

**Known bug avoided by `\entry`**: `\datedsubsection`/`\datedline` use a plain `text \hfill date` pattern, which only right-aligns correctly if `text` fits on one line — if it wraps, the date gets jammed against the last word with no space (e.g. "Florida2025.03"). `\entry` fixes this with a `tabularx` layout (auto-wrapping left column + fixed right column), so long titles wrap safely with the date/location always cleanly separated and right-aligned. Always use `\entry`, not the legacy commands, for anything with a title that might run long. `\role` is not legacy — see the row above, it's still actively used for the Research \& Project Experience tools line.

**Hyphenation / overfull-hbox note**: `my-resume.cls` loads `babel[english]` for hyphenation, but slash-joined compound terms (e.g. `React/TypeScript`, `Python/FastAPI`, `geographic/taxonomic`) still don't get a break point at the `/` by default — English hyphenation only inserts breaks within letter sequences, not around punctuation. If a bullet containing a `/`-joined term causes a large overfull `\hbox` (check the compile log), replace `/` with `\slash` in that specific term (e.g. `Python\slash FastAPI`) rather than rewording the whole bullet.

## Writing-style rules (distilled from `resume template/resume.preview.png` and `resume-zh_CN.tex`)

1. **STAR structure per bullet**: situation/task (what question or problem), action (method + named tools/software), result (quantified outcome or grade/distinction). Not every bullet needs all three, but the strongest lead bullet of an entry should.
2. **Reverse-chronological order** everywhere — most recent/relevant first. When tailoring, the JD's most relevant experience should also physically lead its section, even if not the most recent, but don't break date order within a section — instead choose *which* experiences to include, not reorder them out of sequence.
3. **Bold** org/institution names in `\entry`'s first argument, and standout numbers/superlatives (award tiers, top percentiles) inside bullets. Reserve bold for genuinely impressive, verifiable facts.
4. **Every bullet must start with a bold lead-in phrase + colon** summarizing that bullet's point, e.g. `\item \textbf{Pipeline Design}: Designed and built a reproducible...` — this gives each bullet an immediate "headline" instead of making the reader parse the whole sentence to find the point. Keep the lead-in to 1-3 words (e.g. "Results", "Model Validation", "Outcome", "研究成果", "实验设计"). Vary lead-ins across a single entry's bullets (don't repeat the same word).
5. **1–3 bullets per entry.** More bullets ⇒ trim to the most relevant + best quantified for the target job, don't just shorten each bullet.
6. Skills section: **group under bold category labels** (e.g. `\textbf{Category}: item, item, item`), don't list flat.
7. Lead the Summary paragraph with the single strongest, most job-relevant credential first — this is the one paragraph an employer skims for 5 seconds.
8. **Chinese line-wrap check**: after compiling a Chinese CV, visually check for a lone single character stranded alone on its own line (不要让一个字单独成一行) — CJK justification can produce this on long paragraphs. If spotted, reword slightly (add/remove a character) rather than leaving it, since a single trailing character reads as a typesetting mistake.

### Personal Summary formula (个人总结)

For every job-tailored CV, the Summary must be **freshly written for that JD** — never copy-pasted from the master CV or reused verbatim across applications. Formula: **个人定位 + 核心优势/技能 + 关键成就/经验 + 职业目标/岗位匹配度** (identity/positioning + 2-3 core skills matched to the JD + one standout quantified achievement + motivation/fit for this specific role).

- **Hard cap: 3-4 lines.** An HR reader spends ~30 seconds on this — it must be skimmable, not a full paragraph of every credential.
- **Data over adjectives.** Never write "认真负责/吃苦耐劳/性格开朗" (responsible/hardworking/outgoing) or their English equivalents ("hardworking," "team player," "detail-oriented") without a fact backing it up. Bad: "improved user engagement." Good: "grew followers 50% and article reads 80% in 3 months by planning online interactive campaigns."
- **Skills must match the JD's own keywords**, not a generic skills list — e.g. applying to "user operations" roles means naming "用户生命周期管理/社群运营/活动执行/数据分析," not just "communication skills."
- **Fresh-grad / limited-experience framing**: emphasize learning ability, potential, and transferable soft skills earned through coursework, club/society roles, or volunteering — e.g. "organized 3 100-person campus events as club president, building communication and coordination skills," or "self-taught Python fundamentals and applied them to solve real problems in coursework projects."
- **Experienced-candidate framing**: lead immediately with the strongest "ace card" — quantified experience + skills + results, tied directly to the target role (e.g. sales role → lead with client-facing/quota-attainment results; admin role → lead with process-ownership/efficiency results).
- Never write one summary for every application — the whole point is precise JD matching.

### Section-specific content strategy

- **① Summary/自我评价**: composed of three parts — 教育背景 (1-2 sentences distilling the single most relevant academic highlight, not a transcript), 优势技能 (skills pulled from the JD's own language), 综合素养 (list honors/certificates if there are several; otherwise name 1-2 soft skills that matter for this specific role, e.g. "insight/sensitivity" and "empathy" for a user-operations role).
- **② Internship experience/实习经历**: if there are multiple real internships, lead with the one most relevant to the target role, not the most recent. **The Sunherb Pharma internship (analytical/HPLC) is the only genuine internship in the content bank and must appear in every job-tailored CV**, regardless of direction — it's the sole "formal" work experience. The only other verified internship-adjacent entry is the Jianteng Education tutoring role (2023.07-2023.08) — include it only where genuinely relevant (e.g. client-facing/communication-heavy directions), don't force it into a direction it doesn't fit; it's fine for Internship \& Engagement to be a single-entry section. **A "生物多样性日勺嘴鹬保护行动"/"Biodiversity Day -- Spoon-billed Sandpiper" entry existed in earlier drafts of this CV set and was confirmed fabricated by the user (2026-07-18) — it has been deleted everywhere and must never be reintroduced or reused as a template for "packaging" future entries.**
- **③ Project experience/项目经历**: use a **背景→过程→结果** (background→process→result) narrative for each bullet group, not a flat task list — the goal is for the project to serve as *proof* of problem-solving ability and teamwork, not just a description of what was done.

### STAR + quantification bonus formula ("加分公式")

Applies to every bullet in every section, not just Projects:

- **STAR structure**: Situation/Task (the problem or context) → Action (method + named tools) → Result (quantified outcome). This is the same as Writing-style rule 1 above, restated as the explicit bar to hit on every touched bullet.
- **Quantify the result, don't just state the task.** Don't write "负责什么" (was responsible for X) — write "做成了什么" (achieved X), with a number. Favor strong action verbs: 推动/优化/提升/缩短/对接 ("drove/optimized/improved/cut/coordinated with"). E.g. "优化 XX 流程，将处理时间缩短 20%" or "独立对接 10+ 位合作方，确保项目按时交付."
- **Mine campus/non-formal experience the same way** when a section is thin on real work experience — e.g. reframe "组织校园晚会" (organized a campus show) as "统筹策划 3 场校级活动，协调 20 人团队，累计参与人数超 1500 人" (planned 3 university-wide events, coordinated a 20-person team, reaching 1,500+ attendees). A vague task description earns nothing on a CV; a quantified scope does.

## Formatting rules fixed in this template (apply to every future tailored CV too)

- **Vertical spacing is deliberately tight, between-block only** — line-wrap spacing within a single sentence/bullet (`\baselineskip`) is untouched at its normal value; what's compressed is the space *between* blocks: `\entry`'s leading gap (`0.6ex`), the gap from an `\entry`/`\role` line down to its own bullets (`0pt`, relies on the tight global itemize `topsep=0.1em`), and `\section` heading spacing (`\titlespacing*` at `*0.6`/`*0.4` of default). Don't loosen these back up without a specific reason — the tight spacing is what lets a 1-page Chinese CV hold this much real content.
- **Section rule thickness**: the horizontal rule under each section heading is `\titlerule[0.8pt]` (slightly thicker than titlesec's ~0.4pt default) — note the `{\titlerule[0.8pt]}` must stay wrapped in its own braces inside `\titleformat`'s bracketed argument, or the inner `[0.8pt]` breaks the outer argument parsing (`! Argument of \ttl@rule@i has an extra }` if you get this wrong).
- **Always wrap a bare font-size command in its own `{...}` group** (e.g. `{\large #1}`, not `\large #1`) inside any macro that isn't itself already a self-contained group — `\large`/`\fontsize{}{}\selectfont`/etc. have no inherent scope and will silently leak into every paragraph that follows if the enclosing braces are only TeX argument-grabbing delimiters (as in `\ifthenelse{...}{...}` branches or plain macro bodies) rather than a real group. This bit twice in this template: `\contactInfo`'s `\large` fields leaked `\large` (12pt) into the *entire rest of the document* after the header, and `\entry`'s subtitle `\fontsize{11.5}{14}\selectfont` leaked into every following bullet — both showed up only as small "Overfull \hbox" warnings in the compile log (a few pt each), never as an obvious visual jump, so they're easy to miss without checking the log's reported font size (`.../12` instead of the expected `.../10.95`). Both are now fixed (`{\large #1}` / `{{\fontsize{11.5}{14}\selectfont #3}}`); if you add a new font-size tweak anywhere in `my-resume.cls`, brace it the same way.
- **Header**: name + contact block on the left, ID photo (`photo.jpg`, bundled in this folder) on the right at 2.6cm width, **vertically centered** relative to each other via `\photoheader` (both sides use `minipage[c]`) — **Chinese CVs only**. **English CVs use `\headerNoPhoto` instead — no photo, full-width name/contact block** (not customary on English/Western-market CVs). Contact info is a dot-free 2×2 grid (phone/email, location/tagline) — no `\textperiodcentered` separators between the four fields; if a separator is needed *within* a single field (e.g. joining "target role" and "target cities" in the tagline), use `\textbar` (|), not a dot. Section headers are **bold**, not small-caps.
- **Education/Internship entries are a single line** via `\entry{org/title}{date}{role/subtitle}{location}` — bold org/title + role/subtitle on the left, location + date on the right (wraps to a second line automatically if the combined left text is long, via `tabularx` — never jams into the date). **Research \& Project Experience entries instead leave `\entry`'s 3rd arg empty and put the tools/methods list on its own line via `\role{tools}{}` right below** — project titles are usually already long, so cramming the tools list onto the same line got visually cramped.
- **Every bullet opens with a bold lead-in + colon** (see Writing-style rule 4).
- **Section names**: Education → "教育背景" (ZH) — English stays "Education"; Research & Project Experience → "科研与项目经历" (ZH) / "Research \& Project Experience" (EN); Skills & Other → "技能/其他" (ZH) / "Skills \& Other" (EN). Internship + community/volunteer work stays one blended section, "Internship \& Engagement" (EN) / "实习与社会实践" (ZH) — entries interleaved by date, not grouped by type.
- Education keeps the degree level word (**硕士**/**本科** for Chinese; MSc/BSc already implicit in the English programme name) but drops **"Full-time"/`全日制`** — it's implied and wastes space.
- **Chinese university name**: use **"帝国理工学院 (QS:2)"** instead of appending the English name "(Imperial College London)" — the bilingual form was too long for the single-line `\entry` format, and the QS world-ranking figure signals prestige just as well in less space. Keep this pattern for any other institution when tailoring — a ranking figure instead of a bilingual name, if the institution's ranking is genuinely strong and verifiable.
- **BSc coursework ordering**: the master CV lists coursework in a fixed order (no target job to optimize for). For a job-tailored CV, **reorder the coursework list so the most JD-relevant courses come first** — e.g. "Programming and Statistics, Bioinformatics, ..." first for a data/software role, "Behavioural Ecology, Field Skills in Ecology, ..." first for a field-ecology role.
- **Skills section must be filtered by role relevance, not dumped in full**: the master CV includes every skill category (including wet-lab techniques like Molecular \& Biochemical Techniques) because it's the full content pool. A job-tailored CV should **drop entire categories that don't serve the target role** — e.g. cut "Molecular \& Biochemical Techniques" for a pure data-analysis/software role that has nothing to do with wet-lab work, cut "Python \& Tooling"/"Web Development" for a role with no software component. Keep only the categories the JD would actually care about, reordered so the most relevant leads.
- **Never add a skill to the CV without verified evidence.** The Skills section must reflect what's actually demonstrated in the content bank / project code, not a generic "impressive skills" list. If the user pastes an example skill list (e.g. from someone else's CV, or a style reference), that is a *format example only* — do not copy its content verbatim. Instead: (1) check each item against the actual project experience (read the code/config/dependency files if a software project is involved, not just the README's high-level description), (2) only include items with real evidence, (3) ask the user before adding anything you can't verify, rather than assuming they have it because a reference list mentioned it. Concretely: the VecTraits Curation project's actual `requirements.txt`/installed packages/`llm_client.py` confirm Python, FastAPI, React/TypeScript, pytest, multi-backend LLM clients (Gemini API, Ollama, OpenAI-compatible, HuggingFace), JSON Schema validation, async subprocess orchestration — but do **not** show CrewAI, RAG/Qdrant/BGE/BM25, DeepSeek/Qwen/GLM by name, Streamlit, Vue, Playwright, or SQLite; those were excluded from the CV for lack of evidence, not forgotten. Note: VecTraits Curation is fundamentally a **software/tool-development project** (a full pipeline + evaluation framework + review webapp), not just "a pipeline" — frame it that way when tailoring for software/data-engineering-adjacent roles.
- Languages and Interests are merged onto one bullet line, separated by "；" (ZH) or "|" (EN), e.g. `\textbf{Languages}: ... \textbar\ \textbf{Interests}: ...` — saves a line versus two separate bullets.

## Course bank (for Education → 课程内容/Curriculum)

MSc/MRes modules taken, with fit tags — pick the subset most relevant to the target direction when tailoring rather than always using the same fixed phrase. Not exhaustive; add more as they're confirmed.

| Module (EN) | 中文名（用于中文版CV） | Fit tags |
|---|---|---|
| Statistics in R | R语言统计学 | quant/stats, software |
| Ecological and Evolutionary Data Science | 生态与进化数据科学 | quant/stats, software, field-ecology |
| Biological Computing Bootcamp | 生物计算训练营 | software, quant/stats |
| GIS | GIS（沿用英文缩写，已是中文CV惯例） | field-ecology, quant/stats |
| Genomics | 基因组学 | bioinformatics |
| Bioinformatics | 生物信息学 | bioinformatics |

**中文版CV一律使用中文课程名**（左起第2列），不要直接搬英文模块名——英文版CV则使用官方英文模块名（左起第1列）。

For a software/data/AI-leaning direction, lead the Curriculum bullet with Statistics in R / Ecological and Evolutionary Data Science / Biological Computing Bootcamp (in that order or similar) before GIS/Genomics/Bioinformatics. For a wet-lab/bioinformatics-leaning direction, lead with Genomics/Bioinformatics instead.

## Content bank

One entry per project experience. `Fit tags` are for quick JD matching (quant/stats, wet-lab, bioinformatics, field-ecology, software/LLM, literature-review, modelling). `Private` lines are for triage only — never print a numeric grade on an actual CV; translate strong ones into "distinction"/"high marks" language as the current CV already does, and simply omit mention of grade for average-scoring work.

---

### 0. MRes Dissertation — Evaluating Multimodal LLM Extraction for Vector Trait Curation (2025.12–2026.08, London) — **COMPLETED, submitted 2026-08-18**

**Status**: finalized and submitted. Full title (both CV languages should use this, not the earlier working title): (EN) *"Evaluating Multimodal LLM Extraction for Vector Trait Curation: High Precision with Structure-Dependent Record Recovery"*; (ZH) "多模态大语言模型提取媒介性状数据评估：高精确率与结构依赖型记录召回". Supervisor: Dr Lauren Cator (second reader Prof Samraat Pawar); computational implementation advice from Stanislav Modrak; development benchmark additionally reviewed by Sarah Kelly (One Health VBD Hub Curator). Word count 5,994 (excl. figures/tables/references/appendices).
**Fit tags**: software/LLM, quant/stats, bioinformatics, evaluation/ML-methodology
Full pipeline + rigorous quantitative evaluation, from the finalized dissertation (source PDF in `project experience/`, verified against the text directly, not the earlier in-progress framing):
- **Corpus & benchmark**: selected 20 papers from the VecTraits export (334 paper-level units, 40,000+ rows) via a weighted greedy diversity-selection algorithm (maximizing coverage of trait family, reporting format, dataset source, citation group) — 15 development papers (manually re-curated to a **2,335-record** reference benchmark, reviewed by S. Kelly) + 5 held-out papers (**431-record** benchmark, held out of all prompt development).
- **Schema**: reduced the full 91-column VecTraits schema to a **22-field** extraction schema aligned with the MIReVTD (Minimum Information for Reporting Vector Trait Data) standard.
- **Multimodal extraction pipeline**: PyMuPDF for page-level text extraction (OCR fallback), Docling for table-structure-preserving parsing, table/figure regions rendered at 150 DPI as visual evidence (max 45,000 evidence chars / 12 images per request, split across requests if exceeded) — fed to **Gemma 4 31B IT** (open, instruction-tuned multimodal model, 256K context, accessed via the Gemini API) for schema-constrained JSON record extraction.
- **Prompt iteration**: 11 prompt versions (v1–v11) developed against the dev benchmark; v10 selected (highest dev **conditional macro field F1 = 0.810**) before held-out evaluation.
- **Evaluation framework**: bipartite record matching, then row-set / conditional-field / end-to-end-field metrics, plus qualitative discrepancy/error analysis (document-level omissions vs. field-level disagreement).
- **Held-out (unseen) results for the locked v10 pipeline**: row precision **1.000**, row recall **0.360**, conditional macro field F1 **0.729**, end-to-end macro field F1 **0.394** — i.e. everything the model extracted was correct, but it only recovered a subset of records, and recovery success depended on document structure (table-heavy vs. figure-heavy papers). Conclusion (stated directly in the dissertation): the pipeline is best suited to **generating candidate records for human-in-the-loop curation**, not as a fully automated replacement — field verification and completeness checking stay explicit curation steps.
**Framing note**: earlier CV drafts described this primarily as a software/webapp-build project (FastAPI + React human-in-the-loop review tool, multi-backend LLM client). That tooling is real and can still be mentioned as supporting infrastructure, but the **finalized dissertation's own emphasis is a rigorous quantitative evaluation** of one specific model (Gemma 4 31B IT) against a manually curated gold benchmark — lead with the evaluation framing (benchmark construction, prompt iteration, held-out metrics) for AI/ML-adjacent roles, since that's what's actually defended and citable.
**Not verified in this project** (don't claim without independent confirmation from the user): CrewAI/agent frameworks, RAG/retrieval (Qdrant, BGE, BM25, cross-encoder re-ranking), DeepSeek/Qwen/GLM by name, Streamlit, Vue, Playwright, SQLite.
**Private**: none — this is now a completed, gradable piece of work with real, defensible numbers; the richest "software/LLM" + "rigorous evaluation" experience available. Lead with it for any AI/ML/data/software-adjacent role.

### 1. FYP — Aedes aegypti population dynamics modelling (2025.03–2025.06, London)
Full title: *"Modelling the influence of temperature and rainfall on the population dynamics of Aedes aegypti over Collier County, Florida, USA"*. Imperial BSc Biological Sciences final-year project, supervised by Dr. Lauren Cator (second reader Prof. Samraat Pawar). 4,973 words.
**Fit tags**: quant/stats, modelling, field-relevant-disease-ecology
- Adapted a published Brazil-derived ODE compartment model (Silva et al. 2019; Vasconcelos et al. 2022) to a new geography using R 4.5.0 + `deSolve`
- Validated against 2015 NJLT mosquito-trap surveillance data (53 epidemiological weeks); model fit RMSE = 1.65, Pearson r = 0.29, Spearman ρ = 0.30
- Optimized time-lag (τ = −2 weeks) and a rainfall/water-source scaling factor (λ = 0.0137) to improve fit
- Explicit hypothesis test: a tropical-derived model has limited transferability to a subtropical climate — result supported this, motivating proposed model extensions (anthropogenic water sources, spatial heterogeneity, uncertainty quantification)
**Private**: no numeric grade found in the PDF; note this is a **BSc** final-year project (not MSc) even though it sits within the MSc-adjacent 2025 timeline — user confirmed the topic/title is correct as currently listed, no relabeling needed.

### 2. GCB Fishery Practical Report — North Atlantic fisheries & food web (2025.01–2025.02, London)
Prof. Guy Woodward's module, 3,477 words.
**Fit tags**: quant/stats, field-ecology, literature-review
- Quantified a 90-year time series (Excel Pivot Tables): North Sea herring landings collapsed from ~1.1M tonnes (1970) to <50,000 tonnes (1978), later peaks ~1.2M tonnes (1980s) and ~660,000 tonnes (2005), dropping to ~170,000 tonnes by 2009
- Identified sole (*Solea solea*) as the species most vulnerable to overfishing (~40% decline 1990–2000) via bottom-trawling bycatch and slow maturity, and flagged it separately for heavy-metal bioaccumulation risk (mercury exceeding EU limits — Bosch et al. 2020)
- Synthesized policy/climate/fishing-activity literature into an annotated food web across 8 species (herring, sole, haddock, whiting, saithe, sandeel, Norway pout, plaice)
- Proposed common guillemot as indicator species
**Private**: no numeric grade found; CV currently says "high marks and distinction" — fine to keep.

### 3. BCB Macroecology — hummingbird latitudinal gradients (2024.10–2024.12, London)
Full title: *"Macroecology Analysis on Trochilidae Family"*, 2,690 words.
**Fit tags**: quant/stats, bioinformatics-adjacent (phylogenetics), field-ecology
- GLM: species richness vs. latitude, estimate = −0.9004, p < 2×10⁻¹⁶; diversity peaks at 4° latitude (supports LDG)
- Bergmann's rule: plain LM significant (estimate = −0.007, p = 0.008) but **PGLS controlling for phylogeny is non-significant** (estimate = 0.0015, p = 0.427, λ = 0.85) — a genuinely interesting methodological result (phylogenetic signal explains the naive correlation)
- Rapoport's rule non-significant in both LM and PGLS (λ = 0.22)
- Tools: R, `dplyr`, `ggplot2`, `caper`, `fasterize`, `ape`; AVONET dataset (Tobias et al. 2022) + Jetz et al. 2012 phylogeny
**Private**: no numeric grade found.

### 4. ABFC — insect colour preference field course (2024.09–2024.10, Cape Town/Klipbokkop)
2,427 words. **Grade: 65/100** (private — do not print).
**Fit tags**: field-ecology, quant/stats
- 36 sample points, 6 sites (3 burnt / 3 unburnt), 5-colour pan traps (red/yellow/blue/white/green control)
- Background-adjusted abundance: yellow 20.17%, blue 24.06%, white 11.04%, red 0.03%
- One-sample t-tests vs. green baseline: yellow t = 8.163, blue t = 8.647, white t = 4.113 (all p < 0.001); red not significant
- Pearson correlation with local floral colour ratio significant only for yellow (r = 0.369, p = 0.027)
**Private**: mid-range grade (65/100) — keep CV language qualitative ("supported the hypothesis..."), don't add a number.

### 5. TD — insect decline review (2024.03–2025.06, London)
Full title: *"Why are Insects Declining?"*, Tutored Dissertation module, 6,752 words, 70+ sources.
**Fit tags**: literature-review, quant/stats (meta-analysis synthesis)
- Synthesized Sánchez-Bayo & Wyckhuys (2019) meta-analysis (73 reports): global insect biomass declining ~2.5%/year, >40% of species declining, a third endangered; 98% decline in Puerto Rico ground-dwelling insects over 35 years
- Hallmann et al. (2017): 75% decline in flying-insect biomass over 27 years, German protected reserves
- van Swaay et al. (2022): 35% European butterfly decline, 1990–2020
- Included a "winners and losers" counter-narrative (160/673 UK moth species increasing) and a critique of geographic/taxonomic bias in the reporting literature — shows critical, not just summarizing, analysis
**Private**: no numeric grade found.

### 6. EFS — sea anemone startle behaviour, Plymouth (2024.05–2024.06)
Full title: *"Investigation of boldness in Sea Anemone (Metridium senile) with and without Substrate under Different Temperature Conditions"*, 3,443/2,079 words. **Grade: 58/100** (private — do not print).
**Fit tags**: field-ecology, quant/stats
- n = 52 anemones (26/temperature group, split with/without mussel-shell substrate), 14.5±0.5°C vs 19.5±0.5°C
- Standardized water-squirt startle assay (20ml syringe); inter-observer reliability ICC = 0.949
- Wilcoxon signed-rank: temperature effect significant, V = 670.5, p = 0.01737 (matches current CV's "p=0.017"); substrate effect non-significant, W = 310, p = 0.6138
- R 4.3.0
**Private**: low-average grade (58/100) — keep bullets purely factual/quantitative as the CV already does, no superlatives.

### 7. BE — cricket aggression under heat, London (2024.03)
Full title: *"Exploring Variations in Cricket Aggression with Increasing Exposure Time to Higher Temperatures"*, Behavioural Ecology mini-project. **Grade: 72/100** (private).
**Fit tags**: field-ecology, quant/stats
- Species *Gryllus bimaculatus*; n = 4 replicates × 8 males, paired by body size (weaponry/RHP control, Judge & Bonanno 2008); control vs. 30°C heat-mat exposure at 20/40/60-minute intervals; 6-level aggression ethogram (Alexander 1961)
- Welch t-tests: encounter number p = 0.040, duration p = 0.013; Poisson GLM: temperature estimate = −0.090 (p = 0.029), size-difference estimate = −3.065 (p = 0.023)
- Inter-observer reliability: Kendall's W = 0.995
- Grader praised the statistics table; flagged small n = 4 as a limitation
**Private**: solid grade (72/100), keep as-is.

### 8. EOE — four-part R ecological modelling coursework (2024.01–2024.02, London)
Four independently graded pieces — **all high (91–94/100), private**, matches CV's "90+" claim exactly and can be stated with confidence:
- **Levins metapopulation (91/100)**: Euler-method simulation (dt = 0.01) of dp/dt = cp(1−p) − ep; algebraic equilibrium p* = 0.5; stochastic extension via `rnorm()`-perturbed parameters
- **Fisheries/MSY (93/100)**: logistic-growth harvesting model; MSY = 124.8 (r = 0.5, K = 1000); demonstrated population crash when catch exceeds MSY by just 1 unit; stochastic intrinsic growth-rate extension
- **Resource competition/R\* theory (94/100, highest of the four)**: two-species shared-resource competition; demonstrated competitive exclusion; time-lag challenge extension showed staggered introduction changes the coexistence outcome
- **Lotka-Volterra predator-prey (93/100)**: standard 2-species system extended to a 3-species (1 prey, 2 predator) coupled-ODE system with phase-plane plots; optional interactive 3D visualization via `plotly`
**Fit tags**: quant/stats, modelling, software (R functions/control flow)

### 9. Genetics — inbred mouse strains review (2023.11–2023.12, London)
1,437 words. **Grade: 75/100, formal distinction-level rubric** (private, but strong enough that "distinction" language is safe to keep on CV).
**Fit tags**: literature-review, bioinformatics-adjacent
- Inbreeding-coefficient theory (Wright 1922/1934); >98% isogenicity after 20+ generations
- Cited concrete studies: 40 BALB/c mice testing melittin-loaded niosomes vs. free melittin for breast cancer (renal/liver enzyme assays); *Trpv2* gene mapped via 41 inbred strains for cocaine self-administration; 39 BXD recombinant inbred strains used to map a QTL for *Fam53b*
- Casellas & Medrano (2008): ~4.5% of phenotypic variability in inbred colonies from mutation accumulation
- Feedback: strong intro/argument structure; docked for missing figures

### 10. Genetics — HERV-K viral fingerprinting (2023.11–2023.12, London)
Full title: *"Exploring Viral Fingerprinting Potential: Insights from HERV-K (HML2) Family Analysis in Human Populations"*, 1,288 words. **Grade: 72/100** (private).
**Fit tags**: wet-lab, bioinformatics, quant/stats
- DNA extraction (Qiagen DNeasy Blood & Tissue Kit); PCR (GoTaq/Promega); gel electrophoresis (1.4% agarose, SYBR Gold, 1Kb Plus ladder, 80–100V)
- 5 primer sets (Ne2, De7, De9, De10, De11) targeting solo-LTRs of Neanderthal/Denisovan origin, verified via UCSC in-silico PCR
- Calculated F_ST (range 0.0010–0.3659) and χ² HWE tests (critical value 3.841); Ne2 and De7 significantly deviated from HWE (χ² = 33.28, 10.52)
- Grader called the title "excellent," praised figures/tables

### 11. BPS — OCA1A albinism bioinformatics (2023.10–2023.11, London)
Full title: *"Oculocutaneous Albinism Type IA"*, 1,354 words. **Grade: 57/100** (private, do not print — 2:2-range, keep CV language neutral/factual).
**Fit tags**: bioinformatics
- TYR gene, chr 11:q14.3 (MIM 606933), GRCh38.p14, NM_000372.5; AlphaFold structure used to show the two copper-binding domains
- Traced tyrosine → DOPA → dopaquinone pathway (tyrosinase-catalyzed, ATP7A-dependent copper transport)
- Cited a homozygous 1-bp cytosine-insertion frameshift (Chintamaneni et al. 1991); pathogenic variant rs281865527 (ClinVar/Ensembl/dbSNP); NCBI ALFA population-frequency data across 85,874 samples (highest CCCCC frequency in East Asians)
- Second UniProt missense variant analyzed (rs28940878) across 654 samples; BLAST cross-species comparison (E = 2×10⁻¹²⁴, 82.47% identity)
- Grader praised the population-genetics section as exemplary; critiqued structure/flow and the choice of a yeast homolog as biologically uninformative

---

## Tailoring workflow (for future "make me a CV for job X" requests)

**The 1-page cap applies to the Chinese version only.** Job-tailored English CVs are not forced to 1 page — if fuller bullets push it to 1.5–2 pages, leave it; don't cut English content just to match the Chinese page count. (The master CV in this folder is exempt from any page cap either way — it's the full content pool, not something to hand to an employer.)

**Job-tailored direction CVs omit the Personal Summary section entirely** (master CV keeps it). The space that would've gone to Summary goes into fuller, STAR-structured Internship/Research bullets instead — see the STAR + quantification bonus formula above.

1. Parse the JD for its explicit required/preferred skills and domain (e.g. wet-lab vs. computational vs. regulatory/QC vs. software).
2. Filter the content bank above by `Fit tags`. **Don't under-fill the page** — a 1-page Chinese CV with real content bank depth to draw from should read as full, not sparse. Concretely:
   - **Internship**: the Sunherb Pharma internship is **mandatory in every tailored CV**, any direction — it's the only genuine internship available. The Jianteng tutoring entry is the only other verified internship-adjacent entry and is optional — include only where genuinely relevant to the JD, don't pad with it otherwise.
   - **Research entries**: default to including **both** VecTraits (#0) and the Florida *Aedes aegypti* FYP (#1) — they're the two strongest, most quantified entries in the bank. Substitute only when a direction genuinely doesn't fit either (e.g. wet-lab/genetics-heavy biopharma roles may lean on HERV-K (#10) + OCA1A (#11) instead).
   - If content still doesn't fill the page after including the mandatory internship + prioritized research entries, add a 3rd-4th research entry from the bank by `Fit tags` overlap, or restore optional internship entries — compress bullet wording before cutting whole entries.
3. Write a fresh Summary using the **Personal Summary formula** above — but only for the **master CV**; skip this step for job-tailored direction CVs (see above).
4. Write fresh bullets per the house style above (STAR, bold org/numbers, bold lead-in + colon on every bullet, 1–3 bullets) — use the master CV's bullet depth as the baseline, adjusting wording/emphasis toward the JD's skills rather than shrinking the content. Apply the **Section-specific content strategy** and **STAR + quantification bonus formula** above.
5. Filter and reorder the Skills section by role relevance — **filter by whole category, not by trimming within one**: if a category is relevant, print it at full master-level detail; if not relevant, cut the entire category. Don't keep an abbreviated version of a category. Reorder BSc coursework so the most relevant courses lead; **coursework must be present in Education for every tailored CV**, not omitted.
6. Compile with `xelatex`, confirm the Chinese version's page count is exactly **1 page** (English unconstrained), and visually inspect the rendered PDF for: overfull-hbox spillover (check for `/`-joined compound terms needing `\slash` — see the hyphenation note above), and (for Chinese) any single stranded character at a line end.
7. **Check the rendered page for leftover white space at the bottom — this applies every time the CV is regenerated or edited, not just on first creation.** Estimate the gap as a fraction of the page:
   - **Large gap (roughly a quarter page or more)**: add another content-bank entry, picked by `Fit tags` overlap with the direction — same treatment as adding a research/internship entry in step 2 above (recompile, confirm still 1 page for Chinese).
   - **Small gap**: don't add a whole new entry — expand existing bullets with more STAR detail, or restore a bullet that was trimmed to master-level depth (e.g. a 2-bullet Sunherb entry can become 3 bullets, matching the master's full version).
   - **No gap / page is tight**: leave it — don't force content in past the point where it reads padded.
   - Never leave a 1-page Chinese CV looking visibly sparse when there's real, verified content-bank material available to fill it — a full-looking page reads as substantive, a half-empty one reads as thin.
8. **Filenames in each job-tailored direction folder carry the Chinese direction label right after the name**: `吴筱琦_<方向>_中文版.tex/.pdf`, `吴筱琦_<方向>_英文版.tex/.pdf` — e.g. `吴筱琦_生物医药研发_中文版.pdf`. Use a short, filesystem-safe label (no `/`) even if the on-CV tagline itself uses `/` to combine roles (e.g. tagline "生物医药研发/QC/分析岗" → filename label "生物医药研发"). The master CV in `template/` keeps the plain `吴筱琦_中文版.tex`/`吴筱琦_英文版.tex` names (no direction label — it isn't tailored to one).
9. **Each job-tailored direction also gets a merged PDF** — `吴筱琦_<方向>_中英合并版.pdf`, the Chinese PDF's pages followed by the English PDF's pages, generated with `pdfunite 吴筱琦_<方向>_中文版.pdf 吴筱琦_<方向>_英文版.pdf 吴筱琦_<方向>_中英合并版.pdf` (plain concatenation, no new `.tex` source). **Regenerate this after any edit to either language's `.tex`/`.pdf`** — it goes stale silently otherwise since it isn't compiled from source.
