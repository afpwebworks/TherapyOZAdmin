<cfcomponent displayname="Page" output="false" hint="A bean which models the Page record.">

<cfsilent>
<!----
================================================================
Filename: Page.cfc
Description: A bean which models the Page record.
Client:   Therapyoz.com
Author:   Michael Kear, AFP Webworks 
Date:     7/Sep/2015
================================================================
This bean was generated with the following template:
Bean Name: Page
Path to Bean: 
Extends: 
Call super.init(): false
Bean Template:
	PageID numeric 0 
	PageName string 
	NodeRec 
	Siteno numeric 0 
	Template string 
	Teaser string 
	Keywords string 
	Live boolean false 
	Embargoed boolean false 
	EmbargoDate date #createdate("2005","1","1")# 
	Expires boolean false 
	DateExpires date #createdate("2050","1","1")# 
	AccessLevel numeric 1 
	EditLevel numeric 20 
	ApproveLevel numeric 90 
	EditStatus string 
	LockedForEdit string 
	ApprovedBy string 
	ApprovedDate date 
	DateAdded date #now()# 
	DateUpdated date #now()# 
	UpdatedBy string ('Script') 
	IsVisible boolean true 
	PageTitle string 
Create getSnapshot method: true
Create setSnapshot method: false
Create setStepInstance method: false
Create validate method: true
Create validate interior: true
Create LTO methods: false
Path to LTO: 
Date Format: DD/MM/YYYY
--->
</cfsilent>
	<!---[	PROPERTIES	]--->
	<cfset variables.instance = StructNew() />

	<!---[ 	INITIALIZATION / CONFIGURATION	]--->
	<cffunction name="init" access="public" returntype="Page" output="false">
   
        <cfargument name="PageID" type="numeric" required="true" default="0" />
        <cfargument name="PageName" type="string" required="false" default="" />
        <cfargument name="PageTitle" type="string" required="false" default="" />
        <cfargument name="NodeRec" type="string" required="false" default="/1/" />
        <cfargument name="Siteno" type="numeric" required="false" default="0" />
        <cfargument name="Template" type="string" required="false" default="" />
        <cfargument name="Teaser" type="string" required="false" default="" />
        <cfargument name="Keywords" type="string" required="false" default="" />
        <cfargument name="Live" type="boolean" required="true" default="false" />
        <cfargument name="Embargoed" type="boolean" required="true" default="false" />
        <cfargument name="EmbargoDate" type="date" required="true" default="#createdate('2005','1','1')#" />
        <cfargument name="Expires" type="boolean" required="true" default="false" />
        <cfargument name="DateExpires" type="date" required="false" default="#createdate('2050','1','1')#" />
        <cfargument name="AccessLevel" type="numeric" required="true" default="1" />
        <cfargument name="EditLevel" type="numeric" required="true" default="20" />
        <cfargument name="ApproveLevel" type="numeric" required="true" default="90" />
        <cfargument name="EditStatus" type="string" required="false" default="" />
        <cfargument name="LockedForEdit" type="string" required="false" default="" />
        <cfargument name="ApprovedBy" type="string" required="false" default="" />
        <cfargument name="ApprovedDate" type="Any" required="false" default="" />
        <cfargument name="DateAdded" type="date" required="true" default="#now()#" />
        <cfargument name="DateUpdated" type="date" required="true" default="#now()#" />
        <cfargument name="UpdatedBy" type="string" required="false" default="('Script')" />
        <cfargument name="IsVisible" type="boolean" required="true" default="true" />

    
    
		<cfscript>
			// run setters
			 setPageID(arguments.PageID);
			 setPageName(arguments.PageName);
 			 setPageTitle(arguments.PageTitle);
			 setNodeRec(arguments.NodeRec);
			 setSiteno(arguments.Siteno);
			 setTemplate(arguments.Template);
			 setTeaser(arguments.Teaser);
			 setKeywords(arguments.Keywords);
			 setLive(arguments.Live);
			 setEmbargoed(arguments.Embargoed);
			 setEmbargoDate(arguments.EmbargoDate);
			 setExpires(arguments.Expires);
			 setDateExpires(arguments.DateExpires);
			 setAccessLevel(arguments.AccessLevel);
			 setEditLevel(arguments.EditLevel);
			 setApproveLevel(arguments.ApproveLevel);
			 setEditStatus(arguments.EditStatus);
			 setLockedForEdit(arguments.LockedForEdit);
			 setApprovedBy(arguments.ApprovedBy);
			 setApprovedDate(arguments.ApprovedDate);
			 setDateAdded(arguments.DateAdded);
			 setDateUpdated(arguments.DateUpdated);
			 setUpdatedBy(arguments.UpdatedBy);
			 setIsVisible(arguments.IsVisible);
			 return this;
		</cfscript>
 	</cffunction>

	<!---[ 	PUBLIC FUNCTIONS 	]--->
	<cffunction name="getSnapshot" access="public"returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>

	<cffunction name="validate" access="public" returntype="any" output="false">
		<cfargument name="eH" required="true" type="any" />
