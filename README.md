# How To Set Up a Ruby on Rails Project with a React Frontend

Prerequisites
To follow this tutorial, you need to have the following:

Node.js and npm installed on your development machine. This tutorial uses Node.js version 10.16.0 and npm version 6.9.0. Node.js is a JavaScript run-time environment that allows you to run your code outside of the browser. It comes with a pre-installed Package Manager called npm, which lets you install and update packages. To install these on macOS or Ubuntu 18.04, follow the steps in How to Install Node.js and Create a Local Development Environment on macOS or the “Installing Using a PPA” section of How To Install Node.js on Ubuntu 18.04.
The Yarn package manager installed on your development machine, which will allow you to download the React framework. This tutorial was tested on version 1.16.0; to install this dependency, follow the official Yarn installation guide.
Installation of the Ruby on Rails framework. To get this, follow our guide on How to Install Ruby on Rails with rbenv on Ubuntu 18.04, or How To Install Ruby on Rails with rbenv on CentOS 7. If you would like to develop this application on macOS, please see this tutorial on How To Install Ruby on Rails with rbenv on macOS. This tutorial was tested on version 2.6.3 of Ruby and version 5.2.3 of Rails, so make sure to specify these versions during the installation process.
Installation of PostgreSQL, as shown in Steps 1 and 2 of our tutorial How To Use PostgreSQL with Your Ruby on Rails Application on Ubuntu 18.04 or How To Use PostgreSQL with Your Ruby on Rails Application on macOS. To follow this tutorial, use PostgreSQL version 10. If you are looking to develop this application on a different distribution of Linux or on another OS, see the official PostgreSQL downloads page. For more information on how to use PostgreSQL, see our How To Install and Use PostgreSQL tutorials.
Step 1 — Creating a New Rails Application
In this step, you will build your recipe application on the Rails application framework. First, you’ll create a new Rails application, which will be set up to work with React out of the box with little configuration.

Rails provides a number of scripts called generators that help in creating everything that’s necessary to build a modern web application. To see a full list of these commands and what they do, run the following command in your Terminal window:

rails -h
 
This will yield a comprehensive list of options, which will allow you to set the parameters of your application. One of the commands listed is the new command, which creates a new Rails application.

Now, you will create a new Rails application using the new generator. Run the following command in your Terminal window:

rails new rails_react_recipe -d=postgresql -T --webpack=react --skip-coffee
 
The preceding command creates a new Rails application in a directory named rails_react_recipe, installs the required Ruby and JavaScript dependencies, and configures Webpack. Let’s walk through the flags that are associated with this new generator command:

The -d flag specifies the preferred database engine, which in this case is PostgreSQL.
The -T flag instructs Rails to skip the generation of test files, since you won’t be writing tests for the purposes of this tutorial. This command is also suggested if you want to use a Ruby testing tool different from the one Rails provides.
The --webpack instructs Rails to preconfigure for JavaScript with the webpack bundler, in this case specifically for a React application.
The --skip-coffee asks Rails not to set up CoffeeScript, which is not needed for this tutorial.
Once the command is done running, move into the rails_react_recipe directory, which is the root directory of your app:

cd rails_react_recipe
 
Next, list out the contents of the directory:

ls
 
This root directory has a number of auto-generated files and folders that make up the structure of a Rails application, including a package.json file containing the dependencies for a React application.

Now that you have successfully created a new Rails application, you are ready to hook it up to a database in the next step.

Step 2 — Setting Up the Database
Before you run your new Rails application, you have to first connect it to a database. In this step, you’ll connect the newly created Rails application to a PostgreSQL database, so recipe data can be stored and fetched when needed.

The database.yml file found in config/database.yml contains database details like database name for different development environments. Rails specifies a database name for the different development environments by appending an underscore (_) followed by the environment name to your app’s name. You can always change any environment database name to whatever you prefer.

Note: At this point, you can alter config/database.yml to set up which PostgreSQL role you would like Rails to use to create your database. If you followed the Prerequisite How To Use PostgreSQL with Your Ruby on Rails Application and created a role that is secured by a password, you can follow the instructions in Step 4 for macOS or Ubuntu 18.04.

As earlier stated, Rails offers a lot of commands to make developing web applications easy. This includes commands to work with databases, such as create, drop, and reset. To create a database for your application, run the following command in your Terminal window:

