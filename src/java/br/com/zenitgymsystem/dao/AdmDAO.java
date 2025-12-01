package br.com.zenitgymsystem.dao;

import br.com.zenitgymsystem.model.Administrador;
import br.com.zenitgymsystem.util.Conexao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;


public class AdmDAO {
    
    private final Connection conexao;
    
    public AdmDAO() throws ClassNotFoundException, SQLException{
        this.conexao = Conexao.abrirConexao();
    }
    
   
    public void gravar (Object objeto) throws SQLException{
        Administrador adm = (Administrador) objeto;
        if(adm.getCodAdm()== 0 ){
            this.inserir(adm);
        }else{
            this.alterar(adm);
        }
        
    }

     public void inserir(Object objeto) throws SQLException {
        Administrador administrador = (Administrador) objeto;
        String sql = "insert into administrador values (default, ?, ?)";
        PreparedStatement stmt = null;
        try {
            stmt = conexao.prepareStatement(sql);
            stmt.setBoolean(1,administrador.isStatusAdm());
            stmt.setInt(2, new PessoaDAO().gravar(administrador));
            stmt.execute();
        } catch (SQLException | ClassNotFoundException  ex) {
            ex.printStackTrace();
            throw new SQLException("Erro ao inserir administrador");
        } finally {
            Conexao.encerrarConexao(conexao, stmt);
        }
    }
    
    public List<Object> listar() throws SQLException{
        String sql = "select * from pessoa pe inner join administrador ad on pe.codPessoa = ad.codPessoa";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Object> lista = new ArrayList<>();
        try{
            stmt = conexao.prepareStatement(sql);
            rs = stmt.executeQuery();
            while(rs.next()) {
                Administrador administrador = new Administrador(
                    rs.getInt("codAdm"),
                    rs.getBoolean("statusAdm"),
                    rs.getInt("codPessoa"),
                    rs.getString("nomepessoa"),
                    rs.getString("senhapessoa"),
                    new SimpleDateFormat("yyyy-MM-dd")
                            .format(rs.getDate("dtnascPessoa")),
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
                lista.add(administrador);
            }
        } catch(SQLException ex){
            throw new SQLException("Erro ao listar administrador");
        } finally {
            Conexao.encerrarConexao(conexao, stmt, rs);
        }
        return lista;
    }
    
   public Object consultar(int codAdm) throws SQLException{
        String sql = "select * from pessoa pe inner join administrador fu on pe.codPessoa = fu.codPessoa where codAdm = ?";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Administrador administrador = null;
        try{
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, codAdm);
            rs = stmt.executeQuery();
            while(rs.next()){
                administrador = new Administrador(
                rs.getInt("codAdm"),
                rs.getBoolean("statusAdm"),
                    rs.getInt("codPessoa"),
                    rs.getString("nomepessoa"),
                    rs.getString("senhaPessoa"),
                    new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("dtnascPessoa")),
                    rs.getString("cpfpessoa"),
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
        }
        catch(SQLException  ex){
            ex.printStackTrace();
            System.out.println("Problemas ao Consultar Administrador! ERRO: " + ex.getMessage());
            throw  new SQLException("ERRO na DAO ao consultar Administrador!");
        }
        finally{
            Conexao.encerrarConexao(conexao, stmt, rs);
        }
        return administrador;
    }
   public Object consultarporCPF(String cpfPessoa) throws SQLException{
        String sql = "select * from pessoa pe inner join administrador fu on pe.codPessoa = fu.codPessoa where cpfPessoa = ?";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Administrador administrador = null;
        try{
            stmt = conexao.prepareStatement(sql);
            stmt.setString(1, cpfPessoa);
            rs = stmt.executeQuery();
            while(rs.next()){
               administrador = new Administrador(
                rs.getInt("codAdm"),
                rs.getBoolean("statusAdm"),
                    rs.getInt("codPessoa"),
                    rs.getString("nomepessoa"),
                    rs.getString("senhaPessoa"),
                    new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("dtnascPessoa")),
                    rs.getString("cpfpessoa"),
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
        }
        catch(SQLException  ex){
            ex.printStackTrace();
            System.out.println("Problemas ao Consultar Administrador! ERRO: " + ex.getMessage());
            throw  new SQLException("ERRO na DAO ao consultar Administrador!");
        }
        finally{
            Conexao.encerrarConexao(conexao, stmt, rs);
        }
        return administrador;
    }

    public void alterar(Object objeto) throws SQLException {
        Administrador administrador = (Administrador) objeto;
        String sql = "UPDATE Administrador SET statusAdm = ?, dtcontratoAdm = ? WHERE codAdm = ?";
        PreparedStatement stmt = null;
        try{
            stmt = conexao.prepareStatement(sql);
            stmt.setBoolean(1, administrador.isStatusAdm());
            stmt.setInt(2, administrador.getCodAdm());
            stmt.setInt(3, new PessoaDAO().gravar(administrador));
            stmt.execute();
        }catch(SQLException | ClassNotFoundException ex){
            //mostrar os erros para o progrmador
            System.out.print("ERRO na DAO Alterar Cliente! ERRO: " + ex.getMessage());
            //mostar uma pilha de erros
            ex.printStackTrace();
            throw new SQLException("Erro na DAO ao ALTERAR CLIENTE!");
        } finally{
            Conexao.encerrarConexao(conexao, stmt);
        }
    }
    
    public void excluir(int codigo) throws SQLException{
        String sql = "DELETE FROM administrador WHERE codAdm = ?";
        /*O método PreparedStatement é usado para criar um objeto
        que representa a instrução SQL que será executada no banco*/
        PreparedStatement stmt = null;
        try{
            stmt = conexao.prepareStatement(sql);
            stmt.setInt(1, codigo);
            stmt.execute();
        }
        catch(SQLException ex){
            System.out.println("Problemas na DAO ao Deletar Administrador! ERRO: " + ex.getMessage());
            throw new SQLException("Erro ao excluir administrador!");
        }
        finally{
            Conexao.encerrarConexao(conexao, stmt);
        }
    }
    
}