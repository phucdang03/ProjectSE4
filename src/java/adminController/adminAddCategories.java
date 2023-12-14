/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package adminController;

import dal.CategoriesDAL;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Categories;

/**
 *
 * @author vinhp
 */
public class adminAddCategories extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("addCategoryAdmin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("catid");
        String name = request.getParameter("name");
        CategoriesDAL dal = new CategoriesDAL();
        Categories cat = dal.checkIDCategory(id);
        if (cat != null) {
            request.setAttribute("error", "id " + id + " existed!");
            request.getRequestDispatcher("addCategoryAdmin.jsp").forward(request, response);
        } else {
            cat = new Categories(id, name);
            dal.addNewCategory(cat);
            response.sendRedirect("adminlist");
        }

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
