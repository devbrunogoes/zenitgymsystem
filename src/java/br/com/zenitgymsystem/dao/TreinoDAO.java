package br.com.zenitgymsystem.dao;

import br.com.zenitgymsystem.model.Treino;
import br.com.zenitgymsystem.util.Conexao;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

public class TreinoDAO {

    private final Connection conexao;

    public TreinoDAO() throws ClassNotFoundException, SQLException {
        this.conexao = Conexao.abrirConexao();
    }

    public int gravar(Object objeto) throws SQLException {
        Treino treino = (Treino) objeto;
        if (treino.getCodTreino() == 0) {
            // Chama a função inserir, que vai retornar o codTreino gerado
            return this.inserir(treino);
        } else {
            this.alterar(treino);
            return treino.getCodTreino();  // Retorna o codTreino atualizado
        }
    }

    public int inserir(Treino treino) throws SQLException {
        String sql = "INSERT INTO treino (nomeTreino, descricaoTreino, dtTreino, statusTreino) VALUES (?, ?, ?, ?)";
        int codTreino = 0;  // Variável para armazenar o código gerado.

        try (PreparedStatement stmt = conexao.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            // Definir os parâmetros do PreparedStatement
            stmt.setString(1, treino.getNomeTreino());
            stmt.setString(2, treino.getDescricaoTreino());

            // Converte a data corretamente se necessário
            stmt.setDate(3, java.sql.Date.valueOf(treino.getDtTreino()));  // Melhor para o formato "yyyy-MM-dd"

            stmt.setBoolean(4, treino.isStatusTreino());

            // Executar a atualização
            int affectedRows = stmt.executeUpdate();

            // Se as linhas foram afetadas (inserção bem-sucedida)
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        codTreino = generatedKeys.getInt(1);  // Recupera o código gerado
                        treino.setCodTreino(codTreino);  // Atualiza o objeto treino com o código gerado
                    }
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            throw new SQLException("Erro ao inserir treino: " + ex.getMessage(), ex);
        }

        return codTreino;  // Retorna o código gerado para o treino
    }

    public List<Treino> listar() throws SQLException {
        String sql = "SELECT * FROM treino";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Treino> lista = new ArrayList<>();
        try {
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Treino treino = new Treino(
                        rs.getInt("codTreino"),
                        rs.getString("nomeTreino"),
                        rs.getString("descricaoTreino"),
                        new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("dtTreino")), // Verifique o formato
                        rs.getBoolean("statusTreino")
                );
                lista.add(treino);
            }
        } catch (SQLException ex) {
            throw new SQLException("Erro ao listar treinos", ex);
        } finally {
            Conexao.encerrarConexao(conexao, stmt, rs);
        }
        return lista;
    }

    public Treino consultar(int codTreino) throws SQLException {
        String sql = "SELECT * FROM treino WHERE codTreino = ?";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Treino treino = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, codTreino);
            rs = stmt.executeQuery();
            if (rs.next()) {
                treino = new Treino(
                        rs.getInt("codTreino"),
                        rs.getString("nomeTreino"),
                        rs.getString("descricaoTreino"),
                        new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("dtTreino")), // Verifique o formato
                        rs.getBoolean("statusTreino")
                );
            }
        } catch (SQLException ex) {
            throw new SQLException("Erro ao consultar treino", ex);
        } finally {
            Conexao.encerrarConexao(conexao, stmt, rs);
        }
        return treino;
    }

    public void alterar(Treino treino) throws SQLException {
        String sql = "UPDATE treino SET nomeTreino = ?, descricaoTreino = ?, dtTreino = ? , statusTreino = ?  WHERE codTreino = ?";
        PreparedStatement stmt = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, treino.getNomeTreino());
            stmt.setString(2, treino.getDescricaoTreino());
            stmt.setDate(3, java.sql.Date.valueOf(treino.getDtTreino()));  // Certifique-se de que a data esteja no formato "yyyy-MM-dd"
            stmt.setBoolean(4, treino.isStatusTreino());
            stmt.setInt(5, treino.getCodTreino());
            stmt.execute();
        } catch (SQLException | IllegalArgumentException ex) {
            ex.printStackTrace();
            throw new SQLException("Erro ao alterar treino", ex);
        } finally {
            Conexao.encerrarConexao(conexao, stmt);
        }
    }

    public void excluir(int codTreino) throws SQLException {
        String sql = "DELETE FROM treino WHERE codTreino = ?";
        PreparedStatement stmt = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, codTreino);
            stmt.execute();
        } catch (SQLException ex) {
            ex.printStackTrace();
            throw new SQLException("Erro ao excluir treino", ex);
        } finally {
            Conexao.encerrarConexao(conexao, stmt);
        }
    }

}
