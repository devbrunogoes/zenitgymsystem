package br.com.zenitgymsystem.model;


public class MovFin {

    private int codMov;
    private String descMov;
    private boolean tipoMov; // true para receita, false para despesa
    private double valorMov;
    private String dtMov; // Data da movimentação no formato "yyyy-MM-dd"
    private String tipoPagMov; // Ex: "Cartão", "Dinheiro", "Pix"
    private String categoriaMov; // Ex: "Mensalidade", "Equipamento", "Salário"
    private String obsMov;


    public MovFin() {
    }

    public MovFin(int codMov) {
        this.codMov = codMov;
    }

    public MovFin(int codMov, String descMov, boolean tipoMov, double valorMov, String dtMov, String tipoPagMov, String categoriaMov, String obsMov) {
        this.codMov = codMov;
        this.descMov = descMov;
        this.tipoMov = tipoMov;
        this.valorMov = valorMov;
        this.dtMov = dtMov;
        this.tipoPagMov = tipoPagMov;
        this.categoriaMov = categoriaMov;
        this.obsMov = obsMov;

    }

    public int getCodMov() {
        return codMov;
    }

    public void setCodMov(int codMov) {
        this.codMov = codMov;
    }

    public String getDescMov() {
        return descMov;
    }

    public void setDescMov(String descMov) {
        this.descMov = descMov;
    }

    public boolean isTipoMov() {
        return tipoMov;
    }

    public void setTipoMov(boolean tipoMov) {
        this.tipoMov = tipoMov;
    }

    public double getValorMov() {
        return valorMov;
    }

    public void setValorMov(double valorMov) {
        this.valorMov = valorMov;
    }

    public String getDtMov() {
        return dtMov;
    }

    public void setDtMov(String dtMov) {
        this.dtMov = dtMov;
    }

    public String getTipoPagMov() {
        return tipoPagMov;
    }

    public void setTipoPagMov(String tipoPagMov) {
        this.tipoPagMov = tipoPagMov;
    }

    public String getCategoriaMov() {
        return categoriaMov;
    }

    public void setCategoriaMov(String categoriaMov) {
        this.categoriaMov = categoriaMov;
    }

    public String getObsMov() {
        return obsMov;
    }

    public void setObsMov(String obsMov) {
        this.obsMov = obsMov;
    }

    
    
    
    
    
}
