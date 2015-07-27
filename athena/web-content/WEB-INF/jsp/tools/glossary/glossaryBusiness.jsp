<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.Locale"%>
<%@page import="it.eng.spagobi.commons.utilities.urls.UrlBuilderFactory"%>
<%@page import="it.eng.spagobi.commons.utilities.urls.IUrlBuilder"%>


<%
	Locale locale = request.getLocale();
	String sbiMode = "WEB";
	IUrlBuilder urlBuilder = null;
	urlBuilder = UrlBuilderFactory.getUrlBuilder(sbiMode);
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-app="AIDA_GESTIONE-VOCABOLI">

<head>
	
	<meta http-equiv="x-ua-compatible" content="IE=EmulateIE9" >
	
	<!-- JavaScript --> 
 <!--[if IE 8]> 
 <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script> 
 <script src="http://cdnjs.cloudflare.com/ajax/libs/es5-shim/3.4.0/es5-shim.min.js"></script> 
 <![endif]--> 
	
	
	<script type="text/javascript" src="/athena/js/glossary/angular/angular.js"></script>
		<link rel="stylesheet" href="/athena/themes/glossary/css/font-awesome-4.3.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="/athena/js/glossary/angular/material_0.10.0/angular-material.min.css">
	<script type="text/javascript" src="/athena/js/glossary/angular/material_0.10.0/angular-material.js"></script>
	
	<script type="text/javascript" 	src="/athena/js/glossary/angular/angular-animate.min.js"></script>
	<script type="text/javascript" src="/athena/js/glossary/angular/angular-aria.min.js"></script>
	
	
	<link rel="stylesheet" type="text/css" href="/athena/themes/glossary/css/gestione_glossario.css">
	<link rel="stylesheet" type="text/css" href="/athena/themes/glossary/css/generalStyle.css">
	<link rel="stylesheet" 	href="/athena/js/glossary/angulartree/angular-ui-tree.min.css">
	<script type="text/javascript" src="/athena/js/glossary/angulartree/angular-ui-tree.js"></script>
	<script type="text/javascript" src="/athena/js/glossary/contextmenu/ng-context-menu.min.js"></script>
	<script type="text/javascript" src="/athena/js/glossary/pagination/dirPagination.js"></script>
	
	<%@ include file="/WEB-INF/jsp/tools/glossary/template.jsp"%>
	<%@include file="/WEB-INF/jsp/commons/includeMessageResource.jspf"%>
	<script type="text/javascript">
		var locale= '<%=request.getLocale()%>'; 
		var hostName = '<%=request.getServerName()%>';
		var serverPort ='<%=request.getServerPort()%>';
	</script>
	
	
	<script type="text/javascript" src="/athena/js/glossary/RestService.js"></script>
	<script type="text/javascript" src="/athena/js/glossary/glossary.js"></script>
	
</head>


<body class="bodyStyle">





	<div ng-controller="Controller as ctrl">
	
