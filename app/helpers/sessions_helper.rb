module SessionsHelper
  def session_params
    params.require(:session).permit(:title, :description, :kind, :date, :student_list)
  end
end
