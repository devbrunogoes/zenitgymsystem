package br.com.zenitgymsystem.model;

public class Equipamento {

    private int codEquip;
    private String nomeEquip;
    private String descEquip;
    private String dtAquisicaoEquip;
    private String estadoConsEquip; // 'novo', 'usado', 'precisa de reparo'
    private String statusEquip; // 'ativo', 'inativo', 'manutencao'
    private String dtUltManuEquip;
    private Fornecedor fornecedor; // Relacionamento N para 1

    public Equipamento() {
    }

    public Equipamento(int codEquip) {
        this.codEquip = codEquip;
    }

    public Equipamento(int codEquip, String nomeEquip, String descEquip, String dtAquisicaoEquip, 
                       String estadoConsEquip, String statusEquip, String dtUltManuEquip, Fornecedor fornecedor) {
        this.codEquip = codEquip;
        this.nomeEquip = nomeEquip;
        this.descEquip = descEquip;
        this.dtAquisicaoEquip = dtAquisicaoEquip;
        this.estadoConsEquip = estadoConsEquip;
        this.statusEquip = statusEquip;
        this.dtUltManuEquip = dtUltManuEquip;
        this.fornecedor = fornecedor;
    }

    // Getters e Setters

    public int getCodEquip() {
        return codEquip;
    }

    public void setCodEquip(int codEquip) {
        this.codEquip = codEquip;
    }

    public String getNomeEquip() {
        return nomeEquip;
    }

    public void setNomeEquip(String nomeEquip) {
        this.nomeEquip = nomeEquip;
    }

    public String getDescEquip() {
        return descEquip;
    }

    public void setDescEquip(String descEquip) {
        this.descEquip = descEquip;
    }

    public String getDtAquisicaoEquip() {
        return dtAquisicaoEquip;
    }

    public void setDtAquisicaoEquip(String dtAquisicaoEquip) {
        this.dtAquisicaoEquip = dtAquisicaoEquip;
    }

    public String getEstadoConsEquip() {
        return estadoConsEquip;
    }

    public void setEstadoConsEquip(String estadoConsEquip) {
        this.estadoConsEquip = estadoConsEquip;
    }

    public String getStatusEquip() {
        return statusEquip;
    }

    public void setStatusEquip(String statusEquip) {
        this.statusEquip = statusEquip;
    }

    public String getDtUltManuEquip() {
        return dtUltManuEquip;
    }

    public void setDtUltManuEquip(String dtUltManuEquip) {
        this.dtUltManuEquip = dtUltManuEquip;
    }

    public Fornecedor getFornecedor() {
        return fornecedor;
    }

    public void setFornecedor(Fornecedor fornecedor) {
        this.fornecedor = fornecedor;
    }
}
