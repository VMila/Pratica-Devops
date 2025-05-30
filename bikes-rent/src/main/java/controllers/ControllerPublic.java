package controllers;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.Date;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ClienteDAO;
import domain.Cliente;
import service.EmailService;

// Controller que abriga funções gerais e públicas a todos os usuários e personas
@WebServlet("/public/*")
public class ControllerPublic extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ClienteDAO clienteDAO;

    @Override
    public void init() {
        clienteDAO = new ClienteDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo();
        if (action == null) {
            action = " ";
        }
        try {
            switch (action) {
                case "/novoClienteForm":
                    novoClienteForm(request, response);
                    break;
                case "/criarCliente":
                    criarCliente(request, response);
                    break;
                default:
                    novoClienteForm(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    private void novoClienteForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/novoCliente.jsp");
        dispatcher.forward(request, response);

    }

    private void criarCliente(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException, SQLException {
        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");
        String telefone = request.getParameter("telefone");
        String sexo = request.getParameter("sexo");
        String cpf = request.getParameter("cpf");
        Date dataNascimento = Date.valueOf(request.getParameter("dataNascimento"));

        if(cpf.length() >11 || telefone.length() > 13 || nome.length() >100 || email.length() >100 ){
            String errorMessage = URLEncoder.encode("Campo com muitos caracteres!",
                    StandardCharsets.UTF_8.toString());
            response.sendRedirect("public?error=" + errorMessage);
            return;
        }
        try {
            Cliente novoCliente = new Cliente(email, senha, nome, telefone, sexo, cpf, dataNascimento);
            clienteDAO.insert(novoCliente);
            EmailService.sendWelcomeEmail(email);
            response.sendRedirect("/");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
