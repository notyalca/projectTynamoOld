defmodule ApplicationRouter do
  use Dynamo.Router

  import KeyValue
  import RoutesFile 

  prepare do
    # Pick which parts of the request you want to fetch
    # You can comment the line below if you don't need
    # any of them or move them to a forwarded router
    conn.fetch([:cookies, :params])
  end

  # It is common to break your Dynamo into many
  # routers, forwarding the requests between them:
  # forward "/posts", to: PostsRouter

  get "/" do
    conn = conn.assign(:title, "Welcome to Tynamo!")
    render conn, "index.html"
  end

  get "/sim/:first/:second" do
    path = "/#{conn.params[:first]}/#{conn.params[:second]}"
    #IO.puts path
    #filename = elem List.keyfind(KeyValue.mapTo(RoutesFile.routes),path,0),1
    foundTuple = List.keyfind(KeyValue.mapTo(RoutesFile.routes),path,0)
    if foundTuple do
      filename = elem foundTuple,1
      #IO.puts filename
      conn.resp 200, File.read!("/home/ajclayton/Dropbox/projectTynamo/"<>filename)
    else
      conn.status 404
    end
  end

  get "routes" do
    conn = conn.assign(:title, "Tynamo: Defined Routes")
    conn = conn.assign(:path, RoutesFile.path)
    conn = conn.assign(:keyValue, KeyValue.mapTo(RoutesFile.routes))
    render conn, "routes.html"
  end
end
