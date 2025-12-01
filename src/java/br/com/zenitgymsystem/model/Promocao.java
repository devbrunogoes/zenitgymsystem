/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package br.com.zenitgymsystem.model;

/**
 *
 * @author BrunoGoes
 */
public class Promocao {
    
    private int codPromo;
    private String descPromo;
    private int percentualPromo;
    private String periodoinicioPromo;
    private String periodofimPromo;
    private int codProdutoServico;

    public Promocao() {
    }

    public Promocao(int codPromo) {
        this.codPromo = codPromo;
    }

    public Promocao(int codPromo, String descPromo, int percentualPromo, String periodoinicioPromo, String periodofimPromo, int codProdutoServico) {
        this.codPromo = codPromo;
        this.descPromo = descPromo;
        this.percentualPromo = percentualPromo;
        this.periodoinicioPromo = periodoinicioPromo;
        this.periodofimPromo = periodofimPromo;
        this.codProdutoServico = codProdutoServico;
    }

    public int getCodPromo() {
        return codPromo;
    }

    public void setCodPromo(int codPromo) {
        this.codPromo = codPromo;
    }

    public String getDescPromo() {
        return descPromo;
    }

    public void setDescPromo(String descPromo) {
        this.descPromo = descPromo;
    }

    public int getPercentualPromo() {
        return percentualPromo;
    }

    public void setPercentualPromo(int percentualPromo) {
        this.percentualPromo = percentualPromo;
    }

    public String getPeriodoinicioPromo() {
        return periodoinicioPromo;
    }

    public void setPeriodoinicioPromo(String periodoinicioPromo) {
        this.periodoinicioPromo = periodoinicioPromo;
    }

    public String getPeriodofimPromo() {
        return periodofimPromo;
    }

    public void setPeriodofimPromo(String periodofimPromo) {
        this.periodofimPromo = periodofimPromo;
    }

    public int getCodProdutoServico() {
        return codProdutoServico;
    }

    public void setCodProdutoServico(int codProdutoServico) {
        this.codProdutoServico = codProdutoServico;
    }
    
    
}
