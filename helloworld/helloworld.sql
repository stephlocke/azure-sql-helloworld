CREATE TABLE Helloworld (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Message NVARCHAR(255) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE()
);