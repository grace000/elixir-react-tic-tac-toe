defmodule TicTacToeWeb.PageControllerTest do
    use TicTacToeWeb.ConnCase

    test "index renders index page", %{conn: conn} do
        conn = get conn, "/"
        assert conn.resp_body == "<!DOCTYPE html>\n<html lang=\"en\">\n  <head>\n    <meta charset=\"utf-8\"/>\n    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"/>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"/>\n    <title>PhoenixReactPlayground · Phoenix Framework</title>\n    <link rel=\"stylesheet\" href=\"/css/app.css\"/>\n  </head>\n  <body>\n<div id=\"react-app\"></div>\n    <script type=\"text/javascript\" src=\"/js/app.js\"></script>\n  </body>\n</html>"    
    end
end 
