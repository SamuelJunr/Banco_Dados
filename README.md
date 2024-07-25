# Personalizando-o-Banco-de-Dados-com-ndices-e-Procedures
Projeto Personalizando o Banco de Dados com Índices e Procedures

Neste desafio, eu vou personalizar o banco de dados criando índices e procedures para o cenário de Company e E-commerce. Vamos começar pela Parte 1, que envolve a criação de índices em Banco de Dados.

## Parte 1 – Criando índices em Banco de Dados
A criação de índices visa otimizar consultas no banco de dados. Para isso, consideraremos os seguintes aspectos:

Dados mais acessados: Identifique quais dados são frequentemente consultados.
Dados mais relevantes no contexto: Pense nos dados essenciais para o funcionamento do sistema.
Função do índice: Lembre-se de que o índice impacta diretamente na velocidade de busca das informações no SGBD. Portanto, crie apenas os índices importantes.
Além disso, adicione um README ao repositório do GitHub explicando os motivos por trás da criação desses índices. Isso permitirá que outras pessoas se espelhem em seu trabalho.

A criação dos índices pode ser feita via ALTER TABLE ou CREATE Statement. Veja o exemplo:

ALTER TABLE customer ADD UNIQUE index_email(email);
CREATE INDEX index_ativo_hash ON exemplo(ativo) USING HASH;
Perguntas:
Qual é o departamento com o maior número de pessoas?
Quais são os departamentos por cidade?
Qual é a relação de empregados por departamento?
Entregável:
Crie as queries para responder essas perguntas.
Crie o índice para cada tabela envolvida, conforme a necessidade.
Indique o tipo de índice utilizado e explique o motivo da escolha (via comentário no script ou README).
## Parte 2 - Utilização de Procedures para Manipulação de Dados em Banco de Dados

Nesta etapa, vamos criar uma procedure que englobe as instruções de inserção, remoção e atualização de dados no banco de dados. Essas instruções devem estar dentro de estruturas condicionais, como CASE ou IF.

Além das variáveis para receber as informações, a procedure também terá uma variável de controle. Essa variável determinará a ação a ser executada. Por exemplo:

Opção 1: Selecionar dados (SELECT).
Opção 2: Atualizar dados (UPDATE).
Opção 3: Excluir dados (DELETE).
A seguir, apresento um exemplo de como você pode alterar a procedure existente para atender a esses requisitos:

-- Exemplo de Procedure com Controle de Ação
CREATE PROCEDURE sp_ManipularDados
(
    IN p_Acao INT, -- Variável de controle (1: SELECT, 2: UPDATE, 3: DELETE)
    IN p_Parametro1 VARCHAR(255), -- Parâmetro 1 (por exemplo, ID do registro)
    IN p_Parametro2 INT -- Parâmetro 2 (outro campo relevante)
)
BEGIN
    -- Estrutura condicional para determinar a ação
    CASE p_Acao
        WHEN 1 THEN
            -- SELECT: Recuperar dados
            SELECT * FROM minha_tabela WHERE campo1 = p_Parametro1;
        WHEN 2 THEN
            -- UPDATE: Atualizar dados
            UPDATE minha_tabela SET campo2 = p_Parametro2 WHERE campo1 = p_Parametro1;
        WHEN 3 THEN
            -- DELETE: Excluir dados
            DELETE FROM minha_tabela WHERE campo1 = p_Parametro1;
        ELSE
            -- Ação inválida
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ação inválida!';
    END CASE;
END;
Entregável:
Crie o script SQL com a procedure modificada conforme o exemplo acima.
Realize a chamada da procedure para manipular os dados das tabelas de universidade e e-commerce.
Você pode criar dois arquivos distintos ou utilizar o mesmo script para a criação das procedures. Lembre-se de selecionar o banco de dados correto antes de criar a procedure.
