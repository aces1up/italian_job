

TestsDirectory = "#{$working_directory}tests/"

create_dir( TestsDirectory )

# tags currently with options
# :captcha, :rand_file_line

TagList = [
    #captcha Handling
    :captcha, 
    #credentials
    :username, :email, :domain,
    #Bio Vars
    :first_name, :last_name, :fullname,
    :day_index, :year_index, :month_index, :age, 
    :bio_summary,     
    #file handling
    :rand_file_line
]
