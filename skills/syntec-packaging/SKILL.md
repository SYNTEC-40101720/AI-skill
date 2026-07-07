---
name: syntec-packaging
description: "Use when: 新代/SYNTEC 域控环境下做 Python/.NET 打包、发布检查或发布清单审查。"
argument-hint: "说明项目类型、入口文件/项目、目标 exe 名称、版本号、输出目录"
---

# SYNTEC 域控打包技能

## 适用场景

- Python 程序在 SYNTEC 域控环境发布。
- C#/.NET 程序生成可交付 exe。
- 审查发布前检查清单是否满足域控约束。

## 必要输入

- 项目类型：Python 或 .NET。
- 入口：`.py`、`.csproj` 或 `.sln`。
- 输出 exe 名称、版本号、输出目录。

## 执行规则

1. exe 名称必须以 `SYNTEC` 开头。
2. 版本信息中的公司和版权必须包含 `SYNTEC`，版本号必须是四段数字。
3. Python 打包必须禁用 UPX，禁止使用 `ctypes`/`windll`/`ShowWindow` 调 Windows API。
4. Python 版本资源固定为 `StringTable=000004B0`、`Translation=[0,1200]`。
5. Python 打包路径必须是纯英文路径，one-dir 产物必须检查 `_internal` 核心文件。

## Python 版本资源最小实例

```python
VSVersionInfo(
  ffi=FixedFileInfo(
    filevers=(1, 0, 0, 0),
    prodvers=(1, 0, 0, 0),
    mask=0x3f,
    flags=0x0,
    OS=0x4,
    fileType=0x1,
    subtype=0x0,
    date=(0, 0)
  ),
  kids=[
    StringFileInfo([
      StringTable(
        u'000004B0',
        [
          StringStruct(u'CompanyName', u'SYNTEC'),
          StringStruct(u'FileDescription', u'SYNTEC App'),
          StringStruct(u'FileVersion', u'1.0.0.0'),
          StringStruct(u'ProductName', u'SYNTEC App'),
          StringStruct(u'ProductVersion', u'1.0.0.0'),
          StringStruct(u'LegalCopyright', u'Copyright SYNTEC 2026')
        ]
      )
    ]),
    VarFileInfo([VarStruct(u'Translation', [0, 1200])])
  ]
)
```

## .NET 项目元数据最小实例

```xml
<PropertyGroup>
  <AssemblyName>SYNTEC-App</AssemblyName>
  <AssemblyTitle>SYNTEC App</AssemblyTitle>
  <Company>SYNTEC</Company>
  <Copyright>Copyright SYNTEC 2026</Copyright>
  <Description>SYNTEC App</Description>
  <Product>SYNTEC App</Product>
  <FileVersion>1.0.0.0</FileVersion>
  <Version>1.0.0.0</Version>
  <InformationalVersion>1.0.0.0</InformationalVersion>
  <IncludeSourceRevisionInInformationalVersion>false</IncludeSourceRevisionInInformationalVersion>
</PropertyGroup>
```

## 常用命令

Python 打包：
```powershell
py -m PyInstaller --noconfirm --onedir --windowed --version-file version_info.txt --name "SYNTEC-应用名" --noupx --clean app.py
```

CLI 程序移除 `--windowed`，GUI 程序保留。

.NET 打包：
```powershell
dotnet publish -c Release -r win-x64 --self-contained true -p:PublishSingleFile=true -p:EnableCompressionInSingleFile=true -o "输出目录"
```

Python 验证：
```powershell
$exe = ".\dist\SYNTEC-应用名\SYNTEC-应用名.exe"
(Get-Item $exe).VersionInfo | Format-List CompanyName, LegalCopyright, FileVersion, ProductVersion, ProductName, FileDescription, Language
Test-Path ".\dist\SYNTEC-应用名\_internal\python311.dll"
Test-Path ".\dist\SYNTEC-应用名\_internal\_ctypes.pyd"
```

.NET 验证：
```powershell
$exe = ".\输出目录\SYNTEC-应用名.exe"
(Get-Item $exe).VersionInfo | Format-List CompanyName, LegalCopyright, FileVersion, ProductVersion, ProductName, FileDescription
```

## 输出要求

- 输出打包命令或发布检查清单。
- 缺信息时只追问最少必要问题。
- 审查时优先指出阻断项，不展开无关背景。
