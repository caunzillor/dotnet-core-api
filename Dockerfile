FROM microsoft/dotnet:2.2.100-sdk as build-env
WORKDIR /build
COPY . ./
RUN dotnet restore Todo.csproj
RUN dotnet publish -c Release -o out Todo.csproj
FROM microsoft/dotnet:2.2.0-aspnetcore-runtime
WORKDIR /app
COPY --from=build-env /build/dotnet-core-api/out ./
EXPOSE 80
ENTRYPOINT ["dotnet", "dotnet-core-api.dll"]
