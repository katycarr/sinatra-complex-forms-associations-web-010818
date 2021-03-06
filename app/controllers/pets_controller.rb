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

    if !params["owner"]["name"].empty?
      @owner = Owner.create(name:params["owner"]["name"])
      @owner.pets << @pet
      @owner.save
    elsif !params["owner"]["id"].empty?
      @owner = Owner.find(params["owner"]["id"])
      @owner.pets << @pet
      @owner.save
    end

    @pet.save

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all

    erb :"/pets/edit"

  end



  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])
    if !params["owner"]["id"].empty?
      @owner = Owner.find(params["owner"]["id"])
      @owner.pets << @pet
      @owner.save
    end
    if !params["owner"]["name"].empty?
      @owner = Owner.create(name:params["owner"]["name"])
      @owner.pets << @pet
      @owner.save
    end

    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
