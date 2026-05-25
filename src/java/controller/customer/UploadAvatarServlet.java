package controller.customer;

import dal.UserDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

@WebServlet(name = "UploadAvatarServlet", urlPatterns = {"/UploadAvatarServlet"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class UploadAvatarServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "img/avatars";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }

        // Lấy đường dẫn thực tế trên server (thường là build/web trong NetBeans)
        String applicationPath = request.getServletContext().getRealPath("");
        if (applicationPath == null) {
            applicationPath = request.getServletContext().getRealPath("/");
        }
        
        // Đường dẫn tới thư mục đích trên server đang chạy
        String uploadFilePath = applicationPath + File.separator + "img" + File.separator + "avatars";
        
        // Cố gắng suy luận đường dẫn source code (web/img/avatars) để lưu vĩnh viễn
        String sourceFilePath = null;
        if (applicationPath.contains("build" + File.separator + "web")) {
            sourceFilePath = applicationPath.replace("build" + File.separator + "web", "web") + File.separator + "img" + File.separator + "avatars";
        } else if (applicationPath.contains("build/web")) {
            sourceFilePath = applicationPath.replace("build/web", "web") + File.separator + "img" + File.separator + "avatars";
        } else if (applicationPath.contains("build\\web")) {
            sourceFilePath = applicationPath.replace("build\\web", "web") + File.separator + "img" + File.separator + "avatars";
        }
        
        // Tạo thư mục nếu chưa tồn tại
        File fileSaveDir = new File(uploadFilePath);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdirs();
        }
        
        if (sourceFilePath != null) {
            File sourceDir = new File(sourceFilePath);
            if (!sourceDir.exists()) {
                sourceDir.mkdirs();
            }
        }
        
        String fileName = null;
        try {
            for (Part part : request.getParts()) {
                String submittedFileName = part.getSubmittedFileName();
                if (submittedFileName != null && !submittedFileName.isEmpty()) {
                    String extension = "";
                    int i = submittedFileName.lastIndexOf('.');
                    if (i > 0) {
                        extension = submittedFileName.substring(i);
                    }
                    fileName = "avatar_" + user.getId() + "_" + UUID.randomUUID().toString().substring(0,8) + extension;
                    
                    File targetFile = new File(uploadFilePath, fileName);
                    try (InputStream fileContent = part.getInputStream()) {
                        Files.copy(fileContent, targetFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
                    }
                    
                    // Lưu một bản vào thư mục source web/img/avatars
                    if (sourceFilePath != null) {
                        File sourceFile = new File(sourceFilePath, fileName);
                        Files.copy(targetFile.toPath(), sourceFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
                    }
                    
                    break; 
                }
            }
            
            if (fileName != null) {
                String relativePath = UPLOAD_DIR + "/" + fileName;
                boolean updated = UserDAO.updateAvatar(user.getId(), relativePath);
                if (updated) {
                    user.setAvatar(relativePath);
                    session.setAttribute("user", user);
                    request.getSession().setAttribute("message", "Cập nhật ảnh đại diện thành công!");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Lỗi upload ảnh: " + e.getMessage());
        }
        
        // Nếu là Admin thì redirect về dashboard, nếu là User thì redirect về profile
        if ("ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/admin?action=dashboard");
        } else {
            response.sendRedirect(request.getContextPath() + "/CustomerProfileServlet");
        }
    }
}
