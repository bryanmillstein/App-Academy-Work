class ContactSharesController < ApplicationController

  def create
     c = ContactShare.new(params.require(:contact_share).permit(:contact_id, :user_id))

     if c.save
       render json: c
     else
       render json: c.errors.full_messages, status: :unprocessable_entity
     end

  end

  def destroy
    c = ContactShare.find(params[:id])

    if c.destroy
      render json: c
    else
      render json: c.errors.full_messages, status: :unprocessable_entity
    end

  end


end
