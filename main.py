import mysql.connector

# =====================================
# CONEXÃO COM O BANCO
# =====================================

conexao = mysql.connector.connect(
    host='localhost',
    database='db_jogo',
    user='root',
    password='your_password'
)

# =====================================
# VERIFICA CONEXÃO
# =====================================

if conexao.is_connected():

    print("Conectado ao banco com sucesso!")

    cursor = conexao.cursor(buffered=True)

    tarefas_jogo = {}

    # =====================================
    # MOSTRAR CURSOS
    # =====================================

    print("\n--- CURSOS ---")

    cursor.execute("""
    SELECT id_curso, sigla
    FROM cursos
    """)

    for linha in cursor.fetchall():
        print(linha)

    # =====================================
    # MOSTRAR CASAS
    # =====================================

    print("\n--- CASAS ---")

    cursor.execute("""
    SELECT id_casa, nome_local
    FROM casas
    """)

    for linha in cursor.fetchall():
        print(linha)

    # =====================================
    # LOGIN
    # =====================================

    email = input('\nEmail Mauá: ')
    senha = input('Senha: ')

    query_login = """
    SELECT
        id_usuario,
        nome,
        is_professor,
        id_curso

    FROM usuarios

    WHERE email = %s
    AND senha = %s
    """

    cursor.execute(query_login, (email, senha))

    resultado = cursor.fetchone()

    # =====================================
    # VERIFICA LOGIN
    # =====================================

    if resultado:

        print("\nUsuário encontrado!")

        # =====================================
        # DADOS DO USUÁRIO
        # =====================================

        id_usuario = resultado[0]
        nome_usuario = resultado[1]
        is_professor = resultado[2]
        id_curso = resultado[3]

        print("Bem-vindo,", nome_usuario)

        # =====================================
        # PROFESSOR
        # =====================================

        if is_professor == 1:

            print("\nAcesso de professor liberado.")

            print("\n1 -> Criar tarefa")
            print("2 -> Excluir tarefa")
            print("3 -> Ver tarefas")

            opcao = input("\nEscolha uma opção: ")

            # =====================================
            # CRIAR TAREFA
            # =====================================

            if opcao == '1':

                titulo = input(
                    "\nTítulo da tarefa: "
                )

                descricao = input(
                    "Descrição da tarefa: "
                )

                data_entrega = input(
                    "Data de entrega (AAAA-MM-DD): "
                )

                print("\nCasas disponíveis:")
                print("1 -> Casa 1")
                print("2 -> Casa 2")
                print("3 -> Casa 3")
                print("4 -> Casa 4")

                id_casa = input(
                    "\nEscolha o ID da casa: "
                )

                if id_casa not in ['1', '2', '3', '4']:

                    print("\nCasa inválida.")

                else:

                    query_tarefa = """
                    INSERT INTO tarefas
                    (
                        titulo,
                        descricao,
                        data_entrega,
                        id_usuario,
                        id_casa,
                        id_curso
                    )

                    VALUES (%s, %s, %s, %s, %s, %s)
                    """

                    valores = (
                        titulo,
                        descricao,
                        data_entrega,
                        id_usuario,
                        id_casa,
                        id_curso
                    )

                    cursor.execute(query_tarefa, valores)

                    conexao.commit()

                    print("\nTarefa criada com sucesso!")

            # =====================================
            # EXCLUIR TAREFA
            # =====================================

            elif opcao == '2':

                print("\n--- TAREFAS ---")

                cursor.execute("""
                SELECT id_tarefa, titulo
                FROM tarefas
                """)

                tarefas = cursor.fetchall()

                for tarefa in tarefas:
                    print(tarefa)

                id_tarefa = input(
                    "\nDigite o ID da tarefa que deseja excluir: "
                )

                query_delete = """
                DELETE FROM tarefas
                WHERE id_tarefa = %s
                """

                cursor.execute(query_delete, (id_tarefa,))

                conexao.commit()

                print("\nTarefa excluída com sucesso!")

                        # =====================================
            # VER TAREFAS
            # =====================================

            elif opcao == '3':

                print("\n--- TAREFAS DISPONÍVEIS ---")

                query_tarefas = """
                SELECT
                    titulo,
                    descricao,
                    data_entrega,
                    id_casa

                FROM tarefas

                WHERE id_curso = %s
                """

                cursor.execute(query_tarefas, (id_curso,))

                tarefas = cursor.fetchall()

                # =====================================
                # DICIONÁRIO DAS TAREFAS
                # =====================================

                tarefas_jogo = {}

                # =====================================
                # PREENCHER DICIONÁRIO
                # =====================================

                for i, tarefa in enumerate(tarefas):

                    tarefas_jogo[f"tarefa{i+1}"] = {

                        "titulo": tarefa[0],

                        "descricao": tarefa[1],

                        "data_entrega": tarefa[2],

                        "casa": tarefa[3]
                    }

                # =====================================
                # MOSTRAR TAREFAS
                # =====================================

                if tarefas_jogo:

                    for chave, dados in tarefas_jogo.items():

                        print("\n====================")

                        print("Título:", dados["titulo"])

                        print("Descrição:", dados["descricao"])

                        print("Data de entrega:", dados["data_entrega"])

                        print("Casa:", dados["casa"])
                    
                    # ==========================================
                    # EXIBIR PELA VARIAVEL: (TEM QUE LOGAR COMO PROF)
                    # Ex: print(tarefas_jogo['tarefa1']['titulo'])
                    # ==========================================
                    
                else:

                    print("\nNenhuma tarefa encontrada.")

        # =====================================
        # ALUNO
        # =====================================

        else:

            print("\nVocê é um aluno.")

            print("\n--- TAREFAS DISPONÍVEIS ---")

            query_aluno = """
            SELECT
                titulo,
                descricao,
                data_entrega,
                id_casa

            FROM tarefas

            WHERE id_curso = %s
            """

            cursor.execute(query_aluno, (id_curso,))

            tarefas = cursor.fetchall()

            if tarefas:

                for tarefa in tarefas:

                    print("\n====================")

                    print("Título:", tarefa[0])

                    print("Descrição:", tarefa[1])

                    print("Data de entrega:", tarefa[2])

                    print("Casa:", tarefa[3])

            else:

                print("\nNenhuma tarefa encontrada.")
    else:

        print("\nUsuário não encontrado.")

    # =====================================
    # ENCERRA CONEXÃO
    # =====================================

    cursor.close()
    conexao.close()

    print("\nConexão encerrada.")

else:

    print("Não foi possível conectar ao banco.")