rails db:create
 
This command creates a development and test database, yielding the following output:

Output
Created database 'rails_react_recipe_development'
Created database 'rails_react_recipe_test'
Now that the application is connected to a database, start the application by running the following command in you Terminal window:

rails s --binding=127.0.0.1
 
The s or server command fires up Puma, which is a web server distributed with Rails by default, and --binding=127.0.0.1 binds the server to your localhost.

Once you run this command, your command prompt will disappear, and you will see the following output:

Output
=> Booting Puma
=> Rails 5.2.3 application starting in development 
=> Run `rails server -h` for more startup options
Puma starting in single mode...
* Version 3.12.1 (ruby 2.6.3-p62), codename: Llamas in Pajamas
* Min threads: 5, max threads: 5
* Environment: development
* Listening on tcp://127.0.0.1:3000
Use Ctrl-C to stop
To see your application, open a browser window and navigate to http://localhost:3000. You will see the Rails default welcome page:

Rails welcome page

This means that you have properly set up your Rails application.

To stop the web server at anytime, press CTRL+C in the Terminal window where the server is running. Go ahead and do this now; you will get a goodbye message from Puma:

Output
^C- Gracefully stopping, waiting for requests to finish
=== puma shutdown: 2019-07-31 14:21:24 -0400 ===
- Goodbye!
Exiting
Your prompt will then reappear.

You have successfully set up a database for your food recipe application. In the next step, you will install all the extra JavaScript dependencies you need to put together your React frontend.

Step 3 — Installing Frontend Dependencies
In this step, you will install the JavaScript dependencies needed on the frontend of your food recipe application. They include:

React Router, for handling navigation in a React application.
Bootstrap, for styling your front-end components.
jQuery and Popper, for working with Bootstrap.
Run the following command in your Terminal window to install these packages with the Yarn package manager:

yarn add react-router-dom bootstrap jquery popper.js
 
This command uses Yarn to install the specified packages and adds them to the package.json file. To verify this, take a look at the package.json file located in the root directory of the project:

nano package.json
 
You’ll see the installed packages listed under the dependencies key:

~/rails_react_recipe/package.json
{
  "name": "rails_react_recipe",
  "private": true,
  "dependencies": {
    "@babel/preset-react": "^7.0.0",
    "@rails/webpacker": "^4.0.7",
    "babel-plugin-transform-react-remove-prop-types": "^0.4.24",
    "bootstrap": "^4.3.1",
    "jquery": "^3.4.1",
    "popper.js": "^1.15.0",
    "prop-types": "^15.7.2",
    "react": "^16.8.6",
    "react-dom": "^16.8.6",
    "react-router-dom": "^5.0.1"
  },
  "devDependencies": {
    "webpack-dev-server": "^3.7.2"
  }
}
 
You have installed a few front-end dependencies for your application. Next, you’ll set up a homepage for your food recipe application.

Step 4 — Setting Up the Homepage
With all the required dependencies installed, in this step you will create a homepage for the application. The homepage will serve as the landing page when users first visit the application.

Rails follows the Model-View-Controller architectural pattern for applications. In the MVC pattern, a controller’s purpose is to receive specific requests and pass them along to the appropriate model or view. Right now the application displays the Rails welcome page when the root URL is loaded in the browser. To change this, you will create a controller and view for the homepage and match it to a route.

Rails provides a controller generator for creating a controller. The controller generator receives a controller name, along with a matching action. For more on this, check out the official Rails documentation.

This tutorial will call the controller Homepage. Run the following command in your Terminal window to create a Homepage controller with an index action.

rails g controller Homepage index
 
Note:
On Linux, if you run into the error FATAL: Listen error: unable to monitor directories for changes., this is due to a system limit on the number of files your machine can monitor for changes. Run the following command to fix it:

echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
 
This will permanently increase the amount of directories that you can monitor with Listen to 524288. You can change this again by running the same command and replacing 524288 with your desired number.

Running this command generates the following files:

A homepage_controller.rb file for receiving all homepage-related requests. This file contains the index action you specified in the command.
A homepage.js file for adding any JavaScript behavior related to the Homepage controller.
A homepage.scss file for adding styles related to the Homepage controller.
A homepage_helper.rb file for adding helper methods related to the Homepage controller.
An index.html.erb file which is the view page for rendering anything related to the homepage.
Apart from these new pages created by running the Rails command, Rails also updates your routes file which is located at config/routes.rb. It adds a get route for your homepage which you will modify as your root route.

