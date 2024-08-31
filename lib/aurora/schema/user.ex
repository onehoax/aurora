defmodule Aurora.Schema.User do
  use Ecto.Schema
  import Ecto.Changeset

  # Set to autogenerate: false to let MongoDB handle it
  @primary_key {:_id, :binary_id, autogenerate: false}

  schema "users" do
    field(:username, :string)
    field(:document_id, :string)
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [])
    |> validate_required([])
  end
end
