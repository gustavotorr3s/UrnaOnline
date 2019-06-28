package Service;

import java.util.List;

import Model.Candidatos;
import Repository.CandidatosRepository;

public class CandidatoServiceImpl implements CandidatoService 
{

    private CandidatosRepository candRepo = new CandidatosRepository();

    @Override
    public int SomaVotos(){
        List<Candidatos> candidatos = candRepo.buscaTodosCandidatos();
        int x = 0;
        for (Candidatos cCand : candidatos) {
            x += cCand.getVotos();
        }
        return x;
    }
}