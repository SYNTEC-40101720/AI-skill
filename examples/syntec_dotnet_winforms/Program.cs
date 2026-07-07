using System.Windows.Forms;

ApplicationConfiguration.Initialize();

var marker = Path.Combine(AppContext.BaseDirectory, "SYNTEC-dotnet-winforms-opened.txt");
File.WriteAllText(marker, $"SYNTEC .NET WinForms opened at {DateTime.Now:O}{Environment.NewLine}");