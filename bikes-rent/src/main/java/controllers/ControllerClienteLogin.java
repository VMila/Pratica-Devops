package controllers;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ClienteLoginDAO;
import domain.Cliente;
import service.EmailService;

// Confere as informações de login do cliente provenientes do loginCliente.jsp
@WebServlet("/clienteLogin")
public class ControllerClienteLogin extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ClienteLoginDAO dao;

    @Override
    public void init() {
        dao = new ClienteLoginDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        try {
            Cliente cliente = dao.authCliente(email, password);
            if (cliente != null) {
                HttpSession session = request.getSession();
                session.setAttribute("email", cliente.getEmail());
                session.setAttribute("cpf", cliente.getCpf());
                session.setAttribute("nome", cliente.getNome());
                session.setAttribute("role", "cliente");
                String redirectTo = (String) session.getAttribute("redirectTo");
                EmailService.sendWelcomeEmail(email);
                if (redirectTo != null) {
                    session.removeAttribute("redirectTo");
                    response.sendRedirect(redirectTo);
                } else {
                    response.sendRedirect(request.getContextPath() + "/cliente/");
                }
            } else {
                String errorMessage = URLEncoder.encode("Senha ou email invalidos!", StandardCharsets.UTF_8.toString());
                response.sendRedirect(request.getContextPath() + "/login/loginCliente.jsp?error=" +errorMessage);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
