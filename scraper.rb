require 'rubygems'
require 'mechanize'

agent = Mechanize.new { |a| a.follow_meta_refresh = true }
home_page = agent.get('https://www.raintreevacationclub.com/vacation-resorts/united-states/park-city/the-miners-club/')
	signin_form = home_page.form('LoginTopFormPopup')
	# TODO: replace the following with ENV variables
		signin_form.Username = ''
		signin_form.password = ''
	loggedin_page = agent.submit(signin_form)

#now we need to go to the hotel page, input information, and get results
hotel_page = agent.get('https://www.raintreevacationclub.com/vacation-resorts/united-states/park-city/the-miners-club/')
booking_form = hotel_page.form('BookingSearchForm')
	booking_form.checkinDate = '12/22/2013' # Will make these variables eventually
	booking_form.checkoutDate = '12/24/2013'
		booking_form.checkbox_with(:name => 'selectedSuites').each do |box|
			box.check
		end
	agent.click(booking_form.link_with(:id => /searchNowButton/))
	results_page = agent.get('https://www.raintreevacationclub.com/vacation-resorts/united-states/park-city/the-miners-club/')
output_file = File.open("Siteoutput.txt", "w")
output_file.puts results_page
output_file.close

