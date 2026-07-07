# AI Skill Repository

该仓库用于集中管理可复用 AI 技能与提示词，目标是：

- 统一技能沉淀
- 便于跨项目导入
- 便于后续持续新增与版本管理

## 收纳原则

- 技能优先解决一个具体问题，不追求大而全。
- 文档尽量短，默认只保留触发场景、必要输入、执行规则、输出要求。
- 优先沉淀能直接复用的命令、检查项、约束，不堆背景知识。
- 以实际使用为准，保留能满足使用的最小实例。
- 如果事情不会重复出现，就不要收成技能。

## 目录结构

- `skills/`：技能定义（每个技能一个目录）
- `prompts/`：可直接调用的任务型 prompt
- `templates/`：新增技能/提示词模板

当前已收录：

- `skills/syntec-packaging/SKILL.md`
- `skills/karpathy-guidelines/SKILL.md`
- `prompts/syntec-release-checklist.prompt.md`

## 新增技能流程

1. 复制 `templates/SKILL.template.md` 为 `skills/<skill-name>/SKILL.md`
2. 先判断这件事是否会重复出现；一次性问题不要收录
3. 填写 frontmatter：`name`、`description`、`argument-hint`
4. 正文以能直接使用为准，优先给出最小可用实例，不用硬卡行数
5. 在 `skills/INDEX.md` 增加条目
6. 提交并推送

## 新增 Prompt 流程

1. 复制 `templates/PROMPT.template.md` 为 `prompts/<prompt-name>.prompt.md`
2. 填写 frontmatter 和输出格式
3. 如依赖某个技能，请在正文明确引用该技能名
4. 提交并推送

## 校验机制

仓库已内置 frontmatter 校验：

- 本地脚本：`scripts/validate-frontmatter.ps1`
- CI 工作流：`.github/workflows/validate-frontmatter.yml`

本地执行：

```powershell
Set-ExecutionPolicy -Scope Process Bypass
./scripts/validate-frontmatter.ps1
```

校验范围：

- `skills/**/SKILL.md`：必须包含 `name`、`description`，并建议包含 `argument-hint`
- `prompts/**/*.prompt.md`：必须包含 `name`、`description`
