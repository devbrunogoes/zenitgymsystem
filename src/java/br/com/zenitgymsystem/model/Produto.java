package br.com.zenitgymsystem.model;


public class Produto {
    
    private int codProduto;
    private String nomeProduto;
    private String descProduto;
    private float valorProduto;
    private int qtdProduto;
    private String imgProduto;
    private String categoriaProduto;

    public Produto() {
    }

    public Produto(int codProduto) {
        this.codProduto = codProduto;
    }

    public Produto(int codProduto, String nomeProduto, String descProduto, float valorProduto, int qtdProduto, String imgProduto, String categoriaProduto) {
        this.codProduto = codProduto;
        this.nomeProduto = nomeProduto;
        this.descProduto = descProduto;
        this.valorProduto = valorProduto;
        this.qtdProduto = qtdProduto;
        this.imgProduto = imgProduto;
        this.categoriaProduto = categoriaProduto;
    }

   

    public int getCodProduto() {
        return codProduto;
    }

    public void setCodProduto(int codProduto) {
        this.codProduto = codProduto;
    }

    public String getNomeProduto() {
        return nomeProduto;
    }

    public void setNomeProduto(String nomeProduto) {
        this.nomeProduto = nomeProduto;
    }

    public String getDescProduto() {
        return descProduto;
    }

    public void setDescProduto(String descProduto) {
        this.descProduto = descProduto;
    }

    public float getValorProduto() {
        return valorProduto;
    }

    public void setValorProduto(float valorProduto) {
        this.valorProduto = valorProduto;
    }

    public int getQtdProduto() {
        return qtdProduto;
    }

    public void setQtdProduto(int qtdProduto) {
        this.qtdProduto = qtdProduto;
    }

    public String getImgProduto() {
        return imgProduto;
    }

    public void setImgProduto(String imgProduto) {
        this.imgProduto = imgProduto;
    }

    public String getCategoriaProduto() {
        return categoriaProduto;
    }

    public void setCategoriaProduto(String categoriaProduto) {
        this.categoriaProduto = categoriaProduto;
    }
    
    
}
