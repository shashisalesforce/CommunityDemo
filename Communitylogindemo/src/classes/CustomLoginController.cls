/**
 * An apex page controller that exposes the site login functionality
 */
global with sharing class CustomLoginController {
    global String username{get;set;}
    global String password{get;set;}
    global CustomLoginController () {}
    global PageReference forwardToCustomAuthPage() {
        return new PageReference( '/CustomLogin');
    }
    global PageReference login() {
        return Site.login(username, password, null);
    }

}