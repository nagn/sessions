module CsvImport
  # method used to convert a csv filepath to an array of objects specified by the file
  def csv_import(filepath)
    # initialize
    imported_objects = []
    string = File.read(filepath)
    require 'csv'

    # import data by row
    CSV.parse(string, headers: true) do |row|
      object_hash = row.to_hash.symbolize_keys

      # make all nil values blank
      object_hash.keys.each do |key|
        if object_hash[key].nil?
          object_hash[key] = ''
        end
      end
      imported_objects << object_hash
    end
    # return array of imported objects
    imported_objects
  end

  # The main import method. Pass in the array of imported objects from csv_import,
  # the overwrite boolean, and the student type. The safe defaults are specified here.
  # It first tries to save or update the student with the data specified in the csv. If that
  # fails, it tries ldap. If both fail, the student is returned as part of the array of failures.
  def import_students(array_of_student_data, overwrite=false)

    @array_of_success = [] # will contain student-objects
    @array_of_fail = [] # will contain student_data hashes and error messages
    @overwrite = overwrite

    array_of_student_data.each do |student_data|
      student_data[:csv_import] = true
      if attempt_save_with_csv_data?(student_data)
        next
      else
        attempt_save_with_ldap(student_data)
        next
      end
    end

    hash_of_statuses = {success: @array_of_success, fail: @array_of_fail}
  end

  # attempts to import with LDAP, returns nil if the login is not found, otherwise it
  # replaces the keys in the data hash with the ldap data.
  def import_with_ldap(student_data_hash)
    # check LDAP for missing data
    ldap_student_hash = Student.search_ldap(student_data_hash[:login])

    # if nothing found via LDAP
    if ldap_student_hash.nil?
      return
    end

    # fill-in missing key-values with LDAP data
    student_data_hash.keys.each do |key|
      if student_data_hash[key].blank? and !ldap_student_hash[key].blank?
        student_data_hash[key] = ldap_student_hash[key]
      end
    end
    student_data_hash
  end


  # tries to save using only the csv data. This method will return
  # false if the data specified in the csv is invalid on the student model.
  def attempt_save_with_csv_data?(student_data)
    student = set_or_create_student_for_import(student_data)

    #student.update_attributes(student_data)
    # if the updated or new student is valid, save to database and add to array of successful imports
    if student.valid?
      student.save
      @array_of_success << student
      return true
    else
      return false
    end
  end

  # attempts to save a student with ldap lookup
  def attempt_save_with_ldap(student_data)
    ldap_hash = import_with_ldap(student_data)
    if ldap_hash
      student_data = ldap_hash
    else
      @array_of_fail << [student_data, 'Incomplete student information. Unable to find student in online directory (LDAP).']
      return
    end

    student = set_or_create_student_for_import(student_data)

    if student.valid?
      student.save
      @array_of_success << student
      return
    else
      @array_of_fail << [student_data, student.errors.full_messages.to_sentence.capitalize + '.']
      return
    end
  end

  # sets the student based on the overwrite parameter
  def set_or_create_student_for_import(student_data)
    # set the student and attempt to save with given data
    if @overwrite and (Student.where("net_id = ?", student_data[:net_id]).size > 0)
      student = Student.where("net_id = ?", student_data[:net_id]).first
      student.update_attributes (
          {
        :name => student_data[:name],
        :role => student_data[:role],
        :first_name => student_data[:first_name],
        :nick_name => student_data[:nick_name],
        :last_name => student_data[:last_name],
        :goes_by => student_data[:goes_by],
        :official_full_name => student_data[:official_full_name],
        :net_id => student_data[:net_id],
        :cell => student_data[:cell],
        :yale_email => student_data[:yale_email],
        :yale_email_alias => student_data[:yale_email_alias],
        :non_yale_email => student_data[:non_yale_email],
        :queue => student_data[:queue],
        :old_queue => student_data[:old_queue],
        :college => student_data[:college],
        :class_year => student_data[:class_year],
        :birthday => student_data[:birthday],
        :other => student_data[:other]
      }
      )
    else
      student = Student.new(
      {
        :name => student_data[:name],
        :role => student_data[:role],
        :first_name => student_data[:first_name],
        :nick_name => student_data[:nick_name],
        :last_name => student_data[:last_name],
        :goes_by => student_data[:goes_by],
        :official_full_name => student_data[:official_full_name],
        :net_id => student_data[:net_id],
        :cell => student_data[:cell],
        :yale_email => student_data[:yale_email],
        :yale_email_alias => student_data[:yale_email_alias],
        :non_yale_email => student_data[:non_yale_email],
        :queue => student_data[:queue],
        :old_queue => student_data[:old_queue],
        :college => student_data[:college],
        :class_year => student_data[:class_year],
        :birthday => student_data[:birthday],
        :other => student_data[:other]
      })
    end
    return student
  end
end