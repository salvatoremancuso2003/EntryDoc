/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.*;

@Entity
@Table(name = "files")
@NamedQueries({
    @NamedQuery(
            name = "FileEntity.findByFilename",
            query = "SELECT f FROM FileEntity f WHERE f.filename = :filename"
    ),
    @NamedQuery(
            name = "FileEntity.findAll",
            query = "SELECT f FROM FileEntity f"
    )

})
public class FileEntity implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "filename")
    private String filename;

    @Column(name = "filepath")
    private String filepath;

    @Column(name = "outputfilepath")
    private String outputFilepath;

    @Column(name = "description")
    private String description;

    @Column(name = "file_size")
    private Long fileSize;

    @Column(name = "uploadDate", nullable = false, updatable = false, insertable = true, columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP")
    private Timestamp uploadDate;

    @Lob
    @Column(name = "file_content", columnDefinition = "LONGBLOB")
    private byte[] fileContent;

    private int status;

    @ManyToOne
    private User user;

    @ManyToOne
    private Tipologia_documento tipologia_documento;

    @Column(name = "expiration_date")
    private Timestamp expiration_date;

    @OneToMany(mappedBy = "fileEntity")
    private List<CampoFileValue> campoFileValues = new ArrayList<>();

    @Column(name = "total_pages")
    private String totalPages;

    @Column(name = "page_selected")
    private String pageSelected;

    @Column(name = "json", columnDefinition = "json")
    private String json;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }

    public String getFilepath() {
        return filepath;
    }

    public void setFilepath(String filepath) {
        this.filepath = filepath;
    }

    public Long getFileSize() {
        return fileSize;
    }

    public void setFileSize(Long fileSize) {
        this.fileSize = fileSize;
    }

    public Timestamp getUploadDate() {
        return uploadDate;
    }

    public void setUploadDate(Timestamp uploadDate) {
        this.uploadDate = uploadDate;
    }

    public byte[] getFileContent() {
        return fileContent;
    }

    public void setFileContent(byte[] fileContent) {
        this.fileContent = fileContent;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Tipologia_documento getTipologia_documento() {
        return tipologia_documento;
    }

    public void setTipologia_documento(Tipologia_documento tipologia_documento) {
        this.tipologia_documento = tipologia_documento;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Timestamp getExpiration_date() {
        return expiration_date;
    }

    public void setExpiration_date(Timestamp expiration_date) {
        this.expiration_date = expiration_date;
    }

    public List<CampoFileValue> getCampoFileValues() {
        return campoFileValues;
    }

    public void setCampoFileValues(List<CampoFileValue> campoFileValues) {
        this.campoFileValues = campoFileValues;
    }

    public String getTotalPages() {
        return totalPages;
    }

    public void setTotalPages(String totalPages) {
        this.totalPages = totalPages;
    }

    public String getPageSelected() {
        return pageSelected;
    }

    public void setPageSelected(String pageSelected) {
        this.pageSelected = pageSelected;
    }

    public String getJson() {
        return json;
    }

    public void setJson(String json) {
        this.json = json;
    }

    public String getOutputFilepath() {
        return outputFilepath;
    }

    public void setOutputFilepath(String outputFilepath) {
        this.outputFilepath = outputFilepath;
    }

}
