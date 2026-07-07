# AI Skill Repository

该仓库用于集中管理可复用 AI 技能与提示词，目标是：

- 统一技能沉淀
- 便于跨项目导入
- 便于后续持续新增与版本管理

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
2. 填写 frontmatter：`name`、`description`、`argument-hint`
3. 在 `skills/INDEX.md` 增加条目
4. 提交并推送

## 新增 Prompt 流程

1. 复制 `templates/PROMPT.template.md` 为 `prompts/<prompt-name>.prompt.md`
2. 填写 frontmatter 和输出格式
3. 如依赖某个技能，请在正文明确引用该技能名
4. 提交并推送
