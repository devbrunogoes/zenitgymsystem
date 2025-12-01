create table Pessoa(
	codPessoa SERIAL PRIMARY KEY NOT NULL,
	nomePessoa VARCHAR NOT NULL,
	senhaPessoa VARCHAR NOT NULL,
	dtnascPessoa date NOT NULL,
	cpfPessoa VARCHAR NOT NULL,
	rgPessoa VARCHAR NOT NULL,
	sexoPessoa VARCHAR NOT NULL,
	celularPessoa VARCHAR NOT NULL,
	cepPessoa VARCHAR NOT NULL,
	endPessoa VARCHAR NOT NULL,
	complPessoa VARCHAR,
	numeroPessoa int NOT NULL,
	cidadePessoa VARCHAR NOT NULL,
	ufPessoa VARCHAR NOT NULL,
	bairroPessoa VARCHAR NOT NULL,
	emailPessoa VARCHAR NOT NULL,
	imgPessoa VARCHAR(255)
);


create table Administrador(
    codAdm SERIAL PRIMARY KEY NOT NULL,
    statusAdm boolean not null,
    codPessoa int not null unique REFERENCES Pessoa(codPessoa)    
);
create table Personal(
    codPers SERIAL PRIMARY KEY NOT NULL,
    statusPers BOOLEAN NOT NULL,
    dtcontratoPers DATE NOT NULL,
    codPessoa int not null unique REFERENCES Pessoa(codPessoa)
);
CREATE TABLE Plano (
    codPlano SERIAL PRIMARY KEY NOT NULL,
    nomePlano VARCHAR(50) NOT NULL,
    valorMensalPlano DECIMAL(10, 2) NOT NULL,
    durMesPlano INT NOT NULL
);
CREATE TABLE Aluno (
    codAluno SERIAL PRIMARY KEY NOT NULL,
    statusAluno BOOLEAN NOT NULL,
    dtMatriculaAluno DATE NOT NULL,               
    obsAluno TEXT,
    codPessoa INT NOT NULL UNIQUE REFERENCES Pessoa(codPessoa),
    codPers INT NOT NULL REFERENCES Personal(codPers),
    codPlano INT NOT NULL REFERENCES Plano(codPlano)
);
CREATE TABLE Produto(
    codProduto SERIAL PRIMARY KEY NOT NULL,
    nomeProduto VARCHAR(200) NOT NULL,
    descProduto VARCHAR(500) NOT NULL,
    valorProduto NUMERIC(10,2) NOT NULL,
    qtdProduto INT NOT NULL,
    imgProduto VARCHAR(255),
    categoriaProduto VARCHAR
);

create table Venda(
	codVenda SERIAL PRIMARY KEY NOT NULL,
	valorVenda float NOT NULL,
	dataVenda date NOT NULL,
	statusVenda boolean NOT NULL,
	TipoPagVenda VARCHAR not null,
	codAdm int not null REFERENCES Administrador(codAdm),
	codAluno int not null REFERENCES Aluno(codAluno)
);
CREATE TABLE Analise (
    codAv SERIAL PRIMARY KEY ,
    pesoAv DECIMAL(10, 2) ,
    alturaAv DECIMAL(10, 2) ,
    imcAv DECIMAL(10, 2) ,
    percentGorduraAv DECIMAL(10, 2),
    massaMuscularAv DECIMAL(10, 2),
    pressaoAv VARCHAR(10),                     -- Ex: '120/80'
    freqCardiacaAv INT,
    capacidadeAerobicaAv DECIMAL(10, 2),
    objetivoAv VARCHAR(255),
	dtAgendamentoAv  DATE,
	hrAgendamentoAv  VARCHAR(10),
	statusAv BOOLEAN DEFAULT FALSE,
    codAluno INT  REFERENCES Aluno(codAluno),                             -- Chave estrangeira para Aluno
    codPers INT  REFERENCES Personal(codPers)
);

CREATE TABLE Aula (
    codAula SERIAL PRIMARY KEY NOT NULL,
    nomeAula VARCHAR(200) NOT NULL,
    descAula VARCHAR(500) NOT NULL,
    dtAula DATE NOT NULL,
    horarioAula VARCHAR(10),
    codPers INT REFERENCES Personal(codPers) 
);

