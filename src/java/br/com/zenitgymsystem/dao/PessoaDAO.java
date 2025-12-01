package br.com.zenitgymsystem.dao;

import br.com.zenitgymsystem.model.Pessoa;
import br.com.zenitgymsystem.util.Conexao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class PessoaDAO {

    private final Connection conexao;

    public PessoaDAO() throws ClassNotFoundException, SQLException {
        conexao = Conexao.abrirConexao();
    }

    public int gravar(Object objeto) throws SQLException {
        Pessoa pessoa = (Pessoa) objeto;
        if (pessoa.getCodPessoa() == 0) {
            return this.inserir(pessoa);
        } else {
            return this.alterar(pessoa);
        }
    }

    public int inserir(Object objeto) throws SQLException {
        String sql = "INSERT INTO pessoa VALUES (default,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) returning codPessoa";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int codPessoa = 0;
        Pessoa pessoa = (Pessoa) objeto;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, pessoa.getNomePessoa());
            stmt.setString(2, pessoa.getSenhaPessoa());
            stmt.setDate(3, new java.sql.Date(new SimpleDateFormat("yyyy-MM-dd").parse(pessoa.getDtnascPessoa()).getTime()));
            stmt.setString(4, pessoa.getCpfPessoa());
            stmt.setString(5, pessoa.getRgPessoa());
            stmt.setString(6, pessoa.getSexoPessoa());
            stmt.setString(7, pessoa.getCelularPessoa());
            stmt.setString(8, pessoa.getCepPessoa());
            stmt.setString(9, pessoa.getEndPessoa());
            stmt.setString(10, pessoa.getComplPessoa());
            stmt.setInt(11, pessoa.getNumeroPessoa());
            stmt.setString(12, pessoa.getCidadePessoa());
            stmt.setString(13, pessoa.getUfPessoa());
            stmt.setString(14, pessoa.getBairroPessoa());
            stmt.setString(15, pessoa.getEmailPessoa());
            stmt.setString(16, pessoa.getImgPessoa());
            rs = stmt.executeQuery();
            while (rs.next()) {
                codPessoa = rs.getInt("codPessoa");
            }
        } catch (SQLException | ParseException ex) {
            throw new SQLException("Erro na DAO ao INSERIR PESSOA!" + ex.getMessage());
        } finally {

            Conexao.encerrarConexao(conexao, stmt, rs);
        }
        return codPessoa;
    }

    public Object consultar(String cpfPessoa) throws SQLException {
        String sql = "SELECT * FROM pessoa WHERE cpfPessoa = ?";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Pessoa pessoa = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, cpfPessoa);
            rs = stmt.executeQuery();
            while (rs.next()) {
                pessoa = new Pessoa(
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
        } catch (SQLException ex) {
            throw new SQLException("ERRO na DAO ao consultar pessoa!");
        } finally {
            Conexao.encerrarConexao(conexao, stmt, rs);
        }
        return pessoa;
    }

    private int alterar(Object object) throws SQLException {
        String sql = "UPDATE Pessoa SET nomePessoa = ?, senhaPessoa = ?, dtnascPessoa = ?, cpfPessoa = ?, rgPessoa = ?, sexoPessoa = ?"
                + " celularPessoa = ?, cepPessoa = ? endPessoa = ?, complPessoa = ?, numeroPessoa = ?"
                + " cidadePessoa = ?, ufPessoa = ?, bairroPessoa = ? emailPessoa = ?, imgPessoa = ? WHERE codPessoa = ?";
        Pessoa pessoa = new Pessoa();
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int codPessoa = 0;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, pessoa.getNomePessoa());
            stmt.setString(2, pessoa.getSenhaPessoa());
            if (pessoa.getDtnascPessoa().contains("/")) {
                stmt.setDate(2, new java.sql.Date(new SimpleDateFormat("dd/MM/yyyy").
                        parse(pessoa.getDtnascPessoa()).getTime()));
            } else {
                stmt.setDate(2, new java.sql.Date(new SimpleDateFormat("yyyy-MM-dd").
                        parse(pessoa.getDtnascPessoa()).getTime()));
            }
            stmt.setString(3, pessoa.getCpfPessoa());
            stmt.setString(4, pessoa.getRgPessoa());
            stmt.setString(5, pessoa.getSexoPessoa());
            stmt.setString(6, pessoa.getCelularPessoa());
            stmt.setString(7, pessoa.getCepPessoa());
            stmt.setString(8, pessoa.getEndPessoa());
            stmt.setString(9, pessoa.getComplPessoa());
            stmt.setInt(10, pessoa.getNumeroPessoa());
            stmt.setString(11, pessoa.getCidadePessoa());
            stmt.setString(12, pessoa.getUfPessoa());
            stmt.setString(13, pessoa.getBairroPessoa());
            stmt.setString(14, pessoa.getEmailPessoa());
            stmt.setString(15, pessoa.getImgPessoa());
            rs = stmt.executeQuery();
            while (rs.next()) {
                codPessoa = rs.getInt("codPessoa");
            }
        } catch (SQLException | ParseException ex) {
            System.out.println("ERRO na DAO Alterar Pessoa! ERRO: " + ex.getMessage());
            //mostar uma pilha de erros
            ex.printStackTrace();
            throw new SQLException("Erro na DAO ao ALTERAR PESSOA!");
        } finally {

            Conexao.encerrarConexao(conexao, stmt);
        }
        return codPessoa;
    }

}
