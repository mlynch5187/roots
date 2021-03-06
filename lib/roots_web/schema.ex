defmodule RootsWeb.Schema do
  use Absinthe.Schema

  alias RootsWeb.Data

  import_types(Absinthe.Type.Custom)

  import_types(RootsWeb.Schema.UserTypes)
  import_types(RootsWeb.Schema.CookbookTypes)
  import_types(RootsWeb.Schema.RecipeTypes)
  import_types(RootsWeb.Schema.IngredientTypes)
  # ...other models' types added here

  query do
    import_fields(:cookbook_queries)
    import_fields(:user_queries)
    import_fields(:recipe_queries)
    # ... other models' queries added here
  end

  mutation do
    import_fields(:user_mutations)

    import_fields(:recipe_mutations)
    import_fields(:ingredient_mutations)
    import_fields(:cookbook_mutations)

    # ... other models' mutations added here
  end

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Data, Data.data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
