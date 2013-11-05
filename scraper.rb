require 'rubygems'
require 'mechanize'
require 'action_mailer'

#Configure Emails
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
   :address   => "smtp.gmail.com",
   :port      => 587,
   :domain    => "gmail.com",
   :authentication => :plain,
   :user_name      => "", #replace this with an ENV variable or some such
   :password       => "", #replace this with an ENV variable or some such
   :enable_starttls_auto => true
  }
ActionMailer::Base.view_paths= File.dirname(__FILE__)

class Mailer < ActionMailer::Base

  def success_email
    @var = "var"

    mail(   :to      => "vickicasmere@comcast.net, vickicasmere@gmail.com, scit106@gmail.com",
            :from    => "bathrobeman@gmail.com",
            :subject => "Miners Club - Book Now!") do |format|
                format.html
    end
  end

    def error_email
    @var = "var"

    mail(   :to      => "scit106@gmail.com, scit106@yahoo.com",
            :from    => "bathrobeman@gmail.com",
            :subject => "Raintree Scraper Error") do |format|
                format.html
    end
  end

end
######################################
###### Now check availability ########
######################################

agent = Mechanize.new { |a| a.follow_meta_refresh = true }
home_page = agent.get('https://www.raintreevacationclub.com/vacation-resorts/united-states/park-city/the-miners-club/')
	signin_form = home_page.form('LoginTopFormPopup')
	# TODO: replace the following with ENV variables
		signin_form.Username = ''
		signin_form.password = ''
	loggedin_page = agent.submit(signin_form)

#this is a giant get request which grabs our specific results for 12/22 - 12/24
results_page = agent.get('https://www.raintreevacationclub.com/js/bookingAjaxSuites.asp?resortTSWID=1&theLanguage=English&checkinDate=12%2F22%2F2013&checkoutDate=12%2F24%2F2013&numberOfGuests=4&payType=points&currentBalanceLong=262%2C000&MembershipID=50&selectedSuites=%7C2%7C%7C3%7C%7C4%7C')
@results = results_page.body
#output to file for troubleshooting
# output_file = File.open("Siteoutput.txt", "w")
# output_file.puts results
# output_file.close

if @results == "<table width='100%' cellspacing='0' cellpadding='0' border='0'>"
	# puts "Error. Either Login Failed, Site is Down, or Site Moved"
	email = Mailer.error_email
	puts email
	email.deliver
elsif not @results.include? "No Units Available"
	# puts "Success! Rooms might be available"
	email = Mailer.success_email
	puts email
	email.deliver
# else puts "No Units Available"
end