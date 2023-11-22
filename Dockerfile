FROM mcr.microsoft.com/dotnet/sdk:8.0-alpine  AS base
 WORKDIR /app
 EXPOSE 80
 FROM mcr.microsoft.com/dotnet/sdk:8.0-alpine  AS build
 WORKDIR /src
 COPY ["helloworld-csharp.csproj", ""]
 RUN dotnet restore "./helloworld-csharp.csproj"
 COPY . .
 WORKDIR "/src/."
 RUN dotnet build "helloworld-csharp.csproj" -c Release -o /app/build
 FROM build AS publish
 RUN dotnet publish "helloworld-csharp.csproj" -c Release -o /app/publish
 FROM base AS final
 # Stage 2 - Runtime
FROM mcr.microsoft.com/dotnet/sdk:8.0-alpine AS runtime

ENV ASPNETCORE_ENVIRONMENT Production
ENV ASPNETCORE_HTTP_PORT=8080
ENV ASPNETCORE_URLS http://*:8080
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=false

EXPOSE 8080
 WORKDIR /app
 COPY --from=publish /app/publish .
 ENTRYPOINT ["dotnet", "helloworld-csharp.dll"]