create table AlunoAula(
	codAlunoAula SERIAL PRIMARY KEY NOT NULL,
        codAluno INT REFERENCES Aluno(codAluno), 
        codAula INT REFERENCES Aula(codAula) 
);
CREATE TABLE Fornecedor (
    codForn SERIAL PRIMARY KEY NOT NULL,
    nomeForn VARCHAR(255) NOT NULL, 
    celularForn VARCHAR(20) NOT NULL, 
    emailForn VARCHAR(255),
    cnpjForn VARCHAR,               
    enderecoForn VARCHAR(255),      
    dtCadastroForn TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    statusForn BOOLEAN DEFAULT TRUE, -- Status (ativo/inativo)
    obsForn TEXT                
);


CREATE TABLE Equipamento (
    codEquip SERIAL PRIMARY KEY NOT NULL,             
    nomeEquip VARCHAR(200) NOT NULL,                  
    descEquip VARCHAR(500) NOT NULL,                  
    dtAquisicaoEquip DATE,                               
    estadoConsEquip VARCHAR NOT NULL, 
    statusEquip VARCHAR NOT NULL, 
    dtUltManuEquip DATE,                        
    codForn INT REFERENCES Fornecedor(codForn)       
);


CREATE TABLE Entrega (
    codEntrega SERIAL PRIMARY KEY NOT NULL,
    dataEntrega DATE NOT NULL,
    quantEntrega INT NOT NULL,
    enderecoEntrega VARCHAR(500), 
    statusEntrega VARCHAR(50),  
    codForn INT REFERENCES Fornecedor(codForn) ON DELETE CASCADE,
    codEquip INT REFERENCES Equipamento(codEquip) ON DELETE CASCADE
);



create table EquipamentoAula(
	codEquipamentoAula SERIAL PRIMARY KEY NOT NULL
);

CREATE TABLE Treino (
    codTreino SERIAL PRIMARY KEY ,
    nomeTreino VARCHAR(100) NOT NULL,
    descricaoTreino TEXT,
    dtTreino DATE NOT NULL, 
    statusTreino BOOLEAN NOT NULL
);
CREATE TABLE TreinoAluno (
    codTA SERIAL PRIMARY KEY NOT NULL,
    codAluno INT  REFERENCES Aluno(codAluno),
    codTreino INT  REFERENCES Treino(codTreino)
);


CREATE TABLE Exercicio (
    codEx SERIAL PRIMARY KEY NOT NULL,
    nomeEx VARCHAR(100) NOT NULL,
    grupoEx VARCHAR(50) NOT NULL
);
CREATE TABLE ExercicioTreino (
    codET SERIAL PRIMARY KEY NOT NULL,                    
    pesoET DECIMAL(10, 2) NOT NULL,         -- Peso do exercício
    repeticoesET INT NOT NULL,             -- Repetições do exercício
    seriesET INT NOT NULL,                 -- Número de séries
    tipoET VARCHAR(255) NOT NULL,          -- Tipo do exercício
    descansoET INT NOT NULL,               -- Descanso entre séries (em segundos)
    duracaoET INT NOT NULL,                -- Duração do exercício (em minutos, por exemplo)
    obsET VARCHAR(255),
    codTreino INT NOT NULL REFERENCES Treino(codTreino),
    codEx INT NOT NULL REFERENCES Exercicio(codEx) 
);



CREATE TABLE Mensalidade (
    codMens SERIAL PRIMARY KEY NOT NULL,
    mesMens VARCHAR(10) NOT NULL,
    anoMens INT NOT NULL,
    valorMens DECIMAL(10, 2) NOT NULL,
    dtVencMens DATE NOT NULL,
    dtPagMens DATE,
    tipoPag VARCHAR NOT NULL,
    codAluno INT NOT NULL REFERENCES Aluno(codAluno)
);

CREATE TABLE MovFin (
    codMov SERIAL PRIMARY KEY NOT NULL ,
    descMov VARCHAR(100) NOT NULL,
    tipoMov boolean NOT NULL,
    valorMov DECIMAL(10, 2) NOT NULL,
    dtMov DATE NOT NULL,
    tipoPagMov VARCHAR(50),
    categoriaMov VARCHAR(50),
    obsMov TEXT
    
);
 


