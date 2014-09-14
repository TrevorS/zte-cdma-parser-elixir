defmodule ZteCdmaSpecs do

  def parse_specs(file_name) do
    {_result, file} = File.open(file_name, [:read, :utf8])
    specs = []
    process_line(file, specs)
  end

  def process_line(file, specs) do
    data = IO.read(file, :line)
    case data do
      :eof ->
        File.close(file)
        specs
      _ ->
        updated_specs = process_spec(data, specs)
        process_line(file, updated_specs)
    end
  end

  def process_spec(data, specs) do
    [field_name, length] = String.split(String.strip(data), ", ")
    specs ++ [[field_name, String.to_integer(length)]]
  end
end
