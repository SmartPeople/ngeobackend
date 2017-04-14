defmodule NGEOBackend.ExAdmin.Event do
  use ExAdmin.Register
  
  register_resource NGEOBackend.Event do

    index do
      selectable_column()
      column :id
      column :data, type: :text
      actions()
    end

    form event do
      inputs do
        input event, :id
        input event, :user, collection: NGEOBackend.User.all
      end

    end

  end
end