CREATE VIEW usuario AS
SELECT codAdm AS codUsuario,
       nomePessoa AS nomeUsuario, 
       cpfPessoa AS cpfUsuario,
       senhaPessoa AS senhaUsuario, 
       'Administrador' AS perfilUsuario, 
       imgPessoa AS imgUsuario
FROM Administrador ad 
INNER JOIN Pessoa pe ON ad.codPessoa = pe.codPessoa

UNION

SELECT codAluno AS codUsuario,
       nomePessoa AS nomeUsuario, 
       cpfPessoa AS cpfUsuario,
       senhaPessoa AS senhaUsuario, 
       'Aluno' AS perfilUsuario, 
       imgPessoa AS imgUsuario
FROM Aluno al 
INNER JOIN Pessoa pe ON al.codPessoa = pe.codPessoa

UNION

SELECT codPers AS codUsuario,
       nomePessoa AS nomeUsuario, 
       cpfPessoa AS cpfUsuario,
       senhaPessoa AS senhaUsuario, 
       'Personal' AS perfilUsuario, 
       imgPessoa AS imgUsuario
FROM Personal pr 
INNER JOIN Pessoa pe ON pr.codPessoa = pe.codPessoa;



CREATE VIEW MensalidadeStatus AS
SELECT 
    codMens,
    codAluno,
    mesMens,
    anoMens,
    valorMens,
    dtVencMens,
    dtPagMens,
    CASE
        WHEN dtPagMens IS NOT NULL THEN 'Paga'
        WHEN CURRENT_DATE > dtVencMens THEN 'Vencida'
        ELSE 'Não Paga'
    END AS statusPagamento
FROM Mensalidade;





INSERT INTO Plano (codPlano,nomePlano, valorMensalPlano, durMesPlano) VALUES 
(1,'Mensal', 100.00, 1),     -- Plano Mensal
(2,'Trimestral', 270.00, 3), -- Plano Trimestral
(3,'Semestral', 500.00, 6),  -- Plano Semestral
(4,'Anual', 960.00, 12);     -- Plano Anual

-- Inserindo pessoas
INSERT INTO Pessoa(codPessoa, nomePessoa, senhaPessoa, dtnascPessoa, cpfPessoa, rgPessoa, sexoPessoa, celularPessoa, cepPessoa, endPessoa, complPessoa, numeroPessoa, cidadePessoa, ufPessoa, bairroPessoa, emailPessoa, imgPessoa)
VALUES 
-- Pessoas Existentes (Renomeadas)
(1, 'Breno Pimenta', '123', '2000-01-01', '000.000.000-00', '00.000.000-0', 'Masculino', '(11) 90000-0000', '00000-000', 'Rua das Flores', 'Casa', 10, 'Campinas', 'SP', 'Jardim das Rosas', 'breno.pimenta@gmail.com', 'Breno.JPG'),
(2, 'Bruno Goes', '123', '2000-01-01', '222.222.222-22', '22.222.222-2', 'Masculino', '(11) 91111-1111', '00000-001', 'Rua Central', 'Apto 100', 15, 'Jales', 'SP', 'Centro', 'bruno.goes@gmail.com', 'Bruno.jpg'),
(3, 'Gabriel Siviero', '123', '1990-05-10', '111.111.111-11', '11.111.111-1', 'Masculino', '(11) 92222-2222', '12345-678', 'Rua Exemplo', 'Apto 101', 20, 'São Paulo', 'SP', 'Vila Olímpia', 'gabriel.siviero@gmail.com', 'Gabriel.jpg');

-- Inserindo administradores
INSERT INTO Administrador(codAdm, statusAdm, codPessoa) 
VALUES 
(1, TRUE, 2);

-- Inserindo personal trainers
INSERT INTO Personal(codPers, dtcontratoPers, statusPers, codPessoa) 
VALUES 
(1, '2024-01-01', TRUE, 3);
-- Inserindo alunos
INSERT INTO Aluno(codAluno, statusAluno, dtMatriculaAluno, obsAluno, codPessoa, codPers, codPlano) 
VALUES 
(1, TRUE, '2024-10-01', 'Nenhuma restrição.', 1, 1, 1);



