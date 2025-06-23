package board;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Date;
import java.util.stream.Collectors;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/boardProcess")
@MultipartConfig
public class BoardProcessServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        Part subjectPart = request.getPart("subject");
        Part contentPart = request.getPart("content");

        String subject = new BufferedReader(new InputStreamReader(subjectPart.getInputStream(), "UTF-8"))
                .lines().collect(Collectors.joining("\n"));
        String content = new BufferedReader(new InputStreamReader(contentPart.getInputStream(), "UTF-8"))
                .lines().collect(Collectors.joining("\n"));

        // 디버깅을 위해 데이터 출력
        System.out.println("제목: " + subject);
        System.out.println("내용: " + content);

        String writer = (String) request.getSession().getAttribute("username");
        String date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
        int view = 0;
        int great = 0;

        if (subject == null || subject.isEmpty() || content == null || content.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "제목과 내용이 필요합니다.");
            return;
        }

        String[] imageNames = new String[5];
        for (int i = 0; i < 5; i++) {
            imageNames[i] = "";
        }

        Collection<Part> parts = request.getParts();
        int imageIndex = 0;
        for (Part part : parts) {
            if (part.getName().equals("images") && part.getSize() > 0) {
                String fileName = System.currentTimeMillis() + "_" + part.getSubmittedFileName();
                imageNames[imageIndex] = "uploads/" + fileName;
                part.write(getServletContext().getRealPath("/") + imageNames[imageIndex]);
                imageIndex++;
                if (imageIndex >= 5) break;
            }
        }

        // DTO 사용
        BoardDTO board = new BoardDTO();
        board.setSubject(subject);
        board.setContent(content);
        board.setWriter(writer);
        board.setDate(date);
        board.setView(view);
        board.setGreat(great);
        board.setImages(imageNames);

        Connection conn = (Connection) getServletContext().getAttribute("dbConn");

        if (conn == null) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "데이터베이스 연결에 실패했습니다.");
            return;
        }

        try {
            String sql = "INSERT INTO board (subject, content, writer, date, view, great, image1, image2, image3, image4, image5) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, board.getSubject());
            pstmt.setString(2, board.getContent());
            pstmt.setString(3, board.getWriter());
            pstmt.setString(4, board.getDate());
            pstmt.setInt(5, board.getView());
            pstmt.setInt(6, board.getGreat());
            for (int i = 0; i < 5; i++) {
                pstmt.setString(7 + i, board.getImages()[i]);
            }

            int result = pstmt.executeUpdate();

            if (result > 0) {
                response.sendRedirect("board.jsp");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "게시글 작성에 실패했습니다.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "게시글 작성 중 오류가 발생했습니다.");
        }
    }
}
