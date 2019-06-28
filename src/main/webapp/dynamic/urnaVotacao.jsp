<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.*" %>
<%@ page import="java.util.List" %>

<%
		HttpSession sessao = (HttpSession) request.getSession();
		Usuario usuario = (Usuario) sessao.getAttribute("usuario");
   		Candidatos candidato = (Candidatos) request.getAttribute("candidato");
        
		if (usuario != null) {
			sessao.getServletContext().getRequestDispatcher("/UrnaOnline");
		}
%>

<!doctype html>
<html>
  <head>        
    <meta charset="utf-8"/> 
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>       
		<link rel="stylesheet" type="text/css" href="styles/UrnaStyle.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous"> 
		<link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
	<title>Urna Online - Votação</title>
  </head>

	<body>
		<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
		
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
				<a class="navbar-brand" href="#">Urna Online - Votação</a>
				<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
			
				<div class="collapse navbar-collapse" id="navbarSupportedContent">
					
					<%if (usuario.getFk_nivel().getNivel() == 3 || usuario.getFk_nivel().getNivel() == 2 ) {%>
						<form action="mesario" method="post">
							<button type="submit" class="btn btn-outline-secondary">Mesário</button>
						</form>
					<%}%>

					<%if (usuario.getFk_nivel().getNivel() == 3) {%>
						<form action="chefesessao" method="post">
							<button type="submit" class="btn btn-outline-secondary">Chefe de Sessão</button>
						</form>
					<%}%>
					
					<ul class="navbar-nav mr-auto">
					</ul>

					<!-- Botão para acionar modal -->
							<button type="button" class="btn btn-outline-danger" data-toggle="modal" data-target="#modalLogout">Sair</button>

						<!-- Modal -->
						<div class="modal fade" id="modalLogout" tabindex="-1" role="dialog" aria-labelledby="TituloModalCentralizado" aria-hidden="true">
						<div class="modal-dialog modal-dialog-centered" role="document">
							<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="TituloModalCentralizado">Logout</h5>
								<button type="button" class="close" data-dismiss="modal" aria-label="Cancelar">
								<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">
								Deseja realmente sair ?
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
								<form action="logout" method="post">
									<button type="submit" class="btn btn-primary">Sair</button>
								</form>
							</div>
							</div>
						</div>
						</div>
				</div>
			</nav>
		<div class="section">
			<div class="text-center" id="container-candidato">
				<form action="computarVoto" method="post">
					<div>
						<img src="<%=candidato.getFoto()%>" heigth="200" width="200" alt="<%= candidato.getNome()%>">
					</div>
					<label for="lbCandidato">Candidato:<%= candidato.getNome()%></label>
					<br>
					<label for="lbPartido">Partido:<%= candidato.getPartido()%></label>
					<input type="text" class="form-control" placeholder="Número do seu Candidato..." id="inputCandidato" name="numero" value="<%= candidato.getNumero()%>" required maxlength="2" [0-]>
					<div class="row">
						<div class="col-sm">
							<button type="submit" class="btn btn-outline-success" id="bt_confirma">Confirma</button>
						</div>
					</div>
					<% 
						if (sessao.getAttribute("erroVotacao") != null) {
							out.print("<p> Ops... Aconteceu alguma coisa no processamento do seu voto, tente novamente. </p>"); 
						}
					%>
				</form>
				<form action="urna" method="post">
					<div class="col-sm">
						<button type="submit" class="btn btn-light" id="bt_branco">Retornar</button>
					</div>
				</form>          
			</div>
		</div> 
	</body>
</html>