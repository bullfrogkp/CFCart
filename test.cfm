<cfoutput>
	<link rel="stylesheet" href="#SESSION.absolute_url_theme#css/ui.easytree.css">
<script type="text/javascript" src="#SESSION.absolute_url_theme#js/jquery.min.js"></script>
<script src='#SESSION.absolute_url_theme#js/jquery.easytree.min.js'></script>
<div id="demo1_menu">
       <ul>
           <li data-uiicon="ui-icon-lightbulb">First Node</li>
           <li class="grey_background"><a href="http://www.easyjstree.com" target="_blank"><span class="red green_background">Custom classes</span></a></li>
           <li class="isFolder isExpanded" title="Bookmarks">
               Folder 1
               <ul>
                   <li><img src="http://www.easyjstree.com/content/images/google.ico" style="width:32px;" /><a href="http://www.google.com" target="_blank">Go to Google.com</a></li>
                   <li><img src="http://www.easyjstree.com/content/images/yahoo.jpg" style="width:32px;" /><a href="http://www.yahoo.com" target="_blank">Go to Yahoo.com</a></li>
               </ul>
           </li>
           <li class="isExpanded" data-uiicon="ui-icon-folder-collapsed">
               Jquery icon 'ui-icon-lightbulb'
               <ul>
                   <li><img src="http://www.easyjstree.com/content/images/news.png" style="width:32px;" />Custom image</li>
                   <li data-uiicon="ui-icon-scissors">
                       Jquery icon 'ui-icon-scissors'
                       <ul>
                           <li>Sub Sub Node 1</li>
                           <li>Sub Sub Node 2</li>
                           <li>Sub Sub Node 3</li>
                           <li>Sub Sub Node 4</li>
                       </ul>
                   </li>
                   <li>Sub Node 3</li>
               </ul>
           </li>
           <li><span class="blue">Blue css style</span></li>
       </ul>
   </div>
   <script>
       $('##demo1_menu').easytree();
       function changeTheme() {
           var theme = $('##themes').val();
           var stylesheet = $('.skins');
           var href = stylesheet.attr('href');
           stylesheet.attr('href', '/content/skin-' + theme + '/ui.easytree.css');
       }
   </script>
   <style>
       .grey_background {
           background-color: ##cccccc;
       }
       .green_background {
           background-color: ##909B19;
       }
       .red {
           color: ##FF0000;
       }
       .blue {
           color: ##0000FF;
       }
   </style>
   </cfoutput>