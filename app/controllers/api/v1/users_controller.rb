class Api::V1::UsersController < Api::V1::BaseController
  before_action :set_user, only: [ :show, :update, :destroy ]
  load_and_authorize_resource

  # GET /api/v1/users
  def index
    @users = paginate(User.accessible_by(current_ability))

    render json: {
      users: @users.map { |user| user_json(user) },
      meta: pagination_meta(@users)
    }
  end

  # GET /api/v1/users/1
  def show
    render json: { user: user_json(@user) }
  end

  # POST /api/v1/users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: { user: user_json(@user) }, status: :created
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/users/1
  def update
    if @user.update(user_params)
      render json: { user: user_json(@user) }
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/users/1
  def destroy
    @user.destroy
    head :no_content
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :admin)
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
