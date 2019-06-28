<%@page contentType="text/html" pageEncoding="UTF-8"%>

<% 
    String contexto = request.getContextPath();
    if (!contexto.equals(""))
        contexto = contexto + "/";
%>

<!doctype html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">    
        <link rel="stylesheet" type="text/css" href="${contexto}styles/LoginStyle.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">

        <title>Urna Online - Login </title>
    </head>

    <header>
        <h2>Votação ONLINE</h2>
    </header>
    <body>
       
        
        <div class="container">
            <form action="autenticador" class="form_Login" method="post" >
                    <div class="form-group">
                        <label for="login" id="lb_tituloeleitor">Título Do Eleitor</label>
                        <input type="number" class="form-control" name="login" aria-describedby="infoTitulo" placeholder="Entre com seu Título" required>
                        <small id="infoTitulo">Entre com seu Titulo de Eleitor.</small>
                    </div>
                    <div class="form-group">
                        <label for="senha" id="lb_cpf" >CPF</label>
                        <input type="password" class="form-control" name="senha" placeholder="Entre com seu CPF" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Confirma</button>
            </form>
        </div>        
    </body>
</html>