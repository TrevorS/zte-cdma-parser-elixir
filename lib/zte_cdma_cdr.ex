defmodule ZteCdmaCdr do

  def parse(line, specs) do
    fields = HashDict.new
    process_line(line, specs, fields)
  end

  defp process_line(line, specs, fields) do
    case specs do
      [] ->
        fields
      _ ->
        [[field_name, field_length] | rest_specs] = specs
        [new_fields, rest_line] = process_field(line, field_name, field_length, fields)
        process_line(rest_line, rest_specs, new_fields)
    end
  end

  defp process_field(line, field_name, field_length, fields) do
    << field :: size(field_length) - binary, rest :: binary >> = line
    fields = HashDict.put fields, field_name, String.strip(field)
    [fields, rest]
  end
end
