package controller;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import dal.AccountDAL;
import jakarta.servlet.http.Cookie;

public class SignInServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter pr = response.getWriter();
        request.setAttribute("check", "null");
        request.getRequestDispatcher("signIn.jsp").include(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter pr = response.getWriter();
        String user = request.getParameter("user");
        String pass = request.getParameter("pass");
        String r = request.getParameter("rem");
        Cookie cu = new Cookie("cuser", user);
        Cookie cr = new Cookie("crem", r);
        if (r != null) {
            cu.setMaxAge(60 * 60 * 24 * 7);
            cr.setMaxAge(60 * 60 * 24 * 7);
        } else {
            cu.setMaxAge(0);
            cr.setMaxAge(0);
        }
        response.addCookie(cu);        
        response.addCookie(cr);
        AccountDAL accdal = new AccountDAL();
        HttpSession session = request.getSession();
        Account a = accdal.checkAccount(user, pass);
        if (a != null) {
            request.setAttribute("check", "success");
            session.setAttribute("user", user);
            session.setAttribute("pass", pass);
            request.getRequestDispatcher("signIn.jsp").forward(request, response);
        } else {
            request.setAttribute("check", "fail");
            request.getRequestDispatcher("signIn.jsp").forward(request, response);
        }
    }

}
