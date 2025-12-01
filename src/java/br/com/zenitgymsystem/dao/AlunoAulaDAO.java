package br.com.zenitgymsystem.dao;


import br.com.zenitgymsystem.model.AlunoAula;
import br.com.zenitgymsystem.util.Conexao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;


public class AlunoAulaDAO {

    private final Connection conexao;

    public AlunoAulaDAO() throws ClassNotFoundException, SQLException {
        this.conexao = Conexao.abrirConexao();
    }

    public void associarAulaAluno(AlunoAula alunoAula) throws SQLException {
        String sql = "INSERT INTO AlunoAula (codAluno, codAula) VALUES (?, ?)";
        PreparedStatement stmt = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, alunoAula.getAluno().getCodAluno());
            stmt.setInt(2, alunoAula.getAula().getCodAula());
            stmt.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
            throw new SQLException("Erro ao inserir administrador");
        } finally {
            Conexao.encerrarConexao(conexao, stmt);
        }
    }


}
