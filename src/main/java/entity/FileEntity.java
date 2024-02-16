/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import java.io.Serializable;
import java.sql.Timestamp;
import javax.persistence.*;

@Entity
@Table(name = "files")
////@NamedQueries({
//    //@NamedQuery(
//           // name = "filesByPracticeId",
//           // query = "SELECT f FROM FileEntity f WHERE f.practice.id = :practiceId"
//   // ),
//   // @NamedQuery(
//           / /name = "FileEntity.findByFilename",
//            /query = "SELECT f FROM FileEntity f WHERE f.filename = :filename"
//    )
//})
@JsonIgnoreProperties({"practice","uploadDate","file_content"})
public class FileEntity implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "filename")
    private String filename;

    @Column(name = "filepath")
    private String filepath;

    @Column(name = "description")
    private String description;

    @Column(name = "file_size")
    private Long fileSize;

    @JsonIgnore
    @Column(name = "upload_date")
    private Timestamp uploadDate;

    @Lob
    @Column(name = "file_content", columnDefinition = "LONGBLOB")
    @JsonIgnore
    private byte[] fileContent;
    


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


}