A root route in Rails specifies what will show up when users visit the root URL of your application. In this case, you want your users to see your homepage. Open the routes file located at config/routes.rb in your favorite editor:

nano config/routes.rb
 
Inside this file, replace get 'homepage/index' with root 'homepage#index' so that the file looks like the following:

~/rails_react_recipe/config/routes.rb
Rails.application.routes.draw do
  root 'homepage#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
 
This modification instructs Rails to map requests to the root of the application to the index action of the Homepage controller, which in turn renders whatever is in the index.html.erb file located at app/views/homepage/index.html.erb on to the browser.

To verify that this is working, start your application:

rails s --binding=127.0.0.1
 
Opening the application in the browser, you will see a new landing page for your application:

Application Homepage

Once you have verified that your application is working, press CTRL+C to stop the server.

Next, open up the ~/rails_react_recipe/app/views/homepage/index.html.erb file, remove the code inside the file, then save the file as empty. By doing this, you will ensure that the contents of index.html.erb do not interfere with the React rendering of your frontend.

Now that you have set up your homepage for your application, you can move to the next section, where you will configure the frontend of your application to use React.

Step 5 — Configuring React as Your Rails Frontend
In this step, you will configure Rails to use React on the frontend of the application, instead of its template engine. This will allow you to take advantage of React rendering to create a more visually appealing homepage.

Rails, with the help of the Webpacker gem, bundles all your JavaScript code into packs. These can be found in the packs directory at app/javascript/packs. You can link these packs in Rails views using the javascript_pack_tag helper, and you can link stylesheets imported into the packs using the stylesheet_pack_tag helper. To create an entry point to your React environment, you will add one of these packs to your application layout.

First, rename the ~/rails_react_recipe/app/javascript/packs/hello_react.jsx file to ~/rails_react_recipe/app/javascript/packs/Index.jsx.

mv ~/rails_react_recipe/app/javascript/packs/hello_react.jsx ~/rails_react_recipe/app/javascript/packs/Index.jsx
 
After renaming the file, open application.html.erb, the application layout file:

nano ~/rails_react_recipe/app/views/layouts/application.html.erb
 
Add the following highlighted lines of code at the end of the head tag in the application layout file:

~/rails_react_recipe/app/views/layouts/application.html.erb
<!DOCTYPE html>
<html>
  <head>
    <title>RailsReactRecipe</title>
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>

    <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= javascript_include_tag 'application', 'data-turbolinks-track': 'reload' %>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <%= javascript_pack_tag 'Index' %>
  </head>

  <body>
    <%= yield %>
  </body>
</html>
 
Adding the JavaScript pack to your application’s header makes all your JavaScript code available and executes the code in your Index.jsx file on the page whenever you run the app. Along with the JavaScript pack, you also added a meta viewport tag to control the dimensions and scaling of pages on your application.

Save and exit the file.

Now that your entry file is loaded onto the page, create a React component for your homepage. Start by creating a components directory in the app/javascript directory:

mkdir ~/rails_react_recipe/app/javascript/components
 
The components directory will house the component for the homepage, along with other React components in the application. The homepage will contain some text and a call to action button to view all recipes.

In your editor, create a Home.jsx file in the components directory:

nano ~/rails_react_recipe/app/javascript/components/Home.jsx
 
Add the following code to the file:

~/rails_react_recipe/app/javascript/components/Home.jsx
import React from "react";
import { Link } from "react-router-dom";

export default () => (
  <div className="vw-100 vh-100 primary-color d-flex align-items-center justify-content-center">
    <div className="jumbotron jumbotron-fluid bg-transparent">
      <div className="container secondary-color">
        <h1 className="display-4">Food Recipes</h1>
        <p className="lead">
          A curated list of recipes for the best homemade meal and delicacies.
        </p>
        <hr className="my-4" />
        <Link
          to="/recipes"
          className="btn btn-lg custom-button"
          role="button"
        >
          View Recipes
        </Link>
      </div>
    </div>
  </div>
);
 
In this code, you imported React and also the Link component from React Router. The Link component creates a hyperlink to navigate from one page to another. You then created and exported a functional component containing some Markup language for your homepage, styled with Bootstrap classes.

