<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.*" %>
<%@ page import="java.util.List" %>

<%
		HttpSession sessao = (HttpSession) request.getSession();
		Usuario usuario = (Usuario) sessao.getAttribute("usuario");
		List<Usuario> usuariosAtivos = (List<Usuario>) request.getAttribute("usuariosAtivos");
		List<Usuario> usuariosInativos = (List<Usuario>) request.getAttribute("usuariosInativos");

		if (usuario != null) {
			sessao.getServletContext().getRequestDispatcher("/UrnaOnline");
		}
		if (usuario.getFk_nivel().getNivel() != 3 && usuario.getFk_nivel().getNivel() != 2) {
			sessao.getServletContext().getRequestDispatcher("urna").forward(request, response);
		}
%>

<!doctype html>
<html>
  <head>        
    <meta charset="utf-8"/>        
		<link rel="stylesheet" type="text/css" href="styles/MesarioStyle.css">
    	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous"> 
		<link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
		<link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet">
		<title>Urna Online - Mesário Digital</title>
  </head>

	<body>

		<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
		
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
				<a class="navbar-brand" href="#">Urna Online - Mesario Digital</a>
				<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
			
				<div class="collapse navbar-collapse" id="navbarSupportedContent">
					<%if (usuario.isVotado() == false) {%>
						<form action="urna" method="post">
							<button type="submit" class="btn btn-outline-secondary">Urna</button>
						</form>
					<% } %>
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

		
		<form action="AtivarVotante" method="get">
			<div class="input-group mb-3">
				<input type="text" class="form-control" placeholder="Insira o Titulo para liberar o voto do usuario." name="tituloUser" aria-label="Recipient's username" aria-describedby="basic-addon2" required>
				<button class="btn btn-outline-success" type="Submit">Ativar Usuario</button>
			</div>
		</form>
		
		<%
			if (!usuariosAtivos.isEmpty()) {
		%>
			<h3>Usuarios Ativos</h3>
				<table class="table table-hover">
					<thead>
						<tr>
							<th scope="col">Usuario</th>
							<th scope="col">Titulo</th>
						</tr>
					</thead>
					<tbody>
							<%
								for (Usuario cUser : usuariosAtivos) {
							%>
								<tr>
									<td><%= cUser.getNome() %></td>
									<td><%= cUser.getTitulo() %></td>
								</tr>
							<%}%>
					</tbody>
			</table>
		<% } %>

		<%
			if (!usuariosInativos.isEmpty()) {
		%>
			<h3>Usuarios Inativos</h3>
				<table class="table table-hover">
					<thead>
						<tr>
							<th scope="col">Usuario</th>
							<th scope="col">Titulo</th>
						</tr>
					</thead>
					<tbody>
							<%
								for (Usuario cUserInativos : usuariosInativos) {
							%>
								<tr>
									<td><%= cUserInativos.getNome() %></td>
									<td><%= cUserInativos.getTitulo() %></td>
								</tr>
							<%}%>
					</tbody>
			</table>
		<% } %>


	</body>
</html>