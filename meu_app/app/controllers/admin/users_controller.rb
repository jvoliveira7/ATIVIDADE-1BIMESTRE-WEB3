class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /admin/users
  def index
    @admin_users = User.all
  end

  # GET /admin/users/1
  def show
  end

  # GET /admin/users/new
  def new
    @admin_user = User.new
  end

  # GET /admin/users/1/edit
  def edit
  end

  # POST /admin/users
  def create
    @admin_user = User.new(user_params)

    if @admin_user.save
      redirect_to admin_users_path, notice: "Usuário criado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admin/users/1
  def update
    # Remove campos de senha se estiverem em branco
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    if @admin_user.update(user_params)
      redirect_to admin_users_path, notice: "Usuário atualizado com sucesso.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/users/1
  def destroy
    @admin_user.destroy
    redirect_to admin_users_path, notice: "Usuário excluído com sucesso.", status: :see_other
  end

  private

  def set_user
    @admin_user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :role_id, :password, :password_confirmation)
  end
end
