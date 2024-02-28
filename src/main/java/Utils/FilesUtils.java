/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utils;

import entity.FileEntity;
import entity.User;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 *
 * @author Salvatore
 */
public class FilesUtils {

    private EntityManagerFactory emf;
    private EntityManager em;

    public FilesUtils() {
        emf = Persistence.createEntityManagerFactory("entryDoc");
        em = emf.createEntityManager();
    }

    public byte[] getFileContentByIdAndFilename(Long id, String filename) {
        try {
            FileEntity fileEntity = this.em.createQuery("SELECT f FROM FileEntity f WHERE f.id = :id AND f.filename = :filename", FileEntity.class)
                    .setParameter("id", id)
                    .setParameter("filename", filename)
                    .getSingleResult();

            if (fileEntity != null) {
                return fileEntity.getFileContent();
            } else {
                return null;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public Timestamp getFileExpirationDate(Long id, String filename) {
        try {
            FileEntity fileEntity = this.em.createQuery("SELECT f FROM FileEntity f WHERE f.id = :id AND f.filename = :filename", FileEntity.class)
                    .setParameter("id", id)
                    .setParameter("filename", filename)
                    .getSingleResult();

            if (fileEntity != null) {
                Timestamp expirationDate = fileEntity.getExpiration_date();
                if (expirationDate != null && expirationDate.getTime() < System.currentTimeMillis()) {
                    fileEntity.setStatus(1);
                    fileEntity.setUser(null);
                    fileEntity.setExpiration_date(null);
                    this.em.merge(fileEntity);
                }
                return expirationDate;
            } else {
                return null;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List getAllFiles() {
        try {
            List<FileEntity> fileEntity = this.em.createQuery("SELECT f FROM FileEntity f", FileEntity.class)
                    .getResultList();

            return fileEntity;
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }

    public List getFilesWithStatus1() {
        try {
            List<FileEntity> fileEntity = this.em.createQuery("SELECT f FROM FileEntity f WHERE f.status = 1", FileEntity.class)
                    .getResultList();

            return fileEntity;
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }

    public void close() {
        this.em.close();
        this.emf.close();
    }

    public List getFilesWithStatus2() {
        try {
            List<FileEntity> fileEntity = this.em.createQuery("SELECT f FROM FileEntity f WHERE f.status = 2", FileEntity.class)
                    .getResultList();

            return fileEntity;
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }

    public List getFilesWithStatus3() {
        try {
            List<FileEntity> fileEntity = this.em.createQuery("SELECT f FROM FileEntity f WHERE f.status = 3", FileEntity.class)
                    .getResultList();

            return fileEntity;
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }

    public FileEntity getFilesWithUser(User user) {
        try {
            FileEntity fileEntity = this.em.createQuery("SELECT f FROM FileEntity f WHERE f.user = :user", FileEntity.class)
                    .setParameter("user", user)
                    .getSingleResult();

            if (fileEntity != null) {
                return fileEntity;
            } else {
                return null;
            }
        } catch (Exception e) {
//            e.printStackTrace();
            return null;
        }
    }

    public FileEntity getFiles(String id) {
        try {
            FileEntity fileEntity = this.em.find(FileEntity.class, Long.valueOf(id));
            return fileEntity;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }


}
