defmodule ZteCdmaParserTest do
  use ExUnit.Case

  setup_all do
    {:ok, spec_file: "specs/zte-cdma.txt", test_file: "test-files/zte-test.gz"}
  end

  test "does the specs parser work", context do
    assert ZteCdmaSpecs.parse_specs(context[:spec_file])
  end

  test "does the cdr parser work", context do
    assert ZteCdmaParser.parse(context[:test_file], context[:spec_file])
  end

  test "does the cdr parser have records", context do
    records = ZteCdmaParser.parse(context[:test_file], context[:spec_file])
    assert records > 0
  end

  test "do we have actual records?", context do
    records = ZteCdmaParser.parse(context[:test_file], context[:spec_file])
    assert length(Dict.keys(hd(records))) != 0
  end
end
