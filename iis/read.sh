#default settings
C:\Windows/System32/inetsvr/config/applicationHost.config 

#detailed errors
error pages > edit feature settings > detailed errors

#allow unlisted extentions
<requestFiltering> 
                <fileExtensions allowUnlisted="true" applyToWebDAV="true">


Open web.config
Navigate to the node //configuration/netsparker/settings/
Insert or replace the attribute allowAnonymousWizard with value true
