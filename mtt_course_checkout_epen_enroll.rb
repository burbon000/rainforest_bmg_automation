#tester starts at 
# "http://beta.mindbodygreen.com/trainings/meditation-teacher-training"


test(id: 89962, title: "MTT Course Checkout Test for Installation Payment when Enrollment Open") do
  # You can use any of the following variables in your code:
  # - []
  Capybara.register_driver :sauce do |app|
    @desired_cap = {
      'platform': "Windows 7",
      'browserName': "firefox",
      'version': "45",
      'name': "mbg_mtt_course_chkout_open_enrl",
    }
    Capybara::Selenium::Driver.new(app,
      :browser => :remote,
      :url => 'http://RFAutomation:5328f84f-5623-41ba-a81e-b5daff615024@ondemand.saucelabs.com:80/wd/hub',
      :desired_capabilities => @desired_cap
    )
  end
  rand_num=Random.rand(899999999) + 100000000
  visit "http://beta.mindbodygreen.com/trainings/meditation-teacher-training"

  window = Capybara.current_session.driver.browser.manage.window
  window.maximize

  step id: 1,
      action: "Close out any popups. Scroll down and click on the See Pricing Plans button under the large image screenshot.png. Wait 5 seconds.",
      response: "Does it scroll down to the Enroll Now To Reserve Your Spot section?" do
    # *** START EDITING HERE ***
    expect(page).to have_content("Meditation")

    # action
      #close popups
    for i in 1..5 do
      if page.has_selector?(:css, 'div.listbuilder-popup-scale')
        page.find(:css, "div[class*='sumome-react-wysiwyg-close-button'", wait: 10).click
        break
      end
    end
    # The following JS checks if the .price-container div which holds the course pricing info is in view as a result of clicking the Enroll button
    expect(page.evaluate_script("function() {var elm  = document.querySelector('.price-container');var vph = $(window).height(),st = $(window).scrollTop(),y = $(elm).offset().top;return (y < (vph + st));}();").inspect).to eql("false")
    within(:css, '#training-sub-nav') do
      page.find(:css, 'a', :text => 'Enroll').click
    end

    # response
    sleep(1)
    # The following JS checks if the .price-container div which holds the course pricing info is in view as a result of clicking the Enroll button
    expect(page.evaluate_script("function() {var elm  = document.querySelector('.price-container');var vph = $(window).height(),st = $(window).scrollTop(),y = $(elm).offset().top;return (y < (vph + st));}();").inspect).to eql("true")

    page.save_screenshot('screenshot_step_1.png')
    # *** STOP EDITING HERE ***
  end

  step id: 2,
      action: "Click on the Enroll Now button under the Installation Payment section. Wait 5 seconds.",
      response: "Does it take you to another page showing you the checkout page with the Shopping Cart with two classes in it?" do
    # *** START EDITING HERE ***

    # action
    within(:css, '#payment-section') do
      page.find(:css, 'a', :text => 'Enroll').click
    end
    # Workaround to handle improper redirect to staging env
    # ***********Begin Workaround************
    sleep(2)
    visit 'https://beta.mindbodygreen.com/classes/checkout'
    # ***********End Workaround**************

    # response
    expect(page).to have_content('Your Shopping Cart ( 2 )', wait: 30)
    expect(page).to have_content('TRAININGS')

    page.save_screenshot('screenshot_step_2.png')
    # *** STOP EDITING HERE ***
  end

  step id: 3,
      action: "Scroll down to the Payment Information section and enter your email address {{random.email}} at the top of the page."\
              " Then click on the Name on Card field",
      response: "Were you able to click on the Name on Card field without any warning popups?" do
   
    # *** START EDITING HERE ***
    email = "automation#{rand_num}@nowhere.com"

    # action
    
    fill_in 'emailCheckout', with: email
    page.execute_script('window.scrollTo(0,-1000)')
    #page.find(:css, '#billingName').click

    # response
      # wait to make sure there is no pop-up
    #for i in 1..5 do
    #  if page.has_selector?(:css, 'div.listbuilder-popup-scale')
    #    page.find(:css, "div[class*='sumome-react-wysiwyg-close-button'", wait: 10).click
    #    break
    #  end
    #end
    if page.has_selector?(:css, 'div.listbuilder-popup-scale')
      page.find(:css, "div[class*='sumome-react-wysiwyg-close-button'").click
    end

    page.execute_script('window.scrollTo(0,-10000)')
    page.save_screenshot('screenshot_step_3.png')
    # *** STOP EDITING HERE ***
  end

  step id: 4,
      action: "Enter {{random.full_name}} in the Name on Card field, 5111111111111111 in the Credit Card field, {{random.address_zip}}"\
              " in the Postal Code field, {{random.number}}{{random.number}}{{random.number}} in the CVC field, select a random country"\
              " from the Billing Country, and a future month and year from the Billing Month and Billing Year fields. Check the box to"\
              " agree to the terms of sale. Click the Purchase button",
      response: "Does the page refresh with an error regarding your credit card?" do
    
    # *** START EDITING HERE ***
    rand_name = ('a'..'z').to_a.shuffle[0,8].join
    name = "Automation Name#{rand_name}"
    cc_num = '5111111111111111'
    postal = (Random.rand(89999)+10000).to_s + '-098'
    cvc = Random.rand(899) + 100

    # action
    within(:css, '#credit-card') do
      fill_in 'billingName', with: name
      fill_in 'creditCardNumber', with: cc_num
      fill_in 'postalCode', with: postal
      fill_in 'cvc', with: cvc.to_s
      page.select 'United States', :from => 'country'
      page.select '12', :from => 'month'
      page.select '2022', :from => 'year'
      page.check 'agreePrivacy'
      page.click_button 'Complete My Order'
    end


    # response
    expect(page).to have_content('We were unable to complete this transaction due to an error processing your credit card. The error returned was'\
        ' "There was an error with your user information - Credit card number is invalid." Please make any necessary corrections and try again.'\
        ' If this error persists, please contact us at support@mindbodygreen.com.')

    page.save_screenshot('screenshot_step_4.png')
    # *** STOP EDITING HERE ***
  end

  step id: 5,
      action: "Change the credit card number to 4111111111111111 (four followed by fifteen ones), re-check the box to agree to"\
              " the terms of sale, and click Purchase.",
      response: "Do you see 'Sign in' option ?" do
   
    # *** START EDITING HERE ***
    if page.has_selector?(:css, 'div.listbuilder-popup-scale')
      page.find(:css, "div[class*='sumome-react-wysiwyg-close-button'").click
    end

    cc_num = '4111111111111111'

    # action
    within(:css, '#credit-card') do
      fill_in 'creditCardNumber', with: cc_num
      page.check 'agreePrivacy'
      page.click_button 'Complete My Order'
    end

    # response
    expect(page).to have_content('Purchase Confirmation')

    page.save_screenshot('screenshot_step_5.png')
    # *** STOP EDITING HERE ***
  end

  sleep(10)
end
