#tester starts at 
# https://beta.mindbodygreen.com/


test(id: 75147, title: "Account Management - Logged in user (desktop)") do
  # You can use any of the following variables in your code:
  # - []
  Capybara.register_driver :sauce do |app|
    @desired_cap = {
      'platform': "Windows 7",
      'browserName': "firefox",
      'version': "45",
      'screenResolution': "1920x1080",
      'name': "mbg_acct_mgmt_logged_in_usr",
    }
    Capybara::Selenium::Driver.new(app,
      :browser => :remote,
      :url => 'http://@ondemand.saucelabs.com:80/wd/hub',
      :desired_capabilities => @desired_cap
    )
  end
  # chrome testing
  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, :browser => :chrome)
  end

  # random number used for user information
  rand_num=Random.rand(89999999) + 10000000

  email = 'automation' + rand_num.to_s + "@nowhere.com"
  first_name = 'Automation' + rand_num.to_s
  password = 'Pass' + rand_num.to_s
  
  #Requires executing post to facebook's graph_api to get FB user email and password. 
    #Access token has been removed for posting to github. Email me to get it
  #   https://graph.facebook.com/500648116717448/accounts?method=post&access_token=
  curl_resp = `curl "https://graph.facebook.com/500648116717448/accounts?method=post&access_token="`
  require 'json'
  my_hash = JSON.parse(curl_resp)
  fb_password = my_hash['password']
  fb_email = my_hash['email']

  
  visit "https://beta.mindbodygreen.com/"
  #window = Capybara.current_session.driver.browser.manage.window
  #window.maximize

  step id: 1,
      action: "Close any popups that appear automatically in this test (not as a result of you clicking on something.) Click"\
              " the log in button in the upper right of the nav bar.",
      response: "Does the log in window open up?" do

    # *** START EDITING HERE ***
    expect(page).to have_content("mindbodygreen")
    
    # wait until popup shows
    for i in 1..6 do
      if page.has_selector?(:css, 'div.listbuilder-popup-scale', wait: 10)
        page.find(:css, "div[class*='sumome-react-wysiwyg-close-button'").click
        break
      end
    end
    
    # action    
    within(:css, '.nav__main-nav-icons', wait: 30) do
      page.find(:css, 'a', :text => 'Log In').click
    end

    # response
    within(:css, '#gigya-login-screen') do
      expect(page).to have_content('Don\'t have an account yet?')
    end

    # *** STOP EDITING HERE ***
  end

  step id: 2,
      action: "Look at the bottom of the popup for text that says 'Don't have an account yet?'' and click the link to the right of it",
      response: "Does the window change to show the registration fields?" do
    # *** START EDITING HERE ***

    # action
    within(:css, '#gigya-login-screen') do
      page.find(:css, 'a', :text => 'Sign up').click
    end
    
    # response
    within(:css, '#gigya-register-screen') do
      expect(page).to have_content('Already have an account?')
    end

    # *** STOP EDITING HERE ***
  end

  step id: 3,
      action: "Enter {{random.email}} as the email address, {{random.first_name}} as the Name, {{random.password}} in both password"\
              " fields, and select the checkbox agreeing to the terms of use. Click the submit button",
      response: "Does the registration window close?" do
   
    # *** START EDITING HERE ***

    # action
    within(:css, '#gigya-register-screen') do
      fill_in 'email', :match => :first, with: email
      fill_in 'profile.name', with: first_name
      fill_in 'password', with: password
      sleep(1)
      fill_in 'passwordRetype', with: password 
      check 'data.terms'
      page.find(:css, "input[value='Create Account']").click
    end

    # response
    expect(page.has_no_selector?(:css, '#gigya-register-screen')).to eql(true)
	
    # *** STOP EDITING HERE ***
  end

  step id: 4,
      action: "(Wait up to 10 seconds for the log in link on the right of the nav bar to change) Hover over the upper right of the nav"\
              " where the log in link was.",
      response: "Has it been replaced with a drop down menu?" do
    
    # *** START EDITING HERE ***

    # action
    if page.has_selector?(:css, 'div.listbuilder-popup-scale', wait: 10)
      page.find(:css, "div[class*='sumome-react-wysiwyg-close-button'").click
    end
    page.find(:css, '.user-container', :text => 'My Account').hover

    # response
    expect(page).to have_selector(:css, '.nav__main-nav-icon-account-user-dropdown', :visible => true)

    # *** STOP EDITING HERE ***
  end

  step id: 5,
      action: "Inside the dropdown menu in the upper right of the nav, click My Account",
      response: "Does it take you to the My Account page?" do
   
    # *** START EDITING HERE ***

    # action
    within(:css, '.nav__main-nav-icon-account-user-dropdown', :visible => true) do
      page.find(:css, 'a', :text => 'My Account').click
    end
    # Currently the above step causes a redirect to the staging env. The following block is a workaround
    # ******************Begin Workaround******************
    # wait until popup shows
    for i in 1..5 do
      if page.has_selector?(:css, 'div.listbuilder-popup-scale', wait: 10)
        page.find(:css, "div[class*='sumome-react-wysiwyg-close-button'").click
        break
      end
    end
    # login with newly created acct
    within(:css, '#gigya-login-screen') do
      fill_in 'username', :match => :first, with: email
      fill_in 'password', with: password
      page.find(:css, "input[value='Log In']").click
    end
    # repeat previous test step
    page.find(:css, '.user-container', :text => 'My Account').hover
    within(:css, '.nav__main-nav-icon-account-user-dropdown', :visible => true) do
      page.find(:css, 'a', :text => 'My Account').click
    end
    # *******************End Workaround********************

    # response
    expect(page).to have_selector(:css, 'h1', :text => 'My Account')

    # *** STOP EDITING HERE ***
  end

  step id: 6,
    action: "Click the edit button in the Profile",
    response: "Does an Edit Profile popup open?" do
      
    # *** START EDITING HERE ***
    
    # action
    page.find(:css, '#profile_update').click

    # response   
    within(:css, '#gigya-update-profile-screen') do
      expect(page).to have_content('Edit Profile')
    end

    # *** STOP EDITING HERE ***

  end
  
  
 step id: 7,
      action: "In the first input of the popup box where it shows the user's name, erase the current name and change the name"\
              " to 'TestFirst TestLast'. click the 'Save' button. (wait 10 seconds after clicking the save button)",
      response: "Does the page reload and the NAME in the in the profile box now shows the updated name?" do

    # *** START EDITING HERE ***
    new_name = 'TestFirst TestLast'

    # action
    within(:css, '#gigya-update-profile-screen') do
      page.find(:css, "input[name='profile.name']").set(new_name)
      page.find(:css, "input[value='Save']").click
    end

    # response
    expect(page.has_no_selector?(:css, '#gigya-update-profile-screen')).to eql(true)
    expect(page).to have_content(new_name, wait: 30)
    # *** STOP EDITING HERE ***

  end

  step id: 8,
      action: "Click the first round icon (Facebook icon) under the SOCIAL CONNECTIONS in the Profile box.",
      response: "Does a new window open that says 'Log in to use your Facebook account with MindBodyGreen'?" do
    # *** START EDITING HERE ***
    
    # action
    scroll_offset = 2000 
    page.execute_script("window.scrollTo(0,#{scroll_offset})")

    within(:css, '.profile-contents') do
      page.find(:css, "img[class='facebook-icon social-icon-gray']").click
    end

    # response
      # wait for facebook popup window
    for i in 1..5 do
      if page.driver.browser.window_handles.last != page.driver.browser.window_handles.first
        break
      end
      sleep(1)
    end
    expect(page.driver.browser.window_handles.size).to eql(2)   
    popup = page.driver.browser.window_handles.last
    page.driver.browser.switch_to.window(popup)
    expect(page).to have_content('Log in to use your Facebook', wait: 15)
    # *** STOP EDITING HERE ***

  end
  
  step id: 9,
      action: "Type {{social_account.facebook_login}} and type the password {{social_account.facebook_password}}"\
              " and please be sure to check that the email address matches and click the 'Log In' button.",
      response: "Does the Facebook window show a different screen with a blue button that says Continue as ... "\
                "(name in the blue button is random)?" do

    # *** START EDITING HERE ***

    # action
    fill_in 'email', with: fb_email
    fill_in 'pass', with: fb_password
    page.find(:css, "input[name='login']").click

    # response
    expect(page).to have_content('Review the info you provide')
    expect(page).to have_selector(:css, "button[name='__CONFIRM__']")

    # *** STOP EDITING HERE ***

  end

  
  step id: 10,
      action: "Click the blue Continue as ... button and wait for the window to close. (wait up to 10 seconds).",
      response: "Is the first icon in SOCIAL CONNECTIONS now blue?" do

    # *** START EDITING HERE ***

    # action
    page.find(:css, "button[name='__CONFIRM__']").click

    # response

    main = page.driver.browser.window_handles.first
    page.driver.browser.switch_to.window(main)
    expect(page).to have_selector(:css, "img[class='facebook-icon']")
    expect(page).to have_no_selector(:css, "button[name='__CONFIRM__']")
    expect(page.driver.browser.window_handles.size).to eql(1)    
    

    # *** STOP EDITING HERE ***

  end

  step id: 11,
      action: "Under Settings, click Change Password.",
      response: "Does a Change Password popup open? " do
   
    # *** START EDITING HERE ***

    # action
    page.execute_script('window.scrollTo(0,-100000)')
    page.find(:css, '#password_update').click

    # response
    expect(page).to have_selector(:css, '#gigya-change-password-screen')

    # *** STOP EDITING HERE ***

  end
  
  step id: 12,
	   action: "In the Change Password popup, type {{random.password}} in the Current Password input, type 'Password321'"\
              " in the New Password input, and type 'Password321' again in the Confirm Password input. Click the 'Save' button.",
     response: "Does the window close after a little while?" do

    # *** START EDITING HERE ***
    new_password = 'Password321'

    # action
    fill_in 'password', with: password
    fill_in 'newPassword', with: new_password
    fill_in 'passwordRetype', with: new_password
    click_button 'Save'

    # response
    expect(page).to have_no_selector(:css, '#gigya-change-password-screen')

    # *** STOP EDITING HERE ***
  end

  step id: 13,
     action: "Under Settings, click Manage Email Communication",
     response: "Does a Manage Email Notifications popup open?" do

    # *** START EDITING HERE ***

    # action
    page.find(:css, '#open-email-settings-modal').click

    # response
    expect(page).to have_content('Manage Email Notifications', wait: 20)

    # *** STOP EDITING HERE ***
  end

    step id: 14,
     action: "In the popup, under Newsletters, select the option that says 'I prefer weekly newsletters.' and click the"\
             " 'Save' button at the bottom. (wait up to 10 seconds after clicking save)",
     response: "Does the Manage Email Notifications popup close?" do

    # *** START EDITING HERE ***
    
    # action
    page.find(:css, "input[value='weekly']").click
    click_button 'Save'

    # response
    expect(page).to have_no_content('Manage Email Notifications', wait: 30)

    # *** STOP EDITING HERE ***
  
  end
    step id: 15,
     action: "Refresh the page and click the Manage Email Communication again.",
     response: "Is the 'I prefer weekly newsletters.' option still selected?" do

    # *** START EDITING HERE ***
    

    # action
    visit 'https://beta.mindbodygreen.com/user/home'
    page.find(:css, '#open-email-settings-modal').click

    # response
    
    expect(page).to have_selector(:css, "input[checked=''][value='weekly']", wait: 30)

    # *** STOP EDITING HERE ***
  end
  #sleep(10)
end
