
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author Aldo
 */
import java.io.Serializable;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQuery;
import javax.persistence.Persistence;
import javax.persistence.Temporal;

@Entity
@NamedQuery(name = "InfoTrack.findAll", query = "SELECT t FROM InfoTrack t")
public class InfoTrack implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String info;

    private String info2;

    @Lob()
    @Column(length = 256)
    private String descrizione;

    @Column(name = "dataOraTracciamento")
    @Temporal(javax.persistence.TemporalType.TIMESTAMP)
    private Date dataOraTracciamento;
    
    @ManyToOne
    private FileEntity fileEntity;

    public static void loginTrack(String username) {

        try {

            EntityManagerFactory emf = Persistence.createEntityManagerFactory("entryDoc");
            EntityManager em = emf.createEntityManager();

            InfoTrack t = new InfoTrack(username, "LOGIN UTENTE", new Date());

            em.getTransaction().begin();
            em.persist(t);
            em.getTransaction().commit();
            em.close();

        } catch (Exception e) {
            System.out.println(e);

        }
    }

    public static void actionTrack(String username, String descrizione, String info2) {

        try {

            EntityManagerFactory emf = Persistence.createEntityManagerFactory("entryDoc");
            EntityManager em = emf.createEntityManager();

            InfoTrack t = new InfoTrack(username, info2, descrizione, new Date());

            em.getTransaction().begin();
            em.persist(t);
            em.getTransaction().commit();
            em.close();

        } catch (Exception e) {
            System.out.println(e);

        }

    }

    public static void downloadTrackUpload(String infoName, FileEntity fileEntity) {

        EntityManagerFactory emf = Persistence.createEntityManagerFactory("entryDoc");
        EntityManager em = emf.createEntityManager();

        InfoTrack f = new InfoTrack(infoName, "DOWNLOAD FILE", new Date(), fileEntity);

        em.getTransaction().begin();
        em.persist(f);
        em.getTransaction().commit();
        em.close();
    }

    public static void logoutTrack(String infoUserName) {

        EntityManagerFactory emf = Persistence.createEntityManagerFactory("entryDoc");
        EntityManager em = emf.createEntityManager();

        InfoTrack l = new InfoTrack(infoUserName, "LOGOUT UTENTE", new Date());

        em.getTransaction().begin();
        em.persist(l);
        em.getTransaction().commit();
        em.close();
    }

    public static void formTrackUpdate(String infoName) {

        EntityManagerFactory emf = Persistence.createEntityManagerFactory("regione");
        EntityManager em = emf.createEntityManager();

        InfoTrack a = new InfoTrack(infoName, "NUOVO ALLEGATO CREATO", new Date());

        em.getTransaction().begin();
        em.persist(a);
        em.getTransaction().commit();
        em.close();
    }

    public InfoTrack() {

    }

    public InfoTrack(String info, String descrizione, Date dataOraTracciamento) {
        this.info = info;
        this.descrizione = descrizione;
        this.dataOraTracciamento = dataOraTracciamento;
    }
    
    public InfoTrack(String info,String info2, String descrizione, Date dataOraTracciamento) {
        this.info = info;
        this.info2 = info2;
        this.descrizione = descrizione;
        this.dataOraTracciamento = dataOraTracciamento;
    }

    public InfoTrack(String info, String descrizione, Date dataOraTracciamento, FileEntity file) {
        this.info = info;
        this.descrizione = descrizione;
        this.dataOraTracciamento = dataOraTracciamento;
    }

    // Getter e Setter
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }

    public String getDescrizione() {
        return descrizione;
    }

    public void setDescrizione(String descrizione) {
        this.descrizione = descrizione;
    }

    public Date getDataOraTracciamento() {
        return dataOraTracciamento;
    }

    public void setDataOraTracciamento(Date dataOraTracciamento) {
        this.dataOraTracciamento = dataOraTracciamento;
    }

    public String getInfo2() {
        return info2;
    }

    public void setInfo2(String info2) {
        this.info2 = info2;
    }

    public FileEntity getFileEntity() {
        return fileEntity;
    }

    public void setFileEntity(FileEntity fileEntity) {
        this.fileEntity = fileEntity;
    }
    
    
    

}
