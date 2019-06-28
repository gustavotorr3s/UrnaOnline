package Controller;


import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.Candidatos;
import Repository.CandidatosRepository;
import Repository.UsuarioRepository;

/**
 * VerificaCandidato
 */
@WebServlet("/buscaCandidato")
public class VerificaCandidato extends HttpServlet 
{
    private static final long serialVersionUID = -1547546431545719670L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException 
    {
        try 
        {
			req.setCharacterEncoding("UTF-8"); 
        } 
        catch (Exception e) 
        {
		}
        
        HttpSession sessao = req.getSession();
        try 
        {
            CandidatosRepository candRepo = new CandidatosRepository();
            int numero = Integer.parseInt(req.getParameter("numero"));
            Candidatos cand = candRepo.buscaCandidatosNumero(numero);
    
            req.setAttribute("candidato", cand);
            sessao.getServletContext().getRequestDispatcher("/dynamic/urnaVotacao.jsp").forward(req, resp);   
        } 
        catch (Exception e) 
        {
            //TODO: handle exception
            e.getStackTrace();
            sessao.setAttribute("erro", true);
            sessao.getServletContext().getRequestDispatcher("/dynamic/urna.jsp").forward(req, resp);  
        }
    }
}