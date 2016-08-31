1. Add gem in gemfile.
gem 'ringcaptcha', '~> 0.0.2' and run bundle install.

2. Create new scaffold say home, where index page is root page of application.

3. In app/views/homes/index.html.erb file add javascript files of ringcaptcha widget.

4. In application, On click of button "Check RC", call ajax method /homes_controller.rb/valid_rc

5. In valid_rc mathod, initialize ringcaptach gem by using RingCaptcha::RingCaptcha.new(app_key, secret_key).

6. After initializing gem call is_valid method of ringcaptch with pincode and token key.

7. In valid_rc.js.erb file if pin code is valid then show error else show Rc details.
