class FeedController < ApplicationController
  def index
    page = params[:p].to_i

    @feed = Feed.order(published_at: :desc)
                .page(page)
                .per(25)
  end
end
