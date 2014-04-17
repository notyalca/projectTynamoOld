defmodule ApplicationRouter do
  use Dynamo.Router

  prepare do
    # Pick which parts of the request you want to fetch
    # You can comment the line below if you don't need
    # any of them or move them to a forwarded router
    conn.fetch([:cookies, :params])
  end

  # It is common to break your Dynamo into many
  # routers, forwarding the requests between them:
  # forward "/posts", to: PostsRouter

  defmodule RoutesFile do
    def path do
      "/home/ajclayton/Dropbox/projectTynamo/routes.txt"
    end
    def routes do
      strArray = (String.split(File.read!(RoutesFile.path), "\n"))
      strLen = length strArray
      List.delete_at strArray,strLen-1
    end
  end

  defmodule KeyValue do
    def mapTo(strList) do
      Enum.map strList, fn val -> toKeyValue(val) end
    end
    def toKeyValue(str) do
      [head | tail] = String.split(str, ",")
      [tail | _] = tail
      {head,tail}
    end
    def print(myList) do
      lc { key, value} inlist myList do
        IO.puts key <> ":" <> value 
      end
    end
  end


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
