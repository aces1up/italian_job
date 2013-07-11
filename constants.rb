

TestsDirectory   = "#{$working_directory}tests/"
ProfileDirectory = "#{$working_directory}profile_data/"


create_dir( TestsDirectory )
create_dir( ProfileDirectory )


# tags currently with options
# :captcha, :rand_file_line

TagList = [
    #credentials
    :username, :email, :password, :domain,

    #captcha Handling
    :captcha, 
    
    #Bio Vars
    :first_name, :last_name, :fullname,
    :day_index, :year_index, :month_index, :age, 
    :bio_summary,
    
    #file handling
    :random_line_from_file
]

DOM_Elements = [ 'form', 'input', 'textarea', 'button', 'div', 'span',
                     #'iframe', 'frame',
                     'label', 'select', 'option',
                     'body', 'tbody',
                     'img', 'a',
                     'h1', 'h2', 'h3', 'h4', 'h5',
                     'br', 'p', 'b', 'fieldset', 'legend',
                     'ul', 'li', 'table', 'tr', 'td',
                     'dl', 'dt', 'dd', 'thead', 'th', 'dt', 'caption',
                     'strong', 'hr'
               ]
