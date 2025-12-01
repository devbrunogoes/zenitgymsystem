package br.com.zenitgymsystem.dao;

import br.com.zenitgymsystem.model.ExercicioTreino;
import br.com.zenitgymsystem.model.Exercicio;
import br.com.zenitgymsystem.model.Treino;
import br.com.zenitgymsystem.util.Conexao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

public class ExercicioTreinoDAO {

    private Connection conexao;

    public ExercicioTreinoDAO() throws ClassNotFoundException, SQLException {
        this.conexao = Conexao.abrirConexao();
    }

    public void gravar(ExercicioTreino exercicioTreino, int codTrAluno) throws SQLException {
        if (exercicioTreino.getCodET() == 0) {
            // Se não existe um código, é um novo exercício vinculado ao treino
            this.inserir(exercicioTreino, codTrAluno);
        } else {
            // Se já existe um código, é uma atualização
            this.alterar(exercicioTreino);
        }
    }

    public void inserir(ExercicioTreino exercicioTreino, int codTrAluno) throws SQLException {
        String sql = "INSERT INTO ExercicioTreino (tipoET, seriesET, repeticoesET, pesoET, descansoET, duracaoET, obsET,  codEx, codTreino) "
                + "VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement stmt = null;

        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, exercicioTreino.getTipoET());
            stmt.setInt(2, exercicioTreino.getSeriesET());
            stmt.setInt(3, exercicioTreino.getRepeticoesET());
            stmt.setDouble(4, exercicioTreino.getPesoET());
            stmt.setInt(5, exercicioTreino.getDescansoET());
            stmt.setInt(6, exercicioTreino.getDuracaoET());
            stmt.setString(7, exercicioTreino.getObsET());
            stmt.setInt(8, exercicioTreino.getExercicio().getCodEx());
            stmt.setInt(9, exercicioTreino.getTreino().getCodTreino());

