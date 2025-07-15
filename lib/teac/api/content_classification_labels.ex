defmodule Teac.Api.ContentClassificationLabels do
  alias Teac.Api
  import Ecto.Changeset

  @locales [
    "en-US",
    "bg-BG",
    "cs-CZ",
    "da-DK",
    "da-DK",
    "de-DE",
    "el-GR",
    "en-GB",
    "en-US",
    "es-ES",
    "es-MX",
    "fi-FI",
    "fr-FR",
    "hu-HU",
    "it-IT",
    "ja-JP",
    "ko-KR",
    "nl-NL",
    "no-NO",
    "pl-PL",
    "pt-BT",
    "pt-PT",
    "ro-RO",
    "ru-RU",
    "sk-SK",
    "sv-SE",
    "th-TH",
    "tr-TR",
    "vi-VN",
    "zh-CN",
    "zh-TW"
    ###########
  ]

  def get(opts) do
    case validate_get_opts(opts) do
      {:ok, %{token: token, client_id: client_id} = cs} ->
        params =
          if Map.get(cs, :locale, nil) do
            [{:locale, Map.get(cs, :locale, nil)}]
          else
            []
          end

        [
          base_url: Api.uri("content_classification_labels"),
          params: params,
          headers: Api.headers(token, client_id)
        ]
        |> Keyword.merge(Application.get_env(:teac, :api_req_options, []))
        |> Req.get!()
        |> Api.handle_response()

      error ->
        error
    end
  end

  defp validate_get_opts(opt) do
    data = %{}

    types = %{
      token: :string,
      client_id: :string,
      locale: :string
    }

    changeset =
      {data, types}
      |> cast(opt |> Map.new(), Map.keys(types))
      |> Api.default_client_id()
      |> validate_required([:token, :client_id])
      |> validate_inclusion(:locale, @locales)

    case apply_action(changeset, :insert) do
      {:ok, data} -> {:ok, data}
      {:error, %Ecto.Changeset{errors: errors}} -> {:error, errors}
    end
  end
end
