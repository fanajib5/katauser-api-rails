class Api::V1::ProfileController < Api::V1::BaseController
  before_action :authenticate_user!
  
  # GET /api/v1/profile
  def show
    render json: { user: user_json(current_user) }
  end
  
  # PATCH/PUT /api/v1/profile
  def update
    if current_user.update(profile_params)
      render json: { user: user_json(current_user) }
    else
      render json: { errors: current_user.errors }, status: :unprocessable_entity
    end
  end
  
  # DELETE /api/v1/profile
  def destroy
    current_user.destroy
    head :no_content
  end
  
  private
  
  def profile_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end
  
  def user_json(user)
    {
      id: user.id,
      email: user.email,
      first_name: user.first_name,
      last_name: user.last_name,
      admin: user.admin?,
      created_at: user.created_at,
      updated_at: user.updated_at
    }
  end
end
