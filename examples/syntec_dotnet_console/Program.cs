var marker = Path.Combine(AppContext.BaseDirectory, "SYNTEC-dotnet-console-opened.txt");
File.WriteAllText(marker, $"SYNTEC .NET console opened at {DateTime.Now:O}{Environment.NewLine}");