<!-- <md-button type="button" tabindex="-1" class="md-raised" ng-click="ctrl.prova()" >prova</md-button> -->

	

		<div class="preloader" ng-show="ctrl.showPreloader">
			<md-progress-circular class="md-hue-2" md-mode="indeterminate"></md-progress-circular>
		</div>



		<div layout="row" layout-wrap>

			<!-- 			LEFT BOX WORD -->
			<div flex="20" style="width: 20%;" class="leftBox_word" resize>


				<div layout="column" class="wordListBox" style="height: 60%;">

					<md-toolbar class="md-blue minihead ">
					<div class="md-toolbar-tools">

						<div>Word</div>
						<md-button ng-click="ctrl.createNewWord(false)"
							class="md-fab   md-ExtraMini addButton" aria-label="add word"
							style="position:absolute; right:11px;"> <md-icon
							md-font-icon="fa fa-plus"
							style="  margin-top: 6px ; color: white;"></md-icon> </md-button>
					</div>
					</md-toolbar>

					<md-content layout-padding  style="padding: 0 8px;"> 
					
					
					<md-input-container class="searchBar" md-no-float >
					<md-icon md-font-icon="fa fa-search "></md-icon> 
					<input
						ng-model="searchValue" 
						ng-keyup="ctrl.WordLike(searchValue)" type="text"
						placeholder="Search "> 
					</md-input-container> 
						
						<md-progress-circular
						md-diameter="20" ng-show="ctrl.showSearchPreloader"
						class="md-hue-2"
						style="  left: 50%;  margin-left: -25px; position:absolute "
						md-mode="indeterminate"></md-progress-circular>


					<p ng-if="ctrl.words.length==0">List Word Empty</p>


					<div id="wordTree" ng-if="ctrl.words.length>0"
						ui-tree="ctrl.TreeOptionsWord" data-drag-enabled="true"
						data-drag-delay="500" data-clone-enabled="true">

						<ol ui-tree-nodes ng-model="ctrl.words" data-nodrop-enabled="true">

							<li dir-paginate="word in ctrl.words |  itemsPerPage:	ctrl.WordItemPerPage " total-items="ctrl.totalWord" current-page="ctrl.pagination.current">

								<div ui-tree-node context-menu
									data-target="WordMenu-{{word.WORD}}">

									<div ui-tree-handle style="border: none;" >
									<i class=" dragged-icon fa fa-bars fa-2x"></i>
									
										<md-list > <md-list-item   ng-click="1==1"
											ng-repeat="n in [1]" context-menu
											data-target="WordMenu-{{word.WORD}}" class="smallListItem "
											ng-class="{ 'highlight': highlight, 'expanded' : expanded }">
										<p class="wrapText">{{ word.WORD | uppercase}}</p>
										</md-list-item> </md-list>
									</div>
								</div> <!-- 					menu contestuale -->


								<div class="dropdown position-fixed"
									style="z-index: 999; left: 10px !important"
									id="WordMenu-{{ word.WORD }}">
									<md-list class="dropdown-menu bottomBorder" role="menu"> <md-list-item 
										ng-click='ctrl.modifyWord(word)' role="menuitem" tabindex="1">
									<p>Modifica</p>
									</md-list-item> <md-list-item ng-click='ctrl.deleteWord(word)' role="menuitem" 
										tabindex="2">
									<p>Elimina</p>
									</md-list-item> 
									<md-list-item ng-click="ctrl.showInfoWORD($event,word.WORD_ID)" role="menuitem" 
										tabindex="3">
									<p>Info</p>
									</md-list-item> 
									</md-list>
								</div>

							</li>
						</ol>
					</div>

					</md-content>

					<div class="box_pagination" layout="row" layout-align="center end">
						<dir-pagination-controls max-size="5"  on-page-change="ctrl.pageChanged(newPageNumber)"></dir-pagination-controls>
					</div>

				</div>




				<!-- 				<div> -->
				<!-- 				<md-whiteframe class="md-whiteframe-z1  box_pagination" layout="row" -->
				<!-- 					layout-align="center end"> <dir-pagination-controls -->
				<!-- 					max-size="5"></dir-pagination-controls> </md-whiteframe> -->
				<!-- 				</div> -->



				<div layout="column" layout-wrap class="glossaryListBox">
					<md-toolbar class="md-blue minihead">
					<div class="md-toolbar-tools">

						<div>Glossari</div>
						<md-button ng-click="ctrl.createNewGlossary($event)"
							class="md-fab   md-ExtraMini addButton" aria-label="add word"
							style="position:absolute; right:11px;"> <md-icon
							md-font-icon="fa fa-plus "
							style="  margin-top: 6px ; color: white;"></md-icon> </md-button>
					</div>
					</md-toolbar>

					<md-content layout-padding>
					<md-list style="  width: 100%;" class="bottomBorder" > <md-list-item 
						ng-click="ctrl.showClickedGlossary(gloss);" class="smallListItem "
						ng-repeat="gloss in ctrl.glossary ">

					<div context-menu data-target="Gloss-{{ gloss.GLOSSARY_NM}}"
						ng-class="{ 'highlight': highlight, 'expanded' : expanded }"
						style="width: 100%;"
						>
						<p>{{ gloss.GLOSSARY_NM | uppercase }}</p>
					</div>

					<!-- 					menu contestuale glossario -->
					<div class="dropdown position-fixed"
						style="z-index: 999; left: 10px !important"
						id="Gloss-{{  gloss.GLOSSARY_NM }}">
						<md-list class="dropdown-menu" role="menu"> <md-list-item
							style="  height: 40px! important;"
							ng-click='ctrl.createNewGlossary($event,gloss)' role="menuitem"
							tabindex="1">
						<p>Modifica</p>
						</md-list-item> <md-list-item style="  height: 40px! important;"
							ng-click='ctrl.CloneGloss($event,gloss)' role="menuitem"
							tabindex="2">
						<p>Clona</p>
						</md-list-item> <md-list-item ng-click='ctrl.deleteGlossary(gloss)'
							style="  height: 40px! important;" role="menuitem" tabindex="3">
						<p>Elimina</p>
						</md-list-item> </md-list>
					</div>

					<!-- 						fine menu contestuale albero --> </md-list-item> </md-list>
					</md-content>
				</div>



			</div>
			
			<div flex="80" offset="20"  class="rightBox_GLOSS" >

				<!-- class="hideTabs" -->

				<md-content  >
				 <md-tabs  md-dynamic-height  class="hideTabs" md-border-bottom style="height: 100%;"> 
					<md-tab  label="Glossari"
					md-on-select="ctrl.activeTab='Glossari'"
					md-active="ctrl.activeTab=='Glossari'">
					 <md-content class="md-padding" style="padding:0px;"> 
					
				
				<div layout="row" layout-wrap>
					<div flex="100">







						<p ng-if="ctrl.selectedGloss.GLOSSARY_NM==undefined">Selezionare
							un glossario per visualizzarne la struttura</p>
							
						<div ng-if="ctrl.selectedGloss.GLOSSARY_NM!=undefined ">
								<div context-menu data-target="WordTreeRoot-{{ctrl.selectedGloss.GLOSSARY_NM}}"	>
												<p>{{ctrl.selectedGloss.GLOSSARY_NM | uppercase}}</p>
								</div>
								
								
								
								<div class="dropdown position-fixed"
									style="z-index: 999; margin-left: calc(-25% - 20px);  width: 200px;"
									id="WordTreeRoot-{{ ctrl.selectedGloss.GLOSSARY_NM }}">
									<md-list class="dropdown-menu bottomBorder" role="menu"> <md-list-item
										ng-click='ctrl.newSubItem(this,ctrl.selectedGloss)'
										role="menuitem" tabindex="1">
									<p>Aggiungi Nodo Logico</p>
									</md-list-item> <md-list-item
										ng-click='ctrl.createNewGlossary($event,ctrl.selectedGloss)'
										role="menuitem" tabindex="1">
									<p>Modifica</p>
									</md-list-item> <md-list-item
										ng-click='ctrl.CloneGloss($event,ctrl.selectedGloss)'
										role="menuitem" tabindex="2">
									<p>Clona</p>
									</md-list-item> <md-list-item
										ng-click='ctrl.deleteGlossary(ctrl.selectedGloss)'
										role="menuitem" tabindex="3">
									<p>Elimina</p>
									</md-list-item> </md-list>
								</div>

								<!-- 						fine menu contestuale albero -->

							</div>
							
							
							
						<div id="GlossTree" ng-if="ctrl.selectedGloss.GLOSSARY_NM!=undefined "
							ui-tree="ctrl.TreeOptions" data-drag-enabled="true"
							data-drag-delay="500" >
							

								<ol ui-tree-nodes="options"
									ng-model="ctrl.selectedGloss.SBI_GL_CONTENTS"
									ng-class="{hideChildren: collapsed}">
									
									<li ng-repeat="item in ctrl.selectedGloss.SBI_GL_CONTENTS"
										ui-tree-node data-collapsed="true"
										ng-include="'items_renderer.html'"></li>
											
									<li ng-if="ctrl.selectedGloss.SBI_GL_CONTENTS.length == 0 "
										ng-repeat="n in [1]" data-nodrag ui-tree-node
										class="addFiglioBox"></li>
								</ol>
							
						</div>









					</div>

				</div>
