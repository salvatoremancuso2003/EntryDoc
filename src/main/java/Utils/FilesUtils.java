/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utils;

import entity.FileEntity;
import entity.User;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.Collections;
import java.util.List;
import javax.imageio.ImageIO;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.io.FileUtils;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.graphics.image.LosslessFactory;
import org.apache.pdfbox.pdmodel.graphics.image.PDImageXObject;

/**
 *
 * @author Salvatore
 */
public class FilesUtils {

    private final EntityManagerFactory emf;
    private final EntityManager em;

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
                return FileUtils.readFileToByteArray(new File(fileEntity.getFilepath()));
            } else {
                return null;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public byte[] convertTiffToPdf(byte[] tiffContent) {
        try {
            BufferedImage bufferedImage = ImageIO.read(new ByteArrayInputStream(tiffContent));

            PDDocument document = new PDDocument();
            PDPage page = new PDPage();
            document.addPage(page);

            PDPageContentStream contentStream = new PDPageContentStream(document, page);
            PDImageXObject imageXObject = LosslessFactory.createFromImage(document, bufferedImage);
            contentStream.drawImage(imageXObject, 0, 0, imageXObject.getWidth(), imageXObject.getHeight());
            contentStream.close();

            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            document.save(outputStream);
            document.close();

            return outputStream.toByteArray();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public byte[] getFileContentTiffByIdAndFilename(Long id, String filename, HttpServletResponse response) {
        try {
            FileEntity fileEntity = this.em.createQuery("SELECT f FROM FileEntity f WHERE f.id = :id AND f.filename = :filename", FileEntity.class)
                    .setParameter("id", id)
                    .setParameter("filename", filename)
                    .getSingleResult();

            if (fileEntity != null) {
                byte[] fileContent = FileUtils.readFileToByteArray(new File(fileEntity.getFilepath()));
                if (filename.toLowerCase().endsWith(".tif") || filename.toLowerCase().endsWith(".tiff")) {
                    byte[] convertedPdf = convertTiffToPdf(fileContent);
                    if (convertedPdf != null) {
                        String fileName = fileEntity.getFilename() + "_convertito";
                        String newFileName = changeFileExtension(fileName, ".pdf");
                        savePdfToFile(convertedPdf, newFileName);
                        savePdfToDatabase(convertedPdf, newFileName, fileEntity);
                        response.sendRedirect("compilaDocumenti.jsp?filename=" + newFileName + "&id=" + fileEntity.getId());
                        return convertedPdf;
                    } else {
                        System.err.println("Conversion failed for file: " + filename);
                    }
                } else {
                    System.err.println("File is not TIFF: " + filename);
                }
            } else {
                System.err.println("File not found: " + filename);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public String changeFileExtension(String filename, String newExtension) {
        int lastDotIndex = filename.lastIndexOf(".");
        if (lastDotIndex != -1) {
            return filename.substring(0, lastDotIndex) + ".convertito" + newExtension;
        } else {
            return filename + ".convertito" + newExtension;
        }
    }

    public void savePdfToFile(byte[] pdfContent, String filename) {
        try {
            String desktopPath = System.getProperty("user.home") + "/Desktop/";
            String filePath = desktopPath + filename;
            FileUtils.writeByteArrayToFile(new File(filePath), pdfContent);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void savePdfToDatabase(byte[] pdfContent, String filename, FileEntity fileEntity) {
        EntityTransaction et = null;
        try {

            et = em.getTransaction();
            et.begin();

            FileEntity updatedFileEntity = em.find(FileEntity.class, fileEntity.getId());
            updatedFileEntity.setFilename(filename);

            String originalFilePath = fileEntity.getFilepath();
            File originalFile = new File(originalFilePath);
            String directoryPath = originalFile.getParent();

            String newFilePath = directoryPath + File.separator + filename;
            updatedFileEntity.setFilepath(newFilePath);

            em.merge(updatedFileEntity);
            em.flush();

            et.commit();
        } catch (Exception e) {
            if (et != null && et.isActive()) {
                et.rollback();
            }
            e.printStackTrace();
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

    public String getFilesDetails(Long id) {
        try {
            List<String> jsonResults = this.em.createQuery("SELECT cfv.json FROM CampoFileValue cfv WHERE cfv.fileEntity.id = :id", String.class)
                    .setParameter("id", id)
                    .getResultList();
            if (jsonResults != null && !jsonResults.isEmpty()) {
                return jsonResults.get(0);
            } else {
                return "[]";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "[]";
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
            FileEntity fileEntity = this.em.createQuery("SELECT f FROM FileEntity f WHERE f.user = :user AND f.status = 2", FileEntity.class)
                    .setParameter("user", user)
                    .getSingleResult();

            if (fileEntity != null) {
                return fileEntity;
            } else {
                return null;
            }
        } catch (Exception e) {
            e.printStackTrace();
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
