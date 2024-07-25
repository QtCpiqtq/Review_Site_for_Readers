class Public::GoodsController < ApplicationController
  before_action :authenticate_user!
end
