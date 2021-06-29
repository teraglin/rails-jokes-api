class JokesController < ApplicationController
    before_action :set_joke, only: [:show]
    def index
        @jokes = Joke.all
        render json: @jokes
    end

    def create
        @joke = Joke.create(joke_params)
        if @joke.errors.any? 
            render json: @joke.errors, status: :unprocessable_entity
        else
            render json: @joke, status: 201
        end
    end

    def show
        render json: @joke
    end

    private
    def joke_params
        params.require(:joke).permit(:category_id, :body)
    end

    def set_joke
        begin
            @joke = Joke.find(params[:id]) 
        rescue
            render json: {error: "joke not found"}, status: 404
        end
    end
end
