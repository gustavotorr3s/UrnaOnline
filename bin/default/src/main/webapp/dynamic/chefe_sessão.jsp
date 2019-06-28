<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.*" %>
<%@ page import="java.util.List" %>

<%
	HttpSession sessao = request.getSession();
	Usuario usuario = (Usuario) sessao.getAttribute("usuario"); 
	List<Candidatos> candidatos = (List<Candidatos>) sessao.getAttribute("candidatos");
	int TotalVotos = (int) request.getAttribute("totalVotos");

	if (sessao.getId().equals(null)) {
		sessao.getServletContext().getRequestDispatcher("/UrnaOnline").forward(request, response);
		return;
	}

	if (usuario.getFk_nivel().getNivel() != 3) {
		sessao.getServletContext().getRequestDispatcher("/urna").forward(request, response);
		return;
	}
%>

<!doctype html>
<html>
  <head>        
		<meta charset="utf-8"/>   
		<link rel="stylesheet" type="text/css" href="styles/ChefeSessaoStyle.css">
    	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous"> 
		<link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
		<title>Urna Online - Chefe De Sessão</title>
  </head>

	<body>
		<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
				<a class="navbar-brand" href="#">Urna Online - Chefe De Sessão</a>
				<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
			
				<div class="collapse navbar-collapse" id="navbarSupportedContent">
					<form action="mesario" method="post">
						<button type="submit" class="btn btn-outline-secondary">Mesário</button>
					</form>
					<%if (usuario.isVotado() == false) {%>
						<form action="urna" method="post">
							<button type="submit" class="btn btn-outline-secondary">Urna</button>
						</form>
					<% } %>
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

		<div id="container_zonasessao" class="shadow-sm p-3 mb-5 bg-white rounded">
			<p>Chefe de Sessão: <%=usuario.getNome()%></p>
			<p>CPF: <%=usuario.getCpf()%></p>
			<p>Seção Eleitoral: <%=usuario.getFk_id_secao().getId_secao()%></p>
			<p>Zona Eleitoral: <%=usuario.getFk_id_zona().getNome()%></p>
		</div>

		<table class="table table-hover">
			<thead>
				<tr>
					<th scope="col">Colocação</th>
					<th scope="col">Candidato</th>
					<th scope="col">Partido</th>
					<th scope="col">Votos</th>
				</tr>
			</thead>
			<tbody>
					<%
						if (!candidatos.isEmpty()) {
							for (Candidatos candidato : candidatos) {
					%>
						<tr>
							<td><%= (candidatos.indexOf(candidato)+ 1)%></td>
							<td><%= candidato.getNome() %></td>
							<td><%= candidato.getPartido() %></td>
							<td><%= candidato.getVotos() %></td>
						</tr>
					<%} }%>
				<tr>
					<td>Total de Votos: <%=TotalVotos%></td>
				</tr>
			</tbody>
	</table>
	</body>
</html>