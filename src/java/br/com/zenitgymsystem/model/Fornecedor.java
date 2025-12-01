package br.com.zenitgymsystem.model;

import java.util.List;

public class Fornecedor {

    private int codForn;
    private String nomeForn;
    private String celularForn;
    private String emailForn;
    private String cnpjForn;            
    private String enderecoForn;        
    private String dtCadastroForn;      
    private boolean statusForn;         
    private String obsForn;   

    public Fornecedor() {
    }

    public Fornecedor(int codForn) {
        this.codForn = codForn;
    }
    

    public Fornecedor(int codForn, String nomeForn, String celularForn, String emailForn, String cnpjForn, String enderecoForn, String dtCadastroForn, boolean statusForn, String obsForn) {
        this.codForn = codForn;
        this.nomeForn = nomeForn;
        this.celularForn = celularForn;
        this.emailForn = emailForn;
        this.cnpjForn = cnpjForn;
        this.enderecoForn = enderecoForn;
        this.dtCadastroForn = dtCadastroForn;
        this.statusForn = statusForn;
        this.obsForn = obsForn;
    }

    public int getCodForn() {
        return codForn;
    }

    public void setCodForn(int codForn) {
        this.codForn = codForn;
    }

    public String getNomeForn() {
        return nomeForn;
    }

    public void setNomeForn(String nomeForn) {
        this.nomeForn = nomeForn;
    }

    public String getCelularForn() {
        return celularForn;
    }

    public void setCelularForn(String celularForn) {
        this.celularForn = celularForn;
    }

    public String getEmailForn() {
        return emailForn;
    }

    public void setEmailForn(String emailForn) {
        this.emailForn = emailForn;
    }

    public String getCnpjForn() {
        return cnpjForn;
    }

    public void setCnpjForn(String cnpjForn) {
        this.cnpjForn = cnpjForn;
    }

    public String getEnderecoForn() {
        return enderecoForn;
    }

    public void setEnderecoForn(String enderecoForn) {
        this.enderecoForn = enderecoForn;
    }

    public String getDtCadastroForn() {
        return dtCadastroForn;
    }

    public void setDtCadastroForn(String dtCadastroForn) {
        this.dtCadastroForn = dtCadastroForn;
    }

    public boolean isStatusForn() {
        return statusForn;
    }

    public void setStatusForn(boolean statusForn) {
        this.statusForn = statusForn;
    }

    public String getObsForn() {
        return obsForn;
    }

    public void setObsForn(String obsForn) {
        this.obsForn = obsForn;
    }

    

    
}
