#tester starts at 
# https://lemonsarebetter.herokuapp.com/widget.php?network=rainforestqa.fyre.co&site=383920&articleId=ekrfjherf34823&appType=reviews&userId=user1_9080908090


test(id: 191991, title: "Review Flag") do
  # You can use any of the following variables in your code:
  # - []
  Capybara.register_driver :sauce do |app|
    @desired_cap = {
      'platform': "Windows 7",
      'browserName': "firefox",
      'version': "45",
      'screenResolution': "1440x900",
      'name': "mbg_classes_chckout_usr",
    }
    Capybara::Selenium::Driver.new(app,
      :browser => :remote,
      :url => 'http://RFAutomation:5328f84f-5623-41ba-a81e-b5daff615024@ondemand.saucelabs.com:80/wd/hub',
      :desired_capabilities => @desired_cap
    )
  end
  Capybara.register_driver :browser_stack do |app|
    Capybara::Selenium::Driver.new(app, :browser => :chrome)
  end
  rand_num=Random.rand(899999999) + 100000000
  checkout_page_url = 'https://beta.mindbodygreen.com/classes/checkout'
  visit "https://beta.mindbodygreen.com/classes/topics"
  window = Capybara.current_session.driver.browser.manage.window
  

  step id: 1,
      action: "Close out any popups that appear. Select a random class from the page and click on either the image or link to the class.",
      response: "Are you taken to the class page?" do
    # *** START EDITING HERE ***
    #class_count = all(:css, "div[class='unit_title']").count
    #puts class_count
    #rand_class = Random.rand(1..(class_count/4).to_i)
    rand_class = 0
    class_link = ""
    class_text = ""
    for i in 1..3 do
      if page.has_selector?(:css, 'div.listbuilder-popup-scale')
        page.find(:css, "div[class*='sumome-react-wysiwyg-close-button'").click
        break
      end
      sleep(10)
    end
    expect(page).to have_content("All Video Classes")
    # action
    #page.find(:css, '.unit_img>a', :match => :first, wait: 60).click
    #page.find(:css, '.unit_title>a', :match => :first, wait: 60).click
    #page.all(:css, '.unit_img>a')[0].click
    within(all(:css, "div[class='unit_title']")[rand_class]) do
      class_link = page.find(:css, 'a')
      class_text = class_link.text
      class_link.click
    end

    expect(Capybara.current_session.driver.current_url).to eql('https://staging.mindbodygreen.com/classes/28-days-to-yoga-bliss-the-fundamentals-poses-and-breathwork-you-need-to-know')
    visit 'https://beta.mindbodygreen.com/classes/28-days-to-yoga-bliss-the-fundamentals-poses-and-breathwork-you-need-to-know'
    for i in 1..5 do
      if page.has_selector?(:css, 'div.listbuilder-popup-scale')
        page.find(:css, "div[class*='sumome-react-wysiwyg-close-button'").click
        break
      end
      sleep(10)
    end
    if page.has_selector?(:css, '.close.close-x')
      page.find(:css, '.close.close-x').click
    end
    
    # response
    expect(page).to have_content('CLASS OUTLINE')
    expect(page).to have_content('TAKE THIS CLASS', wait: 10)
    expect(page).to have_content(class_text)

    # *** STOP EDITING HERE ***
  end

  step id: 2,
      action: "Click the 'Take This Class' button",
      response: "Are you taken to the checkout page?" do
    # *** START EDITING HERE ***

    # action
    
    #within(:css, '.columns.large-4') do
    #page.find(:css, '.added-to-cart-btn.ws-button.btn-fill.btn-lg', :text => '   Take This Class ', :match => :first, wait: 20).click
    page.find(:css, '.added-to-cart-btn.ws-button.btn-fill.btn-lg').click
    #end
    
    expect(page).to have_content('Select Payment Method To Complete Order', wait: 20)
    #end
    
    visit checkout_page_url
    for i in 1..2 do
      if page.has_selector?(:css, 'div.listbuilder-popup-scale')
        page.find(:css, "div[class*='sumome-react-wysiwyg-close-button'").click
        break
      end
      sleep(10)
    end
    
    # response
    expect(page).to have_content('Select Payment Method To Complete Order', wait: 20)

    # *** STOP EDITING HERE ***
  end

  step id: 3,
      action: "Some browsers may show a security warning pop up like the attached, so just click the 'Continue' button"\
              " to keep going with the test. If you do not see the popup, just continue with the test",
      response: "Are you able to continue with the test?" do
   
    # *** START EDITING HERE ***

    # action
      # skip this step since there are no brower popups for this site on firefox or chrome
    # response
	
    # *** STOP EDITING HERE ***
  end

  step id: 4,
      action: "Look at the URL in the browser location bar.",
      response: "Does it show a padlock icon in the browser location bar indicating the site is secure?" do
    
    # *** START EDITING HERE ***
