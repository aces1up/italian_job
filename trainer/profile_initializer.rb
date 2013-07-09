

module ProfileInitializer

    def profile_selected()
        DashboardUiController.instance.profile_selected
    end

    def has_profile?()
        return false if !@test_thread
        !@test_thread.container_empty?( :acct )
    end

    def generate_profile()
        ProfileData.new.get_profile
    end

    def init_profile()

        # if we have profile selected,
        # it loads in that profile and saves it to
        # :acct else we generate a profile and save it to acct

        profile_data = profile_selected ? load_profile_from_disk( "#{ProfileDirectory}#{profile_selected}" ) : generate_profile
        add( profile_data, :acct, true, true )

    end

end
