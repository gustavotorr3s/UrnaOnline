package Controller;


import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.Usuario;
import Repository.UsuarioRepository;
import Service.UsuarioServiceImpl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/urna")
public class Urna extends HttpServlet{
    private static final long serialVersionUID = 121875378468696897L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException 
    {
        UsuarioServiceImpl usuarioService = new UsuarioServiceImpl();
        UsuarioRepository userRepo = new UsuarioRepository();


        List<Usuario> usuarios = usuarioService.buscaTodosUsuarios();

        HttpSession sessao = req.getSession();
        Usuario usuarioAtual = (Usuario) sessao.getAttribute("usuario");
        sessao.setAttribute("usuario", userRepo.buscarUsuariosTitulo(usuarioAtual.getTitulo()));
        sessao.setAttribute("usuarios", usuarios);

        try 
        {
            sessao.getServletContext().getRequestDispatcher("/dynamic/urna.jsp").forward(req, resp);
        } 
        catch (Exception e) 
        {
            e.getMessage();
        }
    }
}