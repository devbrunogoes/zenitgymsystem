package br.com.zenitgymsystem.model;


public class Administrador extends Pessoa {
    
    private int codAdm;
    private boolean statusAdm;

    public Administrador() {
    }

    public Administrador(int codAdm) {
        this.codAdm = codAdm;
    }

    public Administrador(int codAdm, boolean statusAdm) {
        this.codAdm = codAdm;
        this.statusAdm = statusAdm;
    }

    public Administrador(int codAdm, boolean statusAdm, int codPessoa) {
        super(codPessoa);
        this.codAdm = codAdm;
        this.statusAdm = statusAdm;
    }

    public Administrador(int codAdm, boolean statusAdm, int codPessoa, String nomePessoa, String senhaPessoa, String dtnascPessoa, String cpfPessoa, String rgPessoa, String sexoPessoa, String celularPessoa, String cepPessoa, String endPessoa, String complPessoa, int numeroPessoa, String cidadePessoa, String ufPessoa, String bairroPessoa, String emailPessoa, String imgPessoa) {
        super(codPessoa, nomePessoa, senhaPessoa, dtnascPessoa, cpfPessoa, rgPessoa, sexoPessoa, celularPessoa, cepPessoa, endPessoa, complPessoa, numeroPessoa, cidadePessoa, ufPessoa, bairroPessoa, emailPessoa, imgPessoa);
        this.codAdm = codAdm;
        this.statusAdm = statusAdm;
    }

    public int getCodAdm() {
        return codAdm;
    }

    public void setCodAdm(int codAdm) {
        this.codAdm = codAdm;
    }

    public boolean isStatusAdm() {
        return statusAdm;
    }

    public void setStatusAdm(boolean statusAdm) {
        this.statusAdm = statusAdm;
    }
    
    
    
}
