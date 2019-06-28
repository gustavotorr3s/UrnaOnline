package Service;

import java.util.List;

import Model.*;
import Repository.*;


public class UsuarioServiceImpl implements UsuarioService {
    
    private UsuarioRepository userRepo = new UsuarioRepository(); 
    private List<Usuario> usuarios = userRepo.buscarUsuarios();
    private CandidatosRepository candRepo = new CandidatosRepository();

    @Override
    public Usuario VerificaLogin(String titulo, String senha) {
        for (Usuario u : usuarios) {
            try {
                if (titulo.equals(u.getTitulo()) && senha.equals(u.getSenha())) {
                    return u;
                }
            } catch (Exception e) {
                return null;
            }
        }
        return null;
    }

	public List<Usuario> buscaTodosUsuarios() {
        try {
            return usuarios;
        } catch (Exception e) {

            //TODO: handle exception
            return null;
        }
    }
    

    @Override
    public Boolean votar(int numero, Usuario user){
        try {
            candRepo.SomarVotacao(numero);
            userRepo.Votado(user);
            return true;
        } catch (Exception e) {
            e.getStackTrace();
            return false;
        }
    }

    @Override
    public Boolean AtivarVotante(String titulo) {
        try {
            userRepo.Habilitar(userRepo.buscarUsuariosTitulo(titulo));
            return true;
        } catch (Exception e) {
            //TODO: handle exception
            e.getStackTrace();
            return false;
        }       
    }
}