import React from "react";
import { BrowserRouter as Router, Route, Switch } from "react-router-dom";
import Home from "../components/Home";
import {Recipes, Recipe,New} from "../components/Recipe/Index";

export default (
  <Router>
    <Switch>
      <Route path="/" exact component={Home} />
      <Route path="/recipes" exact component={Recipes} />
      <Route path="/recipe/:id" exact component={Recipe} />
      <Route path="/recipe" exact component={New} />
    </Switch>
  </Router>
);