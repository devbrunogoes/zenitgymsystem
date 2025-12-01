package br.com.zenitgymsystem.model;

public class Personal extends Pessoa{
    
    private int codPers;
    private String dtcontratoPers;
    private boolean statusPers;

    public Personal() {
    }

    public Personal(int codPers) {
        this.codPers = codPers;
    }

    public Personal(int codPers, String dtcontratoPers, boolean statusPers) {
        this.codPers = codPers;
        this.dtcontratoPers = dtcontratoPers;
        this.statusPers = statusPers;
    }

    public Personal(int codPers, String dtcontratoPers, boolean statusPers, int codPessoa) {
        super(codPessoa);
        this.codPers = codPers;
        this.dtcontratoPers = dtcontratoPers;
        this.statusPers = statusPers;
    }

    public Personal(int codPers, String dtcontratoPers, boolean statusPers, int codPessoa, String nomePessoa, String senhaPessoa, String dtnascPessoa, String cpfPessoa, String rgPessoa, String sexoPessoa, String celularPessoa, String cepPessoa, String endPessoa, String complPessoa, int numeroPessoa, String cidadePessoa, String ufPessoa, String bairroPessoa, String emailPessoa, String imgPessoa) {
        super(codPessoa, nomePessoa, senhaPessoa, dtnascPessoa, cpfPessoa, rgPessoa, sexoPessoa, celularPessoa, cepPessoa, endPessoa, complPessoa, numeroPessoa, cidadePessoa, ufPessoa, bairroPessoa, emailPessoa, imgPessoa);
        this.codPers = codPers;
        this.dtcontratoPers = dtcontratoPers;
        this.statusPers = statusPers;
    }

    public int getCodPers() {
        return codPers;
    }

    public void setCodPers(int codPers) {
        this.codPers = codPers;
    }

    public String getDtcontratoPers() {
        return dtcontratoPers;
    }

    public void setDtcontratoPers(String dtcontratoPers) {
        this.dtcontratoPers = dtcontratoPers;
    }

    public boolean isStatusPers() {
        return statusPers;
    }

    public void setStatusPers(boolean statusPers) {
        this.statusPers = statusPers;
    }
    
    
}
