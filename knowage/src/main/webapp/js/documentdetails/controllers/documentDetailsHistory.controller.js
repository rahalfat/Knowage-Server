/**
 * Knowage, Open Source Business Intelligence suite
 * Copyright (C) 2016 Engineering Ingegneria Informatica S.p.A.
 *
 * Knowage is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Knowage is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
(function () {
angular
        .module('DocumentDetails')
        .controller('DocumentDetailsHistoryController',[ 'DocumentService', 'resourceService', '$location', 'sbiModule_messaging', 'sbiModule_config', '$scope', 'sbiModule_translate', '$mdDialog', 'multipartForm', 'sbiModule_download',
        										function(DocumentService, resourceService, $location, sbiModule_messaging, sbiModule_config, $scope, sbiModule_translate, $mdDialog, multipartForm, sbiModule_download){

        	   var self = this;
        	   $scope.translate = sbiModule_translate;        	   
        	   self.documentService = DocumentService;
        	   self.document = DocumentService.document;
        	   self.confirmDelete = self.documentService.confirmDelete;
               self.documentInfoObject = $location.search();        	   
        	   var id = self.document.id;
               var basePath = id + "/" + 'templates';
               var resourceName = DocumentService.requiredPath;
               self.showIndented = false;               
               self.typeDocument = DocumentService.document.typeCode;               
               
               self.selectTemplate = function(template) {
                   self.selectedTemplate = template;
                   self.isJson(self.selectedTemplate);
                   self.showContent();
               }
               
               self.openMenu = function(menu, e) {
            	   e.stopPropagation();
            	   menu(e);
               }
               
               self.getTemplates = function() {
            	   resourceService.get(resourceName, basePath)
            	   .then(function(response) {            		   
            		   self.documentService.listOfTemplates = response.data;
            		   console.log(response);
            	   });
               };
               
               self.showTemplateTab = function() {
            	   if(id) {
            		   self.getTemplates();
            	   }
               };
               
               self.showTemplateTab();

               self.removeTemplateFromList = function(index) {            	              	  
             	  self.documentService.templatesForDeleting.push(self.documentService.listOfTemplates[index]);
             	  self.documentService.listOfTemplates.splice(index, 1);
               }
        	
         	self.downloadTemplate = function(template) {
         		var name = template.name;
         		var parts = name.split(".");
        		var filetype = parts[parts.length - 1];
    			var link = "/restful-services/" + resourceName + "/" + basePath + "/" + template.id + "/" + filetype + "/file";
    			sbiModule_download.getLink(link);

    		};
    		
    		self.isJson = function(template) {
    			var name = template.name;
         		var parts = name.split(".");
         		self.filetype = parts[parts.length - 1];
         		if(self.filetype=='json') {
         			self.showIndented = true;
         		} else {
         			self.showIndented = false;
         		}
    		};
    		
    		self.setActive = function(template) {
    			for(var i=0; i<self.documentService.listOfTemplates.length; i++) {
    				var temp = self.documentService.listOfTemplates[i];
    				if(temp.active == true) {
    					temp.active = false;
    				}
    			}    			
    			template.active = true;
    			self.documentService.changedTemplates = self.documentService.listOfTemplates;
    			self.document.docVersion = template.id;
    			self.documentService.changedTemplate = template;
    		}
    		
    		self.showContent = function() {    			
    			self.content = atob(self.selectedTemplate.content);
    			console.log(self.content);
    		}
    		
    		self.openTemplateDesigner = function(type) {
			$mdDialog.show({
				controller: DialogNewTemplateController,
				templateUrl: sbiModule_config.contextName+'/js/src/angular_1.4/tools/documentbrowser/template/documentDialogIframeTemplate.jsp',
				fullscreen:true,
				locals: {typeDocument: type}
			}).then(function() {
				
			})
			
			
		};
		
		function DialogNewTemplateController($scope, $mdDialog, sbiModule_config, sbiModule_translate) {			
			if(self.documentService.listOfTemplates && self.documentService.listOfTemplates.length > 0) {
				$scope.iframeUrl = sbiModule_config.contextName + "/servlet/AdapterHTTP?OBJECT_ID="+id+"&PAGE=DocumentTemplateBuildPage&MESSAGEDET=EDIT_DOCUMENT_TEMPLATE";				
			} else {
				$scope.iframeUrl = sbiModule_config.contextName + "/servlet/AdapterHTTP?OBJECT_ID="+id+"&PAGE=DocumentTemplateBuildPage&MESSAGEDET=NEW_DOCUMENT_TEMPLATE";				
			}
			
		};

     }])          
})();


