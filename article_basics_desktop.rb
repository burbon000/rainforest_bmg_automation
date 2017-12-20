#tester starts at 
# https://beta.mindbodygreen.com/
# https://staging.mindbodygreen.com/0-29941/does-having-a-fertility-year-really-help-your-chances-of-conception-a-doctor-e.html 
# https://staging.mindbodygreen.com/0-30059/steal-it-the-australian-yoga-secret-were-obsessing-over.html

test(id: 49012, title: "Article Basics - Desktop") do
  # You can use any of the following variables in your code:
  # - []
  rand_num=Random.rand(899999999) + 100000000
  Capybara.register_driver :sauce do |app|
    @desired_cap = {
      'platform': "Windows 7",
      'browserName': "firefox",
      #'locationContextEnabled': false,
      'screenResolution': "1920x1080",
      'version': "45",
      'name': "mbg_article_basics_desk",
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
  #visit "https://beta.mindbodygreen.com/"
  visit "https://beta.mindbodygreen.com/0-26580/why-this-acroyogi-makes-it-a-point-to-get-upside-down-sweat-every-single-day.html"
  window = Capybara.current_session.driver.browser.manage.window
  #window.maximize
  scroll_offset = 0

  step id: 1,
      action: "As you scroll down the page, you may see ad or email signup popups you can close and ignore.",
      response: "Are you able to continue with the test?" do
    # *** START EDITING HERE ***

    # action    
    for i in 1..5 do
      scroll_offset += 500 
      page.execute_script("window.scrollTo(0,#{scroll_offset})")
      if page.has_selector?(:css, 'div.listbuilder-popup-scale', wait: 10)
        #page.find(:css, "div[class*='sumome-react-wysiwyg-close-button'").click
        break
      end
    end

    # response
      # no response

    #page.save_screenshot('screenshot_step_1.png')
    # *** STOP EDITING HERE ***
  end

  step id: 2,
      action: "Look at the top of the article",
      response: "Do you see the title, an author image, the author name, and publish time of the article?" do
    # *** START EDITING HERE ***

    # action
    #visit "https://beta.mindbodygreen.com/0-26580/why-this-acroyogi-makes-it-a-point-to-get-upside-down-sweat-every-single-day.html"

    # response
    expect(page).to have_selector(:css, '.title')
    expect(page).to have_selector(:css, '.byline-author-image-small.left')
    expect(page).to have_selector(:css, '.byline-author')
    expect(page).to have_selector(:css, '.date')

    #page.save_screenshot('screenshot_step_2.png')
    # *** STOP EDITING HERE ***
  end

  step id: 3,
      action: "Look at the right side below the title",
      response: "Do you see options to Save the article and Share the article on Facebook, Twitter, Pinterest, and via email?" do
   
    # *** START EDITING HERE ***

    # action
      #no action

    # response
    within(:css, '.social-container') do
      expect(page).to have_selector(:css, 'span', :text => 'SAVE')
      expect(page).to have_selector(:css, '.facebook_share_button.social-sprite-image')
      expect(page).to have_selector(:css, '.twitter_share_button.social-sprite-image')
      expect(page).to have_selector(:css, '.pinterest_share_button.social-sprite-image')
      expect(page).to have_selector(:css, '.article_email_button.social-sprite-image')
    end

    #page.save_screenshot('screenshot_step_3.png')
    # *** STOP EDITING HERE ***
  end

  step id: 4,
      action: "Look at the heart next to the word Save",
      response: "Is the heart white?" do
    
    # *** START EDITING HERE ***

    # action
      #no action

    # response
    expect(page).to have_selector(:css, '.article_save_button.hide-for-print')
    expect(page).to have_no_selector(:css, '.article_save_button.hide-for-print.saved')
    
    #page.save_screenshot('screenshot_step_4.png')
    # *** STOP EDITING HERE ***
  end

  step id: 5,
      action: "Look at the hero image below the title",
      response: "Do you see a photo credit on the lower right below the image?" do
   
    # *** START EDITING HERE ***
	   
    # action
      #no action

    # response
    expect(page).to have_selector(:css, '.photo-credits')

    #page.save_screenshot('screenshot_step_5.png')
    # *** STOP EDITING HERE ***
  end

  step id: 6,
      action: "Wait for approximately 10 seconds, then start scrolling down the page and close any popups"\
              " you encounter throughout the test until you reach the end of the article story content",
      response: "Do you see a group of three articles or classes on the right? " do      
    # *** START EDITING HERE ***
      
    # action
    scroll_offset += 2000 
    page.execute_script("window.scrollTo(0,#{scroll_offset})")

    # response 
    expect(page.all(:css, '.row.unit.unit--tab--sm', :maximum => 4, :wait => 60, :visible => false).count).to eq(3)

    #page.save_screenshot('screenshot_step_6.png')
    # *** STOP EDITING HERE ***

  end
  
  
 step id: 7,
      action: "Scroll to the end of the article body content",
      response: "Do you see buttons to share the article on Twitter, Facebook, Pinterest, and Email and the "\
                "words 'KEEP READING' next to one or more linked words?" do
    # *** START EDITING HERE ***

    # action
    scroll_offset += 1000 
    page.execute_script("window.scrollTo(0,#{scroll_offset})")

    # response
    within(:css, '.social-below-article-container') do
      expect(page).to have_selector(:css, '.facebook_share_button.social-sprite-image')
      expect(page).to have_selector(:css, '.twitter_share_button.social-sprite-image')
      expect(page).to have_selector(:css, '.pinterest_share_button.social-sprite-image')
      expect(page).to have_selector(:css, '.article_email_button.social-sprite-image')
    end
    expect(page).to have_content('KEEP READING:  ')

    #page.save_screenshot('screenshot_step_7.png')
    # *** STOP EDITING HERE ***

  end

  step id: 8,
      action: "Look underneath the tag section",
      response: "Do you see a section for the author of the article with her photo, name, and biography?" do
    # *** START EDITING HERE ***
    
    # action
      #no action

    # response
    expect(page).to have_selector(:css, "img[alt='Article Author Image']")
    expect(page).to have_selector(:css, '.show-for-medium-up>p')
    expect(page).to have_selector(:css, '.author-unit__name')

    #page.save_screenshot('screenshot_step_8.png')
    # *** STOP EDITING HERE ***

  end
  
  step id: 9,
      action: "Look below the article",
      response: "Do you see a section entitled 'EXPLORE MORE' that features 6 images and titles?" do

    # *** START EDITING HERE ***

    # action
    page.execute_script("window.scrollTo(0,1500)")

    # response
    expect(page).to have_content('EXPLORE MORE')
    within(:css, '#sailthruExploreMoreContainer') do
      expect(page.all(:css, '.unit__description', :maximum => 7).count).to eq(6)
    end

    #page.save_screenshot('screenshot_step_9.png')
    # *** STOP EDITING HERE ***

  end

  
  step id: 10,
      action: "Scroll down to the 'LATEST'section",
      response: "Do you see a section of articles with an ad unit on the right side?" do

    # *** START EDITING HERE ***

    # action
    scroll_offset += 1000 
    page.execute_script("window.scrollTo(0,#{scroll_offset})")
    #page.execute_script("window.scrollTo(0,1500)")

    # response
    within(:css, '.row.article__latest') do
      expect(page).to have_content('LATEST')
      expect(page).to have_selector(:css, '.unit__title')
      expect(page).to have_selector(:css, '.text-center.vertical-ad-unit.centered-ad', :visible => false)
    end

    #page.save_screenshot('screenshot_step_10.png')
    # *** STOP EDITING HERE ***

  end

  step id: 11,
      action: "Navigate to {{rainforest.url_base}}{{unique_apostrophe_urls.url}} (copy and paste"\
              " the URL into browser window) and look at the article's title",
      response: "If the title of the article has an apostrophe, does it display correctly?" do
   
    # *** START EDITING HERE ***

    # action
    visit 'https://staging.mindbodygreen.com/0-30005/heartbreak-isnt-all-there-is-heres-how-to-process-loss-open-yourself-up-to-l.html'

    # response
    within(:css, '.article-header') do
      expect(page).to have_content("Heartbreak Isn't All There Is. Here's How To Process Loss & Open Yourself Up To Love")
    end


    #page.save_screenshot('screenshot_step_11.png')
    # *** STOP EDITING HERE ***

  end
  
  step id: 12,
      action: "As you scroll down the page, you may see ad or email signup popups you can close and ignore.",
      response: "Are you able to continue with the test?" do

    # *** START EDITING HERE ***

    # action
    scroll_offset = 0
    for i in 1..5 do
      scroll_offset += 500 
      page.execute_script("window.scrollTo(0,#{scroll_offset})")
      if page.has_selector?(:css, 'div.listbuilder-popup-scale', wait: 10)
        page.find(:css, "div[class*='sumome-react-wysiwyg-close-button'").click
        break
      end
    end

    # response
      #no response

    #page.save_screenshot('screenshot_step_12.png')
    # *** STOP EDITING HERE ***
  end

  step id: 13,
      action: "Look at the author's name. (SKIP THIS STEP OF THE AUTHOR DOES NOT HAVE AN APOSTROPHE IN THE NAME)",
      response: "If the author's name has an apostrophe, does the apostrophe display correctly?" do

    # *** START EDITING HERE ***

    # action
      scroll_offset = 0
      page.execute_script("window.scrollTo(0,#{scroll_offset})")

    # response
    expect(page).to have_content("Derek O’Neill")

    #page.save_screenshot('screenshot_step_12.png')
    # *** STOP EDITING HERE ***
  end

    step id: 14,
      action: "Click on the author's name. (SKIP THIS STEP IF THE AUTHOR DOES NOT HAVE AN APOSTROPHE IN THE NAME)",
      response: "Does it take you to the author's individual page that has a short biography?" do

    # *** START EDITING HERE ***

    # action
    within(:css, '.article-header') do
      page.find(:css, 'a', :text => "Derek O’Neill").click
    end

    # response
    within(:css, '#bio-details') do
      expect(page).to have_content("Derek O’Neill")
    end

    #page.save_screenshot('screenshot_step_12.png')
    # *** STOP EDITING HERE ***
  end

    step id: 15,
      action: "Click the back button on the browser and look at the sponsor's name next to the author's name."\
              " (SKIP THIS STEP IF THERE IS NO SPONSOR NEXT TO THE AUTHOR'S NAME)",
      response: "Does the apostrophe in the sponsor's name display correctly?" do

    # *** START EDITING HERE ***

    # action
    page.go_back

    # response
      #No sponsor on this article

    #page.save_screenshot('screenshot_step_12.png')
    # *** STOP EDITING HERE ***
  end

    step id: 16,
      action: "Click on the sponsor's name. (SKIP THIS STEP IF THERE IS NO SPONSOR NEXT TO THE AUTHOR'S NAME)",
      response: "Does this take you to the sponsor page that has more information on the sponsor and possibly more articles from the sponsor?" do

    # *** START EDITING HERE ***

    # action
      #No sponsor on this article
    # response

    #page.save_screenshot('screenshot_step_12.png')
    # *** STOP EDITING HERE ***
  end

end
