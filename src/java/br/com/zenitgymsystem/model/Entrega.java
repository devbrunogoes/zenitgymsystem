package br.com.zenitgymsystem.model;

public class Entrega {
    
    private int codEntrega;
    private String dataEntrega;
    private int quantEntrega;
    private String enderecoEntrega;
    private String statusEntrega;
    private Fornecedor fornecedor;
    private Equipamento equipamento;

    public Entrega() {
    }

    public Entrega(int codEntrega) {
        this.codEntrega = codEntrega;
    }

    public Entrega(int codEntrega, String dataEntrega, int quantEntrega, String enderecoEntrega, String statusEntrega, Fornecedor fornecedor, Equipamento equipamento) {
        this.codEntrega = codEntrega;
        this.dataEntrega = dataEntrega;
        this.quantEntrega = quantEntrega;
        this.enderecoEntrega = enderecoEntrega;
        this.statusEntrega = statusEntrega;
        this.fornecedor = fornecedor;
        this.equipamento = equipamento;
    }

    public int getCodEntrega() {
        return codEntrega;
    }

    public void setCodEntrega(int codEntrega) {
        this.codEntrega = codEntrega;
    }

    public String getDataEntrega() {
        return dataEntrega;
    }

    public void setDataEntrega(String dataEntrega) {
        this.dataEntrega = dataEntrega;
    }

    public int getQuantEntrega() {
        return quantEntrega;
    }

    public void setQuantEntrega(int quantEntrega) {
        this.quantEntrega = quantEntrega;
    }

    public String getEnderecoEntrega() {
        return enderecoEntrega;
    }

    public void setEnderecoEntrega(String enderecoEntrega) {
        this.enderecoEntrega = enderecoEntrega;
    }

    public String getStatusEntrega() {
        return statusEntrega;
    }

    public void setStatusEntrega(String statusEntrega) {
        this.statusEntrega = statusEntrega;
    }

    public Fornecedor getFornecedor() {
        return fornecedor;
    }

    public void setFornecedor(Fornecedor fornecedor) {
        this.fornecedor = fornecedor;
    }

    public Equipamento getEquipamento() {
        return equipamento;
    }

    public void setEquipamento(Equipamento equipamento) {
        this.equipamento = equipamento;
    }
    
    

}
