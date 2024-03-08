/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utils;

import entity.CampoTipologiaDocumento;
import entity.FileEntity;
import entity.Tipologia_documento;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;

/**
 *
 * @author Salvatore
 */
public class Form {

    private EntityManagerFactory emf;
    private EntityManager em;

    public Form() {
        emf = Persistence.createEntityManagerFactory("entryDoc");
        em = emf.createEntityManager();
    }

    public List<CampoTipologiaDocumento> getCampoTipologiaDocumentoByTipologiaDocumento(Tipologia_documento tipologia_documento) {
        try {
            List<CampoTipologiaDocumento> campoTipologiaDocumento = em.createQuery("SELECT ctd FROM CampoTipologiaDocumento ctd WHERE ctd.tipologiaDocumento = :tipologia_documento ORDER BY ctd.ordine", CampoTipologiaDocumento.class)
                    .setParameter("tipologia_documento", tipologia_documento)
                    .getResultList();
            return campoTipologiaDocumento;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public Tipologia_documento findTipologiaDocumentoByFileEntityId(Long id) {
        try {
            FileEntity fileEntity = em.find(FileEntity.class, id);
            if (fileEntity != null) {
                return fileEntity.getTipologia_documento();
            } else {
                System.out.println("FileEntity con ID " + id + " non trovata.");
                return null;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    public List<Tipologia_documento> getTipologie(Tipologia_documento tipologia_documento) {
        String jpql = "SELECT t FROM Tipologia_documento t WHERE t.id != :id";
        TypedQuery<Tipologia_documento> query = em.createQuery(jpql, Tipologia_documento.class);
        query.setParameter("id", tipologia_documento.getId());
        return query.getResultList();
    }
}
