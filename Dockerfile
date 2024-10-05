# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["WebApplicationLocal/WebApplicationLocal.csproj", "WebApplicationLocal/"]
RUN dotnet restore "./WebApplicationLocal/WebApplicationLocal.csproj"
COPY . .
WORKDIR "/src/WebApplicationLocal"
RUN dotnet build "./WebApplicationLocal.csproj" -c Release -o /app/build

# Stage 2: Publish
FROM build AS publish
RUN dotnet publish "./WebApplicationLocal.csproj" -c Release -o /app/publish

# Stage 3: Final
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "WebApplicationLocal.dll"]
