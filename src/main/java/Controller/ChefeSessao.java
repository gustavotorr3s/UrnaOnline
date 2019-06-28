package Controller;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.Candidatos;
import Model.Usuario;
import Repository.*;
import Service.CandidatoServiceImpl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
/**
 * ChefeSessao
 */
@WebServlet("/chefesessao")
public class ChefeSessao extends HttpServlet 
{
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException 
    {
        CandidatosRepository candRep = new CandidatosRepository();
        CandidatoServiceImpl candServ = new CandidatoServiceImpl();
        List <Candidatos> candidatos = candRep.buscaTodosCandidatos();

        HttpSession sessao = req.getSession();
        sessao.setAttribute("candidatos", candidatos);
        req.setAttribute("totalVotos",candServ.SomaVotos());

        Usuario user = (Usuario) sessao.getAttribute("usuario");

        try 
        {
            sessao.getServletContext().getRequestDispatcher("/dynamic/chefe_sessão.jsp").forward(req, resp);
        } 
        catch (Exception e) 
        {
            e.getStackTrace();
        }
    }
}