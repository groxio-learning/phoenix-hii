defmodule BirdleWeb.Guess do
  @types %{word: :string}

  import Ecto.Changeset

  alias Words.Game.Dictionary

  defstruct [:word]

  def changeset(word) do
    {__struct__(), @types}
    |> cast(%{word: word}, [:word])
    |> validate_required([:word])
    |> validate_length(:word, min: 5, max: 5)
    |> validate_guess(:word)
  end

  defp validate_guess(changeset, field) do
    word = get_change(changeset, field)

    if Dictionary.valid?(word) do
      changeset
    else
      add_error(changeset, field, "#{word} is not in the dictionary")
    end
  end
end
