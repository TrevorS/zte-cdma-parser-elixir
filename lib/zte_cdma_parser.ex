defmodule ZteCdmaParser do

  def parse(file_name, specs_name) do
    specs = ZteCdmaSpecs.parse_specs(specs_name)
    records = []
    case File.open(file_name, [:read, :compressed]) do
      {:ok, file} ->
        records = Enum.map IO.stream(file, :line),
          &ZteCdmaCdr.parse(&1, specs)

      {:error, error} ->
        IO.puts "Could not load, error: #{error}."
    end
    records
  end
end
