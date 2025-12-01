/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.com.zenitgymsystem.model;

/**
 *
 * @author BrunoGoes
 */
public class Venda {
    
    private int codVenda;
    private float valorVenda;
    private String dataVenda;
    private boolean statusVenda;
    private int codTipoPag;
    private int codFunc;
    private int codCliente;

    public Venda() {
    }

    public Venda(int codVenda) {
        this.codVenda = codVenda;
    }

    public Venda(int codVenda, float valorVenda, String dataVenda, boolean statusVenda, int codTipoPag, int codFunc, int codCliente) {
        this.codVenda = codVenda;
        this.valorVenda = valorVenda;
        this.dataVenda = dataVenda;
        this.statusVenda = statusVenda;
        this.codTipoPag = codTipoPag;
        this.codFunc = codFunc;
        this.codCliente = codCliente;
    }

    public int getCodVenda() {
        return codVenda;
    }

    public void setCodVenda(int codVenda) {
        this.codVenda = codVenda;
    }

    public float getValorVenda() {
        return valorVenda;
    }

    public void setValorVenda(float valorVenda) {
        this.valorVenda = valorVenda;
    }

    public String getDataVenda() {
        return dataVenda;
    }

    public void setDataVenda(String dataVenda) {
        this.dataVenda = dataVenda;
    }

    public boolean isStatusVenda() {
        return statusVenda;
    }

    public void setStatusVenda(boolean statusVenda) {
        this.statusVenda = statusVenda;
    }

    public int getCodTipoPag() {
        return codTipoPag;
    }

    public void setCodTipoPag(int codTipoPag) {
        this.codTipoPag = codTipoPag;
    }

    public int getCodFunc() {
        return codFunc;
    }

    public void setCodFunc(int codFunc) {
        this.codFunc = codFunc;
    }

    public int getCodCliente() {
        return codCliente;
    }

    public void setCodCliente(int codCliente) {
        this.codCliente = codCliente;
    }
    
    
    
}