<!-----[ validation parameters  (customise to suit) then remove comments  ]---->
  
  <!-----[ 
    <!----[ PageID ]---->
                <cfif ( getPageID() eq whatever )>
                    <cfset arguments.eH.setError("PageID", "PageID This is the error message") />
                </cfif>
  
                  <!----[ PageName ]---->
                <cfif ( getPageName() eq whatever )>
                    <cfset arguments.eH.setError("PageName", "PageName This is the error message") />
                </cfif>
  
                  <!----[ NodeRec ]---->
                <cfif ( getNodeRec() eq whatever )>
                    <cfset arguments.eH.setError("NodeRec", "NodeRec This is the error message") />
                </cfif>
  
                  <!----[ Siteno ]---->
                <cfif ( getSiteno() eq whatever )>
                    <cfset arguments.eH.setError("Siteno", "Siteno This is the error message") />
                </cfif>
  
                  <!----[ Template ]---->
                <cfif ( getTemplate() eq whatever )>
                    <cfset arguments.eH.setError("Template", "Template This is the error message") />
                </cfif>
  
                  <!----[ Teaser ]---->
                <cfif ( getTeaser() eq whatever )>
                    <cfset arguments.eH.setError("Teaser", "Teaser This is the error message") />
                </cfif>
  
                  <!----[ Keywords ]---->
                <cfif ( getKeywords() eq whatever )>
                    <cfset arguments.eH.setError("Keywords", "Keywords This is the error message") />
                </cfif>
  
                  <!----[ Live ]---->
                <cfif ( getLive() eq whatever )>
                    <cfset arguments.eH.setError("Live", "Live This is the error message") />
                </cfif>
  
                  <!----[ Embargoed ]---->
                <cfif ( getEmbargoed() eq whatever )>
                    <cfset arguments.eH.setError("Embargoed", "Embargoed This is the error message") />
                </cfif>
  
                  <!----[ EmbargoDate ]---->
                <cfif ( getEmbargoDate() eq whatever )>
                    <cfset arguments.eH.setError("EmbargoDate", "EmbargoDate This is the error message") />
                </cfif>
  
                  <!----[ Expires ]---->
                <cfif ( getExpires() eq whatever )>
                    <cfset arguments.eH.setError("Expires", "Expires This is the error message") />
                </cfif>
  
                  <!----[ DateExpires ]---->
                <cfif ( getDateExpires() eq whatever )>
                    <cfset arguments.eH.setError("DateExpires", "DateExpires This is the error message") />
                </cfif>
  
                  <!----[ AccessLevel ]---->
                <cfif ( getAccessLevel() eq whatever )>
                    <cfset arguments.eH.setError("AccessLevel", "AccessLevel This is the error message") />
                </cfif>
  
                  <!----[ EditLevel ]---->
                <cfif ( getEditLevel() eq whatever )>
                    <cfset arguments.eH.setError("EditLevel", "EditLevel This is the error message") />
                </cfif>
  
                  <!----[ ApproveLevel ]---->
                <cfif ( getApproveLevel() eq whatever )>
                    <cfset arguments.eH.setError("ApproveLevel", "ApproveLevel This is the error message") />
                </cfif>
  
                  <!----[ EditStatus ]---->
                <cfif ( getEditStatus() eq whatever )>
                    <cfset arguments.eH.setError("EditStatus", "EditStatus This is the error message") />
                </cfif>
  
                  <!----[ LockedForEdit ]---->
                <cfif ( getLockedForEdit() eq whatever )>
                    <cfset arguments.eH.setError("LockedForEdit", "LockedForEdit This is the error message") />
                </cfif>
  
                  <!----[ ApprovedBy ]---->
                <cfif ( getApprovedBy() eq whatever )>
                    <cfset arguments.eH.setError("ApprovedBy", "ApprovedBy This is the error message") />
                </cfif>
  
                  <!----[ ApprovedDate ]---->
                <cfif ( getApprovedDate() eq whatever )>
                    <cfset arguments.eH.setError("ApprovedDate", "ApprovedDate This is the error message") />
                </cfif>
  
                  <!----[ DateAdded ]---->
                <cfif ( getDateAdded() eq whatever )>
                    <cfset arguments.eH.setError("DateAdded", "DateAdded This is the error message") />
                </cfif>
  
                  <!----[ DateUpdated ]---->
                <cfif ( getDateUpdated() eq whatever )>
                    <cfset arguments.eH.setError("DateUpdated", "DateUpdated This is the error message") />
                </cfif>
  
                  <!----[ UpdatedBy ]---->
                <cfif ( getUpdatedBy() eq whatever )>
                    <cfset arguments.eH.setError("UpdatedBy", "UpdatedBy This is the error message") />
                </cfif>
  
                  <!----[ IsVisible ]---->
                <cfif ( getIsVisible() eq whatever )>
                    <cfset arguments.eH.setError("IsVisible", "IsVisible This is the error message") />
                </cfif>
  
                  <!----[ PageTitle ]---->
                <cfif ( getPageTitle() eq whatever )>
                    <cfset arguments.eH.setError("PageTitle", "PageTitle This is the error message") />
                </cfif>
  
   ]---->

			<cfreturn arguments.eH />
	</cffunction>

	<!---[ 	ACCESSORS 	]--->
    
      <cffunction name="setPageID" access="public" returntype="void" output="false">
            <cfargument name="PageID" type="numeric" required="true" />
            <cfset variables.instance.PageID = arguments.PageID />
	    </cffunction>
    <cffunction name="getPageID" access="public" returntype="numeric" output="false">
		   <cfreturn variables.instance.PageID />
		</cffunction>
    <cffunction name="setPageName" access="public" returntype="void" output="false">
            <cfargument name="PageName" type="string" required="true" />
            <cfset variables.instance.PageName = arguments.PageName />
	    </cffunction>
    <cffunction name="getPageName" access="public" returntype="string" output="false">
		   <cfreturn variables.instance.PageName />
		</cffunction>
        
     <cffunction name="setPageTitle" access="public" returntype="void" output="false">
            <cfargument name="PageTitle" type="string" required="true" />
            <cfset variables.instance.PageTitle = arguments.PageTitle />
	  </cffunction>
    <cffunction name="getPageTitle" access="public" returntype="string" output="false">
		   <cfreturn variables.instance.PageTitle />
		</cffunction>
         
    <cffunction name="setNodeRec" access="public" returntype="void" output="false">
            <cfargument name="NodeRec" type="Any" required="true" />
            <cfset variables.instance.NodeRec = arguments.NodeRec />
	    </cffunction>
    <cffunction name="getNodeRec" access="public" returntype="Any" output="false">
		   <cfreturn variables.instance.NodeRec />
		</cffunction>
    <cffunction name="setSiteno" access="public" returntype="void" output="false">
            <cfargument name="Siteno" type="numeric" required="true" />
            <cfset variables.instance.Siteno = arguments.Siteno />
	    </cffunction>
    <cffunction name="getSiteno" access="public" returntype="numeric" output="false">
		   <cfreturn variables.instance.Siteno />
		</cffunction>
    <cffunction name="setTemplate" access="public" returntype="void" output="false">
            <cfargument name="Template" type="string" required="true" />
            <cfset variables.instance.Template = arguments.Template />
	    </cffunction>
    <cffunction name="getTemplate" access="public" returntype="string" output="false">
		   <cfreturn variables.instance.Template />
		</cffunction>
    <cffunction name="setTeaser" access="public" returntype="void" output="false">
            <cfargument name="Teaser" type="string" required="true" />
            <cfset variables.instance.Teaser = arguments.Teaser />
	    </cffunction>
    <cffunction name="getTeaser" access="public" returntype="string" output="false">
		   <cfreturn variables.instance.Teaser />
		</cffunction>
    <cffunction name="setKeywords" access="public" returntype="void" output="false">
            <cfargument name="Keywords" type="string" required="true" />
            <cfset variables.instance.Keywords = arguments.Keywords />
	    </cffunction>
    <cffunction name="getKeywords" access="public" returntype="string" output="false">
		   <cfreturn variables.instance.Keywords />
		</cffunction>
    <cffunction name="setLive" access="public" returntype="void" output="false">
            <cfargument name="Live" type="boolean" required="true" />
            <cfset variables.instance.Live = arguments.Live />
	    </cffunction>
    <cffunction name="getLive" access="public" returntype="boolean" output="false">
		   <cfreturn variables.instance.Live />
		</cffunction>
    <cffunction name="setEmbargoed" access="public" returntype="void" output="false">
            <cfargument name="Embargoed" type="boolean" required="true" />
            <cfset variables.instance.Embargoed = arguments.Embargoed />
	    </cffunction>
    <cffunction name="getEmbargoed" access="public" returntype="boolean" output="false">
		   <cfreturn variables.instance.Embargoed />
		</cffunction>
    <cffunction name="setEmbargoDate" access="public" returntype="void" output="false">
            <cfargument name="EmbargoDate" type="date" required="true" />
            <cfset variables.instance.EmbargoDate = arguments.EmbargoDate />
	    </cffunction>
    <cffunction name="getEmbargoDate" access="public" returntype="date" output="false">
		   <cfreturn variables.instance.EmbargoDate />
		</cffunction>
    <cffunction name="setExpires" access="public" returntype="void" output="false">
            <cfargument name="Expires" type="boolean" required="true" />
            <cfset variables.instance.Expires = arguments.Expires />
	    </cffunction>
    <cffunction name="getExpires" access="public" returntype="boolean" output="false">
		   <cfreturn variables.instance.Expires />
		</cffunction>
    <cffunction name="setDateExpires" access="public" returntype="void" output="false">
            <cfargument name="DateExpires" type="date" required="true" />
            <cfset variables.instance.DateExpires = arguments.DateExpires />
	    </cffunction>
    <cffunction name="getDateExpires" access="public" returntype="date" output="false">
		   <cfreturn variables.instance.DateExpires />
		</cffunction>
    <cffunction name="setAccessLevel" access="public" returntype="void" output="false">
            <cfargument name="AccessLevel" type="numeric" required="true" />
            <cfset variables.instance.AccessLevel = arguments.AccessLevel />
	    </cffunction>
    <cffunction name="getAccessLevel" access="public" returntype="numeric" output="false">
		   <cfreturn variables.instance.AccessLevel />
		</cffunction>
    <cffunction name="setEditLevel" access="public" returntype="void" output="false">
            <cfargument name="EditLevel" type="numeric" required="true" />
            <cfset variables.instance.EditLevel = arguments.EditLevel />
	    </cffunction>
    <cffunction name="getEditLevel" access="public" returntype="numeric" output="false">
		   <cfreturn variables.instance.EditLevel />
		</cffunction>
    <cffunction name="setApproveLevel" access="public" returntype="void" output="false">
            <cfargument name="ApproveLevel" type="numeric" required="true" />
            <cfset variables.instance.ApproveLevel = arguments.ApproveLevel />
	    </cffunction>
    <cffunction name="getApproveLevel" access="public" returntype="numeric" output="false">
		   <cfreturn variables.instance.ApproveLevel />
		</cffunction>
    <cffunction name="setEditStatus" access="public" returntype="void" output="false">
            <cfargument name="EditStatus" type="string" required="true" />
            <cfset variables.instance.EditStatus = arguments.EditStatus />
	    </cffunction>
    <cffunction name="getEditStatus" access="public" returntype="string" output="false">
		   <cfreturn variables.instance.EditStatus />
		</cffunction>
    <cffunction name="setLockedForEdit" access="public" returntype="void" output="false">
            <cfargument name="LockedForEdit" type="string" required="true" />
            <cfset variables.instance.LockedForEdit = arguments.LockedForEdit />
	    </cffunction>
    <cffunction name="getLockedForEdit" access="public" returntype="string" output="false">
		   <cfreturn variables.instance.LockedForEdit />
		</cffunction>
    <cffunction name="setApprovedBy" access="public" returntype="void" output="false">
            <cfargument name="ApprovedBy" type="string" required="true" />
            <cfset variables.instance.ApprovedBy = arguments.ApprovedBy />
	    </cffunction>
    <cffunction name="getApprovedBy" access="public" returntype="string" output="false">
		   <cfreturn variables.instance.ApprovedBy />
		</cffunction>
    <cffunction name="setApprovedDate" access="public" returntype="void" output="false">
            <cfargument name="ApprovedDate" type="any" required="true" />
            <cfset variables.instance.ApprovedDate = arguments.ApprovedDate />
	    </cffunction>
    <cffunction name="getApprovedDate" access="public" returntype="any" output="false">
		   <cfreturn variables.instance.ApprovedDate />
		</cffunction>
    <cffunction name="setDateAdded" access="public" returntype="void" output="false">
            <cfargument name="DateAdded" type="date" required="true" />
            <cfset variables.instance.DateAdded = arguments.DateAdded />
	    </cffunction>
    <cffunction name="getDateAdded" access="public" returntype="date" output="false">
		   <cfreturn variables.instance.DateAdded />
		</cffunction>
    <cffunction name="setDateUpdated" access="public" returntype="void" output="false">
            <cfargument name="DateUpdated" type="date" required="true" />
            <cfset variables.instance.DateUpdated = arguments.DateUpdated />
	    </cffunction>
    <cffunction name="getDateUpdated" access="public" returntype="date" output="false">
		   <cfreturn variables.instance.DateUpdated />
		</cffunction>
    <cffunction name="setUpdatedBy" access="public" returntype="void" output="false">
            <cfargument name="UpdatedBy" type="string" required="true" />
            <cfset variables.instance.UpdatedBy = arguments.UpdatedBy />
	    </cffunction>
    <cffunction name="getUpdatedBy" access="public" returntype="string" output="false">
		   <cfreturn variables.instance.UpdatedBy />
		</cffunction>
    <cffunction name="setIsVisible" access="public" returntype="void" output="false">
            <cfargument name="IsVisible" type="boolean" required="true" />
            <cfset variables.instance.IsVisible = arguments.IsVisible />
	    </cffunction>
    <cffunction name="getIsVisible" access="public" returntype="boolean" output="false">
		   <cfreturn variables.instance.IsVisible />
		</cffunction>
       
        

</cfcomponent>