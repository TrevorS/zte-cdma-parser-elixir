defmodule ZteCdmaParserTest do
  use ExUnit.Case

  setup_all do
    {:ok, test_file: "test-files/zte-test.gz"}
  end

  test "does the specs parser return specs" do
    specs = ZteCdmaSpecs.load_specs
    assert specs > 0
  end

  test "does the cdr parser return records", context do
    records = ZteCdmaParser.parse(context[:test_file])
    assert records > 0
  end

  test "are there actual fields in the records", context do
    records = ZteCdmaParser.parse(context[:test_file])
    assert length(Dict.keys(hd(records))) != 0
  end
end