            stmt.executeUpdate();
            System.out.println("Exercício vinculado ao treino com sucesso!");
        } catch (SQLException ex) {
            ex.printStackTrace();
            throw new SQLException("Erro ao inserir exercício no treino!");
        } finally {
            Conexao.encerrarConexao(conexao, stmt);
        }

    }

    public void adicionarExercicioAoTreino(ExercicioTreino exercicioTreino) throws SQLException {
        String sql = "INSERT INTO ExercicioTreino (codTreino, codEx, tipoET, seriesET, repeticoesET, pesoET, descansoET, duracaoET, obsET) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement stmt = null;

        try {
            // Verificar se a conexão está aberta
            if (conexao == null || conexao.isClosed()) {
                conexao = Conexao.abrirConexao(); // Recriar a conexão se necessário
            }

            stmt = conexao.prepareStatement(sql);

            // Verificações antes de inserir os dados
            if (exercicioTreino.getTreino() == null || exercicioTreino.getTreino().getCodTreino() <= 0) {
                throw new SQLException("Treino não está associado.");
            }
            if (exercicioTreino.getExercicio() == null || exercicioTreino.getExercicio().getCodEx() <= 0) {
                throw new SQLException("Exercício não está associado.");
            }

            // Definir os parâmetros do SQL
            stmt.setInt(1, exercicioTreino.getTreino().getCodTreino());
            stmt.setInt(2, exercicioTreino.getExercicio().getCodEx());
            stmt.setString(3, exercicioTreino.getTipoET());
            stmt.setInt(4, exercicioTreino.getSeriesET());
            stmt.setInt(5, exercicioTreino.getRepeticoesET());
            stmt.setDouble(6, exercicioTreino.getPesoET());
            stmt.setInt(7, exercicioTreino.getDescansoET());
            stmt.setInt(8, exercicioTreino.getDuracaoET());
            stmt.setString(9, exercicioTreino.getObsET());

            // Executar a inserção
            stmt.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            throw new SQLException("Erro ao adicionar exercício ao treino.", e);
        } finally {
            Conexao.encerrarConexao(conexao, stmt);
        }
    }

    public List<ExercicioTreino> listar() throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM ExercicioTreino";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<ExercicioTreino> lista = new ArrayList<>();

        try {
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                // Consultar os objetos Exercicio e TreinoAluno
                Exercicio exercicio = new ExercicioDAO().consultar(rs.getInt("codEx"));
                Treino treino = new TreinoDAO().consultar(rs.getInt("codTreino"));

                // Criar o objeto ExercicioTreino
                ExercicioTreino exercicioTreino = new ExercicioTreino(
                        rs.getInt("codET"), // Código do exercício treino
                        exercicio, // Objeto Exercicio
                        treino, // Objeto TreinoAluno
                        rs.getString("tipoET"), // Tipo do exercício
                        rs.getInt("seriesET"), // Séries
                        rs.getInt("repeticoesET"), // Repetições
                        rs.getDouble("pesoET"), // Peso do exercício
                        rs.getInt("descansoET"), // Descanso
                        rs.getInt("duracaoET"), // Duração
                        rs.getString("obsET") // Observações
                );

                lista.add(exercicioTreino);
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
            throw new SQLException("Erro ao listar ExercicioTreino: " + ex.getMessage());
        } finally {
            Conexao.encerrarConexao(conexao, stmt, rs);
        }

        return lista;
    }

    public List<ExercicioTreino> listarExerciciosPorAluno(int codAluno) throws SQLException {
        List<ExercicioTreino> listaExercicios = new ArrayList<>();
        String sql = "SELECT et.codET, et.tipoET, et.seriesET, et.repeticoesET, et.pesoET, et.descansoET, et.duracaoET, et.obsET, "
                + "et.codEx, et.codTreino "
                + "FROM ExercicioTreino et "
                + "JOIN TreinoAluno ta ON et.codTreino = ta.codTreino "
                + "WHERE ta.codAluno = ?";  // Filtra pelos treinos do aluno
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, codAluno);  // Passa o código do aluno
            rs = stmt.executeQuery();

            while (rs.next()) {
                // Consultar o exercício
                Exercicio exercicio = new ExercicioDAO().consultar(rs.getInt("codEx"));
                // Consultar o treino
                Treino treino = new TreinoDAO().consultar(rs.getInt("codTreino"));

                // Criar o objeto ExercicioTreino e adicionar à lista
                ExercicioTreino exercicioTreino = new ExercicioTreino(
                        rs.getInt("codET"), // Código do exercício treino
                        exercicio, // Objeto Exercicio
                        treino, // Objeto Treino
                        rs.getString("tipoET"), // Tipo do exercício
                        rs.getInt("seriesET"), // Séries
                        rs.getInt("repeticoesET"), // Repetições
                        rs.getDouble("pesoET"), // Peso do exercício
                        rs.getInt("descansoET"), // Descanso
                        rs.getInt("duracaoET"), // Duração
                        rs.getString("obsET") // Observações
                );

                listaExercicios.add(exercicioTreino);
            }

        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
            throw new SQLException("Erro ao listar Exercícios por Aluno: " + ex.getMessage());
        } finally {
            Conexao.encerrarConexao(conexao, stmt, rs);
        }

        return listaExercicios;
    }

    // Método para alterar um ExercicioTreino
    private void alterar(ExercicioTreino exercicioTreino) throws SQLException {
        String sql = "UPDATE ExercicioTreino SET pesoET = ?, repeticoesET = ?, seriesET = ?, tipoET = ?, descansoET = ?, duracaoET = ?,  obsET = ?, codEx = ? WHERE codET = ?";
        PreparedStatement stmt = null;

        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setDouble(1, exercicioTreino.getPesoET());
            stmt.setInt(2, exercicioTreino.getRepeticoesET());
            stmt.setInt(3, exercicioTreino.getSeriesET());
            stmt.setString(4, exercicioTreino.getTipoET());
            stmt.setInt(5, exercicioTreino.getDescansoET());
            stmt.setInt(6, exercicioTreino.getDuracaoET());
            stmt.setString(7, exercicioTreino.getObsET());
            stmt.setInt(8, exercicioTreino.getExercicio().getCodEx());
            stmt.setInt(9, exercicioTreino.getCodET());

            stmt.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
            throw new SQLException("Erro ao atualizar ExercicioTreino: " + ex.getMessage());
        } finally {
            Conexao.encerrarConexao(conexao, stmt);
        }
    }
}
