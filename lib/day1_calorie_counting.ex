defmodule Day1CalorieCounting do
  @moduledoc """
  Documentation for `Day1CalorieCounting`.
  Santa's reindeer typically eat regular reindeer food, but they need a lot of magical energy to deliver presents on Christmas. For that, their favorite snack is a special type of star fruit that only grows deep in the jungle. The Elves have brought you on their annual expedition to the grove where the fruit grows.

  To supply enough magical energy, the expedition needs to retrieve a minimum of fifty stars by December 25th. Although the Elves assure you that the grove has plenty of fruit, you decide to grab any fruit you see along the way, just in case.

  Collect stars by solving puzzles. Two puzzles will be made available on each day in the Advent calendar; the second puzzle is unlocked when you complete the first. Each puzzle grants one star. Good luck!

  """

  @stars_goal 50
  @calories_per_elf_filename "calories_per_elf_list.txt"

  @doc """
  The jungle must be too overgrown and difficult to navigate in vehicles or access from the air; the Elves' expedition traditionally goes on foot. As your boats approach land, the Elves begin taking inventory of their supplies. One important consideration is food - in particular, the number of Calories each Elf is carrying (your puzzle input).

  The Elves take turns writing down the number of Calories contained by the various meals, snacks, rations, etc. that they've brought with them, one item per line. Each Elf separates their own inventory from the previous Elf's inventory (if any) by a blank line.

  For example, suppose the Elves finish writing their items' Calories and end up with the following list:

  1000
  2000
  3000

  4000

  5000
  6000

  7000
  8000
  9000

  10000

  This list represents the Calories of the food carried by five Elves:

    The first Elf is carrying food with 1000, 2000, and 3000 Calories, a total of 6000 Calories.
    The second Elf is carrying one food item with 4000 Calories.
    The third Elf is carrying food with 5000 and 6000 Calories, a total of 11000 Calories.
    The fourth Elf is carrying food with 7000, 8000, and 9000 Calories, a total of 24000 Calories.
    The fifth Elf is carrying one food item with 10000 Calories.

  In case the Elves get hungry and need extra snacks, they need to know which Elf to ask: they'd like to know how many Calories are being carried by the Elf carrying the most Calories. In the example above, this is 24000 (carried by the fourth Elf).

  Find the Elf carrying the most Calories. How many total Calories is that Elf carrying?

  Your puzzle answer was 71124.

  ## Examples

      iex> Day1CalorieCounting.hello()
      :world

  """
  def day1_find_elf_with_most_calories do
    :world

    {:ok, content} = File.read(@calories_per_elf_filename)

    elf_calories_map = content
      |> String.trim()
      |> String.split("\n\n")
      |> Enum.with_index()
      |> Enum.map(fn {calories_list_per_elf_as_string, index} ->
        calories_list = calories_list_per_elf_as_string
          |> String.split("\n")
          |> Enum.map(fn calorie_as_string -> calorie_as_string |> Integer.parse() |> elem(0) end)
        %{index => calories_list}
      end)
      |> Enum.reduce(fn map1, map2 -> Map.merge(map1, map2) end)

    elf_with_most_total_calories = elf_calories_map
      |> Enum.to_list
      |> Enum.map(fn {elf_index, elf_calorie_list} -> {elf_index, Enum.sum(elf_calorie_list)} end)
      |> Enum.reduce(fn {elf_index1, elf_calories1}, {elf_index2, elf_calories2} ->
        if elf_calories1 > elf_calories2,
        do: {elf_index1, elf_calories1},
        else: {elf_index2, elf_calories2}
      end)

  end

  def get_calories_per_elf_filename(), do: @calories_per_elf_filename


end