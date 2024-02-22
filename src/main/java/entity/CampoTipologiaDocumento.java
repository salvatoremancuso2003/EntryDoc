/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.io.Serializable;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 *
 * @author Salvatore
 */
@Entity
@Table(name = "campo_tipologia_documento")
public class CampoTipologiaDocumento implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "campo_form_id")
    private Campo_form campoForm;

    @ManyToOne
    @JoinColumn(name = "tipologia_documento_id")
    private Tipologia_documento tipologiaDocumento;

    private int ordine;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Campo_form getCampoForm() {
        return campoForm;
    }

    public void setCampoForm(Campo_form campoForm) {
        this.campoForm = campoForm;
    }

    public Tipologia_documento getTipologiaDocumento() {
        return tipologiaDocumento;
    }

    public void setTipologiaDocumento(Tipologia_documento tipologiaDocumento) {
        this.tipologiaDocumento = tipologiaDocumento;
    }

    public int getOrdine() {
        return ordine;
    }

    public void setOrdine(int ordine) {
        this.ordine = ordine;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof CampoTipologiaDocumento)) {
            return false;
        }
        CampoTipologiaDocumento other = (CampoTipologiaDocumento) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entity.CampoTipologiaDocumento[ id=" + id + " ]";
    }

}
