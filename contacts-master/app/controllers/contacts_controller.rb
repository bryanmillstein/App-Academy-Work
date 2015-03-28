class ContactsController < ApplicationController

  def index
    owned_contacts = Contact.where(user_id: params[:user_id])
    shared_contacts = User.find(params[:user_id]).shared_contacts
    render json: owned_contacts.concat(shared_contacts)

  end

  def show
    render json: Contact.find(params[:id])
  end

  def create
    c = Contact.new(contact_params)

    if c.save
      render json: c
    else
      render json: c.errors.full_messages, status: :unprocessable_entity
    end

  end

  def update
    c = Contact.find(params[:id])

    if c.update(contact_params)
      render json: c
    else
      render json: c.errors.full_messages, status: :unprocessable_entity
    end

  end

  def destroy
    c = Contact.find(params[:id])

    if c.destroy
      render json: c
    else
      render json: c.errors.full_messages, status: :unprocessable_entity
    end

  end


  private

  def contact_params
    params.require(:contact).permit(:name, :email, :user_id)
  end

end
