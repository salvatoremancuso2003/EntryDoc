/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.io.Serializable;
import java.sql.Timestamp;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 *
 * @author Salvatore
 */
@Entity
@Table(name = "campo_file_value")
public class CampoFileValue implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "campo_form_id")
    private Campo_form campoForm;

    @ManyToOne
    @JoinColumn(name = "file_id")
    private FileEntity fileEntity;

    @Column(name = "field_value")
    private String fieldValue;

    @Column(name = "dataDiCompletamento", nullable = false, updatable = false, insertable = true, columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
    private Timestamp dataDiCompletamento;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

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

    public FileEntity getFileEntity() {
        return fileEntity;
    }

    public void setFileEntity(FileEntity fileEntity) {
        this.fileEntity = fileEntity;
    }

    public String getFieldValue() {
        return fieldValue;
    }

    public void setFieldValue(String fieldValue) {
        this.fieldValue = fieldValue;
    }

    public Timestamp getDataDiCompletamento() {
        return dataDiCompletamento;
    }

    public void setDataDiCompletamento(Timestamp dataDiCompletamento) {
        this.dataDiCompletamento = dataDiCompletamento;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
