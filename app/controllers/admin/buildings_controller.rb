class Admin::BuildingsController < AdminController

  defaults resource_class: Building, collection_name: 'collection', instance_name: 'resource'

  def update
    update! do |format|
      format.js { render js: "showFlashMessage('Информация сохранена.')" }
    end
  end


  protected
    def collection
      get_collection_ivar || set_collection_ivar(end_of_association_chain.order(full_building_square: :asc).paginate(page: params[:page]))
    end

    def permitted_params
      params.permit(:id, building: [:num_of_facilities, :full_building_square])
    end
end
