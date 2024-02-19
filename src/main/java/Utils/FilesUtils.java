/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utils;

import entity.FileEntity;
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
            FileEntity fileEntity = em.createQuery("SELECT f FROM FileEntity f WHERE f.id = :id AND f.filename = :filename", FileEntity.class)
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

    public void close() {
        em.close();
        emf.close();
    }
}
