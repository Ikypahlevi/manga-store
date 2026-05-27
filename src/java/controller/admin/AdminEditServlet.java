package controller.admin;

import dal.SachDAO;
import model.Sach;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "AdminEditServlet", urlPatterns = {"/AdminEditServlet"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class AdminEditServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            ArrayList<Sach> list = SachDAO.findByMaSach(id);
            if (!list.isEmpty()) {
                request.setAttribute("sach", list.get(0));
                request.setAttribute("view", "/WEB-INF/views/admin/edit.jsp");
                request.getRequestDispatcher("/WEB-INF/views/layouts/base.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        try {
            int maSach = Integer.parseInt(request.getParameter("maSach"));
            String tenSach = request.getParameter("tenSach");
            double giaTien = Double.parseDouble(request.getParameter("giaTien"));
            int soLuong = Integer.parseInt(request.getParameter("soLuong"));
            String oldHinhAnh = request.getParameter("oldHinhAnh");
            String trailerUrl = request.getParameter("trailerUrl");
            String theLoai = request.getParameter("theLoai");
            if (theLoai == null || theLoai.trim().isEmpty()) {
                theLoai = "Khác";
            }

            Part filePart = request.getPart("hinhAnh");
            String hinhAnh = oldHinhAnh;
            if (filePart != null && filePart.getSize() > 0) {
                try {
                    String submittedFile = getSubmittedFileName(filePart);
                    if (submittedFile != null && !submittedFile.trim().isEmpty()) {
                        hinhAnh = submittedFile;
                        
                        String projectPath = "C:\\duongg\\NTD-01\\web\\img";
                        File projectDir = new File(projectPath);
                        if (!projectDir.exists()) projectDir.mkdirs();
                        
                        String runtimePath = request.getServletContext().getRealPath("/img");
                        if (runtimePath != null) {
                            File runtimeDir = new File(runtimePath);
                            if (!runtimeDir.exists()) runtimeDir.mkdirs();
                        }

                        File targetProjectFile = new File(projectDir, submittedFile);
                        try (java.io.InputStream is = filePart.getInputStream();
                             java.io.FileOutputStream fos = new java.io.FileOutputStream(targetProjectFile)) {
                            byte[] buffer = new byte[8192];
                            int bytesRead;
                            while ((bytesRead = is.read(buffer)) != -1) {
                                fos.write(buffer, 0, bytesRead);
                            }
                        }
                        
                        if (runtimePath != null) {
                            File targetRuntimeFile = new File(runtimePath, submittedFile);
                            try (java.io.InputStream is = filePart.getInputStream();
                                 java.io.FileOutputStream fos = new java.io.FileOutputStream(targetRuntimeFile)) {
                                byte[] buffer = new byte[8192];
                                int bytesRead;
                                while ((bytesRead = is.read(buffer)) != -1) {
                                    fos.write(buffer, 0, bytesRead);
                                }
                            } catch (Exception ex) {
                                // ignore runtime copy errors
                            }
                        }
                    }
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }

            ArrayList<Sach> list = SachDAO.findByMaSach(maSach);
            if (!list.isEmpty()) {
                Sach s = list.get(0);
                s.setTenSach(tenSach);
                s.setGiaTien(giaTien);
                s.setSoLuong(soLuong);
                s.setHinhAnh(hinhAnh);
                s.setTheLoai(theLoai);
                
                // Xử lý link youtube sang dạng embed
                if (trailerUrl != null && !trailerUrl.trim().isEmpty()) {
                    if (trailerUrl.contains("youtube.com/watch?v=")) {
                        String videoId = trailerUrl.split("v=")[1];
                        int ampersandIndex = videoId.indexOf('&');
                        if (ampersandIndex != -1) {
                            videoId = videoId.substring(0, ampersandIndex);
                        }
                        trailerUrl = "https://www.youtube.com/embed/" + videoId;
                    } else if (trailerUrl.contains("youtu.be/")) {
                        String videoId = trailerUrl.split("youtu.be/")[1];
                        int questionIndex = videoId.indexOf('?');
                        if (questionIndex != -1) {
                            videoId = videoId.substring(0, questionIndex);
                        }
                        trailerUrl = "https://www.youtube.com/embed/" + videoId;
                    }
                }
                
                s.setTrailerUrl(trailerUrl);
                SachDAO.Update(s);
            }

            response.sendRedirect(request.getContextPath() + "/admin");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin");
        }
    }

    private String getSubmittedFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        if (contentDisp != null) {
            for (String token : contentDisp.split(";")) {
                if (token.trim().startsWith("filename")) {
                    String fileName = token.substring(token.indexOf("=") + 1).trim();
                    if (fileName.startsWith("\"") && fileName.endsWith("\"")) {
                        fileName = fileName.substring(1, fileName.length() - 1);
                    }
                    fileName = new java.io.File(fileName).getName();
                    if (fileName.contains("\\")) {
                        fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);
                    }
                    if (fileName.contains("/")) {
                        fileName = fileName.substring(fileName.lastIndexOf("/") + 1);
                    }
                    return fileName;
                }
            }
        }
        return null;
    }
}
