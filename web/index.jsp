<%@page import="br.weather.api.Http"%>
<%@page import="br.weather.clima.Clima"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<% 
    request.setCharacterEncoding("UTF-8");
    response.setContentType("text/html; charset=UTF-8");
    
    Clima clima = null;
    String cidade = "";
    
    if(request.getParameter("cidade") != null) {
        cidade = request.getParameter("cidade");
        clima = Http.getClima(cidade);
    }
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>APIWeather</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>
    </head>
    <style>
        body {
            background: #333333;
        }
        .container-fluid {
            width: 600px;
        }
        .tempo-card {
            padding-top: 100px;
            width: 400px;
            margin: 0 auto !important;
        }
        .card {
            box-shadow: 0 15px 25px 0 rgba(0,0,0,0.2);
            transition: 0.3s;
            border-radius: 20px;
        }
    </style>
    <body>
        
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="./">APIWeather</a>
            
            <form class="d-flex" method="POST">
                <input type="search" name="cidade" value="<%=cidade%>" class="form-control me-2" placeholder="Nome da cidade">
                <button class="btn btn-outline-info" type="submit">Buscar</button>
            </form>
        </div>
    </nav>
                
    <% if(clima != null) { %>
    <div class="container">
        <div class="row">
            <div class="tempo-card">
                <div class="card">
                    <div class="card-body">
                        <div class="text-center">
                            <img src="http://openweathermap.org/img/wn/<%=clima.getWeather().get(0).getIcon()%>@2x.png">
                            <h3>Cidade: <%= clima.getName() %>, <%= clima.getSys().getCountry()%></h3>
                            <hr>
                        </div>
                        <div>
                            <p class="text-capitalize"><strong>Agora: </strong><%= clima.getWeather().get(0).getDescription() %></p>
                            <p><strong>Temperatura: </strong><%= clima.getMain().getTemp()%> °C</p>
                            <p><strong>Máximo </strong><%= clima.getMain().getTempMax()%> °C</p>
                            <p><strong>Mínimo: </strong><%= clima.getMain().getTempMin()%> °C</p>
                            <p><strong>Umidade: </strong><%= clima.getMain().getHumidity()%>%</p>
                            <p><strong>Sensação Térmica: </strong><%= clima.getMain().getFeelsLike()%>°C</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <% } else {%>
    <div class="container">
        <div class="row">
            <div class="tempo-card">
                <div class="card">
                    <div class="card-body">
                        <div class="text-center">
                            <h4><%= cidade.isEmpty() ? "Digite o nome da cidade" : cidade + " não encontrado(a)!"%></h4>
                       </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <% } %>
    </body>
</html>
