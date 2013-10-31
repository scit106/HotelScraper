require 'rubygems'
require 'mechanize'

agent = Mechanize.new { |a| a.follow_meta_refresh = true }
home_page = agent.get('https://www.raintreevacationclub.com/vacation-resorts/united-states/park-city/the-miners-club/')
signin_form = home_page.form('LoginTopForm')
signin_form.Username = 'REPLACE THIS'
signin_form.password = 'REPLACE THIS'
loggedin_page = agent.submit('LoginTopForm')
pp home_page