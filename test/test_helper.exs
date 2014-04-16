Dynamo.under_test(ProjectTynamo.Dynamo)
Dynamo.Loader.enable
ExUnit.start

defmodule ProjectTynamo.TestCase do
  use ExUnit.CaseTemplate

  # Enable code reloading on test cases
  setup do
    Dynamo.Loader.enable
    :ok
  end
end
