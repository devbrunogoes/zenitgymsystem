package br.com.zenitgymsystem.dao;

import br.com.zenitgymsystem.model.TreinoAluno;
import br.com.zenitgymsystem.util.Conexao;
import java.sql.*;

public class TreinoAlunoDAO {

    private final Connection conexao;

    public TreinoAlunoDAO() throws ClassNotFoundException, SQLException {
        this.conexao = Conexao.abrirConexao();
    }

    public void associarTreinoAoAluno(TreinoAluno treinoAluno) throws SQLException {
        String sql = "INSERT INTO TreinoAluno (codAluno, codTreino) VALUES (?, ?)";
        System.out.println("Iniciando associação do treino ao aluno. SQL: " + sql);
        PreparedStatement stmt = null;
        try {
            stmt = conexao.prepareStatement(sql);

            System.out.println("Código do Aluno: " + treinoAluno.getAluno().getCodAluno());
            System.out.println("Código do Treino: " + treinoAluno.getTreino().getCodTreino());

            stmt.setInt(1, treinoAluno.getAluno().getCodAluno());
            stmt.setInt(2, treinoAluno.getTreino().getCodTreino());

            int rowsAffected = stmt.executeUpdate();
            System.out.println("Associação concluída. Linhas afetadas: " + rowsAffected);

        } catch (SQLException e) {
            System.out.println("Erro no método associarTreinoAoAluno: " + e.getMessage());
            throw e; // Relança a exceção para ser capturada no servlet
        }finally {
            Conexao.encerrarConexao(conexao, stmt);
        }
    }

    

}
