package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dal.AccountDAL;

public class SignUpServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter pr = response.getWriter();
        request.getRequestDispatcher("signUp.jsp").include(request, response);

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter pr = response.getWriter();
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        AccountDAL aDAL = new AccountDAL();
        String key = aDAL.signup1(username, password, fullname, email, phone, address);
        HttpSession session = request.getSession();
        if (key != null) {            
            session.setAttribute("key", email + "-" + key);
            response.sendRedirect("signin");
        } else {
            request.setAttribute("error", "Username existed!");
            request.getRequestDispatcher("signUp.jsp").forward(request, response);
        }
    }

}
