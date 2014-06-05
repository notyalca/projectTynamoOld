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

