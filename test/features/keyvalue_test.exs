# Feature tests go through the Dynamo.under_test
# and are meant to test the full stack.
defmodule KeyValueTest do
  use ProjectTynamo.TestCase

  test "splits csv to key-value pairs" do
    assert KeyValue.toKeyValue("myKey,myValue") == {"myKey","myValue"}
  end

  test "map string to key-value pairs" do
    assert KeyValue.mapTo(["myKey1,myValue1","myKey2,myValue2"]) == [{"myKey1","myValue1"},{"myKey2","myValue2"}]
  end
end
