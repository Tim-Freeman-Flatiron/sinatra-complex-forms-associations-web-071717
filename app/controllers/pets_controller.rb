class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    @pet = Pet.create(params[:pet])
    if params[:pet][:owner_id]
      @pet.owner_id = params[:pet][:owner_id]
    else
      params[:owner][:name]
      @pet.owner = Owner.create(params[:owner])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find_by(id: params[:id])
    @owners = Owner.all
    # binding.pry
    erb :'/pets/edit'
  end

  get '/pets/:id' do 
    @pet = Pet.find_by(id: params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do 
    @pet = Pet.find_by(id: params[:id])
    @pet.update(params[:pet])
    
    if params[:owner][:name] != ""
      @owner = Owner.create(params[:owner])
      @pet.owner = @owner
    else
      @owner = Owner.find(params[:owner][:name])
      @pet.owner = @owner
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end