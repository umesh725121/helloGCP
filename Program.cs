// Copyright 2022 Google Inc.

var builder = WebApplication.CreateBuilder(args);

var port = Environment.GetEnvironmentVariable("PORT") ?? "8080";
var url = $"http://0.0.0.0:{port}";
var target = Environment.GetEnvironmentVariable("TARGET") ?? "Solution POD";

var app = builder.Build();

app.MapGet("/", () => $"Hello {target}!");

app.Run(url);
