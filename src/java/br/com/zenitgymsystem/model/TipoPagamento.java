/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.com.zenitgymsystem.model;

/**
 *
 * @author BrunoGoes
 */
public class TipoPagamento {
    
    private int codTipoPag;
    private String tipoPag;

    public TipoPagamento() {
    }

    public TipoPagamento(int codTipoPag) {
        this.codTipoPag = codTipoPag;
    }

    public TipoPagamento(int codTipoPag, String tipoPag) {
        this.codTipoPag = codTipoPag;
        this.tipoPag = tipoPag;
    }

    public int getCodTipoPag() {
        return codTipoPag;
    }

    public void setCodTipoPag(int codTipoPag) {
        this.codTipoPag = codTipoPag;
    }

    public String getTipoPag() {
        return tipoPag;
    }

    public void setTipoPag(String tipoPag) {
        this.tipoPag = tipoPag;
    }
    
    
}
