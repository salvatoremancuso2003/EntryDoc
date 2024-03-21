/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import Utils.FilesUtils;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import entity.CampoFileValue;
import entity.Campo_form;
import entity.FileEntity;
import entity.InfoTrack;
import entity.User;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.io.FileUtils;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageTree;

/**
 *
 * @author Salvatore
 */
public class SaveForm extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long idFileEntity = Long.parseLong(request.getParameter("idFileEntity"));
        String[] campi = request.getParameterValues("campo[]");
        String[] idCampi = request.getParameterValues("idCampo[]");
        String selectedPages = request.getParameter("selectedPages");
        String totalPages = request.getParameter("totalPages");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("us_user");

        EntityManagerFactory emf = Persistence.createEntityManagerFactory("entryDoc");
        EntityManager em = emf.createEntityManager();

        try {
            EntityTransaction et = em.getTransaction();
            et.begin();

            FileEntity fileEntity = em.find(FileEntity.class, idFileEntity);
            JsonObject json = new JsonObject();

            for (int i = 0; i < campi.length; i++) {
                Campo_form campoForm = em.find(Campo_form.class, Long.parseLong(idCampi[i]));

                String campoValue = "Nome campo: " + campoForm.getNome()
                        + ", Valore campo: " + campi[i]
                        + ", Tipologia campo: " + campoForm.getTipologia_campo();

                json.addProperty("Campo_" + (i + 1), campoValue);
            }

            json.addProperty("filePath", fileEntity.getFilepath());
            json.addProperty("user", user.getUsername());
            json.addProperty("user_id", user.getId());
            json.addProperty("total_pages", totalPages);
            
            if (selectedPages != null && !selectedPages.equals("[]")) {
                json.addProperty("selected_pages", selectedPages);
            } else {
                json.addProperty("selected_pages", totalPages);
            }

            Timestamp dataDiCompletamento = new Timestamp(new Date().getTime());

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String dataDiCompletamentoString = sdf.format(dataDiCompletamento);

            json.addProperty("data completamento", dataDiCompletamentoString);

            byte[] fileContent = FileUtils.readFileToByteArray(new File(fileEntity.getFilepath()));
            fileEntity.setStatus(3);
            fileEntity.setUser(user);
            String originalFilePath = fileEntity.getFilepath();
            String filenameWithoutExtension = originalFilePath.substring(0, originalFilePath.lastIndexOf('.'));
            String newFilePath = filenameWithoutExtension + "_completato.pdf";
            FileUtils.writeByteArrayToFile(new File(newFilePath), fileContent);
            fileEntity.setOutputFilepath(newFilePath);
            json.addProperty("outputFilePath", newFilePath);
            String jsonString = json.toString();
            fileEntity.setJson(jsonString);

            if (selectedPages != null && !selectedPages.equals("[]")) {
                fileEntity.setPageSelected(selectedPages);
            } else {
                fileEntity.setPageSelected(totalPages);
            }
            fileEntity.setTotalPages(totalPages);

            ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();

            try (PDDocument document = PDDocument.load(fileContent)) {
                PDDocument nuovoDocumento = new PDDocument();
                PDPageTree pagineOriginali = document.getDocumentCatalog().getPages();

                Set<Integer> selectedPagesSet = new HashSet<>();

                if (selectedPages != null && !selectedPages.equals("[]")) {
                    JsonArray selectedPagesArray = JsonParser.parseString(selectedPages).getAsJsonArray();
                    for (JsonElement element : selectedPagesArray) {
                        int pageNumber = element.getAsInt();
                        selectedPagesSet.add(pageNumber);
                    }
                } else {
                    if (Integer.parseInt(totalPages) == 1) {
                        byteArrayOutputStream.write(fileContent);
                    } else {
                        for (int i = 1; i <= pagineOriginali.getCount(); i++) {
                            selectedPagesSet.add(i);
                        }
                    }
                }

                for (int i = 0; i < pagineOriginali.getCount(); i++) {
                    PDPage pagina = pagineOriginali.get(i);
                    if (selectedPagesSet.contains(i + 1)) {
                        nuovoDocumento.addPage(pagina);
                    }
                }

                nuovoDocumento.save(byteArrayOutputStream);
            } catch (IOException e) {
                e.printStackTrace();
            }

            for (int i = 0; i < campi.length; i++) {
                CampoFileValue campoFileValue = new CampoFileValue();
                String completeFilePath = fileEntity.getFilepath() + ".completed.pdf";

                if (selectedPages != null && !selectedPages.equals("[]")) {

                    FileUtils.writeByteArrayToFile(new File(completeFilePath), byteArrayOutputStream.toByteArray());
                } else {
                    FileUtils.writeByteArrayToFile(new File(completeFilePath), fileContent);
                }
                campoFileValue.setFileContent(completeFilePath.getBytes());
                campoFileValue.setUser(user);
                campoFileValue.setDataDiCompletamento(new Timestamp(new Date().getTime()));
                campoFileValue.setFileEntity(fileEntity);
                campoFileValue.setFieldValue(campi[i]);
                Campo_form campoForm = em.find(Campo_form.class, Long.parseLong(idCampi[i]));
                campoFileValue.setCampoForm(campoForm);
                InfoTrack.actionTrack(request.getSession().getAttribute("us_name").toString(), "Salvataggio Dati", jsonString);
                em.persist(campoFileValue);
            }

            et.commit();
            response.sendRedirect("index.jsp?esito=OK");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?esito=ERROR");
        } finally {
            em.close();
            emf.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
