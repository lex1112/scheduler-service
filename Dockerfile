RUN curl -fsSLO https://get.docker/builds/Linux/x86_64/docker-17.04.0-ce.tgz \
  && tar xzvf docker-17.04.0-ce.tgz \
  && mv docker/docker /usr/local/bin \
  && rm -r docker docker-17.04.0-ce.tgz
  
FROM microsoft/dotnet:2.2-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM microsoft/dotnet:2.2-sdk AS build
WORKDIR /src
COPY ["scheduler-service/scheduler-service.csproj", "scheduler-service/"]
RUN dotnet restore "scheduler-service/scheduler-service.csproj"
COPY . .
WORKDIR "/src/scheduler-service"
RUN dotnet build "scheduler-service.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "scheduler-service.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "scheduler-service.dll"]