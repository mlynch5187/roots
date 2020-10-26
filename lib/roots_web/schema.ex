defmodule RootsWeb.Schema do
  use Absinthe.Schema

  alias RootsWeb.Data

  import_types(Absinthe.Type.Custom)

  import_types(RootsWeb.Schema.UserTypes)
  # ...other models' types added here

  query do
    import_fields(:user_queries)
    # ... other models' queries added here
  end

  mutation do
    import_fields(:user_mutations)
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

  def middleware(middleware, _field, _object) do
    [NewRelic.Absinthe.Middleware] ++ middleware
  end
end