</md-content> </md-tab> <!-- 				<md-tab label="Vocabolo"> <md-content class="md-padding" -->
				<!-- 					new-word-form newWord="ctrl.newWord"> </md-content> </md-tab> </md-tabs> </md-content> -->

				<md-tab label="Vocabolo" selected="true"
					md-on-select="ctrl.activeTab='Vocabolo'"
					md-active="ctrl.activeTab=='Vocabolo'"> <md-content
					class="md-padding">


				<form name="wordForm" class="wordForm md-padding" novalidate
					ng-submit=" ctrl.newWord.DESCR.length > 0  &&  ctrl.newWord.WORD.length > 0 && ctrl.addWord(ctrl.words)">

					<div layout="row" layout-wrap>
						<div flex="100">

							<md-input-container class="md-icon-float"> <!-- Use floating label instead of placeholder -->
							<label>Word</label> <md-icon md-font-icon="fa  fa-newspaper-o "
								class="wo"></md-icon> <input ng-model="ctrl.newWord.WORD" maxlength="100"
								type="text"> </md-input-container>
						</div>
					</div>


					<div layout="row" layout-wrap>
						<div flex="100">
							<md-input-container class="md-icon-float textareaInputBox"
								ng-class="{ 'md-input-hasnt-value' : ctrl.newWord.DESCR.length === 0  }">
							<!-- Use floating label instead of placeholder --> <label>Descrizione</label>
							<md-icon md-font-icon="fa  fa-file-text-o " class="des"></md-icon>
							<textarea id="descrText" ng-model="ctrl.newWord.DESCR" columns="1"
								md-maxlength="500" maxlength="500"></textarea> </md-input-container>
						</div>
					</div>
					<div layout="row"  layout-wrap>
						<div flex="50">
							<md-input-container class="md-icon-float " > 
						<label class="selectLabel" ng-hide="ctrl.newWord.STATE==-1 || ctrl.newWord.STATE.length==0 || ctrl.newWord.STATE==undefined" >State</label>
							<md-icon md-font-icon="fa fa-spinner " class="stato"></md-icon> 
							<md-select 	placeholder="Select state" ng-model="ctrl.newWord.STATE">
								 <md-option value="-1">Select state</md-option>
								 <md-option ng-repeat="st in ctrl.state" value="{{st.VALUE_ID}}">{{ctrl.translate.load(st.VALUE_NM)}}</md-option>
							</md-select> </md-input-container>
						</div>

						<div flex="50">
							<md-input-container class="md-icon-float"> 
						<label class="selectLabel" ng-hide="ctrl.newWord.CATEGORY==-1 || ctrl.newWord.CATEGORY.length==0 || ctrl.newWord.CATEGORY==undefined" >Category</label>
						
						<md-icon md-font-icon="fa fa-flag-o " class="categoria"> </md-icon>
						<md-select
								placeholder="Select category" ng-model="ctrl.newWord.CATEGORY">
								 <md-option value="-1">Select category</md-option>
								 <md-option
								ng-repeat="ct in ctrl.category" value="{{ct.VALUE_ID}}">{{ctrl.translate.load(ct.VALUE_NM)}}</md-option>
							</md-select>
						
					
						</div>
					</div>


					<div layout="row" layout-wrap>
						<div flex="100">
							<md-input-container class="md-icon-float textareaInputBox"
								ng-class="{ 'md-input-hasnt-value' : ctrl.newWord.FORMULA.length === 0  }">
							<!-- Use floating label instead of placeholder --> <label>Formula</label>
							<md-icon md-font-icon="fa fa-superscript " class="formu"></md-icon>
							<textarea id="formulaText" ng-model="ctrl.newWord.FORMULA" columns="1"
								md-maxlength="500" maxlength="500"></textarea> </md-input-container>
						</div>
					</div>





					<div layout="row" layout-wrap>
						<div flex="100">
							<md-input-container class="md-icon-float"
								ng-class="{ 'md-input-has-value-copy' : ctrl.newWord.LINK.length > 0  }">
							<div>
								<div id="chipsTree" ui-tree="ctrl.TreeOptionsChips"
									data-drag-enabled="true" data-drag-delay="500"
									data-empty-placeholder-enabled="false" class="chipsTree">
									<ol id="olchiproot" ui-tree-nodes ng-model="ctrl.newWord.LINK"
										data-empty-placeholder-enabled="false">
										<li ng-repeat="n in [1]" data-nodrag ui-tree-node
											style="height: 0px; min-height: 0px;">

											<div class="angular-ui-tree-empty"></div>
										</li>

									</ol>
								</div>
							</div>

							<label>link</label> <md-icon md-font-icon="fa fa-link "
								class="lin"></md-icon>

							<div class="linkChips">
								<md-contact-chips ng-model="ctrl.newWord.LINK"
									md-contacts="ctrl.querySearch($query)" md-contact-name="WORD" 
									md-require-match="" filter-selected="true">
								<md-chip-template > <strong>{{$chip.WORD
									| uppercase}}</strong> </md-chip-template> </md-contact-chips>
							</div>

							</md-input-container>
						</div>
					</div>


					<div layout="row" layout-wrap>
						<div flex="5">
							<md-icon md-font-icon="fa fa-folder-o " class="stato"
								style="  margin-top: 25px;"></md-icon>

						</div>
						<div flex="40">
							<md-autocomplete style="  min-width: 0;" flex=""
								md-input-name="autocompleteField" md-no-cache="true"
								md-search-text="ctrl.tmpAttr.Prop"
								md-autoselect=true
								md-selected-item="ctrl.selectedItem"
								md-items="item in ctrl.querySearchProp(ctrl.tmpAttr.Prop)"
								md-item-text="item.ATTRIBUTE_NM" 
								md-require-match=""
								md-delay=500
								md-floating-label="ProprietÓ"> <md-item-template>
							<span md-highlight-text="ctrl.tmpAttr.Prop.toUpperCase()">{{item.ATTRIBUTE_NM | uppercase}}</span>
							</md-item-template> </md-autocomplete>
						</div>