=begin    
    # action
      # use the following site to verify HTTPS (green padlock)   
    visit 'https://www.whynopadlock.com/'
    page.fill_in 'url', with: checkout_page_url
    page.find(:css, '#Submit').click

    # response
    expect(page).to have_content(checkout_page_url)
    expect(page).to have_content('Valid Certificate found.')
    expect(page).to have_content('Certificate valid through:')
    expect(page.all(:css, "img[src='check.PNG']", :count => 2).count).to eql(2)

    visit checkout_page_url
    for i in 1..5 do
      if page.has_selector?(:css, 'div.listbuilder-popup-scale')
        page.find(:css, "div[class*='sumome-react-wysiwyg-close-button'").click
        break
      end
      sleep(10)
    end
=end
    # *** STOP EDITING HERE ***
  end

  step id: 5,
      action: "Enter NEWUSR in the Promo Code field on the page and click apply",
      response: "Does the page refresh showing the NEWUSR promo code with savings off the class?" do
   
    # *** START EDITING HERE ***
	   
    # action
    page.fill_in 'coursesapplypromocode_promoCode', with: 'NEWUSR'
    page.find(:css, "input[value='apply']").click

    # response
    expect(page).to have_content('NEWUSR')
    expect(page).to have_content('YOU SAVED')

    # *** STOP EDITING HERE ***
  end

  step id: 6,
    action: "Click the X button next to the NEWUSR promo code",
    response: "Does the page refresh with the promo code gone and savings gone too?" do
      
    # *** START EDITING HERE ***
    
    # action
    page.find(:css, '.promo-remove.ws-a').click

    # response   
    expect(page).to have_no_content('NEWUSR')
    expect(page).to have_no_content('YOU SAVED')
    # *** STOP EDITING HERE ***

  end
  
  
 step id: 7,
      action: "Click the Complete My Order button on the checkout page",
      response: "Do you receive field errors indicating you need to fill out the Name on Card, Email Address, "\
                "Credit Card, Postal Code, CVC, Billing Country, Billing Month, and Billing Year?" do

    # *** START EDITING HERE ***

    # action
    scroll_offset = 2000 
    page.execute_script("window.scrollTo(0,#{scroll_offset})")
    page.click_button 'Complete My Order'

    # response
    expect(page).to have_content('Please provide a billing name')
    expect(page).to have_content('Please provide a postal code')
    expect(page).to have_content('Please provide a CVC number')
    expect(page).to have_content('Please select a country')
    expect(page).to have_content('Please provide an expiration month')
    expect(page).to have_content('Please provide an expiration year')
    expect(page).to have_content('Please provide a credit card number')
    expect(page).to have_content('Please accept our terms of sale')

    # *** STOP EDITING HERE ***

  end

  step id: 8,
      action: "Enter {{random.full_name}} in the Name on Card field, {{random.email}} in the Email Address field, "\
              "5111111111111111 in the Credit Card field, {{random.address_zip}} in the Postal Code field, {{random.number}}"\
              "{{random.number}}{{random.number}} in the CVC field, select a random country from the Billing Country, and a "\
              "future month and year from the Billing Month and Billing Year fields. Check the box to agree to the terms of "\
              "sale. Click the Purchase button",
      response: "Does the page refresh with an error regarding your credit card?" do
    # *** START EDITING HERE ***
    
    rand_name = ('a'..'z').to_a.shuffle[0,8].join
    name = "Automation Name#{rand_name}"
    cc_num = '5111111111111111'
    postal = (Random.rand(89999)+10000).to_s + '-098'
    cvc = Random.rand(899) + 100
    email = "automation#{rand_num}@nowhere.com"

    # action
    
    
    # action
    fill_in 'emailCheckout', with: email
    within(:css, '#credit-card') do
      fill_in 'billingName', with: name
      fill_in 'creditCardNumber', with: cc_num
      fill_in 'postalCode', with: postal
      fill_in 'cvc', with: cvc.to_s
      scroll_offset = 2000 
      page.execute_script("window.scrollTo(0,#{scroll_offset})")
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

    # *** STOP EDITING HERE ***

  end
  


  step id: 9,
      action: "If at any point you receive a browser popup asking if you would like to save your credit card, decline it and "\
              "close the popup to continue with the test",
      response: "Are you able to continue with the test?" do

    # *** START EDITING HERE ***

     # action
    if page.has_selector?(:css, 'div.listbuilder-popup-scale')
      page.find(:css, "div[class*='sumome-react-wysiwyg-close-button'").click
    end

    # response

    # *** STOP EDITING HERE ***

  end

  
  step id: 10,
      action: "Change the credit card number to 4111111111111111 (four followed by fifteen ones), re-check the box to agree to "\
              "the terms of sale, and click Complete My Order",
      response: "Are you taken to a Purchase Confirmation page?" do

    # *** START EDITING HERE ***
    cc_num = '4111111111111111'

    # action
    within(:css, '#credit-card') do
      fill_in 'creditCardNumber', with: cc_num
      scroll_offset = 2000 
      page.execute_script("window.scrollTo(0,#{scroll_offset})")
      page.check 'agreePrivacy'
      page.click_button 'Complete My Order'
    end

    # response
    expect(page).to have_content('Purchase Confirmation')
    
    # *** STOP EDITING HERE ***

  end

  #sleep(20)
end
