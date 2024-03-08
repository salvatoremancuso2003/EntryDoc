/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 *
 * @author Salvatore
 */
@Entity
@Table(name = "campo_form")
public class Campo_form implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Column(name = "nome")
    private String nome;

    @Column(name = "tipologia_campo")
    private String tipologia_campo;

    @Column(name = "etichetta")
    private String etichetta;

    @Lob
    @Column(name = "options_value")
    private String options_value;

    @Lob
    @Column(name = "options_description")
    private String options_description;

    @OneToMany(mappedBy = "campoForm")
    private List<CampoFileValue> campoFileValues = new ArrayList<>();

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getTipologia_campo() {
        return tipologia_campo;
    }

    public void setTipologia_campo(String tipologia_campo) {
        this.tipologia_campo = tipologia_campo;
    }

    public String getEtichetta() {
        return etichetta;
    }

    public void setEtichetta(String etichetta) {
        this.etichetta = etichetta;
    }

    public String getOptionsValue() {
        return options_value;
    }

    public void setOptionsValue(String options_value) {
        this.options_value = options_value;
    }

    public String getOptions_description() {
        return options_description;
    }

    public void setOptions_description(String options_description) {
        this.options_description = options_description;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        if (!(object instanceof Campo_form)) {
            return false;
        }
        Campo_form other = (Campo_form) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entity.Campo_form[ id=" + id + " ]";
    }

    public List<CampoFileValue> getCampoFileValues() {
        return campoFileValues;
    }

    public void setCampoFileValues(List<CampoFileValue> campoFileValues) {
        this.campoFileValues = campoFileValues;
    }

}
