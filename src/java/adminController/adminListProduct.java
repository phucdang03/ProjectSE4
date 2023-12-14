/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package adminController;

import dal.ProductDAL;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Product;

/**
 *
 * @author vinhp
 */
public class adminListProduct extends HttpServlet {

    HashMap<String, Integer> hashCart = new HashMap<String, Integer>();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter pr = response.getWriter();

        ProductDAL pDAL = new ProductDAL();
        HttpSession session = request.getSession();
        //////////////////////////////////////////
        String username = (String) session.getAttribute("user");
        String category = request.getParameter("catid");
        String search = (String) request.getParameter("search");
        String sort = (String) request.getParameter("sort");
        List<Product> bookList = new ArrayList<>();
        //////////////////////////////////////////
        if ((search == null || search.equals("")) && (sort == null || sort.equals("")) && (category == null || category.equals(""))) {
            bookList = pDAL.getAllProduct();
        } else if (search != null && (sort == null || sort.equals("")) && (category == null || category.equals(""))) {
            bookList = pDAL.getProductBySearch(search);
        } else if ((search == null || search.equals("")) && sort != null && (category == null || category.equals(""))) {
            if (sort.equals("price↑")) {
                bookList = pDAL.getProductOrderByPriceAsc();
            }
            if (sort.equals("price↓")) {
                bookList = pDAL.getProductOrderByPriceDesc();
            }
            if (sort.equals("bestSeller")) {
                bookList = pDAL.getProductOrderByBestSeller();
            }
            if (sort.equals("name")) {
                bookList = pDAL.getProductOrderByName();
            }
        } else if ((search == null || search.equals("")) && (sort == null || sort.equals("")) && category != null) {
            bookList = pDAL.getProductByCategory(category);
        } else if ((search == null || search.equals("")) && sort != null && category != null) {
            bookList = pDAL.getProductOrderByCatAndSort(category, sort);
        }
        int page, numperpage = 6;
        int size = bookList.size();
        int num = (size % 6 == 0 ? (size / 6) : ((size / 6)) + 1);//so trang
        String xpage = request.getParameter("page");
        if (xpage == null) {
            page = 1;
        } else {
            page = Integer.parseInt(xpage);
        }
        int start, end;
        start = (page - 1) * numperpage;
        end = Math.min(page * numperpage, size);
        List<Product> list = pDAL.getListByPage(bookList, start, end);

        //request.setAttribute("data", list);
        request.setAttribute("page", page);
        request.setAttribute("num", num);

        request.setAttribute("bookList", list);
        ///////////////////////////////////////////
        try {
            String pid = request.getParameter("pid");
            int amount = Integer.parseInt(request.getParameter("amount"));
            if (pid == null || amount == 0) {
                request.getRequestDispatcher("shopAdmin.jsp").include(request, response);
            } else {
                if (username != null) {
                    hashCart = pDAL.getCart(username);
                }
                if (hashCart.containsKey(pid)) {
                    hashCart.put(pid, (hashCart.get(pid) + amount));
                    pDAL.updateCart(username, pid, hashCart.get(pid));
                    session.setAttribute("hashCart", hashCart);

                } else {
                    hashCart.put(pid, amount);
                    pDAL.addToCart(username, pid, hashCart.get(pid));
                    session.setAttribute("hashCart", hashCart);
                }
                request.getRequestDispatcher("shopAdmin.jsp").include(request, response);
            }
        } catch (Exception e) {
            request.getRequestDispatcher("shopAdmin.jsp").include(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
}
