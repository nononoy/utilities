class Admin::UsersController < AdminController

  defaults resource_class: User, collection_name: 'collection', instance_name: 'resource'

  protected
    def collection
      get_collection_ivar || set_collection_ivar(end_of_association_chain.preload(:user_buildings).paginate(page: params[:page]))
    end
end
