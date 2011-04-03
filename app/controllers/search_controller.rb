class SearchController < ApplicationController
  def new_search
     if !params[:search].nil?
       @query = params[:search]
           if @options.nil?
           options = {
                    :per_page => params[:per_page], :star => true,

            }
           else
           options=@options
           end
       @model = params[:model_type].constantize.search(@query, options) unless params[:model_type].nil?
     end

  end

  def search_result
  end
  def search_options
    @options={
                #:page => params[:page], :per_page => params[:per_page], :star => true,
                 #:field_weights => { :title => 20, :tags => 10, :body => 5 }
                :page => params[:page], :per_page => params[:per_page], :star => true,
                 #:field_weights => session[:search_model].field_weight
    }

  end
  
end
