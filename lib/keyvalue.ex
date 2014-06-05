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

