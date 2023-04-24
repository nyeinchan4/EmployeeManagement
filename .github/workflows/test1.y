name: .NET

on:
  push:
    branches: [ "main" ]
  pull_request:
    branches: [ "main" ]

jobs:

  build:

    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - name: Setup .NET
      uses: actions/setup-dotnet@v3
      with:
        dotnet-version: 6.0.x
    - name: Restore dependencies
      run: dotnet restore
    - name: Build
      run: dotnet build --no-restore
    - name: Test
      run: dotnet test --no-build --verbosity normal
      
      #EmployeeManagement
      #publish build and push artifact of EmployeeManagement.API
    - name: Publish EmployeeManagement.API
      run: dotnet publish EmployeeManagement/EmployeeManagement.API/EmployeeManagement.API.csproj -c Release -o EmployeeManagement.API
    
    - name: Upload a Build EmployeeManagement.API Artifact 
      uses: actions/upload-artifact@v2.3.1
      with:
        name: EmployeeManagement.API-${{ github.sha }}
        path: /home/runner/work/EmployeeManagement/EmployeeManagement/EmployeeManagement.API/**
        if-no-files-found: error
