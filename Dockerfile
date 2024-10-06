# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src

# کپی فقط فایل csproj
COPY ["WebApplicationLocal/WebApplicationLocal.csproj", "WebApplicationLocal/"]

# اجرای dotnet restore
RUN dotnet restore "./WebApplicationLocal/WebApplicationLocal.csproj"

# کپی کردن تنها فایل‌های مورد نیاز (کد سورس و فایل‌های وابسته)
COPY WebApplicationLocal/. WebApplicationLocal/

# ساخت پروژه
WORKDIR "/src/WebApplicationLocal"
RUN dotnet build "./WebApplicationLocal.csproj" -c Release -o /app/build
