class ImportStudentsController < ApplicationController
  include CsvImport
  def import
   # initialize
   file = params[:csv_upload] # the file object
   if file
     overwrite = (params[:overwrite] == '1') # update existing users?
     filepath = file.tempfile.path # the rails CSV class needs a filepath

     imported_students = csv_import(filepath)
   end

   # check if input file is valid and return appropriate error message if not
   if valid_input_file?(imported_students, file)
     # create the users and exit
     @hash_of_statuses = import_students(imported_students, overwrite)
     render 'imported'
   end
 end
  
  # functions like the RESTful new action by rendering a form with a GET request
  def import_page
    # limits the options for user.role to the following array, and displays them with more user-friendly labels.
    render 'import' # a form for uploading a csv file of users to import
  end


  private
    # this method checks that the user has uploaded a file and displays flash messages if there is an error.
    # putting these validations in the controller is not idiomatic in rails and there is likely a cleaner way to
    # do this. If we ever have to validate more input than this, we should remove this to a csv_import validations model.
    def valid_input_file?(imported_students, file)
      # check if the user has uploaded a file at all.
      if !file
        flash[:error] = 'Please select a file to upload.'
        redirect_to :back and return
      end



      # make sure the import went with proper headings / column handling
      
      accepted_keys = [:name, :role, :first_name, :nick_name, :goes_by, :last_name, :official_full_name, :net_id, :cell, :yale_email, :yale_email_alias, :non_yale_email, :queue, :old_queue, :college, :class_year, :t_shirt_size, :birthday, :dietary_needs]
      unless imported_students.first.keys == accepted_keys
        flash[:error] = 'Unable to import CSV file. Please ensure that the first line of the file exactly matches the sample input (login, first_name, etc.) Note that headers are case sensitive and must be in the correct order.'
        redirect_to :back and return
      end
      return true
    end
end
