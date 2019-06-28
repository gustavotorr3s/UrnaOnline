package Controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.Usuario;
import Repository.UsuarioRepository;
import Service.UsuarioServiceImpl;


@WebServlet("/computarVoto")
public class Votacao extends HttpServlet 
{
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException 
    {
        try 
        {
			req.setCharacterEncoding("UTF-8"); 
        } catch (Exception e) 
        {}
        HttpSession sessao = req.getSession();
        try 
        {
            UsuarioServiceImpl userServ = new UsuarioServiceImpl();
            System.out.println(req.getParameter("numero"));
            userServ.votar(Integer.parseInt(req.getParameter("numero")),(Usuario)sessao.getAttribute("usuario"));
            sessao.getServletContext().getRequestDispatcher("/dynamic/votadocomsucesso.jsp").forward(req,resp);
        } 
        catch (Exception e) 
        {
            e.getStackTrace();
            req.setAttribute("erroVotacao", true);
            sessao.getServletContext().getRequestDispatcher("/urna").forward(req,resp);
        }
    }    
}