<!-- 						<div flex="40"> -->
<!-- 							<md-input-container class="attr_Value">  -->
<!-- 							<label>Valore</label> <input ng-model="ctrl.tmpAttr.Val" maxlength="500" -->
<!-- 								type="text"> </md-input-container> -->
						
<!-- 						</div> -->
			<div flex="40">
							<md-input-container class=" attr_Value md-icon-float textareaInputBox" ng-class="{ 'md-input-hasnt-value' : ( ctrl.tmpAttr.Val.length === 0 ||ctrl.tmpAttr.Val == null)  }"> 
							<label>Valore</label> <textarea ng-model="ctrl.tmpAttr.Val" maxlength="500"
								></textarea> </md-input-container>
						
						</div>

						<div flex="15">
							<md-button
								ng-click="ctrl.tmpAttr.Prop=ctrl.selectedItem ;ctrl.addProp(ctrl.tmpAttr)"
								ng-disabled=" ctrl.tmpAttr.Prop.length==0 || ctrl.tmpAttr.Prop==null || ctrl.selectedItem==undefined || ctrl.tmpAttr.Val.length==0 || ctrl.tmpAttr.Val == null "
								class="md-fab   md-mini" aria-label="Aggiungi_Attributo">
							<md-tooltip> Aggiungi Attributo </md-tooltip> <md-icon
								md-font-icon="fa fa-plus fa-2x" style="   margin-left: 2px;"></md-icon>
							</md-button>
						</div>

					</div>

					<div layout="row" layout-wrap>



						<div flex="100">

							<md-list> <md-list-item
								class="md-2-line box-list-option"
								ng-repeat="attr in ctrl.newWord.SBI_GL_WORD_ATTR" layout="row"
								layout-wrap>
							<div class="md-item-text md-whiteframe-z1"
								 flex>
								<p class="margin5 wrapText">
									<span>{{attr.ATTRIBUTE_NM}}</span>
									<!-- 									<input class="transparent_input smallFont"	ng-model="attr.ATTRIBUTE_NM" type="text">  -->

								</p>
								
								
								<md-input-container class=" textareaInputBox"		>
								<textarea  class="attText" style="   padding-top: 0px !important; "ng-model="attr.VALUE" columns="1"
								 maxlength="500"></textarea></md-input-container>

								<md-button ng-click="ctrl.removeProp(attr)"
									class="md-fab   md-ExtraMini" aria-label="add word"
									style="    background-color: rgb(176, 190, 197) !important;
  										border-radius: 0px;
 										 position: absolute;
  											top: 0;
  											right: 0;
  											margin: 0;">
								<md-icon md-font-icon="fa fa-times" style="color: rgb(0, 0, 0);  margin-top: 5px;"></md-icon>
								</md-button>


							</div>
							</md-list-item> </md-list>

						</div>
					</div>





					<div layout="row" layout-align="end end">
						<md-button type="button" tabindex="-1" class="md-raised"
							ng-click="ctrl.createNewWord(true)" >Annulla</md-button>
						<md-button type="submit" class="md-raised"
							ng-disabled="ctrl.newWord.DESCR.length === 0  || ctrl.newWord.WORD.length === 0">Salva</md-button>
					</div>
				</form>


				</md-content> </md-tab> </md-tabs> </md-content>

			</div>

		</div>

	</div>


</body>
</html>