defmodule NGEOBackend.ExAdmin.Event do
  use ExAdmin.Register
  
  register_resource NGEOBackend.Event do

    index do
      selectable_column()
      column :id
      column :uuid
      actions()
    end

    form event do
      inputs do
        input event, :uuid
        input event, :user, collection: NGEOBackend.User.all
      end

    end

  end
end
