class TagsController < ApplicationController
  def index
    user = User.find_by(id: current_user.id)
    @tag_list = user.tags.all
  end

  def dones
    @tag_list = Tag.all
  end
end