With your Home component in place, you will now set up routing using React Router. Create a routes directory in the app/javascript directory:

mkdir ~/rails_react_recipe/app/javascript/routes
 
The routes directory will contain a few routes with their corresponding components. Whenever any specified route is loaded, it will render its corresponding component to the browser.

In the routes directory, create an Index.jsx file:

nano ~/rails_react_recipe/app/javascript/routes/Index.jsx
 
Add the following code to it:

~/rails_react_recipe/app/javascript/routes/Index.jsx
import React from "react";
import { BrowserRouter as Router, Route, Switch } from "react-router-dom";
import Home from "../components/Home";

export default (
  <Router>
    <Switch>
      <Route path="/" exact component={Home} />
    </Switch>
  </Router>
);
 
In this Index.jsx route file, you imported a couple of modules: the React module that allows us to use React, and the BrowserRouter, Route, and Switch modules from React Router, which together help us navigate from one route to another. Lastly, you imported your Home component, which will be rendered whenever a request matches the root (/) route. Whenever you want to add more pages to your application, all you need to do is declare a route in this file and match it to the component you want to render for that page.

Save and exit the file.

You have now successfully set up routing using React Router. For React to be aware of the available routes and use them, the routes have to be available at the entry point to the application. To achieve this, you will render your routes in a component that React will render in your entry file.

Create an App.jsx file in the app/javascript/components directory:

nano ~/rails_react_recipe/app/javascript/components/App.jsx
 
Add the following code into the App.jsx file:

~/rails_react_recipe/app/javascript/components/App.jsx
import React from "react";
import Routes from "../routes/Index";

export default props => <>{Routes}</>;
 
In the App.jsx file, you imported React and the route files you just created. You then exported a component that renders the routes within fragments. This component will be rendered at the entry point of the aplication, thereby making the routes available whenever the application is loaded.

Now that you have your App.jsx set up, it’s time to render it in your entry file. Open the entry Index.jsx file:

nano ~/rails_react_recipe/app/javascript/packs/Index.jsx
 
Replace the code there with the following code:

~/rails_react_recipe/app/javascript/packs/Index.jsx
import React from "react";
import { render } from "react-dom";
import 'bootstrap/dist/css/bootstrap.min.css';
import $ from 'jquery';
import Popper from 'popper.js';
import 'bootstrap/dist/js/bootstrap.bundle.min';
import App from "../components/App";

document.addEventListener("DOMContentLoaded", () => {
  render(
    <App />,
    document.body.appendChild(document.createElement("div"))
  );
});
 
In this code snippet, you imported React, the render method from ReactDOM, Bootstrap, jQuery, Popper.js, and your App component. Using ReactDOM’s render method, you rendered your App component in a div element, which was appended to the body of the page. Whenever the application is loaded, React will render the content of the App component inside the div element on the page.

Save and exit the file.

Finally, add some CSS styles to your homepage.

Open up your application.css in your ~/rails_react_recipe/app/assets/stylesheets directory:

nano ~/rails_react_recipe/app/assets/stylesheets/application.css
 
Next, replace the contents of the application.css file with the follow code:

~/rails_react_recipe/app/assets/stylesheets/application.css
.bg_primary-color {
  background-color: #FFFFFF;
}
.primary-color {
  background-color: #FFFFFF;
}
.bg_secondary-color {
  background-color: #293241;
}
.secondary-color {
  color: #293241;
}
.custom-button.btn {
  background-color: #293241;
  color: #FFF;
  border: none;
}
.custom-button.btn:hover {
  color: #FFF !important;
  border: none;
}
.hero {
  width: 100vw;
  height: 50vh;
}
.hero img {
  object-fit: cover;
  object-position: top;
  height: 100%;
  width: 100%;
}
.overlay {
  height: 100%;
  width: 100%;
  opacity: 0.4;
}
 
This creates the framework for a hero image, or a large web banner on the front page of your website, that you will add later. Additionally, this styles the button that the user will use to enter the application.

With your CSS styles in place, save and exit the file. Next, restart the web server for your application, then reload the application in your browser. You will see a brand new homepage:

Homepage Style

In this step, you configured your application so that it uses React as its frontend. In the next section, you will create models and controllers that will allow you to create, read, update, and delete recipes.