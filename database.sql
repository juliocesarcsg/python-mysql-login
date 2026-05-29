DROP DATABASE IF EXISTS db_jogo;
CREATE DATABASE db_jogo;
USE db_jogo; 

-- 1. cursos
CREATE TABLE cursos (
    id_curso INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    sigla VARCHAR(45) NOT NULL,
    nome_curso TEXT
);

-- 2. tabuleiro
CREATE TABLE tabuleiro (
    id_tabuleiro INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome VARCHAR(45) NOT NULL,
    descricao TEXT
);

-- 3. casas
CREATE TABLE casas (
    id_casa INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome_local VARCHAR(45) NOT NULL,
    descricao TEXT,
    tipo_casa VARCHAR(45),
    id_tabuleiro INT NOT NULL,
    FOREIGN KEY (id_tabuleiro) REFERENCES tabuleiro(id_tabuleiro) ON DELETE RESTRICT
);

-- 4. usuarios
CREATE TABLE usuarios (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(45) NOT NULL,
    senha VARCHAR(45) NOT NULL,

	is_professor TINYINT(1) NOT NULL DEFAULT 0,

    id_curso INT NOT NULL,

    FOREIGN KEY (id_curso)
    REFERENCES cursos(id_curso)
    ON DELETE RESTRICT
);

-- 5. alunos
CREATE TABLE alunos (
    id_aluno INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    id_usuario INT NOT NULL,
    RA VARCHAR(45) NOT NULL,
    semestre INT NOT NULL,
    progresso FLOAT NOT NULL,
    avatar INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE RESTRICT
);

-- 6. materiais
CREATE TABLE materiais (
    id_material INT PRIMARY KEY AUTO_INCREMENT NOT NULL,

    titulo VARCHAR(45) NOT NULL,

    descricao TEXT,

    arquivo VARCHAR(255),

    data_postagem DATE,

    id_usuario INT NOT NULL,

    id_curso INT NOT NULL,

    FOREIGN KEY (id_usuario)
    REFERENCES usuarios(id_usuario)
    ON DELETE RESTRICT,

    FOREIGN KEY (id_curso)
    REFERENCES cursos(id_curso)
    ON DELETE RESTRICT
);

-- 7. tarefas
CREATE TABLE tarefas (
    id_tarefa INT PRIMARY KEY AUTO_INCREMENT NOT NULL,

    titulo VARCHAR(45) NOT NULL,

    descricao TEXT,

    data_entrega DATE,

    id_usuario INT NOT NULL,

    id_casa INT NOT NULL,

    id_curso INT NOT NULL,

    FOREIGN KEY (id_usuario)
    REFERENCES usuarios(id_usuario)
    ON DELETE RESTRICT,

    FOREIGN KEY (id_casa)
    REFERENCES casas(id_casa)
    ON DELETE RESTRICT,

    FOREIGN KEY (id_curso)
    REFERENCES cursos(id_curso)
    ON DELETE RESTRICT
);

-- 8. progresso
CREATE TABLE progresso (
    id_progresso INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    id_usuario INT NOT NULL,
    id_casa INT NOT NULL,
    concluida TINYINT,
    data_conclusao DATE,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE RESTRICT,
    FOREIGN KEY (id_casa) REFERENCES casas(id_casa) ON DELETE RESTRICT
);

-- 9. entrega_tarefas
CREATE TABLE entrega_tarefas (
    id_entrega INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    id_tarefa INT NOT NULL,
    id_usuario INT NOT NULL,
    resposta TEXT,
    arquivo_resposta VARCHAR(255),
    nota FLOAT,
    status VARCHAR(45),
    data_entrega DATETIME,
    FOREIGN KEY (id_tarefa) REFERENCES tarefas(id_tarefa) ON DELETE RESTRICT,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE RESTRICT
);

CREATE TABLE respostas (
	id_resposta INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    id_aluno INT NOT NULL,
    id_tarefa INT NOT NULL,
    resposta VARCHAR(500) NOT NULL,
    FOREIGN KEY (id_tarefa) REFERENCES tarefas(id_tarefa) ON DELETE RESTRICT,
    FOREIGN KEY (id_aluno) REFERENCES alunos(id_aluno)
);

INSERT INTO cursos (sigla, nome_curso) VALUES
('ADM', 'Administração'),
('ARQ', 'Arquitetura e Urbanismo'),
('CC', 'Ciência da Computação'),
('DES', 'Design'),
('EAL', 'Engenharia de Alimentos'),
('EC', 'Engenharia Civil'),
('ECOMP', 'Engenharia de Computação'),
('ECA', 'Engenharia de Controle e Automação'),
('EEL', 'Engenharia Elétrica'),
('EELE', 'Engenharia Eletrônica'),
('EM', 'Engenharia Mecânica'),
('EP', 'Engenharia de Produção'),
('EQ', 'Engenharia Química'),
('IACD', 'Inteligência Artificial e Ciência de Dados'),
('RI', 'Relações Internacionais'),
('SI', 'Sistemas de Informação');


INSERT INTO usuarios
(nome, email, senha, is_professor, id_curso)

VALUES
('Julio Cesar', '26.00722-9@maua.br', '54556218829', 0, 3),
('Rudolf', 'professor.rudolf@maua.br', '123', 1, 3);



INSERT INTO usuarios (nome, email, senha, id_curso) VALUES
('Julio Cesar Carnevalli dos Santos Gualtieroni', '26.00722-9@maua.br', '54556218829', '3'),
('Lucas Medeiros de Sousa', '26.00579-3@maua.br', '47962303867', '3'),
('Rafael Grespan de Souza', '26.00987-8@maua.br', '50812371836', '3'),
('Vitor Pattaro', '26.00044-8@maua.br', '54322882811', '3'),
('Enzo Pironato Bernardes', '26.00399-6@maua.br', '41962405851', '3');


INSERT INTO alunos (id_usuario, RA, progresso, semestre, avatar) VALUES
('1', '26.00722-9', '0.0', '1', '1'),
('2', '26.00579-3', '0.0', '1', '1'),
('3', '26.00987-8', '0.0', '1', '1'),
('4', '26.00044-8', '0.0', '1', '1'),
('5', '26.00399-6', '0.0', '1', '1');

INSERT INTO tabuleiro
(nome, descricao)

VALUES
('Tabuleiro Principal', 'Mapa principal');

INSERT INTO casas
(nome_local, descricao, tipo_casa, id_tabuleiro)

VALUES
('Casa 1', 'Primeira casa do jogo', 'tarefa', 1),

('Casa 2', 'Segunda casa do jogo', 'tarefa', 1),

('Casa 3', 'Terceira casa do jogo', 'tarefa', 1),

('Casa 4', 'Quarta casa do jogo', 'tarefa', 1);

SELECT * FROM usuarios; SELECT * FROM cursos; SELECT * FROM alunos; SELECT * FROM tarefas;




