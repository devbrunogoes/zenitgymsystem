package br.com.zenitgymsystem.dao;

import br.com.zenitgymsystem.model.Aluno;
import br.com.zenitgymsystem.model.Pessoa;
import br.com.zenitgymsystem.model.Personal;
import br.com.zenitgymsystem.model.Plano;
import br.com.zenitgymsystem.model.Usuario;
import br.com.zenitgymsystem.util.Conexao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

public class AlunoDAO {

    private final Connection conexao;

    public AlunoDAO() throws ClassNotFoundException, SQLException {
        this.conexao = Conexao.abrirConexao();
    }

    public void gravar(Object objeto) throws SQLException {
        Aluno aluno = (Aluno) objeto;
        if (aluno.getCodAluno() == 0) {
            this.inserir(aluno);
        } else {
            this.alterar(aluno);
        }
    }

    public void inserir(Object objeto) throws SQLException {
        Aluno aluno = (Aluno) objeto;
        String sql = "INSERT INTO aluno VALUES (default, ?, ?, ?, ?, ?, ?) returning codAluno";
        PreparedStatement stmt = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setBoolean(1, aluno.isStatusAluno());
            stmt.setDate(2, new java.sql.Date(new SimpleDateFormat("yyyy-MM-dd").parse(aluno.getDtMatriculaAluno()).getTime()));
            stmt.setString(3, aluno.getObsAluno());
            stmt.setInt(4, aluno.getPersonal().getCodPers());
            stmt.setInt(5, new PessoaDAO().gravar(aluno));
            stmt.setInt(6, aluno.getPlano().getCodPlano());
            stmt.execute();

        } catch (SQLException | ClassNotFoundException | ParseException ex) {
            ex.printStackTrace();
            throw new SQLException("Erro ao inserir aluno: " + ex.getMessage());
        } finally {
            Conexao.encerrarConexao(conexao, stmt);
        }
    }

    public List<Object> listar() throws SQLException {
        String sql = "SELECT * FROM pessoa pe INNER JOIN aluno al ON pe.codPessoa = al.codPessoa ";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Object> lista = new ArrayList<>();
        try {
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Aluno aluno = new Aluno(
                        rs.getInt("codAluno"),
                        rs.getBoolean("statusAluno"),
                        new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("dtMatriculaAluno")),
                        rs.getString("obsAluno"),
                        (Personal) new PersonalDAO().consultar(rs.getInt("codPers")),
                        (Plano) new PlanoDAO().consultar(rs.getInt("codPlano")),
                        rs.getInt("codPessoa"),
                        rs.getString("nomePessoa"),
                        rs.getString("senhaPessoa"),
                        new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("dtnascPessoa")),
                        rs.getString("cpfPessoa"),
                        rs.getString("rgPessoa"),
                        rs.getString("sexoPessoa"),
                        rs.getString("celularPessoa"),
                        rs.getString("cepPessoa"),
                        rs.getString("endPessoa"),
                        rs.getString("complPessoa"),
                        rs.getInt("numeroPessoa"),
                        rs.getString("cidadePessoa"),
                        rs.getString("ufPessoa"),
                        rs.getString("bairroPessoa"),
                        rs.getString("emailPessoa"),
                        rs.getString("imgPessoa")
                );
                lista.add(aluno);
            }
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
            throw new SQLException("Erro ao listar alunos: " + ex.getMessage());
        } finally {
            Conexao.encerrarConexao(conexao, stmt, rs);
        }
        return lista;
    }

    public Object consultar(int codAluno) throws SQLException {
        String sql = "SELECT * FROM pessoa pe INNER JOIN aluno al ON pe.codPessoa = al.codPessoa  WHERE codAluno = ?";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Aluno aluno = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, codAluno);
            rs = stmt.executeQuery();
            if (rs.next()) {
                aluno = new Aluno(
                        rs.getInt("codAluno"),
                        rs.getBoolean("statusAluno"),
                        new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("dtMatriculaAluno")),
                        rs.getString("obsAluno"),
                        (Personal) new PersonalDAO().consultar(rs.getInt("codPers")),
                        (Plano) new PlanoDAO().consultar(rs.getInt("codPlano")),
                        rs.getInt("codPessoa"),
                        rs.getString("nomePessoa"),
                        rs.getString("senhaPessoa"),
                        new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("dtnascPessoa")),
                        rs.getString("cpfPessoa"),
                        rs.getString("rgPessoa"),
                        rs.getString("sexoPessoa"),
                        rs.getString("celularPessoa"),
                        rs.getString("cepPessoa"),
                        rs.getString("endPessoa"),
                        rs.getString("complPessoa"),
                        rs.getInt("numeroPessoa"),
                        rs.getString("cidadePessoa"),
                        rs.getString("ufPessoa"),
                        rs.getString("bairroPessoa"),
                        rs.getString("emailPessoa"),
                        rs.getString("imgPessoa")
                );
            }
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
            throw new SQLException("Erro ao consultar aluno: " + ex.getMessage());
        } finally {
            Conexao.encerrarConexao(conexao, stmt, rs);
        }
        return aluno;
    }

    public Object consultarporCPF(String cpfPessoa) throws SQLException {
        String sql = "SELECT * FROM pessoa pe INNER JOIN aluno cl ON pe.codPessoa = cl.codPessoa WHERE cpfPessoa = ?";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Aluno aluno = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, cpfPessoa);
            rs = stmt.executeQuery();
            if (rs.next()) {
                aluno = new Aluno(
                        rs.getInt("codAluno"),
                        rs.getBoolean("statusAluno"),
                        new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("dtMatriculaAluno")),
                        rs.getString("obsAluno"),
                        (Personal) new PersonalDAO().consultar(rs.getInt("codPers")),
                        (Plano) new PlanoDAO().consultar(rs.getInt("codPlano")),
                        rs.getInt("codPessoa"),
                        rs.getString("nomePessoa"),
                        rs.getString("senhaPessoa"),
                        new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("dtnascPessoa")),
                        rs.getString("cpfPessoa"),
                        rs.getString("rgPessoa"),
                        rs.getString("sexoPessoa"),
                        rs.getString("celularPessoa"),
                        rs.getString("cepPessoa"),
                        rs.getString("endPessoa"),
                        rs.getString("complPessoa"),
                        rs.getInt("numeroPessoa"),
                        rs.getString("cidadePessoa"),
                        rs.getString("ufPessoa"),
                        rs.getString("bairroPessoa"),
                        rs.getString("emailPessoa"),
                        rs.getString("imgPessoa")
                );
            }
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
            throw new SQLException("Erro ao consultar aluno: " + ex.getMessage());
        } finally {
            Conexao.encerrarConexao(conexao, stmt, rs);
        }
        return aluno;
    }

    public void alterar(Object objeto) throws SQLException {
        Aluno aluno = (Aluno) objeto;
        String sql = "UPDATE aluno SET statusAluno = ?, dtMatriculaAluno = ?, nivelFitAluno = ?, pesoAluno = ?, alturaAluno = ?, objAluno = ?, obsAluno = ?, codPers = ?, codPlano = ? WHERE codAluno = ?";
        PreparedStatement stmt = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setBoolean(1, aluno.isStatusAluno());
            stmt.setString(2, aluno.getDtMatriculaAluno());
            stmt.setString(3, aluno.getObsAluno());
            stmt.setInt(4, aluno.getPersonal().getCodPers());
            stmt.setInt(5, aluno.getPlano().getCodPlano());
            stmt.setInt(6, aluno.getCodAluno());
            stmt.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
            throw new SQLException("Erro ao alterar aluno: " + ex.getMessage());
        } finally {
            Conexao.encerrarConexao(conexao, stmt);
        }
    }

    public void excluir(int codigo) throws SQLException {
        String sql = "DELETE FROM aluno WHERE codAluno = ?";
        PreparedStatement stmt = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, codigo);
            stmt.execute();
        } catch (SQLException ex) {
            ex.printStackTrace();
            throw new SQLException("Erro ao excluir aluno: " + ex.getMessage());
        } finally {
            Conexao.encerrarConexao(conexao, stmt);
        }
    }

    public List<Aluno> listarAlunosPorPersonal(int codPers) throws SQLException {
    String sql = "SELECT pe.*, al.* FROM pessoa pe INNER JOIN aluno al ON pe.codPessoa = al.codPessoa WHERE al.codPers = ?";
    PreparedStatement stmt = null;
    ResultSet rs = null;
    List<Aluno> listaalpers = new ArrayList<>();

    try {
        stmt = conexao.prepareStatement(sql);
        stmt.setInt(1, codPers); // Define o código do personal trainer logado
        rs = stmt.executeQuery();

        while (rs.next()) {
            Aluno aluno = new Aluno(
                rs.getInt("codAluno"),
                rs.getBoolean("statusAluno"),
                new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("dtMatriculaAluno")),
                rs.getString("obsAluno"),
                (Personal) new PersonalDAO().consultar(rs.getInt("codPers")),
                (Plano) new PlanoDAO().consultar(rs.getInt("codPlano")),
                rs.getInt("codPessoa"),
                rs.getString("nomePessoa"),
                rs.getString("senhaPessoa"),
                new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("dtnascPessoa")),
                rs.getString("cpfPessoa"),
                rs.getString("rgPessoa"),
                rs.getString("sexoPessoa"),
                rs.getString("celularPessoa"),
                rs.getString("cepPessoa"),
                rs.getString("endPessoa"),
                rs.getString("complPessoa"),
                rs.getInt("numeroPessoa"),
                rs.getString("cidadePessoa"),
                rs.getString("ufPessoa"),
                rs.getString("bairroPessoa"),
                rs.getString("emailPessoa"),
                rs.getString("imgPessoa")
            );
            listaalpers.add(aluno);
        }
    } catch (SQLException | ClassNotFoundException ex) {
        ex.printStackTrace();
        throw new SQLException("Erro ao listar alunos: " + ex.getMessage());
    } finally {
        Conexao.encerrarConexao(conexao, stmt, rs);
    }
    return listaalpers;
}


}
