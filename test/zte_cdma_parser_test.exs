defmodule ZteCdmaParserTest do
  use ExUnit.Case

  setup_all do
    {:ok, spec_file: "specs/zte-cdma.txt", test_file: "test-files/zte-test.gz"}
  end

  test "does the specs parser return records", context do
    specs = ZteCdmaSpecs.parse_specs(context[:spec_file])
    assert specs > 0
  end

  test "does the cdr parser return records", context do
    records = ZteCdmaParser.parse(context[:test_file], context[:spec_file])
    assert records > 0
  end

  test "are there actual fields in the records", context do
    records = ZteCdmaParser.parse(context[:test_file], context[:spec_file])
    assert length(Dict.keys(hd(records))) != 0
  end
end
