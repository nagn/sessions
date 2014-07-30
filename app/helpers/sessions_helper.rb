module SessionsHelper
  def session_params
    params.require(:session).permit(:title, :description, :kind, :date, :selected_student)
  end
end
