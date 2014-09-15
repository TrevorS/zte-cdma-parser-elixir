defmodule ZteCdmaSpecs do

  def load_specs do
    load_specs_config |> parse_specs
  end

  defp parse_specs(file_name) do
    {_result, file} = File.open(file_name, [:read, :utf8])
    specs = []
    process_line(file, specs)
  end

  defp process_line(file, specs) do
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

  defp process_spec(data, specs) do
    [field_name, length] = String.split(String.strip(data), ", ")
    specs ++ [[field_name, String.to_integer(length)]]
  end

  defp load_specs_config do
    use Mix.Config
    Mix.Config.import_config("../config/config.exs")
      |> Keyword.get(:zte_cdma_parser)
      |> Keyword.get(:specs_filename)
  end
end
