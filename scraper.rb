require 'rubygems'
require 'mechanize'

agent = Mechanize.new { |a| a.follow_meta_refresh = true }
home_page = agent.get('https://www.raintreevacationclub.com/vacation-resorts/united-states/park-city/the-miners-club/')
	signin_form = home_page.form('LoginTopFormPopup')
	# TODO: replace the following with ENV variables
		signin_form.Username = 'VICKICASMERE@COMCAST.NET'
		signin_form.password = 'payton'
	loggedin_page = agent.submit(signin_form)

#now we need to go to the hotel page, input information, and get results
results_page = agent.get('https://www.raintreevacationclub.com/js/bookingAjaxSuites.asp?resortTSWID=1&theLanguage=English&checkinDate=12%2F22%2F2013&checkoutDate=12%2F24%2F2013&numberOfGuests=4&payType=points&currentBalanceLong=262%2C000&MembershipID=50&selectedSuites=%7C2%7C%7C3%7C%7C4%7C')
	# results_page = agent.get('https://www.raintreevacationclub.com/vacation-resorts/united-states/park-city/the-miners-club/')
output_file = File.open("Siteoutput.txt", "w")
output_file.puts results_page.body
output_file.close

