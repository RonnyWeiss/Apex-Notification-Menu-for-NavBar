prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_210200 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2021.10.15'
,p_release=>'21.2.5'
,p_default_workspace_id=>100000
,p_default_application_id=>103428
,p_default_id_offset=>0
,p_default_owner=>'RONNY'
);
end;
/
 
prompt APPLICATION 103428 - Ronny's Demo App
--
-- Application Export:
--   Application:     103428
--   Name:            Ronny's Demo App
--   Date and Time:   20:59 Monday March 17, 2025
--   Exported By:     RONNY
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     PLUGIN: 138285470529447569213
--   Manifest End
--   Version:         21.2.5
--   Instance ID:     900134127207897
--

begin
  -- replace components
  wwv_flow_api.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/plugins/dynamic_action/apex_notification
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(138285470529447569213)
,p_plugin_type=>'DYNAMIC ACTION'
,p_name=>'APEX.NOTIFICATION'
,p_display_name=>'APEX Notification Menu'
,p_category=>'NOTIFICATION'
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'FUNCTION F_AJAX (',
'    P_DYNAMIC_ACTION   IN APEX_PLUGIN.T_DYNAMIC_ACTION,',
'    P_PLUGIN           IN APEX_PLUGIN.T_PLUGIN',
') RETURN APEX_PLUGIN.T_DYNAMIC_ACTION_AJAX_RESULT IS',
'    VR_RESULT         APEX_PLUGIN.T_DYNAMIC_ACTION_AJAX_RESULT;',
'BEGIN',
'    APEX_UTIL.JSON_FROM_SQL( SQLQ   => P_DYNAMIC_ACTION.ATTRIBUTE_04 );',
'    RETURN VR_RESULT;',
'END;',
'',
'FUNCTION F_RENDER (',
'    P_DYNAMIC_ACTION   IN APEX_PLUGIN.T_DYNAMIC_ACTION,',
'    P_PLUGIN           IN APEX_PLUGIN.T_PLUGIN',
') RETURN APEX_PLUGIN.T_DYNAMIC_ACTION_RENDER_RESULT AS',
'    VR_RESULT         APEX_PLUGIN.T_DYNAMIC_ACTION_RENDER_RESULT;',
'    VR_REQUIRE_ESCAPE BOOLEAN := TRUE;',
'    VR_SANITIZE       BOOLEAN := TRUE;',
'BEGIN',
'    APEX_CSS.ADD_FILE(',
'        P_NAME                  => ''style.min'',',
'        P_DIRECTORY             => P_PLUGIN.FILE_PREFIX,',
'        P_VERSION               => NULL,',
'        P_KEY                   => ''noteMenuStyle''',
'    );',
'',
'    APEX_JAVASCRIPT.ADD_LIBRARY(',
'        P_NAME                  => ''purify'',',
'        P_DIRECTORY             => P_PLUGIN.FILE_PREFIX,',
'        p_check_to_add_minified => true,',
'        P_VERSION               => NULL,',
'        P_KEY                   => ''noteMenuPurifySource''',
'    );',
'',
'    APEX_JAVASCRIPT.ADD_LIBRARY(',
'        P_NAME                  => ''script'',',
'        P_DIRECTORY             => P_PLUGIN.FILE_PREFIX,',
'        p_check_to_add_minified => true,',
'        P_VERSION               => NULL,',
'        P_KEY                   => ''noteMenuJSSource''',
'    );',
'',
'    IF',
'        P_DYNAMIC_ACTION.ATTRIBUTE_05 = ''N''',
'    THEN',
'        VR_REQUIRE_ESCAPE   := FALSE;',
'    ELSE',
'        VR_REQUIRE_ESCAPE   := TRUE;',
'    END IF;',
'    ',
'    IF',
'        P_DYNAMIC_ACTION.ATTRIBUTE_06 = ''N''',
'    THEN',
'        VR_SANITIZE   := FALSE;',
'    ELSE',
'        VR_SANITIZE   := TRUE;',
'    END IF;',
'',
'    VR_RESULT.JAVASCRIPT_FUNCTION   := ''function () {',
'  notificationMenu.initialize('' ||',
'    APEX_JAVASCRIPT.ADD_VALUE( P_DYNAMIC_ACTION.ATTRIBUTE_02, TRUE ) ||',
'    APEX_JAVASCRIPT.ADD_VALUE( APEX_PLUGIN.GET_AJAX_IDENTIFIER, TRUE ) ||',
'    APEX_JAVASCRIPT.ADD_VALUE( P_DYNAMIC_ACTION.ATTRIBUTE_01, TRUE ) ||',
'    APEX_JAVASCRIPT.ADD_VALUE( APEX_PLUGIN_UTIL.PAGE_ITEM_NAMES_TO_JQUERY(P_DYNAMIC_ACTION.ATTRIBUTE_03), TRUE ) ||',
'    APEX_JAVASCRIPT.ADD_VALUE( VR_REQUIRE_ESCAPE, TRUE ) ||',
'    APEX_JAVASCRIPT.ADD_VALUE( VR_SANITIZE, TRUE ) ||',
'    APEX_JAVASCRIPT.ADD_VALUE( P_DYNAMIC_ACTION.ATTRIBUTE_07, FALSE ) ||',
'    '');}'';',
'',
'    RETURN VR_RESULT;',
'END;'))
,p_api_version=>1
,p_render_function=>'F_RENDER'
,p_ajax_function=>'F_AJAX'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'This dynamic action plugin allows to render a notification menu which gets its information through an SQL statement. It also has many configuration options and an automatic refresh (if desired). Unfortunately, it is only available with the Universal '
||'Theme 1.1 in Apex 5.1.1 or above. If you want to use it in older Themes then you have to customize the CSS style.',
'',
'To Trigger a manual refresh just create a dynmic action e.g. on button click with the action "Refresh" and set as "Affected Element" a jQuery Selector. Then enter the ID that was set as Element ID for Notification Menu.'))
,p_version_identifier=>'25.03.17'
,p_about_url=>'https://github.com/RonnyWeiss/Apex-Notification-Menu-for-NavBar'
,p_files_version=>1359
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(138285470794301569216)
,p_plugin_id=>wwv_flow_api.id(138285470529447569213)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>4
,p_prompt=>'ConfigJSON'
,p_attribute_type=>'JAVASCRIPT'
,p_is_required=>true
,p_default_value=>wwv_flow_string.join(wwv_flow_t_varchar2(
'{',
'    "refresh": 0,',
'    "mainIcon": "fa-bell",',
'    "mainIconColor": "white",',
'    "mainIconBackgroundColor": "rgba(70,70,70,0.9)",',
'    "mainIconBlinking": false,',
'    "counterBackgroundColor": "rgb(232, 55, 55 )",',
'    "counterFontColor": "white",',
'    "linkTargetBlank": false,',
'    "showAlways": false,',
'    "browserNotifications": {',
'        "enabled": true,',
'        "cutBodyTextAfter": 100,',
'        "link": false',
'    },',
'    "accept": {',
'        "color": "#44e55c",',
'        "icon": "fa-check"',
'    },',
'    "decline": {',
'        "color": "#b73a21",',
'        "icon": "fa-close"',
'    },',
'    "hideOnRefresh": true',
'}'))
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_is_translatable=>false
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<pre>',
'{',
'    "refresh": 0,',
'    "mainIcon": "fa-bell",',
'    "mainIconColor": "white",',
'    "mainIconBackgroundColor": "rgba(70,70,70,0.9)",',
'    "mainIconBlinking": false,',
'    "counterBackgroundColor": "rgb(232, 55, 55 )",',
'    "counterFontColor": "white",',
'    "linkTargetBlank": false,',
'    "showAlways": false,',
'    "browserNotifications": {',
'        "enabled": true,',
'        "cutBodyTextAfter": 100,',
'        "link": false',
'    },',
'    "accept": {',
'        "color": "#44e55c",',
'        "icon": "fa-check"',
'    },',
'    "decline": {',
'        "color": "#b73a21",',
'        "icon": "fa-close"',
'    },',
'    "hideOnRefresh": true',
'}',
'</pre>',
'<br>',
'<h3>Explanation:</h3>',
'  <dl>',
'  <dt>refresh (number)</dt>',
'  <dd>refresh time of cards in seconds if 0 then no refresh will be set</dd>',
'  <dl>',
'  <dt>mainIcon(string)</dt>',
'  <dd>icon of the menu</dd>',
'  <dl>',
'  <dt>mainIconColor(string)</dt>',
'  <dd>color of the icon e.g. #ffffff, green...</dd>',
'  <dl>',
'  <dt>counterBackgroundColor(string)</dt>',
'  <dd>color of the icon background e.g. #ffffff, green...</dd>',
'  <dl>',
'  <dt>mainIconBlinking(boolean)</dt>',
'  <dd>used to get icon blinking</dd>',
'  <dl>',
'  <dt>counterBackgroundColor(string)</dt>',
'  <dd>color of the counter background e.g. #ffffff, green...</dd>',
'  <dl>',
'  <dt>counterFontColor(string)</dt>',
'  <dd>color of the counter font color e.g. #ffffff, green...</dd>',
'  <dl>',
'  <dt>linkTargetBlank(boolean)</dt>',
'  <dd>link to target blank or not</dd>',
'  <dl>',
'  <dt>showAlways(boolean)</dt>',
'  <dd>Use to set if also shown when no notifications occured</dd>',
'  <dt>browserNotifications.enable(boolean)</dt>',
'  <dd>Use the notification API of the browser to show notifications</dd>',
'  <dt>browserNotifications.cutBodyTextAfter(number)</dt>',
'  <dd>Set max length of shown body text</dd>',
'  <dt>browserNotifications.link(boolean)</dt>',
'  <dd>set if link of node entry is directly called or if just when click on notification the browser tab is openend where notification was fired</dd>',
'  <dt>accept.color(string)</dt>',
'  <dd>color of accept icon</dd>',
'  <dt>accept.icon(string)</dt>',
'  <dd>accept icon</dd>',
'  <dt>decline.color(string)</dt>',
'  <dd>color of decline icon</dd>',
'  <dt>decline.icon(string)</dt>',
'  <dd>decline icon</dd>',
'  <dt>hideOnRefresh(boolean)</dt>',
'  <dd>Set if Notification menu should hide on Refresh.</dd>'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(138287077394138746845)
,p_plugin_id=>wwv_flow_api.id(138285470529447569213)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>3
,p_prompt=>'Element ID'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_default_value=>'notification-menu'
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(138316351893608835518)
,p_plugin_id=>wwv_flow_api.id(138285470529447569213)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>2
,p_prompt=>'Items to Submit'
,p_attribute_type=>'PAGE ITEMS'
,p_is_required=>false
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(138316363470361838483)
,p_plugin_id=>wwv_flow_api.id(138285470529447569213)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>1
,p_prompt=>'SQL Source'
,p_attribute_type=>'SQL'
,p_is_required=>true
,p_default_value=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT /* sets the icon of the list item */',
'    ''fa-exclamation-triangle'' AS NOTE_ICON, ',
'    /* sets the color of the list icon */',
'    ''rgb(192,0,15)'' AS NOTE_ICON_COLOR, ',
'    /* sets the title of the list item (html possible) */',
'    ''Alarm occurred'' AS NOTE_HEADER,',
'    /* sets the text of the list item (html possible */',
'    ''There''''s an alarm in <b>Station 3</b>. Error code is <b style="color:rgba(192,0,15);">#304-AD. </b>'' AS NOTE_TEXT, ',
'    /* set the link when click on list item */',
'    ''javascript:alert("Click on Notification Entry");void(0);'' AS NOTE_LINK, ',
'    /* sets the color of the left box shadow */',
'    ''rgb(192,0,15)'' AS NOTE_COLOR,',
'    /* Link or js that is executed when press accept link (if left or null not accept is shown */ ',
'    ''javascript:alert("Accepted");void(0);'' AS NOTE_ACCEPT,',
'    /* Link or js that is executed when press decline link (if left or null not decline is shown */ ',
'    ''javascript:alert("Declined");void(0);'' AS NOTE_DECLINE,',
'    /* When enable Browser Notifications in ConfigJSON then you can select which notifications should not be fire browser not. */',
'    0 AS NO_BROWSER_NOTIFICATION',
'FROM',
'    DUAL',
'UNION ALL',
'SELECT',
'    ''fa-wrench'' AS NOTE_ICON,',
'    ''#3e6ebc'' AS NOTE_ICON_COLOR,',
'    ''System maintenance'' AS NOTE_HEADER,',
'    ''In the time between <b>08:30</b> and <b>11:00</b> a system maintenance takes place. The systems can only be used in read-only mode and are limited in use'' AS NOTE_TEXT,',
'    ''https://apex.world'' AS NOTE_LINK,',
'    ''#3e6ebc'' AS NOTE_COLOR,',
'    NULL AS NOTE_ACCEPT,',
'    ''javascript:alert("Declined");void(0);'' AS NOTE_DECLINE,',
'    /* When enable Browser Notifications in ConfigJSON then you can select which notifications should not be fire browser not. */',
'    0 AS NO_BROWSER_NOTIFICATION',
'FROM',
'    DUAL',
'WHERE',
'    2 = ROUND(',
'        DBMS_RANDOM.VALUE(',
'            1,',
'            2',
'        )',
'    )'))
,p_sql_min_column_count=>1
,p_is_translatable=>false
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<pre>',
'SELECT /* sets the icon of the list item */',
'    ''fa-exclamation-triangle'' AS NOTE_ICON, ',
'    /* sets the color of the list icon */',
'    ''rgb(192,0,15)'' AS NOTE_ICON_COLOR, ',
'    /* sets the title of the list item (html possible) */',
'    ''Alarm occurred'' AS NOTE_HEADER,',
'    /* sets the text of the list item (html possible */',
'    ''There''''s an alarm in <b>Station 3</b>. Error code is <b style="color:rgba(192,0,15);">#304-AD. </b>'' AS NOTE_TEXT, ',
'    /* set the link when click on list item */',
'    ''javascript:alert("Click on Notification Entry");void(0);'' AS NOTE_LINK, ',
'    /* sets the color of the left box shadow */',
'    ''rgb(192,0,15)'' AS NOTE_COLOR,',
'    /* Link or js that is executed when press accept link (if left or null not accept is shown */ ',
'    ''javascript:alert("Accepted");void(0);'' AS NOTE_ACCEPT,',
'    /* Link or js that is executed when press decline link (if left or null not decline is shown */ ',
'    ''javascript:alert("Declined");void(0);'' AS NOTE_DECLINE,',
'    /* When enable Browser Notifications in ConfigJSON then you can select which notifications should not be fire browser not. */',
'    0 AS NO_BROWSER_NOTIFICATION',
'FROM',
'    DUAL',
'UNION ALL',
'SELECT',
'    ''fa-wrench'' AS NOTE_ICON,',
'    ''#3e6ebc'' AS NOTE_ICON_COLOR,',
'    ''System maintenance'' AS NOTE_HEADER,',
'    ''In the time between <b>08:30</b> and <b>11:00</b> a system maintenance takes place. The systems can only be used in read-only mode and are limited in use'' AS NOTE_TEXT,',
'    ''https://apex.world'' AS NOTE_LINK,',
'    ''#3e6ebc'' AS NOTE_COLOR,',
'    NULL AS NOTE_ACCEPT,',
'    ''javascript:alert("Declined");void(0);'' AS NOTE_DECLINE,',
'    /* When enable Browser Notifications in ConfigJSON then you can select which notifications should not be fire browser not. */',
'    0 AS NO_BROWSER_NOTIFICATION',
'FROM',
'    DUAL',
'WHERE',
'    2 = ROUND(',
'        DBMS_RANDOM.VALUE(',
'            1,',
'            2',
'        )',
'    )',
'</pre>'))
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(73265847769135965781)
,p_plugin_id=>wwv_flow_api.id(138285470529447569213)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_prompt=>'Escape special Characters'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'Y'
,p_is_translatable=>false
,p_help_text=>'This value determines whether all texts that the plug-in inserts into the page should be escaped. This is necessary if texts come from user input or insecure sources to prevent XSS.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(27540141459827422112)
,p_plugin_id=>wwv_flow_api.id(138285470529447569213)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>60
,p_prompt=>'Sanitize HTML'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'Y'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(73265847769135965781)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'NOT_EQUALS'
,p_depending_on_expression=>'Y'
,p_help_text=>'Sanitizes HTML e.g. &lt;script&gt; tags will be removed.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(27540165715862424772)
,p_plugin_id=>wwv_flow_api.id(138285470529447569213)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>7
,p_display_sequence=>70
,p_prompt=>'Sanitize HTML Options'
,p_attribute_type=>'JAVASCRIPT'
,p_is_required=>true
,p_default_value=>wwv_flow_string.join(wwv_flow_t_varchar2(
'{',
'  "ALLOWED_ATTR": [',
'    "accesskey",',
'    "align",',
'    "alt",',
'    "always",',
'    "autocomplete",',
'    "autoplay",',
'    "border",',
'    "cellpadding",',
'    "cellspacing",',
'    "charset",',
'    "class",',
'    "dir",',
'    "height",',
'    "href",',
'    "id",',
'    "lang",',
'    "name",',
'    "rel",',
'    "required",',
'    "src",',
'    "style",',
'    "summary",',
'    "tabindex",',
'    "target",',
'    "title",',
'    "type",',
'    "value",',
'    "width"',
'  ],',
'  "ALLOWED_TAGS": [',
'    "a",',
'    "address",',
'    "b",',
'    "blockquote",',
'    "br",',
'    "caption",',
'    "code",',
'    "dd",',
'    "div",',
'    "dl",',
'    "dt",',
'    "em",',
'    "figcaption",',
'    "figure",',
'    "h1",',
'    "h2",',
'    "h3",',
'    "h4",',
'    "h5",',
'    "h6",',
'    "hr",',
'    "i",',
'    "img",',
'    "label",',
'    "li",',
'    "nl",',
'    "ol",',
'    "p",',
'    "pre",',
'    "s",',
'    "span",',
'    "strike",',
'    "strong",',
'    "sub",',
'    "sup",',
'    "table",',
'    "tbody",',
'    "td",',
'    "th",',
'    "thead",',
'    "tr",',
'    "u",',
'    "ul"',
'  ]',
'}'))
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(27540141459827422112)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'Y'
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'This Clob Loader includes a sanitizer for HTML as option to use:',
'A Full Description you will find on: https://github.com/cure53/DOMPurify',
'Example: ',
'<pre>',
'{',
'  "ALLOWED_ATTR": [',
'    "accesskey",',
'    "align",',
'    "alt",',
'    "always",',
'    "autocomplete",',
'    "autoplay",',
'    "border",',
'    "cellpadding",',
'    "cellspacing",',
'    "charset",',
'    "class",',
'    "dir",',
'    "height",',
'    "href",',
'    "id",',
'    "lang",',
'    "name",',
'    "rel",',
'    "required",',
'    "src",',
'    "style",',
'    "summary",',
'    "tabindex",',
'    "target",',
'    "title",',
'    "type",',
'    "value",',
'    "width"',
'  ],',
'  "ALLOWED_TAGS": [',
'    "a",',
'    "address",',
'    "b",',
'    "blockquote",',
'    "br",',
'    "caption",',
'    "code",',
'    "dd",',
'    "div",',
'    "dl",',
'    "dt",',
'    "em",',
'    "figcaption",',
'    "figure",',
'    "h1",',
'    "h2",',
'    "h3",',
'    "h4",',
'    "h5",',
'    "h6",',
'    "hr",',
'    "i",',
'    "img",',
'    "label",',
'    "li",',
'    "nl",',
'    "ol",',
'    "p",',
'    "pre",',
'    "s",',
'    "span",',
'    "strike",',
'    "strong",',
'    "sub",',
'    "sup",',
'    "table",',
'    "tbody",',
'    "td",',
'    "th",',
'    "thead",',
'    "tr",',
'    "u",',
'    "ul"',
'  ]',
'}',
'</pre>',
'<pre>',
'# make output safe for usage in jQuery''s $()/html() method (default is false)',
'SAFE_FOR_JQUERY: true',
'',
'# strip {{ ... }} and &amp;lt;% ... %&amp;gt; to make output safe for template systems',
'# be careful please, this mode is not recommended for production usage.',
'# allowing template parsing in user-controlled HTML is not advised at all.',
'# only use this mode if there is really no alternative.',
'SAFE_FOR_TEMPLATES: true',
'',
'# allow only &amp;lt;b&amp;gt;',
'ALLOWED_TAGS: [''b'']',
'',
'# allow only &amp;lt;b&amp;gt; and &amp;lt;q&amp;gt; with style attributes (for whatever reason)',
'ALLOWED_TAGS: [''b'', ''q''], ALLOWED_ATTR: [''style'']',
'',
'# allow all safe HTML elements but neither SVG nor MathML',
'USE_PROFILES: {html: true}',
'',
'# allow all safe SVG elements and SVG Filters',
'USE_PROFILES: {svg: true, svgFilters: true}',
'',
'# allow all safe MathML elements and SVG',
'USE_PROFILES: {mathMl: true, svg: true}',
'',
'# leave all as it is but forbid &amp;lt;style&amp;gt;',
'FORBID_TAGS: [''style'']',
'',
'# leave all as it is but forbid style attributes',
'FORBID_ATTR: [''style'']',
'',
'# extend the existing array of allowed tags',
'ADD_TAGS: [''my-tag'']',
'',
'# extend the existing array of attributes',
'ADD_ATTR: [''my-attr'']',
'',
'# prohibit HTML5 data attributes (default is true)',
'ALLOW_DATA_ATTR: false',
'',
'# allow external protocol handlers in URL attributes (default is false)',
'# by default only http, https, ftp, ftps, tel, mailto, callto, cid and xmpp are allowed.',
'ALLOW_UNKNOWN_PROTOCOLS: true',
'</pre>'))
);
wwv_flow_api.create_plugin_event(
 p_id=>wwv_flow_api.id(17252763699692308273)
,p_plugin_id=>wwv_flow_api.id(138285470529447569213)
,p_name=>'refresh-apex-notification-menu'
,p_display_name=>'Refresh Notification Menu'
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '4D4954204C6963656E73650A0A436F7079726967687420286329203230323520526F6E6E792057656973730A0A5065726D697373696F6E20697320686572656279206772616E7465642C2066726565206F66206368617267652C20746F20616E79207065';
wwv_flow_api.g_varchar2_table(2) := '72736F6E206F627461696E696E67206120636F70790A6F66207468697320736F66747761726520616E64206173736F63696174656420646F63756D656E746174696F6E2066696C657320287468652022536F66747761726522292C20746F206465616C0A';
wwv_flow_api.g_varchar2_table(3) := '696E2074686520536F66747761726520776974686F7574207265737472696374696F6E2C20696E636C7564696E6720776974686F7574206C696D69746174696F6E20746865207269676874730A746F207573652C20636F70792C206D6F646966792C206D';
wwv_flow_api.g_varchar2_table(4) := '657267652C207075626C6973682C20646973747269627574652C207375626C6963656E73652C20616E642F6F722073656C6C0A636F70696573206F662074686520536F6674776172652C20616E6420746F207065726D697420706572736F6E7320746F20';
wwv_flow_api.g_varchar2_table(5) := '77686F6D2074686520536F6674776172652069730A6675726E697368656420746F20646F20736F2C207375626A65637420746F2074686520666F6C6C6F77696E6720636F6E646974696F6E733A0A0A5468652061626F766520636F70797269676874206E';
wwv_flow_api.g_varchar2_table(6) := '6F7469636520616E642074686973207065726D697373696F6E206E6F74696365207368616C6C20626520696E636C7564656420696E20616C6C0A636F70696573206F72207375627374616E7469616C20706F7274696F6E73206F662074686520536F6674';
wwv_flow_api.g_varchar2_table(7) := '776172652E0A0A54484520534F4654574152452049532050524F564944454420224153204953222C20574954484F55542057415252414E5459204F4620414E59204B494E442C2045585052455353204F520A494D504C4945442C20494E434C5544494E47';
wwv_flow_api.g_varchar2_table(8) := '20425554204E4F54204C494D4954454420544F205448452057415252414E54494553204F46204D45524348414E544142494C4954592C0A4649544E45535320464F52204120504152544943554C415220505552504F534520414E44204E4F4E494E465249';
wwv_flow_api.g_varchar2_table(9) := '4E47454D454E542E20494E204E4F204556454E54205348414C4C205448450A415554484F5253204F5220434F5059524947485420484F4C44455253204245204C4941424C4520464F5220414E5920434C41494D2C2044414D41474553204F52204F544845';
wwv_flow_api.g_varchar2_table(10) := '520A4C494142494C4954592C205748455448455220494E20414E20414354494F4E204F4620434F4E54524143542C20544F5254204F52204F54484552574953452C2041524953494E472046524F4D2C0A4F5554204F46204F5220494E20434F4E4E454354';
wwv_flow_api.g_varchar2_table(11) := '494F4E20574954482054484520534F465457415245204F522054484520555345204F52204F54484552204445414C494E475320494E205448450A534F4654574152452E0A';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(79119286782200389)
,p_plugin_id=>wwv_flow_api.id(138285470529447569213)
,p_file_name=>'LICENSE'
,p_mime_type=>'application/octet-stream'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '4C617374207570646174653A20323032302D30322D32320D0A0D0A68747470733A2F2F6769746875622E636F6D2F6375726535332F444F4D5075726966790D0A0D0A444F4D5075726966790D0A436F707972696768742032303135204D6172696F204865';
wwv_flow_api.g_varchar2_table(2) := '696465726963680D0A0D0A444F4D507572696679206973206672656520736F6674776172653B20796F752063616E2072656469737472696275746520697420616E642F6F72206D6F6469667920697420756E646572207468650D0A7465726D73206F6620';
wwv_flow_api.g_varchar2_table(3) := '6569746865723A0D0A0D0A61292074686520417061636865204C6963656E73652056657273696F6E20322E302C206F720D0A622920746865204D6F7A696C6C61205075626C6963204C6963656E73652056657273696F6E20322E300D0A0D0A2D2D2D2D2D';
wwv_flow_api.g_varchar2_table(4) := '2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D0D0A0D0A4C6963656E73656420756E64657220746865204170616368';
wwv_flow_api.g_varchar2_table(5) := '65204C6963656E73652C2056657273696F6E20322E30202874686520224C6963656E736522293B0D0A796F75206D6179206E6F742075736520746869732066696C652065786365707420696E20636F6D706C69616E6365207769746820746865204C6963';
wwv_flow_api.g_varchar2_table(6) := '656E73652E0D0A596F75206D6179206F627461696E206120636F7079206F6620746865204C6963656E73652061740D0A0D0A20202020687474703A2F2F7777772E6170616368652E6F72672F6C6963656E7365732F4C4943454E53452D322E300D0A0D0A';
wwv_flow_api.g_varchar2_table(7) := '20202020556E6C657373207265717569726564206279206170706C696361626C65206C6177206F722061677265656420746F20696E2077726974696E672C20736F6674776172650D0A20202020646973747269627574656420756E64657220746865204C';
wwv_flow_api.g_varchar2_table(8) := '6963656E7365206973206469737472696275746564206F6E20616E20224153204953222042415349532C0D0A20202020574954484F55542057415252414E54494553204F5220434F4E444954494F4E53204F4620414E59204B494E442C20656974686572';
wwv_flow_api.g_varchar2_table(9) := '2065787072657373206F7220696D706C6965642E0D0A2020202053656520746865204C6963656E736520666F7220746865207370656369666963206C616E677561676520676F7665726E696E67207065726D697373696F6E7320616E640D0A202020206C';
wwv_flow_api.g_varchar2_table(10) := '696D69746174696F6E7320756E64657220746865204C6963656E73652E0D0A0D0A2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2D';
wwv_flow_api.g_varchar2_table(11) := '2D2D2D2D2D2D2D2D2D2D0D0A4D6F7A696C6C61205075626C6963204C6963656E73652C2076657273696F6E20322E300D0A0D0A312E20446566696E6974696F6E730D0A0D0A312E312E2093436F6E7472696275746F72940D0A0D0A20202020206D65616E';
wwv_flow_api.g_varchar2_table(12) := '73206561636820696E646976696475616C206F72206C6567616C20656E74697479207468617420637265617465732C20636F6E747269627574657320746F207468650D0A20202020206372656174696F6E206F662C206F72206F776E7320436F76657265';
wwv_flow_api.g_varchar2_table(13) := '6420536F6674776172652E0D0A0D0A312E322E2093436F6E7472696275746F722056657273696F6E940D0A0D0A20202020206D65616E732074686520636F6D62696E6174696F6E206F662074686520436F6E747269627574696F6E73206F66206F746865';
wwv_flow_api.g_varchar2_table(14) := '72732028696620616E7929207573656420627920610D0A2020202020436F6E7472696275746F7220616E64207468617420706172746963756C617220436F6E7472696275746F72927320436F6E747269627574696F6E2E0D0A0D0A312E332E2093436F6E';
wwv_flow_api.g_varchar2_table(15) := '747269627574696F6E940D0A0D0A20202020206D65616E7320436F766572656420536F667477617265206F66206120706172746963756C617220436F6E7472696275746F722E0D0A0D0A312E342E2093436F766572656420536F667477617265940D0A0D';
wwv_flow_api.g_varchar2_table(16) := '0A20202020206D65616E7320536F7572636520436F646520466F726D20746F2077686963682074686520696E697469616C20436F6E7472696275746F7220686173206174746163686564207468650D0A20202020206E6F7469636520696E204578686962';
wwv_flow_api.g_varchar2_table(17) := '697420412C207468652045786563757461626C6520466F726D206F66207375636820536F7572636520436F646520466F726D2C20616E640D0A20202020204D6F64696669636174696F6E73206F66207375636820536F7572636520436F646520466F726D';
wwv_flow_api.g_varchar2_table(18) := '2C20696E2065616368206361736520696E636C7564696E6720706F7274696F6E730D0A202020202074686572656F662E0D0A0D0A312E352E2093496E636F6D70617469626C652057697468205365636F6E64617279204C6963656E736573940D0A202020';
wwv_flow_api.g_varchar2_table(19) := '20206D65616E730D0A0D0A2020202020612E20746861742074686520696E697469616C20436F6E7472696275746F722068617320617474616368656420746865206E6F746963652064657363726962656420696E0D0A2020202020202020457868696269';
wwv_flow_api.g_varchar2_table(20) := '74204220746F2074686520436F766572656420536F6674776172653B206F720D0A0D0A2020202020622E20746861742074686520436F766572656420536F66747761726520776173206D61646520617661696C61626C6520756E64657220746865207465';
wwv_flow_api.g_varchar2_table(21) := '726D73206F662076657273696F6E0D0A2020202020202020312E31206F72206561726C696572206F6620746865204C6963656E73652C20627574206E6F7420616C736F20756E64657220746865207465726D73206F6620610D0A20202020202020205365';
wwv_flow_api.g_varchar2_table(22) := '636F6E64617279204C6963656E73652E0D0A0D0A312E362E209345786563757461626C6520466F726D940D0A0D0A20202020206D65616E7320616E7920666F726D206F662074686520776F726B206F74686572207468616E20536F7572636520436F6465';
wwv_flow_api.g_varchar2_table(23) := '20466F726D2E0D0A0D0A312E372E20934C617267657220576F726B940D0A0D0A20202020206D65616E73206120776F726B207468617420636F6D62696E657320436F766572656420536F6674776172652077697468206F74686572206D6174657269616C';
wwv_flow_api.g_varchar2_table(24) := '2C20696E20612073657061726174650D0A202020202066696C65206F722066696C65732C2074686174206973206E6F7420436F766572656420536F6674776172652E0D0A0D0A312E382E20934C6963656E7365940D0A0D0A20202020206D65616E732074';
wwv_flow_api.g_varchar2_table(25) := '68697320646F63756D656E742E0D0A0D0A312E392E20934C6963656E7361626C65940D0A0D0A20202020206D65616E7320686176696E672074686520726967687420746F206772616E742C20746F20746865206D6178696D756D20657874656E7420706F';
wwv_flow_api.g_varchar2_table(26) := '737369626C652C2077686574686572206174207468650D0A202020202074696D65206F662074686520696E697469616C206772616E74206F722073756273657175656E746C792C20616E7920616E6420616C6C206F66207468652072696768747320636F';
wwv_flow_api.g_varchar2_table(27) := '6E76657965642062790D0A202020202074686973204C6963656E73652E0D0A0D0A312E31302E20934D6F64696669636174696F6E73940D0A0D0A20202020206D65616E7320616E79206F662074686520666F6C6C6F77696E673A0D0A0D0A202020202061';
wwv_flow_api.g_varchar2_table(28) := '2E20616E792066696C6520696E20536F7572636520436F646520466F726D207468617420726573756C74732066726F6D20616E206164646974696F6E20746F2C2064656C6574696F6E0D0A202020202020202066726F6D2C206F72206D6F646966696361';
wwv_flow_api.g_varchar2_table(29) := '74696F6E206F662074686520636F6E74656E7473206F6620436F766572656420536F6674776172653B206F720D0A0D0A2020202020622E20616E79206E65772066696C6520696E20536F7572636520436F646520466F726D207468617420636F6E746169';
wwv_flow_api.g_varchar2_table(30) := '6E7320616E7920436F766572656420536F6674776172652E0D0A0D0A312E31312E2093506174656E7420436C61696D7394206F66206120436F6E7472696275746F720D0A0D0A2020202020206D65616E7320616E7920706174656E7420636C61696D2873';
wwv_flow_api.g_varchar2_table(31) := '292C20696E636C7564696E6720776974686F7574206C696D69746174696F6E2C206D6574686F642C2070726F636573732C0D0A202020202020616E642061707061726174757320636C61696D732C20696E20616E7920706174656E74204C6963656E7361';
wwv_flow_api.g_varchar2_table(32) := '626C65206279207375636820436F6E7472696275746F7220746861740D0A202020202020776F756C6420626520696E6672696E6765642C2062757420666F7220746865206772616E74206F6620746865204C6963656E73652C20627920746865206D616B';
wwv_flow_api.g_varchar2_table(33) := '696E672C0D0A2020202020207573696E672C2073656C6C696E672C206F66666572696E6720666F722073616C652C20686176696E67206D6164652C20696D706F72742C206F72207472616E73666572206F660D0A20202020202065697468657220697473';
wwv_flow_api.g_varchar2_table(34) := '20436F6E747269627574696F6E73206F722069747320436F6E7472696275746F722056657273696F6E2E0D0A0D0A312E31322E20935365636F6E64617279204C6963656E7365940D0A0D0A2020202020206D65616E73206569746865722074686520474E';
wwv_flow_api.g_varchar2_table(35) := '552047656E6572616C205075626C6963204C6963656E73652C2056657273696F6E20322E302C2074686520474E55204C65737365720D0A20202020202047656E6572616C205075626C6963204C6963656E73652C2056657273696F6E20322E312C207468';
wwv_flow_api.g_varchar2_table(36) := '6520474E552041666665726F2047656E6572616C205075626C69630D0A2020202020204C6963656E73652C2056657273696F6E20332E302C206F7220616E79206C617465722076657273696F6E73206F662074686F7365206C6963656E7365732E0D0A0D';
wwv_flow_api.g_varchar2_table(37) := '0A312E31332E2093536F7572636520436F646520466F726D940D0A0D0A2020202020206D65616E732074686520666F726D206F662074686520776F726B2070726566657272656420666F72206D616B696E67206D6F64696669636174696F6E732E0D0A0D';
wwv_flow_api.g_varchar2_table(38) := '0A312E31342E2093596F759420286F722093596F757294290D0A0D0A2020202020206D65616E7320616E20696E646976696475616C206F722061206C6567616C20656E746974792065786572636973696E672072696768747320756E6465722074686973';
wwv_flow_api.g_varchar2_table(39) := '0D0A2020202020204C6963656E73652E20466F72206C6567616C20656E7469746965732C2093596F759420696E636C7564657320616E7920656E74697479207468617420636F6E74726F6C732C2069730D0A202020202020636F6E74726F6C6C65642062';
wwv_flow_api.g_varchar2_table(40) := '792C206F7220697320756E64657220636F6D6D6F6E20636F6E74726F6C207769746820596F752E20466F7220707572706F736573206F6620746869730D0A202020202020646566696E6974696F6E2C2093636F6E74726F6C94206D65616E732028612920';
wwv_flow_api.g_varchar2_table(41) := '74686520706F7765722C20646972656374206F7220696E6469726563742C20746F2063617573650D0A20202020202074686520646972656374696F6E206F72206D616E6167656D656E74206F66207375636820656E746974792C20776865746865722062';
wwv_flow_api.g_varchar2_table(42) := '7920636F6E7472616374206F720D0A2020202020206F74686572776973652C206F7220286229206F776E657273686970206F66206D6F7265207468616E2066696674792070657263656E74202835302529206F66207468650D0A2020202020206F757473';
wwv_flow_api.g_varchar2_table(43) := '74616E64696E6720736861726573206F722062656E6566696369616C206F776E657273686970206F66207375636820656E746974792E0D0A0D0A0D0A322E204C6963656E7365204772616E747320616E6420436F6E646974696F6E730D0A0D0A322E312E';
wwv_flow_api.g_varchar2_table(44) := '204772616E74730D0A0D0A20202020204561636820436F6E7472696275746F7220686572656279206772616E747320596F75206120776F726C642D776964652C20726F79616C74792D667265652C0D0A20202020206E6F6E2D6578636C7573697665206C';
wwv_flow_api.g_varchar2_table(45) := '6963656E73653A0D0A0D0A2020202020612E20756E64657220696E74656C6C65637475616C2070726F70657274792072696768747320286F74686572207468616E20706174656E74206F722074726164656D61726B290D0A20202020202020204C696365';
wwv_flow_api.g_varchar2_table(46) := '6E7361626C65206279207375636820436F6E7472696275746F7220746F207573652C20726570726F647563652C206D616B6520617661696C61626C652C0D0A20202020202020206D6F646966792C20646973706C61792C20706572666F726D2C20646973';
wwv_flow_api.g_varchar2_table(47) := '747269627574652C20616E64206F7468657277697365206578706C6F6974206974730D0A2020202020202020436F6E747269627574696F6E732C20656974686572206F6E20616E20756E6D6F6469666965642062617369732C2077697468204D6F646966';
wwv_flow_api.g_varchar2_table(48) := '69636174696F6E732C206F722061730D0A202020202020202070617274206F662061204C617267657220576F726B3B20616E640D0A0D0A2020202020622E20756E64657220506174656E7420436C61696D73206F66207375636820436F6E747269627574';
wwv_flow_api.g_varchar2_table(49) := '6F7220746F206D616B652C207573652C2073656C6C2C206F6666657220666F720D0A202020202020202073616C652C2068617665206D6164652C20696D706F72742C20616E64206F7468657277697365207472616E736665722065697468657220697473';
wwv_flow_api.g_varchar2_table(50) := '20436F6E747269627574696F6E730D0A20202020202020206F722069747320436F6E7472696275746F722056657273696F6E2E0D0A0D0A322E322E2045666665637469766520446174650D0A0D0A2020202020546865206C6963656E736573206772616E';
wwv_flow_api.g_varchar2_table(51) := '74656420696E2053656374696F6E20322E312077697468207265737065637420746F20616E7920436F6E747269627574696F6E206265636F6D650D0A202020202065666665637469766520666F72206561636820436F6E747269627574696F6E206F6E20';
wwv_flow_api.g_varchar2_table(52) := '74686520646174652074686520436F6E7472696275746F722066697273742064697374726962757465730D0A20202020207375636820436F6E747269627574696F6E2E0D0A0D0A322E332E204C696D69746174696F6E73206F6E204772616E742053636F';
wwv_flow_api.g_varchar2_table(53) := '70650D0A0D0A2020202020546865206C6963656E736573206772616E74656420696E20746869732053656374696F6E20322061726520746865206F6E6C7920726967687473206772616E74656420756E64657220746869730D0A20202020204C6963656E';
wwv_flow_api.g_varchar2_table(54) := '73652E204E6F206164646974696F6E616C20726967687473206F72206C6963656E7365732077696C6C20626520696D706C6965642066726F6D2074686520646973747269627574696F6E0D0A20202020206F72206C6963656E73696E67206F6620436F76';
wwv_flow_api.g_varchar2_table(55) := '6572656420536F66747761726520756E6465722074686973204C6963656E73652E204E6F74776974687374616E64696E672053656374696F6E0D0A2020202020322E312862292061626F76652C206E6F20706174656E74206C6963656E73652069732067';
wwv_flow_api.g_varchar2_table(56) := '72616E746564206279206120436F6E7472696275746F723A0D0A0D0A2020202020612E20666F7220616E7920636F64652074686174206120436F6E7472696275746F72206861732072656D6F7665642066726F6D20436F766572656420536F6674776172';
wwv_flow_api.g_varchar2_table(57) := '653B206F720D0A0D0A2020202020622E20666F7220696E6672696E67656D656E7473206361757365642062793A2028692920596F757220616E6420616E79206F7468657220746869726420706172747992730D0A20202020202020206D6F646966696361';
wwv_flow_api.g_varchar2_table(58) := '74696F6E73206F6620436F766572656420536F6674776172652C206F7220286969292074686520636F6D62696E6174696F6E206F66206974730D0A2020202020202020436F6E747269627574696F6E732077697468206F7468657220736F667477617265';
wwv_flow_api.g_varchar2_table(59) := '20286578636570742061732070617274206F662069747320436F6E7472696275746F720D0A202020202020202056657273696F6E293B206F720D0A0D0A2020202020632E20756E64657220506174656E7420436C61696D7320696E6672696E6765642062';
wwv_flow_api.g_varchar2_table(60) := '7920436F766572656420536F66747761726520696E2074686520616273656E6365206F66206974730D0A2020202020202020436F6E747269627574696F6E732E0D0A0D0A202020202054686973204C6963656E736520646F6573206E6F74206772616E74';
wwv_flow_api.g_varchar2_table(61) := '20616E792072696768747320696E207468652074726164656D61726B732C2073657276696365206D61726B732C206F720D0A20202020206C6F676F73206F6620616E7920436F6E7472696275746F722028657863657074206173206D6179206265206E65';
wwv_flow_api.g_varchar2_table(62) := '6365737361727920746F20636F6D706C792077697468207468650D0A20202020206E6F7469636520726571756972656D656E747320696E2053656374696F6E20332E34292E0D0A0D0A322E342E2053756273657175656E74204C6963656E7365730D0A0D';
wwv_flow_api.g_varchar2_table(63) := '0A20202020204E6F20436F6E7472696275746F72206D616B6573206164646974696F6E616C206772616E7473206173206120726573756C74206F6620596F75722063686F69636520746F0D0A2020202020646973747269627574652074686520436F7665';
wwv_flow_api.g_varchar2_table(64) := '72656420536F66747761726520756E64657220612073756273657175656E742076657273696F6E206F662074686973204C6963656E73650D0A2020202020287365652053656374696F6E2031302E3229206F7220756E64657220746865207465726D7320';
wwv_flow_api.g_varchar2_table(65) := '6F662061205365636F6E64617279204C6963656E736520286966207065726D69747465640D0A2020202020756E64657220746865207465726D73206F662053656374696F6E20332E33292E0D0A0D0A322E352E20526570726573656E746174696F6E0D0A';
wwv_flow_api.g_varchar2_table(66) := '0D0A20202020204561636820436F6E7472696275746F7220726570726573656E747320746861742074686520436F6E7472696275746F722062656C69657665732069747320436F6E747269627574696F6E730D0A202020202061726520697473206F7269';
wwv_flow_api.g_varchar2_table(67) := '67696E616C206372656174696F6E287329206F72206974206861732073756666696369656E742072696768747320746F206772616E74207468650D0A202020202072696768747320746F2069747320436F6E747269627574696F6E7320636F6E76657965';
wwv_flow_api.g_varchar2_table(68) := '642062792074686973204C6963656E73652E0D0A0D0A322E362E2046616972205573650D0A0D0A202020202054686973204C6963656E7365206973206E6F7420696E74656E64656420746F206C696D697420616E792072696768747320596F7520686176';
wwv_flow_api.g_varchar2_table(69) := '6520756E646572206170706C696361626C650D0A2020202020636F7079726967687420646F637472696E6573206F662066616972207573652C2066616972206465616C696E672C206F72206F74686572206571756976616C656E74732E0D0A0D0A322E37';
wwv_flow_api.g_varchar2_table(70) := '2E20436F6E646974696F6E730D0A0D0A202020202053656374696F6E7320332E312C20332E322C20332E332C20616E6420332E342061726520636F6E646974696F6E73206F6620746865206C6963656E736573206772616E74656420696E0D0A20202020';
wwv_flow_api.g_varchar2_table(71) := '2053656374696F6E20322E312E0D0A0D0A0D0A332E20526573706F6E736962696C69746965730D0A0D0A332E312E20446973747269627574696F6E206F6620536F7572636520466F726D0D0A0D0A2020202020416C6C20646973747269627574696F6E20';
wwv_flow_api.g_varchar2_table(72) := '6F6620436F766572656420536F66747761726520696E20536F7572636520436F646520466F726D2C20696E636C7564696E6720616E790D0A20202020204D6F64696669636174696F6E73207468617420596F7520637265617465206F7220746F20776869';
wwv_flow_api.g_varchar2_table(73) := '636820596F7520636F6E747269627574652C206D75737420626520756E646572207468650D0A20202020207465726D73206F662074686973204C6963656E73652E20596F75206D75737420696E666F726D20726563697069656E74732074686174207468';
wwv_flow_api.g_varchar2_table(74) := '6520536F7572636520436F646520466F726D0D0A20202020206F662074686520436F766572656420536F66747761726520697320676F7665726E656420627920746865207465726D73206F662074686973204C6963656E73652C20616E6420686F770D0A';
wwv_flow_api.g_varchar2_table(75) := '2020202020746865792063616E206F627461696E206120636F7079206F662074686973204C6963656E73652E20596F75206D6179206E6F7420617474656D707420746F20616C746572206F720D0A20202020207265737472696374207468652072656369';
wwv_flow_api.g_varchar2_table(76) := '7069656E7473922072696768747320696E2074686520536F7572636520436F646520466F726D2E0D0A0D0A332E322E20446973747269627574696F6E206F662045786563757461626C6520466F726D0D0A0D0A2020202020496620596F75206469737472';
wwv_flow_api.g_varchar2_table(77) := '696275746520436F766572656420536F66747761726520696E2045786563757461626C6520466F726D207468656E3A0D0A0D0A2020202020612E207375636820436F766572656420536F667477617265206D75737420616C736F206265206D6164652061';
wwv_flow_api.g_varchar2_table(78) := '7661696C61626C6520696E20536F7572636520436F646520466F726D2C0D0A202020202020202061732064657363726962656420696E2053656374696F6E20332E312C20616E6420596F75206D75737420696E666F726D20726563697069656E7473206F';
wwv_flow_api.g_varchar2_table(79) := '66207468650D0A202020202020202045786563757461626C6520466F726D20686F7720746865792063616E206F627461696E206120636F7079206F66207375636820536F7572636520436F646520466F726D2062790D0A2020202020202020726561736F';
wwv_flow_api.g_varchar2_table(80) := '6E61626C65206D65616E7320696E20612074696D656C79206D616E6E65722C206174206120636861726765206E6F206D6F7265207468616E2074686520636F73740D0A20202020202020206F6620646973747269627574696F6E20746F20746865207265';
wwv_flow_api.g_varchar2_table(81) := '63697069656E743B20616E640D0A0D0A2020202020622E20596F75206D6179206469737472696275746520737563682045786563757461626C6520466F726D20756E64657220746865207465726D73206F662074686973204C6963656E73652C0D0A2020';
wwv_flow_api.g_varchar2_table(82) := '2020202020206F72207375626C6963656E736520697420756E64657220646966666572656E74207465726D732C2070726F7669646564207468617420746865206C6963656E736520666F720D0A20202020202020207468652045786563757461626C6520';
wwv_flow_api.g_varchar2_table(83) := '466F726D20646F6573206E6F7420617474656D707420746F206C696D6974206F7220616C7465722074686520726563697069656E7473920D0A202020202020202072696768747320696E2074686520536F7572636520436F646520466F726D20756E6465';
wwv_flow_api.g_varchar2_table(84) := '722074686973204C6963656E73652E0D0A0D0A332E332E20446973747269627574696F6E206F662061204C617267657220576F726B0D0A0D0A2020202020596F75206D61792063726561746520616E6420646973747269627574652061204C6172676572';
wwv_flow_api.g_varchar2_table(85) := '20576F726B20756E646572207465726D73206F6620596F75722063686F6963652C0D0A202020202070726F7669646564207468617420596F7520616C736F20636F6D706C7920776974682074686520726571756972656D656E7473206F66207468697320';
wwv_flow_api.g_varchar2_table(86) := '4C6963656E736520666F72207468650D0A2020202020436F766572656420536F6674776172652E20496620746865204C617267657220576F726B206973206120636F6D62696E6174696F6E206F6620436F766572656420536F6674776172650D0A202020';
wwv_flow_api.g_varchar2_table(87) := '202077697468206120776F726B20676F7665726E6564206279206F6E65206F72206D6F7265205365636F6E64617279204C6963656E7365732C20616E642074686520436F76657265640D0A2020202020536F667477617265206973206E6F7420496E636F';
wwv_flow_api.g_varchar2_table(88) := '6D70617469626C652057697468205365636F6E64617279204C6963656E7365732C2074686973204C6963656E7365207065726D6974730D0A2020202020596F7520746F206164646974696F6E616C6C792064697374726962757465207375636820436F76';
wwv_flow_api.g_varchar2_table(89) := '6572656420536F66747761726520756E64657220746865207465726D73206F660D0A202020202073756368205365636F6E64617279204C6963656E73652873292C20736F20746861742074686520726563697069656E74206F6620746865204C61726765';
wwv_flow_api.g_varchar2_table(90) := '7220576F726B206D61792C2061740D0A20202020207468656972206F7074696F6E2C206675727468657220646973747269627574652074686520436F766572656420536F66747761726520756E64657220746865207465726D73206F660D0A2020202020';
wwv_flow_api.g_varchar2_table(91) := '6569746865722074686973204C6963656E7365206F722073756368205365636F6E64617279204C6963656E73652873292E0D0A0D0A332E342E204E6F74696365730D0A0D0A2020202020596F75206D6179206E6F742072656D6F7665206F7220616C7465';
wwv_flow_api.g_varchar2_table(92) := '7220746865207375627374616E6365206F6620616E79206C6963656E7365206E6F74696365732028696E636C7564696E670D0A2020202020636F70797269676874206E6F74696365732C20706174656E74206E6F74696365732C20646973636C61696D65';
wwv_flow_api.g_varchar2_table(93) := '7273206F662077617272616E74792C206F72206C696D69746174696F6E730D0A20202020206F66206C696162696C6974792920636F6E7461696E65642077697468696E2074686520536F7572636520436F646520466F726D206F662074686520436F7665';
wwv_flow_api.g_varchar2_table(94) := '7265640D0A2020202020536F6674776172652C20657863657074207468617420596F75206D617920616C74657220616E79206C6963656E7365206E6F746963657320746F2074686520657874656E740D0A2020202020726571756972656420746F207265';
wwv_flow_api.g_varchar2_table(95) := '6D656479206B6E6F776E206661637475616C20696E616363757261636965732E0D0A0D0A332E352E204170706C69636174696F6E206F66204164646974696F6E616C205465726D730D0A0D0A2020202020596F75206D61792063686F6F736520746F206F';
wwv_flow_api.g_varchar2_table(96) := '666665722C20616E6420746F2063686172676520612066656520666F722C2077617272616E74792C20737570706F72742C0D0A2020202020696E64656D6E697479206F72206C696162696C697479206F626C69676174696F6E7320746F206F6E65206F72';
wwv_flow_api.g_varchar2_table(97) := '206D6F726520726563697069656E7473206F6620436F76657265640D0A2020202020536F6674776172652E20486F77657665722C20596F75206D617920646F20736F206F6E6C79206F6E20596F7572206F776E20626568616C662C20616E64206E6F7420';
wwv_flow_api.g_varchar2_table(98) := '6F6E20626568616C660D0A20202020206F6620616E7920436F6E7472696275746F722E20596F75206D757374206D616B65206974206162736F6C7574656C7920636C656172207468617420616E7920737563680D0A202020202077617272616E74792C20';
wwv_flow_api.g_varchar2_table(99) := '737570706F72742C20696E64656D6E6974792C206F72206C696162696C697479206F626C69676174696F6E206973206F66666572656420627920596F750D0A2020202020616C6F6E652C20616E6420596F752068657265627920616772656520746F2069';
wwv_flow_api.g_varchar2_table(100) := '6E64656D6E69667920657665727920436F6E7472696275746F7220666F7220616E790D0A20202020206C696162696C69747920696E637572726564206279207375636820436F6E7472696275746F72206173206120726573756C74206F66207761727261';
wwv_flow_api.g_varchar2_table(101) := '6E74792C20737570706F72742C0D0A2020202020696E64656D6E697479206F72206C696162696C697479207465726D7320596F75206F666665722E20596F75206D617920696E636C756465206164646974696F6E616C0D0A2020202020646973636C6169';
wwv_flow_api.g_varchar2_table(102) := '6D657273206F662077617272616E747920616E64206C696D69746174696F6E73206F66206C696162696C69747920737065636966696320746F20616E790D0A20202020206A7572697364696374696F6E2E0D0A0D0A342E20496E6162696C69747920746F';
wwv_flow_api.g_varchar2_table(103) := '20436F6D706C792044756520746F2053746174757465206F7220526567756C6174696F6E0D0A0D0A202020496620697420697320696D706F737369626C6520666F7220596F7520746F20636F6D706C79207769746820616E79206F662074686520746572';
wwv_flow_api.g_varchar2_table(104) := '6D73206F662074686973204C6963656E73650D0A20202077697468207265737065637420746F20736F6D65206F7220616C6C206F662074686520436F766572656420536F6674776172652064756520746F20737461747574652C206A7564696369616C0D';
wwv_flow_api.g_varchar2_table(105) := '0A2020206F726465722C206F7220726567756C6174696F6E207468656E20596F75206D7573743A2028612920636F6D706C79207769746820746865207465726D73206F662074686973204C6963656E73650D0A202020746F20746865206D6178696D756D';
wwv_flow_api.g_varchar2_table(106) := '20657874656E7420706F737369626C653B20616E642028622920646573637269626520746865206C696D69746174696F6E7320616E642074686520636F64650D0A20202074686579206166666563742E2053756368206465736372697074696F6E206D75';
wwv_flow_api.g_varchar2_table(107) := '737420626520706C6163656420696E206120746578742066696C6520696E636C75646564207769746820616C6C0D0A202020646973747269627574696F6E73206F662074686520436F766572656420536F66747761726520756E6465722074686973204C';
wwv_flow_api.g_varchar2_table(108) := '6963656E73652E2045786365707420746F207468650D0A202020657874656E742070726F686962697465642062792073746174757465206F7220726567756C6174696F6E2C2073756368206465736372697074696F6E206D7573742062650D0A20202073';
wwv_flow_api.g_varchar2_table(109) := '756666696369656E746C792064657461696C656420666F72206120726563697069656E74206F66206F7264696E61727920736B696C6C20746F2062652061626C6520746F0D0A202020756E6465727374616E642069742E0D0A0D0A352E205465726D696E';
wwv_flow_api.g_varchar2_table(110) := '6174696F6E0D0A0D0A352E312E2054686520726967687473206772616E74656420756E6465722074686973204C6963656E73652077696C6C207465726D696E617465206175746F6D61746963616C6C7920696620596F750D0A20202020206661696C2074';
wwv_flow_api.g_varchar2_table(111) := '6F20636F6D706C79207769746820616E79206F6620697473207465726D732E20486F77657665722C20696620596F75206265636F6D6520636F6D706C69616E742C0D0A20202020207468656E2074686520726967687473206772616E74656420756E6465';
wwv_flow_api.g_varchar2_table(112) := '722074686973204C6963656E73652066726F6D206120706172746963756C617220436F6E7472696275746F720D0A2020202020617265207265696E737461746564202861292070726F766973696F6E616C6C792C20756E6C65737320616E6420756E7469';
wwv_flow_api.g_varchar2_table(113) := '6C207375636820436F6E7472696275746F720D0A20202020206578706C696369746C7920616E642066696E616C6C79207465726D696E6174657320596F7572206772616E74732C20616E6420286229206F6E20616E206F6E676F696E672062617369732C';
wwv_flow_api.g_varchar2_table(114) := '0D0A20202020206966207375636820436F6E7472696275746F72206661696C7320746F206E6F7469667920596F75206F6620746865206E6F6E2D636F6D706C69616E636520627920736F6D650D0A2020202020726561736F6E61626C65206D65616E7320';
wwv_flow_api.g_varchar2_table(115) := '7072696F7220746F203630206461797320616674657220596F75206861766520636F6D65206261636B20696E746F20636F6D706C69616E63652E0D0A20202020204D6F72656F7665722C20596F7572206772616E74732066726F6D206120706172746963';
wwv_flow_api.g_varchar2_table(116) := '756C617220436F6E7472696275746F7220617265207265696E737461746564206F6E20616E0D0A20202020206F6E676F696E67206261736973206966207375636820436F6E7472696275746F72206E6F74696669657320596F75206F6620746865206E6F';
wwv_flow_api.g_varchar2_table(117) := '6E2D636F6D706C69616E63652062790D0A2020202020736F6D6520726561736F6E61626C65206D65616E732C2074686973206973207468652066697273742074696D6520596F752068617665207265636569766564206E6F74696365206F660D0A202020';
wwv_flow_api.g_varchar2_table(118) := '20206E6F6E2D636F6D706C69616E636520776974682074686973204C6963656E73652066726F6D207375636820436F6E7472696275746F722C20616E6420596F75206265636F6D650D0A2020202020636F6D706C69616E74207072696F7220746F203330';
wwv_flow_api.g_varchar2_table(119) := '206461797320616674657220596F75722072656365697074206F6620746865206E6F746963652E0D0A0D0A352E322E20496620596F7520696E697469617465206C697469676174696F6E20616761696E737420616E7920656E7469747920627920617373';
wwv_flow_api.g_varchar2_table(120) := '657274696E67206120706174656E740D0A2020202020696E6672696E67656D656E7420636C61696D20286578636C7564696E67206465636C617261746F7279206A7564676D656E7420616374696F6E732C20636F756E7465722D636C61696D732C0D0A20';
wwv_flow_api.g_varchar2_table(121) := '20202020616E642063726F73732D636C61696D732920616C6C6567696E672074686174206120436F6E7472696275746F722056657273696F6E206469726563746C79206F720D0A2020202020696E6469726563746C7920696E6672696E67657320616E79';
wwv_flow_api.g_varchar2_table(122) := '20706174656E742C207468656E2074686520726967687473206772616E74656420746F20596F7520627920616E7920616E640D0A2020202020616C6C20436F6E7472696275746F727320666F722074686520436F766572656420536F6674776172652075';
wwv_flow_api.g_varchar2_table(123) := '6E6465722053656374696F6E20322E31206F662074686973204C6963656E73650D0A20202020207368616C6C207465726D696E6174652E0D0A0D0A352E332E20496E20746865206576656E74206F66207465726D696E6174696F6E20756E646572205365';
wwv_flow_api.g_varchar2_table(124) := '6374696F6E7320352E31206F7220352E322061626F76652C20616C6C20656E6420757365720D0A20202020206C6963656E73652061677265656D656E747320286578636C7564696E67206469737472696275746F727320616E6420726573656C6C657273';
wwv_flow_api.g_varchar2_table(125) := '292077686963682068617665206265656E0D0A202020202076616C69646C79206772616E74656420627920596F75206F7220596F7572206469737472696275746F727320756E6465722074686973204C6963656E7365207072696F7220746F0D0A202020';
wwv_flow_api.g_varchar2_table(126) := '20207465726D696E6174696F6E207368616C6C2073757276697665207465726D696E6174696F6E2E0D0A0D0A362E20446973636C61696D6572206F662057617272616E74790D0A0D0A202020436F766572656420536F6674776172652069732070726F76';
wwv_flow_api.g_varchar2_table(127) := '6964656420756E6465722074686973204C6963656E7365206F6E20616E20936173206973942062617369732C20776974686F75740D0A20202077617272616E7479206F6620616E79206B696E642C20656974686572206578707265737365642C20696D70';
wwv_flow_api.g_varchar2_table(128) := '6C6965642C206F72207374617475746F72792C20696E636C7564696E672C0D0A202020776974686F7574206C696D69746174696F6E2C2077617272616E7469657320746861742074686520436F766572656420536F667477617265206973206672656520';
wwv_flow_api.g_varchar2_table(129) := '6F6620646566656374732C0D0A2020206D65726368616E7461626C652C2066697420666F72206120706172746963756C617220707572706F7365206F72206E6F6E2D696E6672696E67696E672E2054686520656E746972650D0A2020207269736B206173';
wwv_flow_api.g_varchar2_table(130) := '20746F20746865207175616C69747920616E6420706572666F726D616E6365206F662074686520436F766572656420536F667477617265206973207769746820596F752E0D0A20202053686F756C6420616E7920436F766572656420536F667477617265';
wwv_flow_api.g_varchar2_table(131) := '2070726F76652064656665637469766520696E20616E7920726573706563742C20596F7520286E6F7420616E790D0A202020436F6E7472696275746F722920617373756D652074686520636F7374206F6620616E79206E65636573736172792073657276';
wwv_flow_api.g_varchar2_table(132) := '6963696E672C207265706169722C206F720D0A202020636F7272656374696F6E2E205468697320646973636C61696D6572206F662077617272616E747920636F6E737469747574657320616E20657373656E7469616C2070617274206F6620746869730D';
wwv_flow_api.g_varchar2_table(133) := '0A2020204C6963656E73652E204E6F20757365206F662020616E7920436F766572656420536F66747761726520697320617574686F72697A656420756E6465722074686973204C6963656E73650D0A20202065786365707420756E646572207468697320';
wwv_flow_api.g_varchar2_table(134) := '646973636C61696D65722E0D0A0D0A372E204C696D69746174696F6E206F66204C696162696C6974790D0A0D0A202020556E646572206E6F2063697263756D7374616E63657320616E6420756E646572206E6F206C6567616C207468656F72792C207768';
wwv_flow_api.g_varchar2_table(135) := '657468657220746F72742028696E636C7564696E670D0A2020206E65676C6967656E6365292C20636F6E74726163742C206F72206F74686572776973652C207368616C6C20616E7920436F6E7472696275746F722C206F7220616E796F6E652077686F0D';
wwv_flow_api.g_varchar2_table(136) := '0A202020646973747269627574657320436F766572656420536F667477617265206173207065726D69747465642061626F76652C206265206C6961626C6520746F20596F7520666F7220616E790D0A2020206469726563742C20696E6469726563742C20';
wwv_flow_api.g_varchar2_table(137) := '7370656369616C2C20696E636964656E74616C2C206F7220636F6E73657175656E7469616C2064616D61676573206F6620616E790D0A20202063686172616374657220696E636C7564696E672C20776974686F7574206C696D69746174696F6E2C206461';
wwv_flow_api.g_varchar2_table(138) := '6D6167657320666F72206C6F73742070726F666974732C206C6F7373206F660D0A202020676F6F6477696C6C2C20776F726B2073746F70706167652C20636F6D7075746572206661696C757265206F72206D616C66756E6374696F6E2C206F7220616E79';
wwv_flow_api.g_varchar2_table(139) := '20616E6420616C6C0D0A2020206F7468657220636F6D6D65726369616C2064616D61676573206F72206C6F737365732C206576656E2069662073756368207061727479207368616C6C2068617665206265656E0D0A202020696E666F726D6564206F6620';
wwv_flow_api.g_varchar2_table(140) := '74686520706F73736962696C697479206F6620737563682064616D616765732E2054686973206C696D69746174696F6E206F66206C696162696C6974790D0A2020207368616C6C206E6F74206170706C7920746F206C696162696C69747920666F722064';
wwv_flow_api.g_varchar2_table(141) := '65617468206F7220706572736F6E616C20696E6A75727920726573756C74696E672066726F6D20737563680D0A20202070617274799273206E65676C6967656E636520746F2074686520657874656E74206170706C696361626C65206C61772070726F68';
wwv_flow_api.g_varchar2_table(142) := '69626974732073756368206C696D69746174696F6E2E0D0A202020536F6D65206A7572697364696374696F6E7320646F206E6F7420616C6C6F7720746865206578636C7573696F6E206F72206C696D69746174696F6E206F6620696E636964656E74616C';
wwv_flow_api.g_varchar2_table(143) := '206F720D0A202020636F6E73657175656E7469616C2064616D616765732C20736F2074686973206578636C7573696F6E20616E64206C696D69746174696F6E206D6179206E6F74206170706C7920746F20596F752E0D0A0D0A382E204C69746967617469';
wwv_flow_api.g_varchar2_table(144) := '6F6E0D0A0D0A202020416E79206C697469676174696F6E2072656C6174696E6720746F2074686973204C6963656E7365206D61792062652062726F75676874206F6E6C7920696E2074686520636F75727473206F660D0A20202061206A75726973646963';
wwv_flow_api.g_varchar2_table(145) := '74696F6E2077686572652074686520646566656E64616E74206D61696E7461696E7320697473207072696E636970616C20706C616365206F6620627573696E6573730D0A202020616E642073756368206C697469676174696F6E207368616C6C20626520';
wwv_flow_api.g_varchar2_table(146) := '676F7665726E6564206279206C617773206F662074686174206A7572697364696374696F6E2C20776974686F75740D0A2020207265666572656E636520746F2069747320636F6E666C6963742D6F662D6C61772070726F766973696F6E732E204E6F7468';
wwv_flow_api.g_varchar2_table(147) := '696E6720696E20746869732053656374696F6E207368616C6C0D0A20202070726576656E7420612070617274799273206162696C69747920746F206272696E672063726F73732D636C61696D73206F7220636F756E7465722D636C61696D732E0D0A0D0A';
wwv_flow_api.g_varchar2_table(148) := '392E204D697363656C6C616E656F75730D0A0D0A20202054686973204C6963656E736520726570726573656E74732074686520636F6D706C6574652061677265656D656E7420636F6E6365726E696E6720746865207375626A656374206D61747465720D';
wwv_flow_api.g_varchar2_table(149) := '0A202020686572656F662E20496620616E792070726F766973696F6E206F662074686973204C6963656E73652069732068656C6420746F20626520756E656E666F72636561626C652C20737563680D0A20202070726F766973696F6E207368616C6C2062';
wwv_flow_api.g_varchar2_table(150) := '65207265666F726D6564206F6E6C7920746F2074686520657874656E74206E656365737361727920746F206D616B652069740D0A202020656E666F72636561626C652E20416E79206C6177206F7220726567756C6174696F6E2077686963682070726F76';
wwv_flow_api.g_varchar2_table(151) := '69646573207468617420746865206C616E6775616765206F6620610D0A202020636F6E7472616374207368616C6C20626520636F6E73747275656420616761696E7374207468652064726166746572207368616C6C206E6F74206265207573656420746F';
wwv_flow_api.g_varchar2_table(152) := '20636F6E73747275650D0A20202074686973204C6963656E736520616761696E7374206120436F6E7472696275746F722E0D0A0D0A0D0A31302E2056657273696F6E73206F6620746865204C6963656E73650D0A0D0A31302E312E204E65772056657273';
wwv_flow_api.g_varchar2_table(153) := '696F6E730D0A0D0A2020202020204D6F7A696C6C6120466F756E646174696F6E20697320746865206C6963656E736520737465776172642E204578636570742061732070726F766964656420696E2053656374696F6E0D0A20202020202031302E332C20';
wwv_flow_api.g_varchar2_table(154) := '6E6F206F6E65206F74686572207468616E20746865206C6963656E73652073746577617264206861732074686520726967687420746F206D6F64696679206F720D0A2020202020207075626C697368206E65772076657273696F6E73206F662074686973';
wwv_flow_api.g_varchar2_table(155) := '204C6963656E73652E20456163682076657273696F6E2077696C6C20626520676976656E20610D0A20202020202064697374696E6775697368696E672076657273696F6E206E756D6265722E0D0A0D0A31302E322E20456666656374206F66204E657720';
wwv_flow_api.g_varchar2_table(156) := '56657273696F6E730D0A0D0A202020202020596F75206D617920646973747269627574652074686520436F766572656420536F66747761726520756E64657220746865207465726D73206F66207468652076657273696F6E206F660D0A20202020202074';
wwv_flow_api.g_varchar2_table(157) := '6865204C6963656E736520756E64657220776869636820596F75206F726967696E616C6C792072656365697665642074686520436F766572656420536F6674776172652C206F720D0A202020202020756E64657220746865207465726D73206F6620616E';
wwv_flow_api.g_varchar2_table(158) := '792073756273657175656E742076657273696F6E207075626C697368656420627920746865206C6963656E73650D0A202020202020737465776172642E0D0A0D0A31302E332E204D6F6469666965642056657273696F6E730D0A0D0A2020202020204966';
wwv_flow_api.g_varchar2_table(159) := '20796F752063726561746520736F667477617265206E6F7420676F7665726E65642062792074686973204C6963656E73652C20616E6420796F752077616E7420746F0D0A2020202020206372656174652061206E6577206C6963656E736520666F722073';
wwv_flow_api.g_varchar2_table(160) := '75636820736F6674776172652C20796F75206D61792063726561746520616E64207573652061206D6F6469666965640D0A20202020202076657273696F6E206F662074686973204C6963656E736520696620796F752072656E616D6520746865206C6963';
wwv_flow_api.g_varchar2_table(161) := '656E736520616E642072656D6F766520616E790D0A2020202020207265666572656E63657320746F20746865206E616D65206F6620746865206C6963656E73652073746577617264202865786365707420746F206E6F7465207468617420737563680D0A';
wwv_flow_api.g_varchar2_table(162) := '2020202020206D6F646966696564206C6963656E736520646966666572732066726F6D2074686973204C6963656E7365292E0D0A0D0A31302E342E20446973747269627574696E6720536F7572636520436F646520466F726D207468617420697320496E';
wwv_flow_api.g_varchar2_table(163) := '636F6D70617469626C652057697468205365636F6E64617279204C6963656E7365730D0A202020202020496620596F752063686F6F736520746F206469737472696275746520536F7572636520436F646520466F726D207468617420697320496E636F6D';
wwv_flow_api.g_varchar2_table(164) := '70617469626C6520576974680D0A2020202020205365636F6E64617279204C6963656E73657320756E64657220746865207465726D73206F6620746869732076657273696F6E206F6620746865204C6963656E73652C207468650D0A2020202020206E6F';
wwv_flow_api.g_varchar2_table(165) := '746963652064657363726962656420696E20457868696269742042206F662074686973204C6963656E7365206D7573742062652061747461636865642E0D0A0D0A457868696269742041202D20536F7572636520436F646520466F726D204C6963656E73';
wwv_flow_api.g_varchar2_table(166) := '65204E6F746963650D0A0D0A2020202020205468697320536F7572636520436F646520466F726D206973207375626A65637420746F207468650D0A2020202020207465726D73206F6620746865204D6F7A696C6C61205075626C6963204C6963656E7365';
wwv_flow_api.g_varchar2_table(167) := '2C20762E0D0A202020202020322E302E204966206120636F7079206F6620746865204D504C20776173206E6F740D0A2020202020206469737472696275746564207769746820746869732066696C652C20596F752063616E0D0A2020202020206F627461';
wwv_flow_api.g_varchar2_table(168) := '696E206F6E652061740D0A202020202020687474703A2F2F6D6F7A696C6C612E6F72672F4D504C2F322E302F2E0D0A0D0A4966206974206973206E6F7420706F737369626C65206F7220646573697261626C6520746F2070757420746865206E6F746963';
wwv_flow_api.g_varchar2_table(169) := '6520696E206120706172746963756C61722066696C652C207468656E0D0A596F75206D617920696E636C75646520746865206E6F7469636520696E2061206C6F636174696F6E2028737563682061732061204C4943454E53452066696C6520696E206120';
wwv_flow_api.g_varchar2_table(170) := '72656C6576616E740D0A6469726563746F727929207768657265206120726563697069656E7420776F756C64206265206C696B656C7920746F206C6F6F6B20666F7220737563682061206E6F746963652E0D0A0D0A596F75206D61792061646420616464';
wwv_flow_api.g_varchar2_table(171) := '6974696F6E616C206163637572617465206E6F7469636573206F6620636F70797269676874206F776E6572736869702E0D0A0D0A457868696269742042202D2093496E636F6D70617469626C652057697468205365636F6E64617279204C6963656E7365';
wwv_flow_api.g_varchar2_table(172) := '7394204E6F746963650D0A0D0A2020202020205468697320536F7572636520436F646520466F726D2069732093496E636F6D70617469626C650D0A20202020202057697468205365636F6E64617279204C6963656E736573942C20617320646566696E65';
wwv_flow_api.g_varchar2_table(173) := '642062790D0A202020202020746865204D6F7A696C6C61205075626C6963204C6963656E73652C20762E20322E302E';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(79119589161200390)
,p_plugin_id=>wwv_flow_api.id(138285470529447569213)
,p_file_name=>'LICENSE4LIBS'
,p_mime_type=>'application/octet-stream'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '636F6E7374206E6F74696669636174696F6E4D656E75203D202866756E6374696F6E202829207B0A202020202275736520737472696374223B0A0A20202020636F6E7374207574696C203D207B0A20202020202020206665617475726544657461696C73';
wwv_flow_api.g_varchar2_table(2) := '3A207B0A2020202020202020202020206E616D653A202241504558204E6F74696669636174696F6E204D656E75222C0A20202020202020202020202073637269707456657273696F6E3A202232352E30332E3137222C0A20202020202020202020202075';
wwv_flow_api.g_varchar2_table(3) := '74696C56657273696F6E3A202232352E30332E3137222C0A20202020202020202020202075726C3A202268747470733A2F2F6769746875622E636F6D2F526F6E6E795765697373222C0A2020202020202020202020206C6963656E73653A20224D495422';
wwv_flow_api.g_varchar2_table(4) := '0A20202020202020207D2C0A202020202020202065736361706548544D4C3A2066756E6374696F6E202873747229207B0A20202020202020202020202069662028737472203D3D3D206E756C6C29207B0A20202020202020202020202020202020726574';
wwv_flow_api.g_varchar2_table(5) := '75726E206E756C6C3B0A2020202020202020202020207D0A20202020202020202020202069662028747970656F6620737472203D3D3D2022756E646566696E65642229207B0A2020202020202020202020202020202072657475726E3B0A202020202020';
wwv_flow_api.g_varchar2_table(6) := '2020202020207D0A20202020202020202020202069662028747970656F6620737472203D3D3D20226F626A6563742229207B0A20202020202020202020202020202020747279207B0A2020202020202020202020202020202020202020737472203D204A';
wwv_flow_api.g_varchar2_table(7) := '534F4E2E737472696E6769667928737472293B0A202020202020202020202020202020207D20636174636820286529207B0A20202020202020202020202020202020202020202F2A646F206E6F7468696E67202A2F0A2020202020202020202020202020';
wwv_flow_api.g_varchar2_table(8) := '20207D0A2020202020202020202020207D0A20202020202020202020202072657475726E20617065782E7574696C2E65736361706548544D4C28537472696E672873747229293B0A20202020202020207D2C0A20202020202020206A736F6E5361766545';
wwv_flow_api.g_varchar2_table(9) := '7874656E643A2066756E6374696F6E2028737263436F6E6669672C20746172676574436F6E66696729207B0A2020202020202020202020206C65742066696E616C436F6E666967203D207B7D3B0A2020202020202020202020206C657420746D704A534F';
wwv_flow_api.g_varchar2_table(10) := '4E203D207B7D3B0A2020202020202020202020202F2A2074727920746F20706172736520636F6E666967206A736F6E207768656E20737472696E67206F72206A75737420736574202A2F0A20202020202020202020202069662028747970656F66207461';
wwv_flow_api.g_varchar2_table(11) := '72676574436F6E666967203D3D3D2027737472696E672729207B0A20202020202020202020202020202020747279207B0A2020202020202020202020202020202020202020746D704A534F4E203D204A534F4E2E706172736528746172676574436F6E66';
wwv_flow_api.g_varchar2_table(12) := '6967293B0A202020202020202020202020202020207D20636174636820286529207B0A2020202020202020202020202020202020202020617065782E64656275672E6572726F72287B0A202020202020202020202020202020202020202020202020226D';
wwv_flow_api.g_varchar2_table(13) := '6F64756C65223A20227574696C2E6A73222C0A202020202020202020202020202020202020202020202020226D7367223A20224572726F72207768696C652074727920746F20706172736520746172676574436F6E6669672E20506C6561736520636865';
wwv_flow_api.g_varchar2_table(14) := '636B20796F757220436F6E666967204A534F4E2E205374616E6461726420436F6E6669672077696C6C20626520757365642E222C0A20202020202020202020202020202020202020202020202022657272223A20652C0A20202020202020202020202020';
wwv_flow_api.g_varchar2_table(15) := '202020202020202020202022746172676574436F6E666967223A20746172676574436F6E6669670A20202020202020202020202020202020202020207D293B0A202020202020202020202020202020207D0A2020202020202020202020207D20656C7365';
wwv_flow_api.g_varchar2_table(16) := '207B0A20202020202020202020202020202020746D704A534F4E203D20242E657874656E6428747275652C207B7D2C20746172676574436F6E666967293B0A2020202020202020202020207D0A2020202020202020202020202F2A2074727920746F206D';
wwv_flow_api.g_varchar2_table(17) := '657267652077697468207374616E6461726420696620616E7920617474726962757465206973206D697373696E67202A2F0A202020202020202020202020747279207B0A2020202020202020202020202020202066696E616C436F6E666967203D20242E';
wwv_flow_api.g_varchar2_table(18) := '657874656E6428747275652C207B7D2C20737263436F6E6669672C20746D704A534F4E293B0A2020202020202020202020207D20636174636820286529207B0A2020202020202020202020202020202066696E616C436F6E666967203D20242E65787465';
wwv_flow_api.g_varchar2_table(19) := '6E6428747275652C207B7D2C20737263436F6E666967293B0A20202020202020202020202020202020617065782E64656275672E6572726F72287B0A2020202020202020202020202020202020202020226D6F64756C65223A20227574696C2E6A73222C';
wwv_flow_api.g_varchar2_table(20) := '0A2020202020202020202020202020202020202020226D7367223A20224572726F72207768696C652074727920746F206D657267652032204A534F4E7320696E746F207374616E64617264204A534F4E20696620616E7920617474726962757465206973';
wwv_flow_api.g_varchar2_table(21) := '206D697373696E672E20506C6561736520636865636B20796F757220436F6E666967204A534F4E2E205374616E6461726420436F6E6669672077696C6C20626520757365642E222C0A202020202020202020202020202020202020202022657272223A20';
wwv_flow_api.g_varchar2_table(22) := '652C0A20202020202020202020202020202020202020202266696E616C436F6E666967223A2066696E616C436F6E6669670A202020202020202020202020202020207D293B0A2020202020202020202020207D0A20202020202020202020202072657475';
wwv_flow_api.g_varchar2_table(23) := '726E2066696E616C436F6E6669673B0A20202020202020207D2C0A20202020202020206C696E6B3A2066756E6374696F6E2028704C696E6B2C2070546172676574203D20225F706172656E742229207B0A202020202020202020202020696620285B225F';
wwv_flow_api.g_varchar2_table(24) := '706172656E74222C20225F73656C66225D2E696E636C7564657328705461726765742929207B0A20202020202020202020202020202020617065782E6E617669676174696F6E2E726564697265637428704C696E6B293B0A202020202020202020202020';
wwv_flow_api.g_varchar2_table(25) := '7D20656C7365207B0A2020202020202020202020202020202069662028747970656F6620704C696E6B20213D3D2022756E646566696E65642220262620704C696E6B20213D3D206E756C6C20262620704C696E6B20213D3D20222229207B0A2020202020';
wwv_flow_api.g_varchar2_table(26) := '20202020202020202020202020202077696E646F772E6F70656E28704C696E6B2C2070546172676574293B0A202020202020202020202020202020207D0A2020202020202020202020207D0A20202020202020207D2C0A20202020202020206375745374';
wwv_flow_api.g_varchar2_table(27) := '72696E673A2066756E6374696F6E2028746578742C20746578744C656E67746829207B0A202020202020202020202020747279207B0A2020202020202020202020202020202069662028746578744C656E677468203C203029207B2072657475726E2074';
wwv_flow_api.g_varchar2_table(28) := '6578743B207D0A20202020202020202020202020202020656C7365207B0A202020202020202020202020202020202020202072657475726E2028746578742E6C656E677468203E20746578744C656E67746829203F0A2020202020202020202020202020';
wwv_flow_api.g_varchar2_table(29) := '20202020202020202020746578742E737562737472696E6728302C20746578744C656E677468202D203329202B20222E2E2E22203A0A202020202020202020202020202020202020202020202020746578743B0A20202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(30) := '7D0A2020202020202020202020207D20636174636820286529207B0A2020202020202020202020202020202072657475726E20746578743B0A2020202020202020202020207D0A20202020202020207D2C0A202020202020202072656D6F766548544D4C';
wwv_flow_api.g_varchar2_table(31) := '3A2066756E6374696F6E20287048544D4C29207B0A202020202020202020202020696620286170657820262620617065782E7574696C20262620617065782E7574696C2E737472697048544D4C29207B0A20202020202020202020202020202020726574';
wwv_flow_api.g_varchar2_table(32) := '75726E20617065782E7574696C2E737472697048544D4C287048544D4C293B0A2020202020202020202020207D20656C7365207B0A2020202020202020202020202020202072657475726E202428223C6469762F3E22292E68746D6C287048544D4C292E';
wwv_flow_api.g_varchar2_table(33) := '7465787428293B0A2020202020202020202020207D0A20202020202020207D0A202020207D3B0A0A2020202072657475726E207B0A0A2020202020202020696E697469616C697A653A2066756E6374696F6E2028656C656D656E7449442C20616A617849';
wwv_flow_api.g_varchar2_table(34) := '442C207564436F6E6669674A534F4E2C206974656D73325375626D69742C2065736361706552657175697265642C2073616E6974697A652C2073616E6974697A65724F7074696F6E7329207B0A0A202020202020202020202020617065782E6465627567';
wwv_flow_api.g_varchar2_table(35) := '2E696E666F287B0A2020202020202020202020202020202022666374223A207574696C2E6665617475726544657461696C732E6E616D65202B2022202D2022202B2022696E697469616C697A65222C0A2020202020202020202020202020202022617267';
wwv_flow_api.g_varchar2_table(36) := '756D656E7473223A207B0A202020202020202020202020202020202020202022656C656D656E744944223A20656C656D656E7449442C0A202020202020202020202020202020202020202022616A61784944223A20616A617849442C0A20202020202020';
wwv_flow_api.g_varchar2_table(37) := '20202020202020202020202020227564436F6E6669674A534F4E223A207564436F6E6669674A534F4E2C0A2020202020202020202020202020202020202020226974656D73325375626D6974223A206974656D73325375626D69742C0A20202020202020';
wwv_flow_api.g_varchar2_table(38) := '20202020202020202020202020226573636170655265717569726564223A2065736361706552657175697265642C0A20202020202020202020202020202020202020202273616E6974697A65223A2073616E6974697A652C0A2020202020202020202020';
wwv_flow_api.g_varchar2_table(39) := '2020202020202020202273616E6974697A65724F7074696F6E73223A2073616E6974697A65724F7074696F6E730A202020202020202020202020202020207D2C0A20202020202020202020202020202020226665617475726544657461696C73223A2075';
wwv_flow_api.g_varchar2_table(40) := '74696C2E6665617475726544657461696C730A2020202020202020202020207D293B0A0A2020202020202020202020207661722074696D6572733B0A20202020202020202020202076617220657272436F756E74203D20303B0A0A202020202020202020';
wwv_flow_api.g_varchar2_table(41) := '20202076617220737464436F6E6669674A534F4E203D207B0A202020202020202020202020202020202272656672657368223A20302C0A20202020202020202020202020202020226D61696E49636F6E223A202266612D62656C6C222C0A202020202020';
wwv_flow_api.g_varchar2_table(42) := '20202020202020202020226D61696E49636F6E436F6C6F72223A20227768697465222C0A20202020202020202020202020202020226D61696E49636F6E4261636B67726F756E64436F6C6F72223A2022726762612837302C37302C37302C302E3929222C';
wwv_flow_api.g_varchar2_table(43) := '0A20202020202020202020202020202020226D61696E49636F6E426C696E6B696E67223A2066616C73652C0A2020202020202020202020202020202022636F756E7465724261636B67726F756E64436F6C6F72223A2022726762283233322C2035352C20';
wwv_flow_api.g_varchar2_table(44) := '35352029222C0A2020202020202020202020202020202022636F756E746572466F6E74436F6C6F72223A20227768697465222C0A20202020202020202020202020202020226C696E6B546172676574426C616E6B223A2066616C73652C0A202020202020';
wwv_flow_api.g_varchar2_table(45) := '202020202020202020202273686F77416C77617973223A2066616C73652C0A202020202020202020202020202020202262726F777365724E6F74696669636174696F6E73223A207B0A202020202020202020202020202020202020202022656E61626C65';
wwv_flow_api.g_varchar2_table(46) := '64223A20747275652C0A202020202020202020202020202020202020202022637574426F6479546578744166746572223A203130302C0A2020202020202020202020202020202020202020226C696E6B223A2066616C73650A2020202020202020202020';
wwv_flow_api.g_varchar2_table(47) := '20202020207D2C0A2020202020202020202020202020202022616363657074223A207B0A202020202020202020202020202020202020202022636F6C6F72223A202223343465353563222C0A20202020202020202020202020202020202020202269636F';
wwv_flow_api.g_varchar2_table(48) := '6E223A202266612D636865636B220A202020202020202020202020202020207D2C0A20202020202020202020202020202020226465636C696E65223A207B0A202020202020202020202020202020202020202022636F6C6F72223A202223623733613231';
wwv_flow_api.g_varchar2_table(49) := '222C0A20202020202020202020202020202020202020202269636F6E223A202266612D636C6F7365220A202020202020202020202020202020207D2C0A2020202020202020202020202020202022686964654F6E52656672657368223A20747275650A20';
wwv_flow_api.g_varchar2_table(50) := '20202020202020202020207D3B0A0A2020202020202020202020202F2A2074686973206973207468652064656661756C74206A736F6E20666F7220707572696679206A73202A2F0A2020202020202020202020207661722073616E6974697A65436F6E66';
wwv_flow_api.g_varchar2_table(51) := '69674A534F4E3B0A2020202020202020202020207661722073746453616E6174697A6572436F6E6669674A534F4E203D207B0A2020202020202020202020202020202022414C4C4F5745445F41545452223A205B226163636573736B6579222C2022616C';
wwv_flow_api.g_varchar2_table(52) := '69676E222C2022616C74222C2022616C77617973222C20226175746F636F6D706C657465222C20226175746F706C6179222C2022626F72646572222C202263656C6C70616464696E67222C202263656C6C73706163696E67222C20226368617273657422';
wwv_flow_api.g_varchar2_table(53) := '2C2022636C617373222C2022636F6C7370616E222C2022646972222C2022686569676874222C202268726566222C20226964222C20226C616E67222C20226E616D65222C202272656C222C20227265717569726564222C2022726F777370616E222C2022';
wwv_flow_api.g_varchar2_table(54) := '737263222C20227374796C65222C202273756D6D617279222C2022746162696E646578222C2022746172676574222C20227469746C65222C202274797065222C202276616C7565222C20227769647468225D2C0A20202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(55) := '22414C4C4F5745445F54414753223A205B2261222C202261646472657373222C202262222C2022626C6F636B71756F7465222C20226272222C202263617074696F6E222C2022636F6465222C20226464222C2022646976222C2022646C222C2022647422';
wwv_flow_api.g_varchar2_table(56) := '2C2022656D222C202266696763617074696F6E222C2022666967757265222C20226831222C20226832222C20226833222C20226834222C20226835222C20226836222C20226872222C202269222C2022696D67222C20226C6162656C222C20226C69222C';
wwv_flow_api.g_varchar2_table(57) := '20226E6C222C20226F6C222C202270222C2022707265222C202273222C20227370616E222C2022737472696B65222C20227374726F6E67222C2022737562222C2022737570222C20227461626C65222C202274626F6479222C20227464222C2022746822';
wwv_flow_api.g_varchar2_table(58) := '2C20227468656164222C20227472222C202275222C2022756C225D0A2020202020202020202020207D3B0A0A2020202020202020202020206966202873616E6974697A6520213D3D2066616C736529207B0A202020202020202020202020202020206966';
wwv_flow_api.g_varchar2_table(59) := '202873616E6974697A65724F7074696F6E7329207B0A202020202020202020202020202020202020202073616E6974697A65436F6E6669674A534F4E203D207574696C2E6A736F6E53617665457874656E642873746453616E6174697A6572436F6E6669';
wwv_flow_api.g_varchar2_table(60) := '674A534F4E2C2073616E6974697A65724F7074696F6E73293B0A202020202020202020202020202020207D20656C7365207B0A202020202020202020202020202020202020202073616E6974697A65436F6E6669674A534F4E203D2073746453616E6174';
wwv_flow_api.g_varchar2_table(61) := '697A6572436F6E6669674A534F4E3B0A202020202020202020202020202020207D0A2020202020202020202020207D0A0A20202020202020202020202076617220636F6E6669674A534F4E203D207B7D3B0A202020202020202020202020636F6E666967';
wwv_flow_api.g_varchar2_table(62) := '4A534F4E203D207574696C2E6A736F6E53617665457874656E6428737464436F6E6669674A534F4E2C207564436F6E6669674A534F4E293B0A0A2020202020202020202020202F2A20646566696E6520636F6E7461696E657220616E6420616464206974';
wwv_flow_api.g_varchar2_table(63) := '20746F20706172656E74202A2F0A20202020202020202020202076617220636F6E7461696E6572203D2064726177436F6E7461696E657228656C656D656E744944293B0A0A20202020202020202020202069662028636F6E6669674A534F4E2E62726F77';
wwv_flow_api.g_varchar2_table(64) := '7365724E6F74696669636174696F6E732E656E61626C656429207B0A20202020202020202020202020202020747279207B0A2020202020202020202020202020202020202020696620282128224E6F74696669636174696F6E2220696E2077696E646F77';
wwv_flow_api.g_varchar2_table(65) := '2929207B0A202020202020202020202020202020202020202020202020617065782E64656275672E6572726F72287B0A2020202020202020202020202020202020202020202020202020202022666374223A207574696C2E666561747572654465746169';
wwv_flow_api.g_varchar2_table(66) := '6C732E6E616D65202B2022202D2022202B2022647261774C697374222C0A20202020202020202020202020202020202020202020202020202020226D7367223A2022546869732062726F7773657220646F6573206E6F7420737570706F72742073797374';
wwv_flow_api.g_varchar2_table(67) := '656D206E6F74696669636174696F6E73222C0A2020202020202020202020202020202020202020202020202020202022657272223A20652C0A20202020202020202020202020202020202020202020202020202020226665617475726544657461696C73';
wwv_flow_api.g_varchar2_table(68) := '223A207574696C2E6665617475726544657461696C730A2020202020202020202020202020202020202020202020207D293B0A20202020202020202020202020202020202020207D20656C7365207B0A2020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(69) := '202020204E6F74696669636174696F6E2E726571756573745065726D697373696F6E28293B0A20202020202020202020202020202020202020207D0A202020202020202020202020202020207D20636174636820286529207B0A20202020202020202020';
wwv_flow_api.g_varchar2_table(70) := '20202020202020202020617065782E64656275672E6572726F72287B0A20202020202020202020202020202020202020202020202022666374223A207574696C2E6665617475726544657461696C732E6E616D65202B2022202D2022202B2022696E6974';
wwv_flow_api.g_varchar2_table(71) := '69616C697A65222C0A202020202020202020202020202020202020202020202020226D7367223A20224572726F72207768696C652074727920746F20676574206E6F74696669636174696F6E207065726D697373696F6E222C0A20202020202020202020';
wwv_flow_api.g_varchar2_table(72) := '202020202020202020202020202022657272223A20652C0A202020202020202020202020202020202020202020202020226665617475726544657461696C73223A207574696C2E6665617475726544657461696C730A2020202020202020202020202020';
wwv_flow_api.g_varchar2_table(73) := '2020202020207D293B0A202020202020202020202020202020207D0A2020202020202020202020207D0A0A2020202020202020202020202F2A20676574206461746120616E642064726177202A2F0A202020202020202020202020676574446174612864';
wwv_flow_api.g_varchar2_table(74) := '726177426F6479293B0A0A2020202020202020202020202F2A205573656420746F207365742061207265667265736820766961206A736F6E20636F6E66696775726174696F6E202A2F0A20202020202020202020202069662028636F6E6669674A534F4E';
wwv_flow_api.g_varchar2_table(75) := '2E72656672657368203E203029207B0A2020202020202020202020202020202074696D657273203D20736574496E74657276616C2866756E6374696F6E202829207B0A2020202020202020202020202020202020202020696620282428222322202B2065';
wwv_flow_api.g_varchar2_table(76) := '6C656D656E744944292E6C656E677468203D3D3D203029207B0A202020202020202020202020202020202020202020202020636C656172496E74657276616C2874696D657273293B0A20202020202020202020202020202020202020207D0A2020202020';
wwv_flow_api.g_varchar2_table(77) := '2020202020202020202020202020202F2A2073746F702074696D65722061667465722033206C6F6164696E67206572726F7273206F636375726564202A2F0A202020202020202020202020202020202020202069662028657272436F756E74203E3D2032';
wwv_flow_api.g_varchar2_table(78) := '29207B0A202020202020202020202020202020202020202020202020636C656172496E74657276616C2874696D657273293B0A20202020202020202020202020202020202020207D0A202020202020202020202020202020202020202069662028636F6E';
wwv_flow_api.g_varchar2_table(79) := '7461696E65722E6368696C6472656E28227370616E22292E6C656E677468203D3D203029207B0A20202020202020202020202020202020202020202020202069662028616A6178494429207B0A2020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(80) := '2020202020676574446174612872656672657368426F6479293B0A2020202020202020202020202020202020202020202020207D20656C7365207B0A2020202020202020202020202020202020202020202020202020202072656672657368426F647928';
wwv_flow_api.g_varchar2_table(81) := '646174614A534F4E293B0A2020202020202020202020202020202020202020202020207D0A20202020202020202020202020202020202020207D0A202020202020202020202020202020207D2C20636F6E6669674A534F4E2E72656672657368202A2031';
wwv_flow_api.g_varchar2_table(82) := '303030293B0A2020202020202020202020207D0A0A2020202020202020202020202F2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A';
wwv_flow_api.g_varchar2_table(83) := '2A2A2A2A2A0A202020202020202020202020202A2A0A202020202020202020202020202A2A2066756E6374696F6E20746F20657363617065206F662073616E6974697A652068746D6C0A202020202020202020202020202A2A0A20202020202020202020';
wwv_flow_api.g_varchar2_table(84) := '2020202A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2F0A20202020202020202020202066756E6374696F6E20657363';
wwv_flow_api.g_varchar2_table(85) := '6170654F7253616E6974697A6548544D4C287048544D4C29207B0A202020202020202020202020202020202F2A206573636170652068746D6C2069662065736361706520697320736574202A2F0A20202020202020202020202020202020696620286573';
wwv_flow_api.g_varchar2_table(86) := '63617065526571756972656420213D3D2066616C736529207B0A202020202020202020202020202020202020202072657475726E207574696C2E65736361706548544D4C287048544D4C293B0A202020202020202020202020202020207D20656C736520';
wwv_flow_api.g_varchar2_table(87) := '7B0A20202020202020202020202020202020202020202F2A2069662073616E6974697A6572206973206163746976617465642073616E6974697A652068746D6C202A2F0A20202020202020202020202020202020202020206966202873616E6974697A65';
wwv_flow_api.g_varchar2_table(88) := '20213D3D2066616C736529207B0A20202020202020202020202020202020202020202020202072657475726E20444F4D5075726966792E73616E6974697A65287048544D4C2C2073616E6974697A65436F6E6669674A534F4E293B0A2020202020202020';
wwv_flow_api.g_varchar2_table(89) := '2020202020202020202020207D20656C7365207B0A20202020202020202020202020202020202020202020202072657475726E207048544D4C3B0A20202020202020202020202020202020202020207D0A202020202020202020202020202020207D0A20';
wwv_flow_api.g_varchar2_table(90) := '20202020202020202020207D0A0A2020202020202020202020202F2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A0A20';
wwv_flow_api.g_varchar2_table(91) := '2020202020202020202020202A2A0A202020202020202020202020202A2A2066756E6374696F6E20746F2067657420646174612066726F6D20417065780A202020202020202020202020202A2A0A202020202020202020202020202A2A2A2A2A2A2A2A2A';
wwv_flow_api.g_varchar2_table(92) := '2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2F0A20202020202020202020202066756E6374696F6E2067657444617461287043616C6C6261';
wwv_flow_api.g_varchar2_table(93) := '636B29207B0A20202020202020202020202020202020617065782E7365727665722E706C7567696E280A2020202020202020202020202020202020202020616A617849442C207B0A2020202020202020202020202020202020202020706167654974656D';
wwv_flow_api.g_varchar2_table(94) := '733A206974656D73325375626D69740A202020202020202020202020202020207D2C207B0A2020202020202020202020202020202020202020737563636573733A2066756E6374696F6E2028704461746129207B0A202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(95) := '202020202020202020617065782E64656275672E696E666F287B0A2020202020202020202020202020202020202020202020202020202022666374223A207574696C2E6665617475726544657461696C732E6E616D65202B2022202D2022202B20226765';
wwv_flow_api.g_varchar2_table(96) := '7444617461222C0A20202020202020202020202020202020202020202020202020202020226D7367223A2022414A41582064617461207265636569766564222C0A2020202020202020202020202020202020202020202020202020202022704461746122';
wwv_flow_api.g_varchar2_table(97) := '3A2070446174612C0A20202020202020202020202020202020202020202020202020202020226665617475726544657461696C73223A207574696C2E6665617475726544657461696C730A2020202020202020202020202020202020202020202020207D';
wwv_flow_api.g_varchar2_table(98) := '293B0A202020202020202020202020202020202020202020202020657272436F756E74203D20303B0A2020202020202020202020202020202020202020202020207043616C6C6261636B287044617461293B0A2020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(99) := '2020207D2C0A20202020202020202020202020202020202020206572726F723A2066756E6374696F6E20286429207B0A20202020202020202020202020202020202020202020202069662028657272436F756E74203D3D3D203029207B0A202020202020';
wwv_flow_api.g_varchar2_table(100) := '2020202020202020202020202020202020202020202076617220646174614A534F4E203D207B0A2020202020202020202020202020202020202020202020202020202020202020726F773A205B7B0A202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(101) := '202020202020202020202020202020224E4F54455F49434F4E223A202266612D6578636C616D6174696F6E2D747269616E676C65222C0A202020202020202020202020202020202020202020202020202020202020202020202020224E4F54455F49434F';
wwv_flow_api.g_varchar2_table(102) := '4E5F434F4C4F52223A202223464630303030222C0A202020202020202020202020202020202020202020202020202020202020202020202020224E4F54455F484541444552223A2028642E726573706F6E73654A534F4E20262620642E726573706F6E73';
wwv_flow_api.g_varchar2_table(103) := '654A534F4E2E6572726F7229203F20642E726573706F6E73654A534F4E2E6572726F72203A20224572726F72206F636375726564222C0A202020202020202020202020202020202020202020202020202020202020202020202020224E4F54455F544558';
wwv_flow_api.g_varchar2_table(104) := '54223A206E756C6C2C0A202020202020202020202020202020202020202020202020202020202020202020202020224E4F54455F434F4C4F52223A202223464630303030220A202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(105) := '20207D0A20202020202020202020202020202020202020202020202020202020202020205D0A202020202020202020202020202020202020202020202020202020207D3B0A0A202020202020202020202020202020202020202020202020202020207043';
wwv_flow_api.g_varchar2_table(106) := '616C6C6261636B28646174614A534F4E293B0A20202020202020202020202020202020202020202020202020202020617065782E64656275672E6572726F72287B0A20202020202020202020202020202020202020202020202020202020202020202266';
wwv_flow_api.g_varchar2_table(107) := '6374223A207574696C2E6665617475726544657461696C732E6E616D65202B2022202D2022202B202267657444617461222C0A2020202020202020202020202020202020202020202020202020202020202020226D7367223A2022414A41582064617461';
wwv_flow_api.g_varchar2_table(108) := '206572726F72222C0A202020202020202020202020202020202020202020202020202020202020202022726573706F6E7365223A20642C0A2020202020202020202020202020202020202020202020202020202020202020226665617475726544657461';
wwv_flow_api.g_varchar2_table(109) := '696C73223A207574696C2E6665617475726544657461696C730A202020202020202020202020202020202020202020202020202020207D293B0A2020202020202020202020202020202020202020202020207D0A20202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(110) := '2020202020202020657272436F756E742B2B3B0A20202020202020202020202020202020202020207D2C0A202020202020202020202020202020202020202064617461547970653A20226A736F6E220A202020202020202020202020202020207D293B0A';
wwv_flow_api.g_varchar2_table(111) := '2020202020202020202020207D0A0A2020202020202020202020202F2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A0A';
wwv_flow_api.g_varchar2_table(112) := '202020202020202020202020202A2A0A202020202020202020202020202A2A205573656420746F2064726177206120636F6E7461696E65720A202020202020202020202020202A2A0A202020202020202020202020202A2A2A2A2A2A2A2A2A2A2A2A2A2A';
wwv_flow_api.g_varchar2_table(113) := '2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2F0A20202020202020202020202066756E6374696F6E2064726177436F6E7461696E657228656C656D656E';
wwv_flow_api.g_varchar2_table(114) := '74494429207B0A20202020202020202020202020202020766172206C69203D202428223C6C693E3C2F6C693E22293B0A202020202020202020202020202020206C692E616464436C6173732822742D4E617669676174696F6E4261722D6974656D22293B';
wwv_flow_api.g_varchar2_table(115) := '0A0A2020202020202020202020202020202076617220646976203D202428223C6469763E3C2F6469763E22293B0A202020202020202020202020202020206469762E6174747228226964222C20656C656D656E744944293B0A0A20202020202020202020';
wwv_flow_api.g_varchar2_table(116) := '2020202020206469762E62696E6428226170657872656672657368222C2066756E6374696F6E202829207B0A202020202020202020202020202020202020202069662028636F6E7461696E65722E6368696C6472656E28227370616E22292E6C656E6774';
wwv_flow_api.g_varchar2_table(117) := '68203D3D203029207B0A202020202020202020202020202020202020202020202020676574446174612872656672657368426F6479293B0A20202020202020202020202020202020202020207D0A202020202020202020202020202020207D293B0A0A20';
wwv_flow_api.g_varchar2_table(118) := '2020202020202020202020202020206C692E617070656E6428646976293B0A0A202020202020202020202020202020202428222E742D4E617669676174696F6E42617222292E70726570656E64286C69293B0A2020202020202020202020202020202072';
wwv_flow_api.g_varchar2_table(119) := '657475726E2028646976293B0A2020202020202020202020207D0A0A2020202020202020202020202F2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A';
wwv_flow_api.g_varchar2_table(120) := '2A2A2A2A2A2A2A2A2A2A2A2A0A202020202020202020202020202A2A0A202020202020202020202020202A2A205573656420746F20647261772061206E6F746520626F64790A202020202020202020202020202A2A0A202020202020202020202020202A';
wwv_flow_api.g_varchar2_table(121) := '2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2F0A20202020202020202020202066756E6374696F6E2064726177426F64';
wwv_flow_api.g_varchar2_table(122) := '7928646174614A534F4E29207B0A20202020202020202020202020202020636F6E6669674A534F4E2E636F756E7465724261636B67726F756E64436F6C6F72203D206573636170654F7253616E6974697A6548544D4C28636F6E6669674A534F4E2E636F';
wwv_flow_api.g_varchar2_table(123) := '756E7465724261636B67726F756E64436F6C6F72293B0A20202020202020202020202020202020636F6E6669674A534F4E2E636F756E746572466F6E74436F6C6F72203D206573636170654F7253616E6974697A6548544D4C28636F6E6669674A534F4E';
wwv_flow_api.g_varchar2_table(124) := '2E636F756E746572466F6E74436F6C6F72293B0A20202020202020202020202020202020636F6E6669674A534F4E2E6D61696E49636F6E203D206573636170654F7253616E6974697A6548544D4C28636F6E6669674A534F4E2E6D61696E49636F6E293B';
wwv_flow_api.g_varchar2_table(125) := '0A20202020202020202020202020202020636F6E6669674A534F4E2E6D61696E49636F6E4261636B67726F756E64436F6C6F72203D206573636170654F7253616E6974697A6548544D4C28636F6E6669674A534F4E2E6D61696E49636F6E4261636B6772';
wwv_flow_api.g_varchar2_table(126) := '6F756E64436F6C6F72293B0A20202020202020202020202020202020636F6E6669674A534F4E2E6D61696E49636F6E436F6C6F72203D206573636170654F7253616E6974697A6548544D4C28636F6E6669674A534F4E2E6D61696E49636F6E436F6C6F72';
wwv_flow_api.g_varchar2_table(127) := '293B0A0A2020202020202020202020202020202076617220646976203D202428223C6469763E3C2F6469763E22293B0A202020202020202020202020202020206469762E616464436C6173732822746F67676C654E6F74696669636174696F6E7322293B';
wwv_flow_api.g_varchar2_table(128) := '0A202020202020202020202020202020206469762E6174747228226964222C20656C656D656E744944202B20225F746F67676C654E6F746522293B0A0A2020202020202020202020202020202076617220756C203D20222322202B20656C656D656E7449';
wwv_flow_api.g_varchar2_table(129) := '44202B20225F756C223B0A0A202020202020202020202020202020206469762E6F6E2822746F75636820636C69636B222C2066756E6374696F6E202829207B0A20202020202020202020202020202020202020202428756C292E746F67676C65436C6173';
wwv_flow_api.g_varchar2_table(130) := '732822746F67676C654C69737422293B0A202020202020202020202020202020207D293B0A0A202020202020202020202020202020202428646F63756D656E74292E6F6E2822746F75636820636C69636B222C2066756E6374696F6E20286529207B0A20';
wwv_flow_api.g_varchar2_table(131) := '202020202020202020202020202020202020206966202828216469762E697328652E74617267657429202626206469762E68617328652E746172676574292E6C656E677468203D3D3D20302920262620212428652E746172676574292E706172656E7473';
wwv_flow_api.g_varchar2_table(132) := '28756C292E6C656E677468203E203029207B0A202020202020202020202020202020202020202020202020696620282428756C292E686173436C6173732822746F67676C654C6973742229203D3D3D2066616C736529207B0A2020202020202020202020';
wwv_flow_api.g_varchar2_table(133) := '20202020202020202020202020202020202428756C292E746F67676C65436C6173732822746F67676C654C69737422293B0A2020202020202020202020202020202020202020202020207D0A20202020202020202020202020202020202020207D0A2020';
wwv_flow_api.g_varchar2_table(134) := '20202020202020202020202020207D293B0A0A2020202020202020202020202020202076617220636F756E74446976203D202428223C6469763E3C2F6469763E22293B0A20202020202020202020202020202020636F756E744469762E616464436C6173';
wwv_flow_api.g_varchar2_table(135) := '732822636F756E7422293B0A202020202020202020202020202020206469762E617070656E6428636F756E74446976293B0A0A20202020202020202020202020202020766172206E756D446976203D202428223C6469763E3C2F6469763E22293B0A2020';
wwv_flow_api.g_varchar2_table(136) := '20202020202020202020202020206E756D4469762E616464436C61737328226E756D22293B0A202020202020202020202020202020206E756D4469762E63737328226261636B67726F756E64222C20636F6E6669674A534F4E2E636F756E746572426163';
wwv_flow_api.g_varchar2_table(137) := '6B67726F756E64436F6C6F72293B0A202020202020202020202020202020206E756D4469762E6373732822636F6C6F72222C20636F6E6669674A534F4E2E636F756E746572466F6E74436F6C6F72293B0A202020202020202020202020202020206E756D';
wwv_flow_api.g_varchar2_table(138) := '4469762E6174747228226964222C20656C656D656E744944202B20225F6E756D64697622293B0A202020202020202020202020202020206E756D4469762E68746D6C28646174614A534F4E2E726F772E6C656E677468293B0A2020202020202020202020';
wwv_flow_api.g_varchar2_table(139) := '2020202020636F756E744469762E617070656E64286E756D446976293B0A0A202020202020202020202020202020207661722062656C6C4C6162656C203D202428223C6C6162656C3E3C2F6C6162656C3E22293B0A202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(140) := '2062656C6C4C6162656C2E616464436C617373282273686F7722293B0A2020202020202020202020202020202062656C6C4C6162656C2E63737328226261636B67726F756E64222C20636F6E6669674A534F4E2E6D61696E49636F6E4261636B67726F75';
wwv_flow_api.g_varchar2_table(141) := '6E64436F6C6F72293B0A0A202020202020202020202020202020207661722062656C6C49203D202428223C693E3C2F693E22293B0A2020202020202020202020202020202062656C6C492E616464436C6173732822666122293B0A202020202020202020';
wwv_flow_api.g_varchar2_table(142) := '2020202020202062656C6C492E616464436C61737328636F6E6669674A534F4E2E6D61696E49636F6E293B0A2020202020202020202020202020202062656C6C492E6373732822636F6C6F72222C20636F6E6669674A534F4E2E6D61696E49636F6E436F';
wwv_flow_api.g_varchar2_table(143) := '6C6F72293B0A0A2020202020202020202020202020202069662028636F6E6669674A534F4E2E6D61696E49636F6E426C696E6B696E6729207B0A202020202020202020202020202020202020202062656C6C492E616464436C617373282266612D626C69';
wwv_flow_api.g_varchar2_table(144) := '6E6B22293B0A202020202020202020202020202020207D0A0A2020202020202020202020202020202062656C6C4C6162656C2E617070656E642862656C6C49293B0A0A202020202020202020202020202020206469762E617070656E642862656C6C4C61';
wwv_flow_api.g_varchar2_table(145) := '62656C293B0A0A20202020202020202020202020202020636F6E7461696E65722E617070656E6428646976293B0A0A2020202020202020202020202020202072656672657368426F647928646174614A534F4E293B0A2020202020202020202020207D0A';
wwv_flow_api.g_varchar2_table(146) := '0A2020202020202020202020202F2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A0A202020202020202020202020202A';
wwv_flow_api.g_varchar2_table(147) := '2A0A202020202020202020202020202A2A205573656420746F20726566726573680A202020202020202020202020202A2A0A202020202020202020202020202A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A';
wwv_flow_api.g_varchar2_table(148) := '2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2F0A20202020202020202020202066756E6374696F6E2072656672657368426F647928646174614A534F4E29207B0A20202020202020202020202020202020766172';
wwv_flow_api.g_varchar2_table(149) := '20746F67676C654E6F7465203D20222322202B20656C656D656E744944202B20225F746F67676C654E6F7465223B0A202020202020202020202020202020202428746F67676C654E6F7465292E6869646528293B0A202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(150) := '2069662028646174614A534F4E2E726F7729207B0A2020202020202020202020202020202020202020766172206E756D4469764944203D20222322202B20656C656D656E744944202B20225F6E756D646976223B0A202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(151) := '202020202076617220756C4944203D20222322202B20656C656D656E744944202B20225F756C223B0A202020202020202020202020202020202020202069662028646174614A534F4E2E726F772E6C656E677468203E203029207B0A2020202020202020';
wwv_flow_api.g_varchar2_table(152) := '2020202020202020202020202020202024286E756D4469764944292E63737328226261636B67726F756E64222C20636F6E6669674A534F4E2E636F756E7465724261636B67726F756E64436F6C6F72293B0A202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(153) := '2020202020202428746F67676C654E6F7465292E73686F7728293B0A20202020202020202020202020202020202020202020202024286E756D4469764944292E73686F7728293B0A20202020202020202020202020202020202020202020202024286E75';
wwv_flow_api.g_varchar2_table(154) := '6D4469764944292E7465787428646174614A534F4E2E726F772E6C656E677468293B0A2020202020202020202020202020202020202020202020202428756C4944292E656D70747928293B0A202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(155) := '647261774C697374282428746F67676C654E6F7465292C20646174614A534F4E290A20202020202020202020202020202020202020207D20656C7365207B0A20202020202020202020202020202020202020202020202069662028636F6E6669674A534F';
wwv_flow_api.g_varchar2_table(156) := '4E2E73686F77416C7761797329207B0A202020202020202020202020202020202020202020202020202020202428746F67676C654E6F7465292E73686F7728293B0A2020202020202020202020202020202020202020202020202020202024286E756D44';
wwv_flow_api.g_varchar2_table(157) := '69764944292E6869646528293B0A2020202020202020202020202020202020202020202020207D0A2020202020202020202020202020202020202020202020202428756C4944292E656D70747928293B0A20202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(158) := '207D0A202020202020202020202020202020207D0A2020202020202020202020207D0A0A2020202020202020202020202F2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A';
wwv_flow_api.g_varchar2_table(159) := '2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A0A202020202020202020202020202A2A0A202020202020202020202020202A2A205573656420746F206472617720746865206E6F7465206C6973740A202020202020202020202020202A2A0A20202020';
wwv_flow_api.g_varchar2_table(160) := '2020202020202020202A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2A2F0A20202020202020202020202066756E637469';
wwv_flow_api.g_varchar2_table(161) := '6F6E20647261774C697374286469762C20646174614A534F4E29207B0A2020202020202020202020202020202076617220737472203D2022223B0A2020202020202020202020202020202076617220756C3B0A2020202020202020202020202020202076';
wwv_flow_api.g_varchar2_table(162) := '617220697352656672657368203D2066616C73653B0A20202020202020202020202020202020696620282428222322202B20656C656D656E744944202B20225F756C22292E6C656E67746829207B0A202020202020202020202020202020202020202075';
wwv_flow_api.g_varchar2_table(163) := '6C203D202428222322202B20656C656D656E744944202B20225F756C22293B0A2020202020202020202020202020202020202020697352656672657368203D20747275653B0A202020202020202020202020202020207D20656C7365207B0A2020202020';
wwv_flow_api.g_varchar2_table(164) := '202020202020202020202020202020756C203D202428223C756C3E3C2F756C3E22293B0A2020202020202020202020202020202020202020756C2E6174747228226964222C20656C656D656E744944202B20225F756C22293B0A20202020202020202020';
wwv_flow_api.g_varchar2_table(165) := '20202020202020202020756C2E616464436C61737328226E6F74696669636174696F6E7322293B0A2020202020202020202020202020202020202020756C2E616464436C6173732822746F67676C654C69737422293B0A20202020202020202020202020';
wwv_flow_api.g_varchar2_table(166) := '2020207D0A0A202020202020202020202020202020206966202869735265667265736820262620636F6E6669674A534F4E2E686964654F6E52656672657368202626202428756C292E686173436C6173732822746F67676C654C6973742229203D3D3D20';
wwv_flow_api.g_varchar2_table(167) := '66616C736529207B0A20202020202020202020202020202020202020202428756C292E616464436C6173732822746F67676C654C69737422293B0A202020202020202020202020202020207D0A0A20202020202020202020202020202020696620286461';
wwv_flow_api.g_varchar2_table(168) := '74614A534F4E2E726F7729207B0A2020202020202020202020202020202020202020242E6561636828646174614A534F4E2E726F772C2066756E6374696F6E20286974656D2C206461746129207B0A202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(169) := '20202069662028636F6E6669674A534F4E2E62726F777365724E6F74696669636174696F6E732E656E61626C656429207B0A2020202020202020202020202020202020202020202020202020202069662028646174612E4E4F5F42524F575345525F4E4F';
wwv_flow_api.g_varchar2_table(170) := '54494649434154494F4E20213D203129207B0A2020202020202020202020202020202020202020202020202020202020202020747279207B0A20202020202020202020202020202020202020202020202020202020202020202020202076617220746974';
wwv_flow_api.g_varchar2_table(171) := '6C652C20746578743B0A20202020202020202020202020202020202020202020202020202020202020202020202069662028646174612E4E4F54455F48454144455229207B0A202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(172) := '202020202020202020207469746C65203D207574696C2E72656D6F766548544D4C28646174612E4E4F54455F484541444552293B0A2020202020202020202020202020202020202020202020202020202020202020202020207D0A202020202020202020';
wwv_flow_api.g_varchar2_table(173) := '20202020202020202020202020202020202020202020202020202069662028646174612E4E4F54455F5445585429207B0A2020202020202020202020202020202020202020202020202020202020202020202020202020202074657874203D207574696C';
wwv_flow_api.g_varchar2_table(174) := '2E72656D6F766548544D4C28646174612E4E4F54455F54455854293B0A2020202020202020202020202020202020202020202020202020202020202020202020202020202074657874203D207574696C2E637574537472696E6728746578742C20636F6E';
wwv_flow_api.g_varchar2_table(175) := '6669674A534F4E2E62726F777365724E6F74696669636174696F6E732E637574426F6479546578744166746572293B0A2020202020202020202020202020202020202020202020202020202020202020202020207D0A2020202020202020202020202020';
wwv_flow_api.g_varchar2_table(176) := '202020202020202020202020202020202020202020202F2A2066697265206E6F74696669636174696F6E2061667465722074696D656F757420666F72206265747465722062726F777365722075736162696C697479202A2F0A2020202020202020202020';
wwv_flow_api.g_varchar2_table(177) := '2020202020202020202020202020202020202020202020202073657454696D656F75742866756E6374696F6E202829207B0A20202020202020202020202020202020202020202020202020202020202020202020202020202020696620282128224E6F74';
wwv_flow_api.g_varchar2_table(178) := '696669636174696F6E2220696E2077696E646F772929207B0A2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020617065782E64656275672E6572726F72287B0A202020202020202020202020';
wwv_flow_api.g_varchar2_table(179) := '20202020202020202020202020202020202020202020202020202020202020202020202022666374223A207574696C2E6665617475726544657461696C732E6E616D65202B2022202D2022202B2022647261774C697374222C0A20202020202020202020';
wwv_flow_api.g_varchar2_table(180) := '2020202020202020202020202020202020202020202020202020202020202020202020202020226D7367223A2022546869732062726F7773657220646F6573206E6F7420737570706F72742073797374656D206E6F74696669636174696F6E73222C0A20';
wwv_flow_api.g_varchar2_table(181) := '2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020226665617475726544657461696C73223A207574696C2E6665617475726544657461696C730A202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(182) := '20202020202020202020202020202020202020202020202020202020207D293B0A202020202020202020202020202020202020202020202020202020202020202020202020202020207D20656C736520696620284E6F74696669636174696F6E2E706572';
wwv_flow_api.g_varchar2_table(183) := '6D697373696F6E203D3D3D20226772616E7465642229207B0A2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020766172206E6F74696669636174696F6E203D206E6577204E6F746966696361';
wwv_flow_api.g_varchar2_table(184) := '74696F6E287469746C652C207B0A202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020626F64793A20746578742C0A2020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(185) := '2020202020202020202020202020202020202020202072657175697265496E746572616374696F6E3A20636F6E6669674A534F4E2E62726F777365724E6F74696669636174696F6E732E72657175697265496E746572616374696F6E0A20202020202020';
wwv_flow_api.g_varchar2_table(186) := '202020202020202020202020202020202020202020202020202020202020202020202020207D293B0A202020202020202020202020202020202020202020202020202020202020202020202020202020202020202069662028636F6E6669674A534F4E2E';
wwv_flow_api.g_varchar2_table(187) := '62726F777365724E6F74696669636174696F6E732E6C696E6B20262620646174612E4E4F54455F4C494E4B29207B0A2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020206E6F746966';
wwv_flow_api.g_varchar2_table(188) := '69636174696F6E2E6F6E636C69636B203D2066756E6374696F6E20286576656E7429207B0A202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207574696C2E6C696E6B2864';
wwv_flow_api.g_varchar2_table(189) := '6174612E4E4F54455F4C494E4B290A2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207D0A2020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(190) := '2020202020202020207D0A202020202020202020202020202020202020202020202020202020202020202020202020202020207D20656C736520696620284E6F74696669636174696F6E2E7065726D697373696F6E20213D3D202764656E696564272920';
wwv_flow_api.g_varchar2_table(191) := '7B0A20202020202020202020202020202020202020202020202020202020202020202020202020202020202020204E6F74696669636174696F6E2E726571756573745065726D697373696F6E2866756E6374696F6E20287065726D697373696F6E29207B';
wwv_flow_api.g_varchar2_table(192) := '0A202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020696620287065726D697373696F6E203D3D3D20226772616E7465642229207B0A20202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(193) := '202020202020202020202020202020202020202020202020202020202020202020766172206E6F74696669636174696F6E203D206E6577204E6F74696669636174696F6E287469746C652C207B0A20202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(194) := '20202020202020202020202020202020202020202020202020202020202020202020626F64793A20746578742C0A202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(195) := '202072657175697265496E746572616374696F6E3A20636F6E6669674A534F4E2E62726F777365724E6F74696669636174696F6E732E72657175697265496E746572616374696F6E0A202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(196) := '202020202020202020202020202020202020202020202020207D293B0A2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202069662028636F6E6669674A534F4E2E62726F77';
wwv_flow_api.g_varchar2_table(197) := '7365724E6F74696669636174696F6E732E6C696E6B20262620646174612E4E4F54455F4C494E4B29207B0A20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020206E';
wwv_flow_api.g_varchar2_table(198) := '6F74696669636174696F6E2E6F6E636C69636B203D2066756E6374696F6E20286576656E7429207B0A2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(199) := '207574696C2E6C696E6B28646174612E4E4F54455F4C494E4B290A20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207D0A202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(200) := '202020202020202020202020202020202020202020202020202020202020202020202020207D0A2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020207D0A2020202020202020202020';
wwv_flow_api.g_varchar2_table(201) := '2020202020202020202020202020202020202020202020202020202020202020207D293B0A202020202020202020202020202020202020202020202020202020202020202020202020202020207D0A202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(202) := '2020202020202020202020202020207D2C20313530202A206974656D293B0A20202020202020202020202020202020202020202020202020202020202020207D20636174636820286529207B0A2020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(203) := '20202020202020202020202020617065782E64656275672E6572726F72287B0A2020202020202020202020202020202020202020202020202020202020202020202020202020202022666374223A207574696C2E6665617475726544657461696C732E6E';
wwv_flow_api.g_varchar2_table(204) := '616D65202B2022202D2022202B2022647261774C697374222C0A20202020202020202020202020202020202020202020202020202020202020202020202020202020226D7367223A20224572726F72207768696C652074727920746F20676574206E6F74';
wwv_flow_api.g_varchar2_table(205) := '696669636174696F6E207065726D697373696F6E222C0A2020202020202020202020202020202020202020202020202020202020202020202020202020202022657272223A20652C0A202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(206) := '20202020202020202020202020226665617475726544657461696C73223A207574696C2E6665617475726544657461696C730A2020202020202020202020202020202020202020202020202020202020202020202020207D293B0A202020202020202020';
wwv_flow_api.g_varchar2_table(207) := '20202020202020202020202020202020202020202020207D0A202020202020202020202020202020202020202020202020202020207D0A2020202020202020202020202020202020202020202020207D0A0A202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(208) := '20202020202069662028646174612E4E4F54455F48454144455229207B0A20202020202020202020202020202020202020202020202020202020646174612E4E4F54455F484541444552203D206573636170654F7253616E6974697A6548544D4C286461';
wwv_flow_api.g_varchar2_table(209) := '74612E4E4F54455F484541444552293B0A2020202020202020202020202020202020202020202020207D0A20202020202020202020202020202020202020202020202069662028646174612E4E4F54455F49434F4E29207B0A2020202020202020202020';
wwv_flow_api.g_varchar2_table(210) := '2020202020202020202020202020202020646174612E4E4F54455F49434F4E203D206573636170654F7253616E6974697A6548544D4C28646174612E4E4F54455F49434F4E293B0A2020202020202020202020202020202020202020202020207D0A2020';
wwv_flow_api.g_varchar2_table(211) := '2020202020202020202020202020202020202020202069662028646174612E4E4F54455F49434F4E5F434F4C4F5229207B0A20202020202020202020202020202020202020202020202020202020646174612E4E4F54455F49434F4E5F434F4C4F52203D';
wwv_flow_api.g_varchar2_table(212) := '206573636170654F7253616E6974697A6548544D4C28646174612E4E4F54455F49434F4E5F434F4C4F52293B0A2020202020202020202020202020202020202020202020207D0A2020202020202020202020202020202020202020202020206966202864';
wwv_flow_api.g_varchar2_table(213) := '6174612E4E4F54455F5445585429207B0A20202020202020202020202020202020202020202020202020202020646174612E4E4F54455F54455854203D206573636170654F7253616E6974697A6548544D4C28646174612E4E4F54455F54455854293B0A';
wwv_flow_api.g_varchar2_table(214) := '2020202020202020202020202020202020202020202020207D0A0A2020202020202020202020202020202020202020202020207661722061203D202428223C613E3C2F613E22293B0A0A2020202020202020202020202020202020202020202020206966';
wwv_flow_api.g_varchar2_table(215) := '2028646174612E4E4F54455F4C494E4B29207B0A20202020202020202020202020202020202020202020202020202020612E61747472282268726566222C20646174612E4E4F54455F4C494E4B293B0A2020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(216) := '202020202020202069662028636F6E6669674A534F4E2E6C696E6B546172676574426C616E6B29207B0A2020202020202020202020202020202020202020202020202020202020202020612E617474722822746172676574222C20225F626C616E6B2229';
wwv_flow_api.g_varchar2_table(217) := '3B0A202020202020202020202020202020202020202020202020202020207D0A20202020202020202020202020202020202020202020202020202020612E6F6E2822746F75636820636C69636B222C2066756E6374696F6E20286529207B0A2020202020';
wwv_flow_api.g_varchar2_table(218) := '2020202020202020202020202020202020202020202020202020202428756C292E616464436C6173732822746F67676C654C69737422293B0A202020202020202020202020202020202020202020202020202020207D293B0A2020202020202020202020';
wwv_flow_api.g_varchar2_table(219) := '202020202020202020202020207D0A0A202020202020202020202020202020202020202020202020766172206C69203D202428223C6C693E3C2F6C693E22293B0A2020202020202020202020202020202020202020202020206C692E616464436C617373';
wwv_flow_api.g_varchar2_table(220) := '28226E6F746522293B0A20202020202020202020202020202020202020202020202069662028646174612E4E4F54455F434F4C4F5229207B0A202020202020202020202020202020202020202020202020202020206C692E6373732822626F782D736861';
wwv_flow_api.g_varchar2_table(221) := '646F77222C20222D3570782030203020302022202B20646174612E4E4F54455F434F4C4F52293B0A2020202020202020202020202020202020202020202020207D0A0A20202020202020202020202020202020202020202020202069662028646174612E';
wwv_flow_api.g_varchar2_table(222) := '4E4F54455F414343455054207C7C20646174612E4E4F54455F4445434C494E4529207B0A202020202020202020202020202020202020202020202020202020206C692E637373282270616464696E672D7269676874222C20223332707822293B0A0A2020';
wwv_flow_api.g_varchar2_table(223) := '202020202020202020202020202020202020202020202020202069662028646174612E4E4F54455F41434345505429207B0A20202020202020202020202020202020202020202020202020202020202020207661722061636365707441203D202428223C';
wwv_flow_api.g_varchar2_table(224) := '613E3C2F613E22293B0A2020202020202020202020202020202020202020202020202020202020202020616363657074412E616464436C61737328226163636570742D6122293B0A20202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(225) := '20202020616363657074412E61747472282268726566222C20646174612E4E4F54455F414343455054293B0A0A20202020202020202020202020202020202020202020202020202020202020207661722061636365707449203D202428223C693E3C2F69';
wwv_flow_api.g_varchar2_table(226) := '3E22293B0A2020202020202020202020202020202020202020202020202020202020202020616363657074492E616464436C6173732822666122293B0A202020202020202020202020202020202020202020202020202020202020202061636365707449';
wwv_flow_api.g_varchar2_table(227) := '2E616464436C61737328636F6E6669674A534F4E2E6163636570742E69636F6E293B0A2020202020202020202020202020202020202020202020202020202020202020616363657074492E6373732822636F6C6F72222C20636F6E6669674A534F4E2E61';
wwv_flow_api.g_varchar2_table(228) := '63636570742E636F6C6F72293B0A2020202020202020202020202020202020202020202020202020202020202020616363657074492E6373732822666F6E742D73697A65222C20223230707822293B0A2020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(229) := '202020202020202020202020616363657074412E617070656E642861636365707449293B0A0A20202020202020202020202020202020202020202020202020202020202020206C692E617070656E642861636365707441293B0A20202020202020202020';
wwv_flow_api.g_varchar2_table(230) := '2020202020202020202020202020202020207D0A2020202020202020202020202020202020202020202020202020202069662028646174612E4E4F54455F4445434C494E4529207B0A202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(231) := '2020202020766172206465636C696E6541203D202428223C613E3C2F613E22293B0A20202020202020202020202020202020202020202020202020202020202020206465636C696E65412E616464436C61737328226465636C696E652D6122293B0A2020';
wwv_flow_api.g_varchar2_table(232) := '2020202020202020202020202020202020202020202020202020202020206465636C696E65412E61747472282268726566222C20646174612E4E4F54455F4445434C494E45293B0A20202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(233) := '2020202069662028646174612E4E4F54455F41434345505429207B0A2020202020202020202020202020202020202020202020202020202020202020202020206465636C696E65412E6373732822626F74746F6D222C20223430707822293B0A20202020';
wwv_flow_api.g_varchar2_table(234) := '202020202020202020202020202020202020202020202020202020207D0A0A2020202020202020202020202020202020202020202020202020202020202020766172206465636C696E6549203D202428223C693E3C2F693E22293B0A2020202020202020';
wwv_flow_api.g_varchar2_table(235) := '2020202020202020202020202020202020202020202020206465636C696E65492E616464436C6173732822666122293B0A20202020202020202020202020202020202020202020202020202020202020206465636C696E65492E616464436C6173732863';
wwv_flow_api.g_varchar2_table(236) := '6F6E6669674A534F4E2E6465636C696E652E69636F6E293B0A20202020202020202020202020202020202020202020202020202020202020206465636C696E65492E6373732822636F6C6F72222C20636F6E6669674A534F4E2E6465636C696E652E636F';
wwv_flow_api.g_varchar2_table(237) := '6C6F72293B0A20202020202020202020202020202020202020202020202020202020202020206465636C696E65492E6373732822666F6E742D73697A65222C20223234707822293B0A202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(238) := '20202020206465636C696E65412E617070656E64286465636C696E6549293B0A0A20202020202020202020202020202020202020202020202020202020202020206C692E617070656E64286465636C696E6541293B0A2020202020202020202020202020';
wwv_flow_api.g_varchar2_table(239) := '20202020202020202020202020207D0A2020202020202020202020202020202020202020202020207D0A0A202020202020202020202020202020202020202020202020766172206E6F7465486561646572203D202428223C6469763E3C2F6469763E2229';
wwv_flow_api.g_varchar2_table(240) := '3B0A2020202020202020202020202020202020202020202020206E6F74654865616465722E616464436C61737328226E6F74652D68656164657222293B0A0A2020202020202020202020202020202020202020202020207661722069203D202428223C69';
wwv_flow_api.g_varchar2_table(241) := '3E3C2F693E22293B0A202020202020202020202020202020202020202020202020692E616464436C6173732822666122293B0A20202020202020202020202020202020202020202020202069662028646174612E4E4F54455F49434F4E29207B0A202020';
wwv_flow_api.g_varchar2_table(242) := '20202020202020202020202020202020202020202020202020692E616464436C61737328646174612E4E4F54455F49434F4E293B0A2020202020202020202020202020202020202020202020207D0A202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(243) := '20202069662028646174612E4E4F54455F49434F4E5F434F4C4F5229207B0A20202020202020202020202020202020202020202020202020202020692E6373732822636F6C6F72222C20646174612E4E4F54455F49434F4E5F434F4C4F52293B0A202020';
wwv_flow_api.g_varchar2_table(244) := '2020202020202020202020202020202020202020207D0A202020202020202020202020202020202020202020202020692E616464436C617373282266612D6C6722293B0A0A2020202020202020202020202020202020202020202020206E6F7465486561';
wwv_flow_api.g_varchar2_table(245) := '6465722E617070656E642869293B0A20202020202020202020202020202020202020202020202069662028646174612E4E4F54455F48454144455229207B0A202020202020202020202020202020202020202020202020202020206E6F74654865616465';
wwv_flow_api.g_varchar2_table(246) := '722E617070656E6428646174612E4E4F54455F484541444552293B0A2020202020202020202020202020202020202020202020207D0A2020202020202020202020202020202020202020202020206C692E617070656E64286E6F7465486561646572293B';
wwv_flow_api.g_varchar2_table(247) := '0A0A202020202020202020202020202020202020202020202020766172207370616E203D202428223C7370616E3E3C2F7370616E3E22293B0A2020202020202020202020202020202020202020202020207370616E2E616464436C61737328226E6F7465';
wwv_flow_api.g_varchar2_table(248) := '2D696E666F22293B0A20202020202020202020202020202020202020202020202069662028646174612E4E4F54455F5445585429207B0A202020202020202020202020202020202020202020202020202020207370616E2E68746D6C28646174612E4E4F';
wwv_flow_api.g_varchar2_table(249) := '54455F54455854293B0A2020202020202020202020202020202020202020202020207D0A2020202020202020202020202020202020202020202020206C692E617070656E64287370616E293B0A0A20202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(250) := '2020612E617070656E64286C69293B0A0A202020202020202020202020202020202020202020202020756C2E617070656E642861293B0A20202020202020202020202020202020202020207D293B0A0A202020202020202020202020202020207D0A0A20';
wwv_flow_api.g_varchar2_table(251) := '202020202020202020202020202020242822626F647922292E617070656E6428756C293B0A2020202020202020202020207D0A20202020202020207D0A202020207D0A7D2928293B0A';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(79120054173200975)
,p_plugin_id=>wwv_flow_api.id(138285470529447569213)
,p_file_name=>'script.js'
,p_mime_type=>'text/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2F2A2120406C6963656E736520444F4D50757269667920332E322E34207C202863292043757265353320616E64206F7468657220636F6E7472696275746F7273207C2052656C656173656420756E6465722074686520417061636865206C6963656E7365';
wwv_flow_api.g_varchar2_table(2) := '20322E3020616E64204D6F7A696C6C61205075626C6963204C6963656E736520322E30207C206769746875622E636F6D2F6375726535332F444F4D5075726966792F626C6F622F332E322E342F4C4943454E5345202A2F0A0A2866756E6374696F6E2028';
wwv_flow_api.g_varchar2_table(3) := '676C6F62616C2C20666163746F727929207B0A2020747970656F66206578706F727473203D3D3D20276F626A6563742720262620747970656F66206D6F64756C6520213D3D2027756E646566696E656427203F206D6F64756C652E6578706F727473203D';
wwv_flow_api.g_varchar2_table(4) := '20666163746F72792829203A0A2020747970656F6620646566696E65203D3D3D202766756E6374696F6E2720262620646566696E652E616D64203F20646566696E6528666163746F727929203A0A202028676C6F62616C203D20747970656F6620676C6F';
wwv_flow_api.g_varchar2_table(5) := '62616C5468697320213D3D2027756E646566696E656427203F20676C6F62616C54686973203A20676C6F62616C207C7C2073656C662C20676C6F62616C2E444F4D507572696679203D20666163746F72792829293B0A7D2928746869732C202866756E63';
wwv_flow_api.g_varchar2_table(6) := '74696F6E202829207B202775736520737472696374273B0A0A2020636F6E7374207B0A20202020656E74726965732C0A2020202073657450726F746F747970654F662C0A20202020697346726F7A656E2C0A2020202067657450726F746F747970654F66';
wwv_flow_api.g_varchar2_table(7) := '2C0A202020206765744F776E50726F706572747944657363726970746F720A20207D203D204F626A6563743B0A20206C6574207B0A20202020667265657A652C0A202020207365616C2C0A202020206372656174650A20207D203D204F626A6563743B20';
wwv_flow_api.g_varchar2_table(8) := '2F2F2065736C696E742D64697361626C652D6C696E6520696D706F72742F6E6F2D6D757461626C652D6578706F7274730A20206C6574207B0A202020206170706C792C0A20202020636F6E7374727563740A20207D203D20747970656F66205265666C65';
wwv_flow_api.g_varchar2_table(9) := '637420213D3D2027756E646566696E656427202626205265666C6563743B0A20206966202821667265657A6529207B0A20202020667265657A65203D2066756E6374696F6E20667265657A65287829207B0A20202020202072657475726E20783B0A2020';
wwv_flow_api.g_varchar2_table(10) := '20207D3B0A20207D0A202069662028217365616C29207B0A202020207365616C203D2066756E6374696F6E207365616C287829207B0A20202020202072657475726E20783B0A202020207D3B0A20207D0A202069662028216170706C7929207B0A202020';
wwv_flow_api.g_varchar2_table(11) := '206170706C79203D2066756E6374696F6E206170706C792866756E2C207468697356616C75652C206172677329207B0A20202020202072657475726E2066756E2E6170706C79287468697356616C75652C2061726773293B0A202020207D3B0A20207D0A';
wwv_flow_api.g_varchar2_table(12) := '20206966202821636F6E73747275637429207B0A20202020636F6E737472756374203D2066756E6374696F6E20636F6E7374727563742846756E632C206172677329207B0A20202020202072657475726E206E65772046756E63282E2E2E61726773293B';
wwv_flow_api.g_varchar2_table(13) := '0A202020207D3B0A20207D0A2020636F6E7374206172726179466F7245616368203D20756E6170706C792841727261792E70726F746F747970652E666F7245616368293B0A2020636F6E73742061727261794C617374496E6465784F66203D20756E6170';
wwv_flow_api.g_varchar2_table(14) := '706C792841727261792E70726F746F747970652E6C617374496E6465784F66293B0A2020636F6E7374206172726179506F70203D20756E6170706C792841727261792E70726F746F747970652E706F70293B0A2020636F6E737420617272617950757368';
wwv_flow_api.g_varchar2_table(15) := '203D20756E6170706C792841727261792E70726F746F747970652E70757368293B0A2020636F6E737420617272617953706C696365203D20756E6170706C792841727261792E70726F746F747970652E73706C696365293B0A2020636F6E737420737472';
wwv_flow_api.g_varchar2_table(16) := '696E67546F4C6F77657243617365203D20756E6170706C7928537472696E672E70726F746F747970652E746F4C6F77657243617365293B0A2020636F6E737420737472696E67546F537472696E67203D20756E6170706C7928537472696E672E70726F74';
wwv_flow_api.g_varchar2_table(17) := '6F747970652E746F537472696E67293B0A2020636F6E737420737472696E674D61746368203D20756E6170706C7928537472696E672E70726F746F747970652E6D61746368293B0A2020636F6E737420737472696E675265706C616365203D20756E6170';
wwv_flow_api.g_varchar2_table(18) := '706C7928537472696E672E70726F746F747970652E7265706C616365293B0A2020636F6E737420737472696E67496E6465784F66203D20756E6170706C7928537472696E672E70726F746F747970652E696E6465784F66293B0A2020636F6E7374207374';
wwv_flow_api.g_varchar2_table(19) := '72696E675472696D203D20756E6170706C7928537472696E672E70726F746F747970652E7472696D293B0A2020636F6E7374206F626A6563744861734F776E50726F7065727479203D20756E6170706C79284F626A6563742E70726F746F747970652E68';
wwv_flow_api.g_varchar2_table(20) := '61734F776E50726F7065727479293B0A2020636F6E73742072656745787054657374203D20756E6170706C79285265674578702E70726F746F747970652E74657374293B0A2020636F6E737420747970654572726F72437265617465203D20756E636F6E';
wwv_flow_api.g_varchar2_table(21) := '73747275637428547970654572726F72293B0A20202F2A2A0A2020202A20437265617465732061206E65772066756E6374696F6E20746861742063616C6C732074686520676976656E2066756E6374696F6E207769746820612073706563696669656420';
wwv_flow_api.g_varchar2_table(22) := '7468697341726720616E6420617267756D656E74732E0A2020202A0A2020202A2040706172616D2066756E63202D205468652066756E6374696F6E20746F206265207772617070656420616E642063616C6C65642E0A2020202A204072657475726E7320';
wwv_flow_api.g_varchar2_table(23) := '41206E65772066756E6374696F6E20746861742063616C6C732074686520676976656E2066756E6374696F6E2077697468206120737065636966696564207468697341726720616E6420617267756D656E74732E0A2020202A2F0A202066756E6374696F';
wwv_flow_api.g_varchar2_table(24) := '6E20756E6170706C792866756E6329207B0A2020202072657475726E2066756E6374696F6E20287468697341726729207B0A202020202020666F722028766172205F6C656E203D20617267756D656E74732E6C656E6774682C2061726773203D206E6577';
wwv_flow_api.g_varchar2_table(25) := '204172726179285F6C656E203E2031203F205F6C656E202D2031203A2030292C205F6B6579203D20313B205F6B6579203C205F6C656E3B205F6B65792B2B29207B0A2020202020202020617267735B5F6B6579202D20315D203D20617267756D656E7473';
wwv_flow_api.g_varchar2_table(26) := '5B5F6B65795D3B0A2020202020207D0A20202020202072657475726E206170706C792866756E632C20746869734172672C2061726773293B0A202020207D3B0A20207D0A20202F2A2A0A2020202A20437265617465732061206E65772066756E6374696F';
wwv_flow_api.g_varchar2_table(27) := '6E207468617420636F6E7374727563747320616E20696E7374616E6365206F662074686520676976656E20636F6E7374727563746F722066756E6374696F6E2077697468207468652070726F766964656420617267756D656E74732E0A2020202A0A2020';
wwv_flow_api.g_varchar2_table(28) := '202A2040706172616D2066756E63202D2054686520636F6E7374727563746F722066756E6374696F6E20746F206265207772617070656420616E642063616C6C65642E0A2020202A204072657475726E732041206E65772066756E6374696F6E20746861';
wwv_flow_api.g_varchar2_table(29) := '7420636F6E7374727563747320616E20696E7374616E6365206F662074686520676976656E20636F6E7374727563746F722066756E6374696F6E2077697468207468652070726F766964656420617267756D656E74732E0A2020202A2F0A202066756E63';
wwv_flow_api.g_varchar2_table(30) := '74696F6E20756E636F6E7374727563742866756E6329207B0A2020202072657475726E2066756E6374696F6E202829207B0A202020202020666F722028766172205F6C656E32203D20617267756D656E74732E6C656E6774682C2061726773203D206E65';
wwv_flow_api.g_varchar2_table(31) := '77204172726179285F6C656E32292C205F6B657932203D20303B205F6B657932203C205F6C656E323B205F6B6579322B2B29207B0A2020202020202020617267735B5F6B6579325D203D20617267756D656E74735B5F6B6579325D3B0A2020202020207D';
wwv_flow_api.g_varchar2_table(32) := '0A20202020202072657475726E20636F6E7374727563742866756E632C2061726773293B0A202020207D3B0A20207D0A20202F2A2A0A2020202A204164642070726F7065727469657320746F2061206C6F6F6B7570207461626C650A2020202A0A202020';
wwv_flow_api.g_varchar2_table(33) := '2A2040706172616D20736574202D205468652073657420746F20776869636820656C656D656E74732077696C6C2062652061646465642E0A2020202A2040706172616D206172726179202D2054686520617272617920636F6E7461696E696E6720656C65';
wwv_flow_api.g_varchar2_table(34) := '6D656E747320746F20626520616464656420746F20746865207365742E0A2020202A2040706172616D207472616E73666F726D4361736546756E63202D20416E206F7074696F6E616C2066756E6374696F6E20746F207472616E73666F726D2074686520';
wwv_flow_api.g_varchar2_table(35) := '63617365206F66206561636820656C656D656E74206265666F726520616464696E6720746F20746865207365742E0A2020202A204072657475726E7320546865206D6F64696669656420736574207769746820616464656420656C656D656E74732E0A20';
wwv_flow_api.g_varchar2_table(36) := '20202A2F0A202066756E6374696F6E20616464546F536574287365742C20617272617929207B0A202020206C6574207472616E73666F726D4361736546756E63203D20617267756D656E74732E6C656E677468203E203220262620617267756D656E7473';
wwv_flow_api.g_varchar2_table(37) := '5B325D20213D3D20756E646566696E6564203F20617267756D656E74735B325D203A20737472696E67546F4C6F776572436173653B0A202020206966202873657450726F746F747970654F6629207B0A2020202020202F2F204D616B652027696E272061';
wwv_flow_api.g_varchar2_table(38) := '6E642074727574687920636865636B73206C696B6520426F6F6C65616E287365742E636F6E7374727563746F72290A2020202020202F2F20696E646570656E64656E74206F6620616E792070726F7065727469657320646566696E6564206F6E204F626A';
wwv_flow_api.g_varchar2_table(39) := '6563742E70726F746F747970652E0A2020202020202F2F2050726576656E742070726F746F7479706520736574746572732066726F6D20696E74657263657074696E6720736574206173206120746869732076616C75652E0A2020202020207365745072';
wwv_flow_api.g_varchar2_table(40) := '6F746F747970654F66287365742C206E756C6C293B0A202020207D0A202020206C6574206C203D2061727261792E6C656E6774683B0A202020207768696C6520286C2D2D29207B0A2020202020206C657420656C656D656E74203D2061727261795B6C5D';
wwv_flow_api.g_varchar2_table(41) := '3B0A20202020202069662028747970656F6620656C656D656E74203D3D3D2027737472696E672729207B0A2020202020202020636F6E7374206C63456C656D656E74203D207472616E73666F726D4361736546756E6328656C656D656E74293B0A202020';
wwv_flow_api.g_varchar2_table(42) := '2020202020696620286C63456C656D656E7420213D3D20656C656D656E7429207B0A202020202020202020202F2F20436F6E66696720707265736574732028652E672E20746167732E6A732C2061747472732E6A73292061726520696D6D757461626C65';
wwv_flow_api.g_varchar2_table(43) := '2E0A202020202020202020206966202821697346726F7A656E2861727261792929207B0A20202020202020202020202061727261795B6C5D203D206C63456C656D656E743B0A202020202020202020207D0A20202020202020202020656C656D656E7420';
wwv_flow_api.g_varchar2_table(44) := '3D206C63456C656D656E743B0A20202020202020207D0A2020202020207D0A2020202020207365745B656C656D656E745D203D20747275653B0A202020207D0A2020202072657475726E207365743B0A20207D0A20202F2A2A0A2020202A20436C65616E';
wwv_flow_api.g_varchar2_table(45) := '20757020616E20617272617920746F2068617264656E20616761696E737420435350500A2020202A0A2020202A2040706172616D206172726179202D2054686520617272617920746F20626520636C65616E65642E0A2020202A204072657475726E7320';
wwv_flow_api.g_varchar2_table(46) := '54686520636C65616E65642076657273696F6E206F66207468652061727261790A2020202A2F0A202066756E6374696F6E20636C65616E417272617928617272617929207B0A20202020666F7220286C657420696E646578203D20303B20696E64657820';
wwv_flow_api.g_varchar2_table(47) := '3C2061727261792E6C656E6774683B20696E6465782B2B29207B0A202020202020636F6E737420697350726F70657274794578697374203D206F626A6563744861734F776E50726F70657274792861727261792C20696E646578293B0A20202020202069';
wwv_flow_api.g_varchar2_table(48) := '66202821697350726F7065727479457869737429207B0A202020202020202061727261795B696E6465785D203D206E756C6C3B0A2020202020207D0A202020207D0A2020202072657475726E2061727261793B0A20207D0A20202F2A2A0A2020202A2053';
wwv_flow_api.g_varchar2_table(49) := '68616C6C6F7720636C6F6E6520616E206F626A6563740A2020202A0A2020202A2040706172616D206F626A656374202D20546865206F626A65637420746F20626520636C6F6E65642E0A2020202A204072657475726E732041206E6577206F626A656374';
wwv_flow_api.g_varchar2_table(50) := '207468617420636F7069657320746865206F726967696E616C2E0A2020202A2F0A202066756E6374696F6E20636C6F6E65286F626A65637429207B0A20202020636F6E7374206E65774F626A656374203D20637265617465286E756C6C293B0A20202020';
wwv_flow_api.g_varchar2_table(51) := '666F722028636F6E7374205B70726F70657274792C2076616C75655D206F6620656E7472696573286F626A6563742929207B0A202020202020636F6E737420697350726F70657274794578697374203D206F626A6563744861734F776E50726F70657274';
wwv_flow_api.g_varchar2_table(52) := '79286F626A6563742C2070726F7065727479293B0A20202020202069662028697350726F7065727479457869737429207B0A20202020202020206966202841727261792E697341727261792876616C75652929207B0A202020202020202020206E65774F';
wwv_flow_api.g_varchar2_table(53) := '626A6563745B70726F70657274795D203D20636C65616E41727261792876616C7565293B0A20202020202020207D20656C7365206966202876616C756520262620747970656F662076616C7565203D3D3D20276F626A656374272026262076616C75652E';
wwv_flow_api.g_varchar2_table(54) := '636F6E7374727563746F72203D3D3D204F626A65637429207B0A202020202020202020206E65774F626A6563745B70726F70657274795D203D20636C6F6E652876616C7565293B0A20202020202020207D20656C7365207B0A202020202020202020206E';
wwv_flow_api.g_varchar2_table(55) := '65774F626A6563745B70726F70657274795D203D2076616C75653B0A20202020202020207D0A2020202020207D0A202020207D0A2020202072657475726E206E65774F626A6563743B0A20207D0A20202F2A2A0A2020202A2054686973206D6574686F64';
wwv_flow_api.g_varchar2_table(56) := '206175746F6D61746963616C6C7920636865636B73206966207468652070726F702069732066756E6374696F6E206F722067657474657220616E642062656861766573206163636F7264696E676C792E0A2020202A0A2020202A2040706172616D206F62';
wwv_flow_api.g_varchar2_table(57) := '6A656374202D20546865206F626A65637420746F206C6F6F6B20757020746865206765747465722066756E6374696F6E20696E206974732070726F746F7479706520636861696E2E0A2020202A2040706172616D2070726F70202D205468652070726F70';
wwv_flow_api.g_varchar2_table(58) := '65727479206E616D6520666F7220776869636820746F2066696E6420746865206765747465722066756E6374696F6E2E0A2020202A204072657475726E7320546865206765747465722066756E6374696F6E20666F756E6420696E207468652070726F74';
wwv_flow_api.g_varchar2_table(59) := '6F7479706520636861696E206F7220612066616C6C6261636B2066756E6374696F6E2E0A2020202A2F0A202066756E6374696F6E206C6F6F6B7570476574746572286F626A6563742C2070726F7029207B0A202020207768696C6520286F626A65637420';
wwv_flow_api.g_varchar2_table(60) := '213D3D206E756C6C29207B0A202020202020636F6E73742064657363203D206765744F776E50726F706572747944657363726970746F72286F626A6563742C2070726F70293B0A202020202020696620286465736329207B0A2020202020202020696620';
wwv_flow_api.g_varchar2_table(61) := '28646573632E67657429207B0A2020202020202020202072657475726E20756E6170706C7928646573632E676574293B0A20202020202020207D0A202020202020202069662028747970656F6620646573632E76616C7565203D3D3D202766756E637469';
wwv_flow_api.g_varchar2_table(62) := '6F6E2729207B0A2020202020202020202072657475726E20756E6170706C7928646573632E76616C7565293B0A20202020202020207D0A2020202020207D0A2020202020206F626A656374203D2067657450726F746F747970654F66286F626A65637429';
wwv_flow_api.g_varchar2_table(63) := '3B0A202020207D0A2020202066756E6374696F6E2066616C6C6261636B56616C75652829207B0A20202020202072657475726E206E756C6C3B0A202020207D0A2020202072657475726E2066616C6C6261636B56616C75653B0A20207D0A0A2020636F6E';
wwv_flow_api.g_varchar2_table(64) := '73742068746D6C2431203D20667265657A65285B2761272C202761626272272C20276163726F6E796D272C202761646472657373272C202761726561272C202761727469636C65272C20276173696465272C2027617564696F272C202762272C20276264';
wwv_flow_api.g_varchar2_table(65) := '69272C202762646F272C2027626967272C2027626C696E6B272C2027626C6F636B71756F7465272C2027626F6479272C20276272272C2027627574746F6E272C202763616E766173272C202763617074696F6E272C202763656E746572272C2027636974';
wwv_flow_api.g_varchar2_table(66) := '65272C2027636F6465272C2027636F6C272C2027636F6C67726F7570272C2027636F6E74656E74272C202764617461272C2027646174616C697374272C20276464272C20276465636F7261746F72272C202764656C272C202764657461696C73272C2027';
wwv_flow_api.g_varchar2_table(67) := '64666E272C20276469616C6F67272C2027646972272C2027646976272C2027646C272C20276474272C2027656C656D656E74272C2027656D272C20276669656C64736574272C202766696763617074696F6E272C2027666967757265272C2027666F6E74';
wwv_flow_api.g_varchar2_table(68) := '272C2027666F6F746572272C2027666F726D272C20276831272C20276832272C20276833272C20276834272C20276835272C20276836272C202768656164272C2027686561646572272C20276867726F7570272C20276872272C202768746D6C272C2027';
wwv_flow_api.g_varchar2_table(69) := '69272C2027696D67272C2027696E707574272C2027696E73272C20276B6264272C20276C6162656C272C20276C6567656E64272C20276C69272C20276D61696E272C20276D6170272C20276D61726B272C20276D617271756565272C20276D656E75272C';
wwv_flow_api.g_varchar2_table(70) := '20276D656E756974656D272C20276D65746572272C20276E6176272C20276E6F6272272C20276F6C272C20276F707467726F7570272C20276F7074696F6E272C20276F7574707574272C202770272C202770696374757265272C2027707265272C202770';
wwv_flow_api.g_varchar2_table(71) := '726F6772657373272C202771272C20277270272C20277274272C202772756279272C202773272C202773616D70272C202773656374696F6E272C202773656C656374272C2027736861646F77272C2027736D616C6C272C2027736F75726365272C202773';
wwv_flow_api.g_varchar2_table(72) := '7061636572272C20277370616E272C2027737472696B65272C20277374726F6E67272C20277374796C65272C2027737562272C202773756D6D617279272C2027737570272C20277461626C65272C202774626F6479272C20277464272C202774656D706C';
wwv_flow_api.g_varchar2_table(73) := '617465272C20277465787461726561272C202774666F6F74272C20277468272C20277468656164272C202774696D65272C20277472272C2027747261636B272C20277474272C202775272C2027756C272C2027766172272C2027766964656F272C202777';
wwv_flow_api.g_varchar2_table(74) := '6272275D293B0A2020636F6E7374207376672431203D20667265657A65285B27737667272C202761272C2027616C74676C797068272C2027616C74676C797068646566272C2027616C74676C7970686974656D272C2027616E696D617465636F6C6F7227';
wwv_flow_api.g_varchar2_table(75) := '2C2027616E696D6174656D6F74696F6E272C2027616E696D6174657472616E73666F726D272C2027636972636C65272C2027636C697070617468272C202764656673272C202764657363272C2027656C6C69707365272C202766696C746572272C202766';
wwv_flow_api.g_varchar2_table(76) := '6F6E74272C202767272C2027676C797068272C2027676C797068726566272C2027686B65726E272C2027696D616765272C20276C696E65272C20276C696E6561726772616469656E74272C20276D61726B6572272C20276D61736B272C20276D65746164';
wwv_flow_api.g_varchar2_table(77) := '617461272C20276D70617468272C202770617468272C20277061747465726E272C2027706F6C79676F6E272C2027706F6C796C696E65272C202772616469616C6772616469656E74272C202772656374272C202773746F70272C20277374796C65272C20';
wwv_flow_api.g_varchar2_table(78) := '27737769746368272C202773796D626F6C272C202774657874272C20277465787470617468272C20277469746C65272C202774726566272C2027747370616E272C202776696577272C2027766B65726E275D293B0A2020636F6E73742073766746696C74';
wwv_flow_api.g_varchar2_table(79) := '657273203D20667265657A65285B276665426C656E64272C20276665436F6C6F724D6174726978272C20276665436F6D706F6E656E745472616E73666572272C20276665436F6D706F73697465272C20276665436F6E766F6C76654D6174726978272C20';
wwv_flow_api.g_varchar2_table(80) := '276665446966667573654C69676874696E67272C20276665446973706C6163656D656E744D6170272C2027666544697374616E744C69676874272C2027666544726F70536861646F77272C20276665466C6F6F64272C2027666546756E6341272C202766';
wwv_flow_api.g_varchar2_table(81) := '6546756E6342272C2027666546756E6347272C2027666546756E6352272C20276665476175737369616E426C7572272C20276665496D616765272C202766654D65726765272C202766654D657267654E6F6465272C202766654D6F7270686F6C6F677927';
wwv_flow_api.g_varchar2_table(82) := '2C202766654F6666736574272C20276665506F696E744C69676874272C2027666553706563756C61724C69676874696E67272C2027666553706F744C69676874272C2027666554696C65272C2027666554757262756C656E6365275D293B0A20202F2F20';
wwv_flow_api.g_varchar2_table(83) := '4C697374206F662053564720656C656D656E747320746861742061726520646973616C6C6F7765642062792064656661756C742E0A20202F2F205765207374696C6C206E65656420746F206B6E6F77207468656D20736F20746861742077652063616E20';
wwv_flow_api.g_varchar2_table(84) := '646F206E616D6573706163650A20202F2F20636865636B732070726F7065726C7920696E2063617365206F6E652077616E747320746F20616464207468656D20746F0A20202F2F20616C6C6F772D6C6973742E0A2020636F6E737420737667446973616C';
wwv_flow_api.g_varchar2_table(85) := '6C6F776564203D20667265657A65285B27616E696D617465272C2027636F6C6F722D70726F66696C65272C2027637572736F72272C202764697363617264272C2027666F6E742D66616365272C2027666F6E742D666163652D666F726D6174272C202766';
wwv_flow_api.g_varchar2_table(86) := '6F6E742D666163652D6E616D65272C2027666F6E742D666163652D737263272C2027666F6E742D666163652D757269272C2027666F726569676E6F626A656374272C20276861746368272C2027686174636870617468272C20276D657368272C20276D65';
wwv_flow_api.g_varchar2_table(87) := '73686772616469656E74272C20276D6573687061746368272C20276D657368726F77272C20276D697373696E672D676C797068272C2027736372697074272C2027736574272C2027736F6C6964636F6C6F72272C2027756E6B6E6F776E272C2027757365';
wwv_flow_api.g_varchar2_table(88) := '275D293B0A2020636F6E7374206D6174684D6C2431203D20667265657A65285B276D617468272C20276D656E636C6F7365272C20276D6572726F72272C20276D66656E636564272C20276D66726163272C20276D676C797068272C20276D69272C20276D';
wwv_flow_api.g_varchar2_table(89) := '6C6162656C65647472272C20276D6D756C746973637269707473272C20276D6E272C20276D6F272C20276D6F766572272C20276D706164646564272C20276D7068616E746F6D272C20276D726F6F74272C20276D726F77272C20276D73272C20276D7370';
wwv_flow_api.g_varchar2_table(90) := '616365272C20276D73717274272C20276D7374796C65272C20276D737562272C20276D737570272C20276D737562737570272C20276D7461626C65272C20276D7464272C20276D74657874272C20276D7472272C20276D756E646572272C20276D756E64';
wwv_flow_api.g_varchar2_table(91) := '65726F766572272C20276D70726573637269707473275D293B0A20202F2F2053696D696C61726C7920746F205356472C2077652077616E7420746F206B6E6F7720616C6C204D6174684D4C20656C656D656E74732C0A20202F2F206576656E2074686F73';
wwv_flow_api.g_varchar2_table(92) := '65207468617420776520646973616C6C6F772062792064656661756C742E0A2020636F6E7374206D6174684D6C446973616C6C6F776564203D20667265657A65285B276D616374696F6E272C20276D616C69676E67726F7570272C20276D616C69676E6D';
wwv_flow_api.g_varchar2_table(93) := '61726B272C20276D6C6F6E67646976272C20276D7363617272696573272C20276D736361727279272C20276D7367726F7570272C20276D737461636B272C20276D736C696E65272C20276D73726F77272C202773656D616E74696373272C2027616E6E6F';
wwv_flow_api.g_varchar2_table(94) := '746174696F6E272C2027616E6E6F746174696F6E2D786D6C272C20276D70726573637269707473272C20276E6F6E65275D293B0A2020636F6E73742074657874203D20667265657A65285B272374657874275D293B0A0A2020636F6E73742068746D6C20';
wwv_flow_api.g_varchar2_table(95) := '3D20667265657A65285B27616363657074272C2027616374696F6E272C2027616C69676E272C2027616C74272C20276175746F6361706974616C697A65272C20276175746F636F6D706C657465272C20276175746F70696374757265696E706963747572';
wwv_flow_api.g_varchar2_table(96) := '65272C20276175746F706C6179272C20276261636B67726F756E64272C20276267636F6C6F72272C2027626F72646572272C202763617074757265272C202763656C6C70616464696E67272C202763656C6C73706163696E67272C2027636865636B6564';
wwv_flow_api.g_varchar2_table(97) := '272C202763697465272C2027636C617373272C2027636C656172272C2027636F6C6F72272C2027636F6C73272C2027636F6C7370616E272C2027636F6E74726F6C73272C2027636F6E74726F6C736C697374272C2027636F6F726473272C202763726F73';
wwv_flow_api.g_varchar2_table(98) := '736F726967696E272C20276461746574696D65272C20276465636F64696E67272C202764656661756C74272C2027646972272C202764697361626C6564272C202764697361626C6570696374757265696E70696374757265272C202764697361626C6572';
wwv_flow_api.g_varchar2_table(99) := '656D6F7465706C61796261636B272C2027646F776E6C6F6164272C2027647261676761626C65272C2027656E6374797065272C2027656E7465726B657968696E74272C202766616365272C2027666F72272C202768656164657273272C20276865696768';
wwv_flow_api.g_varchar2_table(100) := '74272C202768696464656E272C202768696768272C202768726566272C2027687265666C616E67272C20276964272C2027696E7075746D6F6465272C2027696E74656772697479272C202769736D6170272C20276B696E64272C20276C6162656C272C20';
wwv_flow_api.g_varchar2_table(101) := '276C616E67272C20276C697374272C20276C6F6164696E67272C20276C6F6F70272C20276C6F77272C20276D6178272C20276D61786C656E677468272C20276D65646961272C20276D6574686F64272C20276D696E272C20276D696E6C656E677468272C';
wwv_flow_api.g_varchar2_table(102) := '20276D756C7469706C65272C20276D75746564272C20276E616D65272C20276E6F6E6365272C20276E6F7368616465272C20276E6F76616C6964617465272C20276E6F77726170272C20276F70656E272C20276F7074696D756D272C2027706174746572';
wwv_flow_api.g_varchar2_table(103) := '6E272C2027706C616365686F6C646572272C2027706C617973696E6C696E65272C2027706F706F766572272C2027706F706F766572746172676574272C2027706F706F766572746172676574616374696F6E272C2027706F73746572272C20277072656C';
wwv_flow_api.g_varchar2_table(104) := '6F6164272C202770756264617465272C2027726164696F67726F7570272C2027726561646F6E6C79272C202772656C272C20277265717569726564272C2027726576272C20277265766572736564272C2027726F6C65272C2027726F7773272C2027726F';
wwv_flow_api.g_varchar2_table(105) := '777370616E272C20277370656C6C636865636B272C202773636F7065272C202773656C6563746564272C20277368617065272C202773697A65272C202773697A6573272C20277370616E272C20277372636C616E67272C20277374617274272C20277372';
wwv_flow_api.g_varchar2_table(106) := '63272C2027737263736574272C202773746570272C20277374796C65272C202773756D6D617279272C2027746162696E646578272C20277469746C65272C20277472616E736C617465272C202774797065272C20277573656D6170272C202776616C6967';
wwv_flow_api.g_varchar2_table(107) := '6E272C202776616C7565272C20277769647468272C202777726170272C2027786D6C6E73272C2027736C6F74275D293B0A2020636F6E737420737667203D20667265657A65285B27616363656E742D686569676874272C2027616363756D756C61746527';
wwv_flow_api.g_varchar2_table(108) := '2C20276164646974697665272C2027616C69676E6D656E742D626173656C696E65272C2027616D706C6974756465272C2027617363656E74272C20276174747269627574656E616D65272C202761747472696275746574797065272C2027617A696D7574';
wwv_flow_api.g_varchar2_table(109) := '68272C2027626173656672657175656E6379272C2027626173656C696E652D7368696674272C2027626567696E272C202762696173272C20276279272C2027636C617373272C2027636C6970272C2027636C697070617468756E697473272C2027636C69';
wwv_flow_api.g_varchar2_table(110) := '702D70617468272C2027636C69702D72756C65272C2027636F6C6F72272C2027636F6C6F722D696E746572706F6C6174696F6E272C2027636F6C6F722D696E746572706F6C6174696F6E2D66696C74657273272C2027636F6C6F722D70726F66696C6527';
wwv_flow_api.g_varchar2_table(111) := '2C2027636F6C6F722D72656E646572696E67272C20276378272C20276379272C202764272C20276478272C20276479272C202764696666757365636F6E7374616E74272C2027646972656374696F6E272C2027646973706C6179272C202764697669736F';
wwv_flow_api.g_varchar2_table(112) := '72272C2027647572272C2027656467656D6F6465272C2027656C65766174696F6E272C2027656E64272C20276578706F6E656E74272C202766696C6C272C202766696C6C2D6F706163697479272C202766696C6C2D72756C65272C202766696C74657227';
wwv_flow_api.g_varchar2_table(113) := '2C202766696C746572756E697473272C2027666C6F6F642D636F6C6F72272C2027666C6F6F642D6F706163697479272C2027666F6E742D66616D696C79272C2027666F6E742D73697A65272C2027666F6E742D73697A652D61646A757374272C2027666F';
wwv_flow_api.g_varchar2_table(114) := '6E742D73747265746368272C2027666F6E742D7374796C65272C2027666F6E742D76617269616E74272C2027666F6E742D776569676874272C20276678272C20276679272C20276731272C20276732272C2027676C7970682D6E616D65272C2027676C79';
wwv_flow_api.g_varchar2_table(115) := '7068726566272C20276772616469656E74756E697473272C20276772616469656E747472616E73666F726D272C2027686569676874272C202768726566272C20276964272C2027696D6167652D72656E646572696E67272C2027696E272C2027696E3227';
wwv_flow_api.g_varchar2_table(116) := '2C2027696E74657263657074272C20276B272C20276B31272C20276B32272C20276B33272C20276B34272C20276B65726E696E67272C20276B6579706F696E7473272C20276B657973706C696E6573272C20276B657974696D6573272C20276C616E6727';
wwv_flow_api.g_varchar2_table(117) := '2C20276C656E67746861646A757374272C20276C65747465722D73706163696E67272C20276B65726E656C6D6174726978272C20276B65726E656C756E69746C656E677468272C20276C69676874696E672D636F6C6F72272C20276C6F63616C272C2027';
wwv_flow_api.g_varchar2_table(118) := '6D61726B65722D656E64272C20276D61726B65722D6D6964272C20276D61726B65722D7374617274272C20276D61726B6572686569676874272C20276D61726B6572756E697473272C20276D61726B65727769647468272C20276D61736B636F6E74656E';
wwv_flow_api.g_varchar2_table(119) := '74756E697473272C20276D61736B756E697473272C20276D6178272C20276D61736B272C20276D65646961272C20276D6574686F64272C20276D6F6465272C20276D696E272C20276E616D65272C20276E756D6F637461766573272C20276F6666736574';
wwv_flow_api.g_varchar2_table(120) := '272C20276F70657261746F72272C20276F706163697479272C20276F72646572272C20276F7269656E74272C20276F7269656E746174696F6E272C20276F726967696E272C20276F766572666C6F77272C20277061696E742D6F72646572272C20277061';
wwv_flow_api.g_varchar2_table(121) := '7468272C2027706174686C656E677468272C20277061747465726E636F6E74656E74756E697473272C20277061747465726E7472616E73666F726D272C20277061747465726E756E697473272C2027706F696E7473272C20277072657365727665616C70';
wwv_flow_api.g_varchar2_table(122) := '6861272C20277072657365727665617370656374726174696F272C20277072696D6974697665756E697473272C202772272C20277278272C20277279272C2027726164697573272C202772656678272C202772656679272C2027726570656174636F756E';
wwv_flow_api.g_varchar2_table(123) := '74272C2027726570656174647572272C202772657374617274272C2027726573756C74272C2027726F74617465272C20277363616C65272C202773656564272C202773686170652D72656E646572696E67272C2027736C6F7065272C202773706563756C';
wwv_flow_api.g_varchar2_table(124) := '6172636F6E7374616E74272C202773706563756C61726578706F6E656E74272C20277370726561646D6574686F64272C202773746172746F6666736574272C2027737464646576696174696F6E272C202773746974636874696C6573272C202773746F70';
wwv_flow_api.g_varchar2_table(125) := '2D636F6C6F72272C202773746F702D6F706163697479272C20277374726F6B652D646173686172726179272C20277374726F6B652D646173686F6666736574272C20277374726F6B652D6C696E65636170272C20277374726F6B652D6C696E656A6F696E';
wwv_flow_api.g_varchar2_table(126) := '272C20277374726F6B652D6D697465726C696D6974272C20277374726F6B652D6F706163697479272C20277374726F6B65272C20277374726F6B652D7769647468272C20277374796C65272C2027737572666163657363616C65272C202773797374656D';
wwv_flow_api.g_varchar2_table(127) := '6C616E6775616765272C2027746162696E646578272C20277461626C6576616C756573272C202774617267657478272C202774617267657479272C20277472616E73666F726D272C20277472616E73666F726D2D6F726967696E272C2027746578742D61';
wwv_flow_api.g_varchar2_table(128) := '6E63686F72272C2027746578742D6465636F726174696F6E272C2027746578742D72656E646572696E67272C2027746578746C656E677468272C202774797065272C20277531272C20277532272C2027756E69636F6465272C202776616C756573272C20';
wwv_flow_api.g_varchar2_table(129) := '2776696577626F78272C20277669736962696C697479272C202776657273696F6E272C2027766572742D6164762D79272C2027766572742D6F726967696E2D78272C2027766572742D6F726967696E2D79272C20277769647468272C2027776F72642D73';
wwv_flow_api.g_varchar2_table(130) := '706163696E67272C202777726170272C202777726974696E672D6D6F6465272C2027786368616E6E656C73656C6563746F72272C2027796368616E6E656C73656C6563746F72272C202778272C20277831272C20277832272C2027786D6C6E73272C2027';
wwv_flow_api.g_varchar2_table(131) := '79272C20277931272C20277932272C20277A272C20277A6F6F6D616E6470616E275D293B0A2020636F6E7374206D6174684D6C203D20667265657A65285B27616363656E74272C2027616363656E74756E646572272C2027616C69676E272C2027626576';
wwv_flow_api.g_varchar2_table(132) := '656C6C6564272C2027636C6F7365272C2027636F6C756D6E73616C69676E272C2027636F6C756D6E6C696E6573272C2027636F6C756D6E7370616E272C202764656E6F6D616C69676E272C20276465707468272C2027646972272C2027646973706C6179';
wwv_flow_api.g_varchar2_table(133) := '272C2027646973706C61797374796C65272C2027656E636F64696E67272C202766656E6365272C20276672616D65272C2027686569676874272C202768726566272C20276964272C20276C617267656F70272C20276C656E677468272C20276C696E6574';
wwv_flow_api.g_varchar2_table(134) := '6869636B6E657373272C20276C7370616365272C20276C71756F7465272C20276D6174686261636B67726F756E64272C20276D617468636F6C6F72272C20276D61746873697A65272C20276D61746876617269616E74272C20276D617873697A65272C20';
wwv_flow_api.g_varchar2_table(135) := '276D696E73697A65272C20276D6F7661626C656C696D697473272C20276E6F746174696F6E272C20276E756D616C69676E272C20276F70656E272C2027726F77616C69676E272C2027726F776C696E6573272C2027726F7773706163696E67272C202772';
wwv_flow_api.g_varchar2_table(136) := '6F777370616E272C2027727370616365272C20277271756F7465272C20277363726970746C6576656C272C20277363726970746D696E73697A65272C202773637269707473697A656D756C7469706C696572272C202773656C656374696F6E272C202773';
wwv_flow_api.g_varchar2_table(137) := '6570617261746F72272C2027736570617261746F7273272C20277374726574636879272C20277375627363726970747368696674272C20277375707363726970747368696674272C202773796D6D6574726963272C2027766F6666736574272C20277769';
wwv_flow_api.g_varchar2_table(138) := '647468272C2027786D6C6E73275D293B0A2020636F6E737420786D6C203D20667265657A65285B27786C696E6B3A68726566272C2027786D6C3A6964272C2027786C696E6B3A7469746C65272C2027786D6C3A7370616365272C2027786D6C6E733A786C';
wwv_flow_api.g_varchar2_table(139) := '696E6B275D293B0A0A20202F2F2065736C696E742D64697361626C652D6E6578742D6C696E6520756E69636F726E2F6265747465722D72656765780A2020636F6E7374204D555354414348455F45585052203D207365616C282F5C7B5C7B5B5C775C575D';
wwv_flow_api.g_varchar2_table(140) := '2A7C5B5C775C575D2A5C7D5C7D2F676D293B202F2F20537065636966792074656D706C61746520646574656374696F6E20726567657820666F7220534146455F464F525F54454D504C41544553206D6F64650A2020636F6E7374204552425F4558505220';
wwv_flow_api.g_varchar2_table(141) := '3D207365616C282F3C255B5C775C575D2A7C5B5C775C575D2A253E2F676D293B0A2020636F6E737420544D504C49545F45585052203D207365616C282F5C245C7B5B5C775C575D2A2F676D293B202F2F2065736C696E742D64697361626C652D6C696E65';
wwv_flow_api.g_varchar2_table(142) := '20756E69636F726E2F6265747465722D72656765780A2020636F6E737420444154415F41545452203D207365616C282F5E646174612D5B5C2D5C772E5C75303042372D5C75464646465D2B242F293B202F2F2065736C696E742D64697361626C652D6C69';
wwv_flow_api.g_varchar2_table(143) := '6E65206E6F2D7573656C6573732D6573636170650A2020636F6E737420415249415F41545452203D207365616C282F5E617269612D5B5C2D5C775D2B242F293B202F2F2065736C696E742D64697361626C652D6C696E65206E6F2D7573656C6573732D65';
wwv_flow_api.g_varchar2_table(144) := '73636170650A2020636F6E73742049535F414C4C4F5745445F555249203D207365616C282F5E283F3A283F3A283F3A667C6874297470733F7C6D61696C746F7C74656C7C63616C6C746F7C736D737C6369647C786D7070293A7C5B5E612D7A5D7C5B612D';
wwv_flow_api.g_varchar2_table(145) := '7A2B2E5C2D5D2B283F3A5B5E612D7A2B2E5C2D3A5D7C2429292F69202F2F2065736C696E742D64697361626C652D6C696E65206E6F2D7573656C6573732D6573636170650A2020293B0A2020636F6E73742049535F5343524950545F4F525F4441544120';
wwv_flow_api.g_varchar2_table(146) := '3D207365616C282F5E283F3A5C772B7363726970747C64617461293A2F69293B0A2020636F6E737420415454525F57484954455350414345203D207365616C282F5B5C75303030302D5C75303032305C75303041305C75313638305C75313830455C7532';
wwv_flow_api.g_varchar2_table(147) := '3030302D5C75323032395C75323035465C75333030305D2F67202F2F2065736C696E742D64697361626C652D6C696E65206E6F2D636F6E74726F6C2D72656765780A2020293B0A2020636F6E737420444F43545950455F4E414D45203D207365616C282F';
wwv_flow_api.g_varchar2_table(148) := '5E68746D6C242F69293B0A2020636F6E737420435553544F4D5F454C454D454E54203D207365616C282F5E5B612D7A5D5B2E5C775D2A282D5B2E5C775D2B292B242F69293B0A0A20207661722045585052455353494F4E53203D202F2A235F5F50555245';
wwv_flow_api.g_varchar2_table(149) := '5F5F2A2F4F626A6563742E667265657A65287B0A202020205F5F70726F746F5F5F3A206E756C6C2C0A20202020415249415F415454523A20415249415F415454522C0A20202020415454525F574849544553504143453A20415454525F57484954455350';
wwv_flow_api.g_varchar2_table(150) := '4143452C0A20202020435553544F4D5F454C454D454E543A20435553544F4D5F454C454D454E542C0A20202020444154415F415454523A20444154415F415454522C0A20202020444F43545950455F4E414D453A20444F43545950455F4E414D452C0A20';
wwv_flow_api.g_varchar2_table(151) := '2020204552425F455850523A204552425F455850522C0A2020202049535F414C4C4F5745445F5552493A2049535F414C4C4F5745445F5552492C0A2020202049535F5343524950545F4F525F444154413A2049535F5343524950545F4F525F444154412C';
wwv_flow_api.g_varchar2_table(152) := '0A202020204D555354414348455F455850523A204D555354414348455F455850522C0A20202020544D504C49545F455850523A20544D504C49545F455850520A20207D293B0A0A20202F2A2065736C696E742D64697361626C6520407479706573637269';
wwv_flow_api.g_varchar2_table(153) := '70742D65736C696E742F696E64656E74202A2F0A20202F2F2068747470733A2F2F646576656C6F7065722E6D6F7A696C6C612E6F72672F656E2D55532F646F63732F5765622F4150492F4E6F64652F6E6F6465547970650A2020636F6E7374204E4F4445';
wwv_flow_api.g_varchar2_table(154) := '5F54595045203D207B0A20202020656C656D656E743A20312C0A202020206174747269627574653A20322C0A20202020746578743A20332C0A20202020636461746153656374696F6E3A20342C0A20202020656E746974795265666572656E63653A2035';
wwv_flow_api.g_varchar2_table(155) := '2C0A202020202F2F20446570726563617465640A20202020656E746974794E6F64653A20362C0A202020202F2F20446570726563617465640A2020202070726F6772657373696E67496E737472756374696F6E3A20372C0A20202020636F6D6D656E743A';
wwv_flow_api.g_varchar2_table(156) := '20382C0A20202020646F63756D656E743A20392C0A20202020646F63756D656E74547970653A2031302C0A20202020646F63756D656E74467261676D656E743A2031312C0A202020206E6F746174696F6E3A203132202F2F20446570726563617465640A';
wwv_flow_api.g_varchar2_table(157) := '20207D3B0A2020636F6E737420676574476C6F62616C203D2066756E6374696F6E20676574476C6F62616C2829207B0A2020202072657475726E20747970656F662077696E646F77203D3D3D2027756E646566696E656427203F206E756C6C203A207769';
wwv_flow_api.g_varchar2_table(158) := '6E646F773B0A20207D3B0A20202F2A2A0A2020202A20437265617465732061206E6F2D6F7020706F6C69637920666F7220696E7465726E616C20757365206F6E6C792E0A2020202A20446F6E2774206578706F727420746869732066756E6374696F6E20';
wwv_flow_api.g_varchar2_table(159) := '6F7574736964652074686973206D6F64756C65210A2020202A2040706172616D207472757374656454797065732054686520706F6C69637920666163746F72792E0A2020202A2040706172616D20707572696679486F7374456C656D656E742054686520';
wwv_flow_api.g_varchar2_table(160) := '53637269707420656C656D656E74207573656420746F206C6F616420444F4D5075726966792028746F2064657465726D696E6520706F6C696379206E616D6520737566666978292E0A2020202A204072657475726E2054686520706F6C69637920637265';
wwv_flow_api.g_varchar2_table(161) := '6174656420286F72206E756C6C2C20696620547275737465642054797065730A2020202A20617265206E6F7420737570706F72746564206F72206372656174696E672074686520706F6C696379206661696C6564292E0A2020202A2F0A2020636F6E7374';
wwv_flow_api.g_varchar2_table(162) := '205F637265617465547275737465645479706573506F6C696379203D2066756E6374696F6E205F637265617465547275737465645479706573506F6C696379287472757374656454797065732C20707572696679486F7374456C656D656E7429207B0A20';
wwv_flow_api.g_varchar2_table(163) := '20202069662028747970656F662074727573746564547970657320213D3D20276F626A65637427207C7C20747970656F66207472757374656454797065732E637265617465506F6C69637920213D3D202766756E6374696F6E2729207B0A202020202020';
wwv_flow_api.g_varchar2_table(164) := '72657475726E206E756C6C3B0A202020207D0A202020202F2F20416C6C6F77207468652063616C6C65727320746F20636F6E74726F6C2074686520756E6971756520706F6C696379206E616D650A202020202F2F20627920616464696E67206120646174';
wwv_flow_api.g_varchar2_table(165) := '612D74742D706F6C6963792D73756666697820746F207468652073637269707420656C656D656E7420776974682074686520444F4D5075726966792E0A202020202F2F20506F6C696379206372656174696F6E2077697468206475706C6963617465206E';
wwv_flow_api.g_varchar2_table(166) := '616D6573207468726F777320696E20547275737465642054797065732E0A202020206C657420737566666978203D206E756C6C3B0A20202020636F6E737420415454525F4E414D45203D2027646174612D74742D706F6C6963792D737566666978273B0A';
wwv_flow_api.g_varchar2_table(167) := '2020202069662028707572696679486F7374456C656D656E7420262620707572696679486F7374456C656D656E742E68617341747472696275746528415454525F4E414D452929207B0A202020202020737566666978203D20707572696679486F737445';
wwv_flow_api.g_varchar2_table(168) := '6C656D656E742E67657441747472696275746528415454525F4E414D45293B0A202020207D0A20202020636F6E737420706F6C6963794E616D65203D2027646F6D70757269667927202B2028737566666978203F20272327202B20737566666978203A20';
wwv_flow_api.g_varchar2_table(169) := '2727293B0A20202020747279207B0A20202020202072657475726E207472757374656454797065732E637265617465506F6C69637928706F6C6963794E616D652C207B0A202020202020202063726561746548544D4C2868746D6C29207B0A2020202020';
wwv_flow_api.g_varchar2_table(170) := '202020202072657475726E2068746D6C3B0A20202020202020207D2C0A202020202020202063726561746553637269707455524C2873637269707455726C29207B0A2020202020202020202072657475726E2073637269707455726C3B0A202020202020';
wwv_flow_api.g_varchar2_table(171) := '20207D0A2020202020207D293B0A202020207D20636174636820285F29207B0A2020202020202F2F20506F6C696379206372656174696F6E206661696C656420286D6F7374206C696B656C7920616E6F7468657220444F4D507572696679207363726970';
wwv_flow_api.g_varchar2_table(172) := '74206861730A2020202020202F2F20616C72656164792072756E292E20536B6970206372656174696E672074686520706F6C6963792C20617320746869732077696C6C206F6E6C79206361757365206572726F72730A2020202020202F2F206966205454';
wwv_flow_api.g_varchar2_table(173) := '2061726520656E666F726365642E0A202020202020636F6E736F6C652E7761726E282754727573746564547970657320706F6C6963792027202B20706F6C6963794E616D65202B202720636F756C64206E6F7420626520637265617465642E27293B0A20';
wwv_flow_api.g_varchar2_table(174) := '202020202072657475726E206E756C6C3B0A202020207D0A20207D3B0A2020636F6E7374205F637265617465486F6F6B734D6170203D2066756E6374696F6E205F637265617465486F6F6B734D61702829207B0A2020202072657475726E207B0A202020';
wwv_flow_api.g_varchar2_table(175) := '202020616674657253616E6974697A65417474726962757465733A205B5D2C0A202020202020616674657253616E6974697A65456C656D656E74733A205B5D2C0A202020202020616674657253616E6974697A65536861646F77444F4D3A205B5D2C0A20';
wwv_flow_api.g_varchar2_table(176) := '20202020206265666F726553616E6974697A65417474726962757465733A205B5D2C0A2020202020206265666F726553616E6974697A65456C656D656E74733A205B5D2C0A2020202020206265666F726553616E6974697A65536861646F77444F4D3A20';
wwv_flow_api.g_varchar2_table(177) := '5B5D2C0A20202020202075706F6E53616E6974697A654174747269627574653A205B5D2C0A20202020202075706F6E53616E6974697A65456C656D656E743A205B5D2C0A20202020202075706F6E53616E6974697A65536861646F774E6F64653A205B5D';
wwv_flow_api.g_varchar2_table(178) := '0A202020207D3B0A20207D3B0A202066756E6374696F6E20637265617465444F4D5075726966792829207B0A202020206C65742077696E646F77203D20617267756D656E74732E6C656E677468203E203020262620617267756D656E74735B305D20213D';
wwv_flow_api.g_varchar2_table(179) := '3D20756E646566696E6564203F20617267756D656E74735B305D203A20676574476C6F62616C28293B0A20202020636F6E737420444F4D507572696679203D20726F6F74203D3E20637265617465444F4D50757269667928726F6F74293B0A2020202044';
wwv_flow_api.g_varchar2_table(180) := '4F4D5075726966792E76657273696F6E203D2027332E322E34273B0A20202020444F4D5075726966792E72656D6F766564203D205B5D3B0A20202020696620282177696E646F77207C7C202177696E646F772E646F63756D656E74207C7C2077696E646F';
wwv_flow_api.g_varchar2_table(181) := '772E646F63756D656E742E6E6F64655479706520213D3D204E4F44455F545950452E646F63756D656E74207C7C202177696E646F772E456C656D656E7429207B0A2020202020202F2F204E6F742072756E6E696E6720696E20612062726F777365722C20';
wwv_flow_api.g_varchar2_table(182) := '70726F76696465206120666163746F72792066756E6374696F6E0A2020202020202F2F20736F207468617420796F752063616E207061737320796F7572206F776E2057696E646F770A202020202020444F4D5075726966792E6973537570706F72746564';
wwv_flow_api.g_varchar2_table(183) := '203D2066616C73653B0A20202020202072657475726E20444F4D5075726966793B0A202020207D0A202020206C6574207B0A202020202020646F63756D656E740A202020207D203D2077696E646F773B0A20202020636F6E7374206F726967696E616C44';
wwv_flow_api.g_varchar2_table(184) := '6F63756D656E74203D20646F63756D656E743B0A20202020636F6E73742063757272656E74536372697074203D206F726967696E616C446F63756D656E742E63757272656E745363726970743B0A20202020636F6E7374207B0A202020202020446F6375';
wwv_flow_api.g_varchar2_table(185) := '6D656E74467261676D656E742C0A20202020202048544D4C54656D706C617465456C656D656E742C0A2020202020204E6F64652C0A202020202020456C656D656E742C0A2020202020204E6F646546696C7465722C0A2020202020204E616D65644E6F64';
wwv_flow_api.g_varchar2_table(186) := '654D6170203D2077696E646F772E4E616D65644E6F64654D6170207C7C2077696E646F772E4D6F7A4E616D6564417474724D61702C0A20202020202048544D4C466F726D456C656D656E742C0A202020202020444F4D5061727365722C0A202020202020';
wwv_flow_api.g_varchar2_table(187) := '7472757374656454797065730A202020207D203D2077696E646F773B0A20202020636F6E737420456C656D656E7450726F746F74797065203D20456C656D656E742E70726F746F747970653B0A20202020636F6E737420636C6F6E654E6F6465203D206C';
wwv_flow_api.g_varchar2_table(188) := '6F6F6B757047657474657228456C656D656E7450726F746F747970652C2027636C6F6E654E6F646527293B0A20202020636F6E73742072656D6F7665203D206C6F6F6B757047657474657228456C656D656E7450726F746F747970652C202772656D6F76';
wwv_flow_api.g_varchar2_table(189) := '6527293B0A20202020636F6E7374206765744E6578745369626C696E67203D206C6F6F6B757047657474657228456C656D656E7450726F746F747970652C20276E6578745369626C696E6727293B0A20202020636F6E7374206765744368696C644E6F64';
wwv_flow_api.g_varchar2_table(190) := '6573203D206C6F6F6B757047657474657228456C656D656E7450726F746F747970652C20276368696C644E6F64657327293B0A20202020636F6E737420676574506172656E744E6F6465203D206C6F6F6B757047657474657228456C656D656E7450726F';
wwv_flow_api.g_varchar2_table(191) := '746F747970652C2027706172656E744E6F646527293B0A202020202F2F20417320706572206973737565202334372C20746865207765622D636F6D706F6E656E747320726567697374727920697320696E6865726974656420627920610A202020202F2F';
wwv_flow_api.g_varchar2_table(192) := '206E657720646F63756D656E742063726561746564207669612063726561746548544D4C446F63756D656E742E204173207065722074686520737065630A202020202F2F2028687474703A2F2F7733632E6769746875622E696F2F776562636F6D706F6E';
wwv_flow_api.g_varchar2_table(193) := '656E74732F737065632F637573746F6D2F236372656174696E672D616E642D70617373696E672D72656769737472696573290A202020202F2F2061206E657720656D7074792072656769737472792069732075736564207768656E206372656174696E67';
wwv_flow_api.g_varchar2_table(194) := '20612074656D706C61746520636F6E74656E7473206F776E65720A202020202F2F20646F63756D656E742C20736F207765207573652074686174206173206F757220706172656E7420646F63756D656E7420746F20656E73757265206E6F7468696E670A';
wwv_flow_api.g_varchar2_table(195) := '202020202F2F20697320696E686572697465642E0A2020202069662028747970656F662048544D4C54656D706C617465456C656D656E74203D3D3D202766756E6374696F6E2729207B0A202020202020636F6E73742074656D706C617465203D20646F63';
wwv_flow_api.g_varchar2_table(196) := '756D656E742E637265617465456C656D656E74282774656D706C61746527293B0A2020202020206966202874656D706C6174652E636F6E74656E742026262074656D706C6174652E636F6E74656E742E6F776E6572446F63756D656E7429207B0A202020';
wwv_flow_api.g_varchar2_table(197) := '2020202020646F63756D656E74203D2074656D706C6174652E636F6E74656E742E6F776E6572446F63756D656E743B0A2020202020207D0A202020207D0A202020206C657420747275737465645479706573506F6C6963793B0A202020206C657420656D';
wwv_flow_api.g_varchar2_table(198) := '70747948544D4C203D2027273B0A20202020636F6E7374207B0A202020202020696D706C656D656E746174696F6E2C0A2020202020206372656174654E6F64654974657261746F722C0A202020202020637265617465446F63756D656E74467261676D65';
wwv_flow_api.g_varchar2_table(199) := '6E742C0A202020202020676574456C656D656E747342795461674E616D650A202020207D203D20646F63756D656E743B0A20202020636F6E7374207B0A202020202020696D706F72744E6F64650A202020207D203D206F726967696E616C446F63756D65';
wwv_flow_api.g_varchar2_table(200) := '6E743B0A202020206C657420686F6F6B73203D205F637265617465486F6F6B734D617028293B0A202020202F2A2A0A20202020202A204578706F7365207768657468657220746869732062726F7773657220737570706F7274732072756E6E696E672074';
wwv_flow_api.g_varchar2_table(201) := '68652066756C6C20444F4D5075726966792E0A20202020202A2F0A20202020444F4D5075726966792E6973537570706F72746564203D20747970656F6620656E7472696573203D3D3D202766756E6374696F6E2720262620747970656F66206765745061';
wwv_flow_api.g_varchar2_table(202) := '72656E744E6F6465203D3D3D202766756E6374696F6E2720262620696D706C656D656E746174696F6E20262620696D706C656D656E746174696F6E2E63726561746548544D4C446F63756D656E7420213D3D20756E646566696E65643B0A20202020636F';
wwv_flow_api.g_varchar2_table(203) := '6E7374207B0A2020202020204D555354414348455F455850522C0A2020202020204552425F455850522C0A202020202020544D504C49545F455850522C0A202020202020444154415F415454522C0A202020202020415249415F415454522C0A20202020';
wwv_flow_api.g_varchar2_table(204) := '202049535F5343524950545F4F525F444154412C0A202020202020415454525F574849544553504143452C0A202020202020435553544F4D5F454C454D454E540A202020207D203D2045585052455353494F4E533B0A202020206C6574207B0A20202020';
wwv_flow_api.g_varchar2_table(205) := '202049535F414C4C4F5745445F5552493A2049535F414C4C4F5745445F55524924310A202020207D203D2045585052455353494F4E533B0A202020202F2A2A0A20202020202A20576520636F6E73696465722074686520656C656D656E747320616E6420';
wwv_flow_api.g_varchar2_table(206) := '617474726962757465732062656C6F7720746F20626520736166652E20496465616C6C790A20202020202A20646F6E27742061646420616E79206E6577206F6E657320627574206665656C206672656520746F2072656D6F766520756E77616E74656420';
wwv_flow_api.g_varchar2_table(207) := '6F6E65732E0A20202020202A2F0A202020202F2A20616C6C6F77656420656C656D656E74206E616D6573202A2F0A202020206C657420414C4C4F5745445F54414753203D206E756C6C3B0A20202020636F6E73742044454641554C545F414C4C4F574544';
wwv_flow_api.g_varchar2_table(208) := '5F54414753203D20616464546F536574287B7D2C205B2E2E2E68746D6C24312C202E2E2E73766724312C202E2E2E73766746696C746572732C202E2E2E6D6174684D6C24312C202E2E2E746578745D293B0A202020202F2A20416C6C6F77656420617474';
wwv_flow_api.g_varchar2_table(209) := '726962757465206E616D6573202A2F0A202020206C657420414C4C4F5745445F41545452203D206E756C6C3B0A20202020636F6E73742044454641554C545F414C4C4F5745445F41545452203D20616464546F536574287B7D2C205B2E2E2E68746D6C2C';
wwv_flow_api.g_varchar2_table(210) := '202E2E2E7376672C202E2E2E6D6174684D6C2C202E2E2E786D6C5D293B0A202020202F2A0A20202020202A20436F6E66696775726520686F7720444F4D5075726966792073686F756C642068616E646C6520637573746F6D20656C656D656E747320616E';
wwv_flow_api.g_varchar2_table(211) := '6420746865697220617474726962757465732061732077656C6C20617320637573746F6D697A6564206275696C742D696E20656C656D656E74732E0A20202020202A204070726F7065727479207B5265674578707C46756E6374696F6E7C6E756C6C7D20';
wwv_flow_api.g_varchar2_table(212) := '7461674E616D65436865636B206F6E65206F66205B6E756C6C2C2072656765785061747465726E2C207072656469636174655D2E2044656661756C743A20606E756C6C602028646973616C6C6F7720616E7920637573746F6D20656C656D656E7473290A';
wwv_flow_api.g_varchar2_table(213) := '20202020202A204070726F7065727479207B5265674578707C46756E6374696F6E7C6E756C6C7D206174747269627574654E616D65436865636B206F6E65206F66205B6E756C6C2C2072656765785061747465726E2C207072656469636174655D2E2044';
wwv_flow_api.g_varchar2_table(214) := '656661756C743A20606E756C6C602028646973616C6C6F7720616E792061747472696275746573206E6F74206F6E2074686520616C6C6F77206C697374290A20202020202A204070726F7065727479207B626F6F6C65616E7D20616C6C6F77437573746F';
wwv_flow_api.g_varchar2_table(215) := '6D697A65644275696C74496E456C656D656E747320616C6C6F7720637573746F6D20656C656D656E747320646572697665642066726F6D206275696C742D696E732069662074686579207061737320435553544F4D5F454C454D454E545F48414E444C49';
wwv_flow_api.g_varchar2_table(216) := '4E472E7461674E616D65436865636B2E2044656661756C743A206066616C7365602E0A20202020202A2F0A202020206C657420435553544F4D5F454C454D454E545F48414E444C494E47203D204F626A6563742E7365616C28637265617465286E756C6C';
wwv_flow_api.g_varchar2_table(217) := '2C207B0A2020202020207461674E616D65436865636B3A207B0A20202020202020207772697461626C653A20747275652C0A2020202020202020636F6E666967757261626C653A2066616C73652C0A2020202020202020656E756D657261626C653A2074';
wwv_flow_api.g_varchar2_table(218) := '7275652C0A202020202020202076616C75653A206E756C6C0A2020202020207D2C0A2020202020206174747269627574654E616D65436865636B3A207B0A20202020202020207772697461626C653A20747275652C0A2020202020202020636F6E666967';
wwv_flow_api.g_varchar2_table(219) := '757261626C653A2066616C73652C0A2020202020202020656E756D657261626C653A20747275652C0A202020202020202076616C75653A206E756C6C0A2020202020207D2C0A202020202020616C6C6F77437573746F6D697A65644275696C74496E456C';
wwv_flow_api.g_varchar2_table(220) := '656D656E74733A207B0A20202020202020207772697461626C653A20747275652C0A2020202020202020636F6E666967757261626C653A2066616C73652C0A2020202020202020656E756D657261626C653A20747275652C0A202020202020202076616C';
wwv_flow_api.g_varchar2_table(221) := '75653A2066616C73650A2020202020207D0A202020207D29293B0A202020202F2A204578706C696369746C7920666F7262696464656E207461677320286F766572726964657320414C4C4F5745445F544147532F4144445F5441475329202A2F0A202020';
wwv_flow_api.g_varchar2_table(222) := '206C657420464F524249445F54414753203D206E756C6C3B0A202020202F2A204578706C696369746C7920666F7262696464656E206174747269627574657320286F766572726964657320414C4C4F5745445F415454522F4144445F4154545229202A2F';
wwv_flow_api.g_varchar2_table(223) := '0A202020206C657420464F524249445F41545452203D206E756C6C3B0A202020202F2A204465636964652069662041524941206174747269627574657320617265206F6B6179202A2F0A202020206C657420414C4C4F575F415249415F41545452203D20';
wwv_flow_api.g_varchar2_table(224) := '747275653B0A202020202F2A2044656369646520696620637573746F6D2064617461206174747269627574657320617265206F6B6179202A2F0A202020206C657420414C4C4F575F444154415F41545452203D20747275653B0A202020202F2A20446563';
wwv_flow_api.g_varchar2_table(225) := '69646520696620756E6B6E6F776E2070726F746F636F6C7320617265206F6B6179202A2F0A202020206C657420414C4C4F575F554E4B4E4F574E5F50524F544F434F4C53203D2066616C73653B0A202020202F2A204465636964652069662073656C662D';
wwv_flow_api.g_varchar2_table(226) := '636C6F73696E67207461677320696E20617474726962757465732061726520616C6C6F7765642E0A20202020202A20557375616C6C792072656D6F7665642064756520746F2061206D58535320697373756520696E206A517565727920332E30202A2F0A';
wwv_flow_api.g_varchar2_table(227) := '202020206C657420414C4C4F575F53454C465F434C4F53455F494E5F41545452203D20747275653B0A202020202F2A204F75747075742073686F756C64206265207361666520666F7220636F6D6D6F6E2074656D706C61746520656E67696E65732E0A20';
wwv_flow_api.g_varchar2_table(228) := '202020202A2054686973206D65616E732C20444F4D5075726966792072656D6F766573206461746120617474726962757465732C206D757374616368657320616E64204552420A20202020202A2F0A202020206C657420534146455F464F525F54454D50';
wwv_flow_api.g_varchar2_table(229) := '4C41544553203D2066616C73653B0A202020202F2A204F75747075742073686F756C642062652073616665206576656E20666F7220584D4C20757365642077697468696E2048544D4C20616E6420616C696B652E0A20202020202A2054686973206D6561';
wwv_flow_api.g_varchar2_table(230) := '6E732C20444F4D5075726966792072656D6F76657320636F6D6D656E7473207768656E20636F6E7461696E696E67207269736B7920636F6E74656E742E0A20202020202A2F0A202020206C657420534146455F464F525F584D4C203D20747275653B0A20';
wwv_flow_api.g_varchar2_table(231) := '2020202F2A2044656369646520696620646F63756D656E742077697468203C68746D6C3E2E2E2E2073686F756C642062652072657475726E6564202A2F0A202020206C65742057484F4C455F444F43554D454E54203D2066616C73653B0A202020202F2A';
wwv_flow_api.g_varchar2_table(232) := '20547261636B207768657468657220636F6E66696720697320616C726561647920736574206F6E207468697320696E7374616E6365206F6620444F4D5075726966792E202A2F0A202020206C6574205345545F434F4E464947203D2066616C73653B0A20';
wwv_flow_api.g_varchar2_table(233) := '2020202F2A2044656369646520696620616C6C20656C656D656E74732028652E672E207374796C652C2073637269707429206D757374206265206368696C6472656E206F660A20202020202A20646F63756D656E742E626F64792E204279206465666175';
wwv_flow_api.g_varchar2_table(234) := '6C742C2062726F7773657273206D69676874206D6F7665207468656D20746F20646F63756D656E742E68656164202A2F0A202020206C657420464F5243455F424F4459203D2066616C73653B0A202020202F2A20446563696465206966206120444F4D20';
wwv_flow_api.g_varchar2_table(235) := '6048544D4C426F6479456C656D656E74602073686F756C642062652072657475726E65642C20696E7374656164206F6620612068746D6C0A20202020202A20737472696E6720286F722061205472757374656448544D4C206F626A656374206966205472';
wwv_flow_api.g_varchar2_table(236) := '75737465642054797065732061726520737570706F72746564292E0A20202020202A204966206057484F4C455F444F43554D454E546020697320656E61626C65642061206048544D4C48746D6C456C656D656E74602077696C6C2062652072657475726E';
wwv_flow_api.g_varchar2_table(237) := '656420696E73746561640A20202020202A2F0A202020206C65742052455455524E5F444F4D203D2066616C73653B0A202020202F2A20446563696465206966206120444F4D2060446F63756D656E74467261676D656E74602073686F756C642062652072';
wwv_flow_api.g_varchar2_table(238) := '657475726E65642C20696E7374656164206F6620612068746D6C0A20202020202A20737472696E672020286F722061205472757374656448544D4C206F626A65637420696620547275737465642054797065732061726520737570706F7274656429202A';
wwv_flow_api.g_varchar2_table(239) := '2F0A202020206C65742052455455524E5F444F4D5F465241474D454E54203D2066616C73653B0A202020202F2A2054727920746F2072657475726E206120547275737465642054797065206F626A65637420696E7374656164206F66206120737472696E';
wwv_flow_api.g_varchar2_table(240) := '672C2072657475726E206120737472696E6720696E0A20202020202A2063617365205472757374656420547970657320617265206E6F7420737570706F7274656420202A2F0A202020206C65742052455455524E5F545255535445445F54595045203D20';
wwv_flow_api.g_varchar2_table(241) := '66616C73653B0A202020202F2A204F75747075742073686F756C6420626520667265652066726F6D20444F4D20636C6F62626572696E672061747461636B733F0A20202020202A20546869732073616E6974697A6573206D61726B757073206E616D6564';
wwv_flow_api.g_varchar2_table(242) := '207769746820636F6C6C6964696E672C20636C6F6262657261626C65206275696C742D696E20444F4D20415049732E0A20202020202A2F0A202020206C65742053414E4954495A455F444F4D203D20747275653B0A202020202F2A204163686965766520';
wwv_flow_api.g_varchar2_table(243) := '66756C6C20444F4D20436C6F62626572696E672070726F74656374696F6E2062792069736F6C6174696E6720746865206E616D657370616365206F66206E616D65640A20202020202A2070726F7065727469657320616E64204A53207661726961626C65';
wwv_flow_api.g_varchar2_table(244) := '732C206D697469676174696E672061747461636B732074686174206162757365207468652048544D4C2F444F4D20737065632072756C65732E0A20202020202A0A20202020202A2048544D4C2F444F4D20737065632072756C6573207468617420656E61';
wwv_flow_api.g_varchar2_table(245) := '626C6520444F4D20436C6F62626572696E673A0A20202020202A2020202D204E616D656420416363657373206F6E2057696E646F772028C2A7372E332E33290A20202020202A2020202D20444F4D2054726565204163636573736F72732028C2A7332E31';
wwv_flow_api.g_varchar2_table(246) := '2E35290A20202020202A2020202D20466F726D20456C656D656E7420506172656E742D4368696C642052656C6174696F6E732028C2A7342E31302E33290A20202020202A2020202D20496672616D6520737263646F63202F204E65737465642057696E64';
wwv_flow_api.g_varchar2_table(247) := '6F7750726F786965732028C2A7342E382E35290A20202020202A2020202D2048544D4C436F6C6C656374696F6E2028C2A7342E322E31302E32290A20202020202A0A20202020202A204E616D6573706163652069736F6C6174696F6E20697320696D706C';
wwv_flow_api.g_varchar2_table(248) := '656D656E74656420627920707265666978696E67206069646020616E6420606E616D656020617474726962757465730A20202020202A2077697468206120636F6E7374616E7420737472696E672C20692E652E2C2060757365722D636F6E74656E742D60';
wwv_flow_api.g_varchar2_table(249) := '0A20202020202A2F0A202020206C65742053414E4954495A455F4E414D45445F50524F5053203D2066616C73653B0A20202020636F6E73742053414E4954495A455F4E414D45445F50524F50535F505245464958203D2027757365722D636F6E74656E74';
wwv_flow_api.g_varchar2_table(250) := '2D273B0A202020202F2A204B65657020656C656D656E7420636F6E74656E74207768656E2072656D6F76696E6720656C656D656E743F202A2F0A202020206C6574204B4545505F434F4E54454E54203D20747275653B0A202020202F2A20496620612060';
wwv_flow_api.g_varchar2_table(251) := '4E6F6465602069732070617373656420746F2073616E6974697A6528292C207468656E20706572666F726D732073616E6974697A6174696F6E20696E2D706C61636520696E73746561640A20202020202A206F6620696D706F7274696E6720697420696E';
wwv_flow_api.g_varchar2_table(252) := '746F2061206E657720446F63756D656E7420616E642072657475726E696E6720612073616E6974697A656420636F7079202A2F0A202020206C657420494E5F504C414345203D2066616C73653B0A202020202F2A20416C6C6F77207573616765206F6620';
wwv_flow_api.g_varchar2_table(253) := '70726F66696C6573206C696B652068746D6C2C2073766720616E64206D6174684D6C202A2F0A202020206C6574205553455F50524F46494C4553203D207B7D3B0A202020202F2A205461677320746F2069676E6F726520636F6E74656E74206F66207768';
wwv_flow_api.g_varchar2_table(254) := '656E204B4545505F434F4E54454E542069732074727565202A2F0A202020206C657420464F524249445F434F4E54454E5453203D206E756C6C3B0A20202020636F6E73742044454641554C545F464F524249445F434F4E54454E5453203D20616464546F';
wwv_flow_api.g_varchar2_table(255) := '536574287B7D2C205B27616E6E6F746174696F6E2D786D6C272C2027617564696F272C2027636F6C67726F7570272C202764657363272C2027666F726569676E6F626A656374272C202768656164272C2027696672616D65272C20276D617468272C2027';
wwv_flow_api.g_varchar2_table(256) := '6D69272C20276D6E272C20276D6F272C20276D73272C20276D74657874272C20276E6F656D626564272C20276E6F6672616D6573272C20276E6F736372697074272C2027706C61696E74657874272C2027736372697074272C20277374796C65272C2027';
wwv_flow_api.g_varchar2_table(257) := '737667272C202774656D706C617465272C20277468656164272C20277469746C65272C2027766964656F272C2027786D70275D293B0A202020202F2A2054616773207468617420617265207361666520666F7220646174613A2055524973202A2F0A2020';
wwv_flow_api.g_varchar2_table(258) := '20206C657420444154415F5552495F54414753203D206E756C6C3B0A20202020636F6E73742044454641554C545F444154415F5552495F54414753203D20616464546F536574287B7D2C205B27617564696F272C2027766964656F272C2027696D67272C';
wwv_flow_api.g_varchar2_table(259) := '2027736F75726365272C2027696D616765272C2027747261636B275D293B0A202020202F2A2041747472696275746573207361666520666F722076616C756573206C696B6520226A6176617363726970743A22202A2F0A202020206C6574205552495F53';
wwv_flow_api.g_varchar2_table(260) := '4146455F41545452494255544553203D206E756C6C3B0A20202020636F6E73742044454641554C545F5552495F534146455F41545452494255544553203D20616464546F536574287B7D2C205B27616C74272C2027636C617373272C2027666F72272C20';
wwv_flow_api.g_varchar2_table(261) := '276964272C20276C6162656C272C20276E616D65272C20277061747465726E272C2027706C616365686F6C646572272C2027726F6C65272C202773756D6D617279272C20277469746C65272C202776616C7565272C20277374796C65272C2027786D6C6E';
wwv_flow_api.g_varchar2_table(262) := '73275D293B0A20202020636F6E7374204D4154484D4C5F4E414D455350414345203D2027687474703A2F2F7777772E77332E6F72672F313939382F4D6174682F4D6174684D4C273B0A20202020636F6E7374205356475F4E414D455350414345203D2027';
wwv_flow_api.g_varchar2_table(263) := '687474703A2F2F7777772E77332E6F72672F323030302F737667273B0A20202020636F6E73742048544D4C5F4E414D455350414345203D2027687474703A2F2F7777772E77332E6F72672F313939392F7868746D6C273B0A202020202F2A20446F63756D';
wwv_flow_api.g_varchar2_table(264) := '656E74206E616D657370616365202A2F0A202020206C6574204E414D455350414345203D2048544D4C5F4E414D4553504143453B0A202020206C65742049535F454D5054595F494E505554203D2066616C73653B0A202020202F2A20416C6C6F77656420';
wwv_flow_api.g_varchar2_table(265) := '5848544D4C2B584D4C206E616D65737061636573202A2F0A202020206C657420414C4C4F5745445F4E414D45535041434553203D206E756C6C3B0A20202020636F6E73742044454641554C545F414C4C4F5745445F4E414D45535041434553203D206164';
wwv_flow_api.g_varchar2_table(266) := '64546F536574287B7D2C205B4D4154484D4C5F4E414D4553504143452C205356475F4E414D4553504143452C2048544D4C5F4E414D4553504143455D2C20737472696E67546F537472696E67293B0A202020206C6574204D4154484D4C5F544558545F49';
wwv_flow_api.g_varchar2_table(267) := '4E544547524154494F4E5F504F494E5453203D20616464546F536574287B7D2C205B276D69272C20276D6F272C20276D6E272C20276D73272C20276D74657874275D293B0A202020206C65742048544D4C5F494E544547524154494F4E5F504F494E5453';
wwv_flow_api.g_varchar2_table(268) := '203D20616464546F536574287B7D2C205B27616E6E6F746174696F6E2D786D6C275D293B0A202020202F2F204365727461696E20656C656D656E74732061726520616C6C6F77656420696E20626F74682053564720616E642048544D4C0A202020202F2F';
wwv_flow_api.g_varchar2_table(269) := '206E616D6573706163652E205765206E65656420746F2073706563696679207468656D206578706C696369746C790A202020202F2F20736F2074686174207468657920646F6E277420676574206572726F6E656F75736C792064656C657465642066726F';
wwv_flow_api.g_varchar2_table(270) := '6D0A202020202F2F2048544D4C206E616D6573706163652E0A20202020636F6E737420434F4D4D4F4E5F5356475F414E445F48544D4C5F454C454D454E5453203D20616464546F536574287B7D2C205B277469746C65272C20277374796C65272C202766';
wwv_flow_api.g_varchar2_table(271) := '6F6E74272C202761272C2027736372697074275D293B0A202020202F2A2050617273696E67206F6620737472696374205848544D4C20646F63756D656E7473202A2F0A202020206C6574205041525345525F4D454449415F54595045203D206E756C6C3B';
wwv_flow_api.g_varchar2_table(272) := '0A20202020636F6E737420535550504F525445445F5041525345525F4D454449415F5459504553203D205B276170706C69636174696F6E2F7868746D6C2B786D6C272C2027746578742F68746D6C275D3B0A20202020636F6E73742044454641554C545F';
wwv_flow_api.g_varchar2_table(273) := '5041525345525F4D454449415F54595045203D2027746578742F68746D6C273B0A202020206C6574207472616E73666F726D4361736546756E63203D206E756C6C3B0A202020202F2A204B6565702061207265666572656E636520746F20636F6E666967';
wwv_flow_api.g_varchar2_table(274) := '20746F207061737320746F20686F6F6B73202A2F0A202020206C657420434F4E464947203D206E756C6C3B0A202020202F2A20496465616C6C792C20646F206E6F7420746F75636820616E797468696E672062656C6F772074686973206C696E65202A2F';
wwv_flow_api.g_varchar2_table(275) := '0A202020202F2A205F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F5F202A2F0A20202020636F6E737420666F726D456C656D656E74203D20646F63756D656E742E637265617465456C65';
wwv_flow_api.g_varchar2_table(276) := '6D656E742827666F726D27293B0A20202020636F6E737420697352656765784F7246756E6374696F6E203D2066756E6374696F6E20697352656765784F7246756E6374696F6E287465737456616C756529207B0A20202020202072657475726E20746573';
wwv_flow_api.g_varchar2_table(277) := '7456616C756520696E7374616E63656F6620526567457870207C7C207465737456616C756520696E7374616E63656F662046756E6374696F6E3B0A202020207D3B0A202020202F2A2A0A20202020202A205F7061727365436F6E6669670A20202020202A';
wwv_flow_api.g_varchar2_table(278) := '0A20202020202A2040706172616D20636667206F7074696F6E616C20636F6E666967206C69746572616C0A20202020202A2F0A202020202F2F2065736C696E742D64697361626C652D6E6578742D6C696E6520636F6D706C65786974790A20202020636F';
wwv_flow_api.g_varchar2_table(279) := '6E7374205F7061727365436F6E666967203D2066756E6374696F6E205F7061727365436F6E6669672829207B0A2020202020206C657420636667203D20617267756D656E74732E6C656E677468203E203020262620617267756D656E74735B305D20213D';
wwv_flow_api.g_varchar2_table(280) := '3D20756E646566696E6564203F20617267756D656E74735B305D203A207B7D3B0A20202020202069662028434F4E46494720262620434F4E464947203D3D3D2063666729207B0A202020202020202072657475726E3B0A2020202020207D0A2020202020';
wwv_flow_api.g_varchar2_table(281) := '202F2A20536869656C6420636F6E66696775726174696F6E206F626A6563742066726F6D2074616D706572696E67202A2F0A2020202020206966202821636667207C7C20747970656F662063666720213D3D20276F626A6563742729207B0A2020202020';
wwv_flow_api.g_varchar2_table(282) := '202020636667203D207B7D3B0A2020202020207D0A2020202020202F2A20536869656C6420636F6E66696775726174696F6E206F626A6563742066726F6D2070726F746F7479706520706F6C6C7574696F6E202A2F0A202020202020636667203D20636C';
wwv_flow_api.g_varchar2_table(283) := '6F6E6528636667293B0A2020202020205041525345525F4D454449415F54595045203D0A2020202020202F2F2065736C696E742D64697361626C652D6E6578742D6C696E6520756E69636F726E2F7072656665722D696E636C756465730A202020202020';
wwv_flow_api.g_varchar2_table(284) := '535550504F525445445F5041525345525F4D454449415F54595045532E696E6465784F66286366672E5041525345525F4D454449415F5459504529203D3D3D202D31203F2044454641554C545F5041525345525F4D454449415F54595045203A20636667';
wwv_flow_api.g_varchar2_table(285) := '2E5041525345525F4D454449415F545950453B0A2020202020202F2F2048544D4C207461677320616E64206174747269627574657320617265206E6F7420636173652D73656E7369746976652C20636F6E76657274696E6720746F206C6F776572636173';
wwv_flow_api.g_varchar2_table(286) := '652E204B656570696E67205848544D4C2061732069732E0A2020202020207472616E73666F726D4361736546756E63203D205041525345525F4D454449415F54595045203D3D3D20276170706C69636174696F6E2F7868746D6C2B786D6C27203F207374';
wwv_flow_api.g_varchar2_table(287) := '72696E67546F537472696E67203A20737472696E67546F4C6F776572436173653B0A2020202020202F2A2053657420636F6E66696775726174696F6E20706172616D6574657273202A2F0A202020202020414C4C4F5745445F54414753203D206F626A65';
wwv_flow_api.g_varchar2_table(288) := '63744861734F776E50726F7065727479286366672C2027414C4C4F5745445F544147532729203F20616464546F536574287B7D2C206366672E414C4C4F5745445F544147532C207472616E73666F726D4361736546756E6329203A2044454641554C545F';
wwv_flow_api.g_varchar2_table(289) := '414C4C4F5745445F544147533B0A202020202020414C4C4F5745445F41545452203D206F626A6563744861734F776E50726F7065727479286366672C2027414C4C4F5745445F415454522729203F20616464546F536574287B7D2C206366672E414C4C4F';
wwv_flow_api.g_varchar2_table(290) := '5745445F415454522C207472616E73666F726D4361736546756E6329203A2044454641554C545F414C4C4F5745445F415454523B0A202020202020414C4C4F5745445F4E414D45535041434553203D206F626A6563744861734F776E50726F7065727479';
wwv_flow_api.g_varchar2_table(291) := '286366672C2027414C4C4F5745445F4E414D455350414345532729203F20616464546F536574287B7D2C206366672E414C4C4F5745445F4E414D455350414345532C20737472696E67546F537472696E6729203A2044454641554C545F414C4C4F574544';
wwv_flow_api.g_varchar2_table(292) := '5F4E414D455350414345533B0A2020202020205552495F534146455F41545452494255544553203D206F626A6563744861734F776E50726F7065727479286366672C20274144445F5552495F534146455F415454522729203F20616464546F5365742863';
wwv_flow_api.g_varchar2_table(293) := '6C6F6E652844454641554C545F5552495F534146455F41545452494255544553292C206366672E4144445F5552495F534146455F415454522C207472616E73666F726D4361736546756E6329203A2044454641554C545F5552495F534146455F41545452';
wwv_flow_api.g_varchar2_table(294) := '4942555445533B0A202020202020444154415F5552495F54414753203D206F626A6563744861734F776E50726F7065727479286366672C20274144445F444154415F5552495F544147532729203F20616464546F53657428636C6F6E652844454641554C';
wwv_flow_api.g_varchar2_table(295) := '545F444154415F5552495F54414753292C206366672E4144445F444154415F5552495F544147532C207472616E73666F726D4361736546756E6329203A2044454641554C545F444154415F5552495F544147533B0A202020202020464F524249445F434F';
wwv_flow_api.g_varchar2_table(296) := '4E54454E5453203D206F626A6563744861734F776E50726F7065727479286366672C2027464F524249445F434F4E54454E54532729203F20616464546F536574287B7D2C206366672E464F524249445F434F4E54454E54532C207472616E73666F726D43';
wwv_flow_api.g_varchar2_table(297) := '61736546756E6329203A2044454641554C545F464F524249445F434F4E54454E54533B0A202020202020464F524249445F54414753203D206F626A6563744861734F776E50726F7065727479286366672C2027464F524249445F544147532729203F2061';
wwv_flow_api.g_varchar2_table(298) := '6464546F536574287B7D2C206366672E464F524249445F544147532C207472616E73666F726D4361736546756E6329203A207B7D3B0A202020202020464F524249445F41545452203D206F626A6563744861734F776E50726F7065727479286366672C20';
wwv_flow_api.g_varchar2_table(299) := '27464F524249445F415454522729203F20616464546F536574287B7D2C206366672E464F524249445F415454522C207472616E73666F726D4361736546756E6329203A207B7D3B0A2020202020205553455F50524F46494C4553203D206F626A65637448';
wwv_flow_api.g_varchar2_table(300) := '61734F776E50726F7065727479286366672C20275553455F50524F46494C45532729203F206366672E5553455F50524F46494C4553203A2066616C73653B0A202020202020414C4C4F575F415249415F41545452203D206366672E414C4C4F575F415249';
wwv_flow_api.g_varchar2_table(301) := '415F4154545220213D3D2066616C73653B202F2F2044656661756C7420747275650A202020202020414C4C4F575F444154415F41545452203D206366672E414C4C4F575F444154415F4154545220213D3D2066616C73653B202F2F2044656661756C7420';
wwv_flow_api.g_varchar2_table(302) := '747275650A202020202020414C4C4F575F554E4B4E4F574E5F50524F544F434F4C53203D206366672E414C4C4F575F554E4B4E4F574E5F50524F544F434F4C53207C7C2066616C73653B202F2F2044656661756C742066616C73650A202020202020414C';
wwv_flow_api.g_varchar2_table(303) := '4C4F575F53454C465F434C4F53455F494E5F41545452203D206366672E414C4C4F575F53454C465F434C4F53455F494E5F4154545220213D3D2066616C73653B202F2F2044656661756C7420747275650A202020202020534146455F464F525F54454D50';
wwv_flow_api.g_varchar2_table(304) := '4C41544553203D206366672E534146455F464F525F54454D504C41544553207C7C2066616C73653B202F2F2044656661756C742066616C73650A202020202020534146455F464F525F584D4C203D206366672E534146455F464F525F584D4C20213D3D20';
wwv_flow_api.g_varchar2_table(305) := '66616C73653B202F2F2044656661756C7420747275650A20202020202057484F4C455F444F43554D454E54203D206366672E57484F4C455F444F43554D454E54207C7C2066616C73653B202F2F2044656661756C742066616C73650A2020202020205245';
wwv_flow_api.g_varchar2_table(306) := '5455524E5F444F4D203D206366672E52455455524E5F444F4D207C7C2066616C73653B202F2F2044656661756C742066616C73650A20202020202052455455524E5F444F4D5F465241474D454E54203D206366672E52455455524E5F444F4D5F46524147';
wwv_flow_api.g_varchar2_table(307) := '4D454E54207C7C2066616C73653B202F2F2044656661756C742066616C73650A20202020202052455455524E5F545255535445445F54595045203D206366672E52455455524E5F545255535445445F54595045207C7C2066616C73653B202F2F20446566';
wwv_flow_api.g_varchar2_table(308) := '61756C742066616C73650A202020202020464F5243455F424F4459203D206366672E464F5243455F424F4459207C7C2066616C73653B202F2F2044656661756C742066616C73650A20202020202053414E4954495A455F444F4D203D206366672E53414E';
wwv_flow_api.g_varchar2_table(309) := '4954495A455F444F4D20213D3D2066616C73653B202F2F2044656661756C7420747275650A20202020202053414E4954495A455F4E414D45445F50524F5053203D206366672E53414E4954495A455F4E414D45445F50524F5053207C7C2066616C73653B';
wwv_flow_api.g_varchar2_table(310) := '202F2F2044656661756C742066616C73650A2020202020204B4545505F434F4E54454E54203D206366672E4B4545505F434F4E54454E5420213D3D2066616C73653B202F2F2044656661756C7420747275650A202020202020494E5F504C414345203D20';
wwv_flow_api.g_varchar2_table(311) := '6366672E494E5F504C414345207C7C2066616C73653B202F2F2044656661756C742066616C73650A20202020202049535F414C4C4F5745445F5552492431203D206366672E414C4C4F5745445F5552495F524547455850207C7C2049535F414C4C4F5745';
wwv_flow_api.g_varchar2_table(312) := '445F5552493B0A2020202020204E414D455350414345203D206366672E4E414D455350414345207C7C2048544D4C5F4E414D4553504143453B0A2020202020204D4154484D4C5F544558545F494E544547524154494F4E5F504F494E5453203D20636667';
wwv_flow_api.g_varchar2_table(313) := '2E4D4154484D4C5F544558545F494E544547524154494F4E5F504F494E5453207C7C204D4154484D4C5F544558545F494E544547524154494F4E5F504F494E54533B0A20202020202048544D4C5F494E544547524154494F4E5F504F494E5453203D2063';
wwv_flow_api.g_varchar2_table(314) := '66672E48544D4C5F494E544547524154494F4E5F504F494E5453207C7C2048544D4C5F494E544547524154494F4E5F504F494E54533B0A202020202020435553544F4D5F454C454D454E545F48414E444C494E47203D206366672E435553544F4D5F454C';
wwv_flow_api.g_varchar2_table(315) := '454D454E545F48414E444C494E47207C7C207B7D3B0A202020202020696620286366672E435553544F4D5F454C454D454E545F48414E444C494E4720262620697352656765784F7246756E6374696F6E286366672E435553544F4D5F454C454D454E545F';
wwv_flow_api.g_varchar2_table(316) := '48414E444C494E472E7461674E616D65436865636B2929207B0A2020202020202020435553544F4D5F454C454D454E545F48414E444C494E472E7461674E616D65436865636B203D206366672E435553544F4D5F454C454D454E545F48414E444C494E47';
wwv_flow_api.g_varchar2_table(317) := '2E7461674E616D65436865636B3B0A2020202020207D0A202020202020696620286366672E435553544F4D5F454C454D454E545F48414E444C494E4720262620697352656765784F7246756E6374696F6E286366672E435553544F4D5F454C454D454E54';
wwv_flow_api.g_varchar2_table(318) := '5F48414E444C494E472E6174747269627574654E616D65436865636B2929207B0A2020202020202020435553544F4D5F454C454D454E545F48414E444C494E472E6174747269627574654E616D65436865636B203D206366672E435553544F4D5F454C45';
wwv_flow_api.g_varchar2_table(319) := '4D454E545F48414E444C494E472E6174747269627574654E616D65436865636B3B0A2020202020207D0A202020202020696620286366672E435553544F4D5F454C454D454E545F48414E444C494E4720262620747970656F66206366672E435553544F4D';
wwv_flow_api.g_varchar2_table(320) := '5F454C454D454E545F48414E444C494E472E616C6C6F77437573746F6D697A65644275696C74496E456C656D656E7473203D3D3D2027626F6F6C65616E2729207B0A2020202020202020435553544F4D5F454C454D454E545F48414E444C494E472E616C';
wwv_flow_api.g_varchar2_table(321) := '6C6F77437573746F6D697A65644275696C74496E456C656D656E7473203D206366672E435553544F4D5F454C454D454E545F48414E444C494E472E616C6C6F77437573746F6D697A65644275696C74496E456C656D656E74733B0A2020202020207D0A20';
wwv_flow_api.g_varchar2_table(322) := '202020202069662028534146455F464F525F54454D504C4154455329207B0A2020202020202020414C4C4F575F444154415F41545452203D2066616C73653B0A2020202020207D0A2020202020206966202852455455524E5F444F4D5F465241474D454E';
wwv_flow_api.g_varchar2_table(323) := '5429207B0A202020202020202052455455524E5F444F4D203D20747275653B0A2020202020207D0A2020202020202F2A2050617273652070726F66696C6520696E666F202A2F0A202020202020696620285553455F50524F46494C455329207B0A202020';
wwv_flow_api.g_varchar2_table(324) := '2020202020414C4C4F5745445F54414753203D20616464546F536574287B7D2C2074657874293B0A2020202020202020414C4C4F5745445F41545452203D205B5D3B0A2020202020202020696620285553455F50524F46494C45532E68746D6C203D3D3D';
wwv_flow_api.g_varchar2_table(325) := '207472756529207B0A20202020202020202020616464546F53657428414C4C4F5745445F544147532C2068746D6C2431293B0A20202020202020202020616464546F53657428414C4C4F5745445F415454522C2068746D6C293B0A20202020202020207D';
wwv_flow_api.g_varchar2_table(326) := '0A2020202020202020696620285553455F50524F46494C45532E737667203D3D3D207472756529207B0A20202020202020202020616464546F53657428414C4C4F5745445F544147532C207376672431293B0A20202020202020202020616464546F5365';
wwv_flow_api.g_varchar2_table(327) := '7428414C4C4F5745445F415454522C20737667293B0A20202020202020202020616464546F53657428414C4C4F5745445F415454522C20786D6C293B0A20202020202020207D0A2020202020202020696620285553455F50524F46494C45532E73766746';
wwv_flow_api.g_varchar2_table(328) := '696C74657273203D3D3D207472756529207B0A20202020202020202020616464546F53657428414C4C4F5745445F544147532C2073766746696C74657273293B0A20202020202020202020616464546F53657428414C4C4F5745445F415454522C207376';
wwv_flow_api.g_varchar2_table(329) := '67293B0A20202020202020202020616464546F53657428414C4C4F5745445F415454522C20786D6C293B0A20202020202020207D0A2020202020202020696620285553455F50524F46494C45532E6D6174684D6C203D3D3D207472756529207B0A202020';
wwv_flow_api.g_varchar2_table(330) := '20202020202020616464546F53657428414C4C4F5745445F544147532C206D6174684D6C2431293B0A20202020202020202020616464546F53657428414C4C4F5745445F415454522C206D6174684D6C293B0A20202020202020202020616464546F5365';
wwv_flow_api.g_varchar2_table(331) := '7428414C4C4F5745445F415454522C20786D6C293B0A20202020202020207D0A2020202020207D0A2020202020202F2A204D6572676520636F6E66696775726174696F6E20706172616D6574657273202A2F0A202020202020696620286366672E414444';
wwv_flow_api.g_varchar2_table(332) := '5F5441475329207B0A202020202020202069662028414C4C4F5745445F54414753203D3D3D2044454641554C545F414C4C4F5745445F5441475329207B0A20202020202020202020414C4C4F5745445F54414753203D20636C6F6E6528414C4C4F574544';
wwv_flow_api.g_varchar2_table(333) := '5F54414753293B0A20202020202020207D0A2020202020202020616464546F53657428414C4C4F5745445F544147532C206366672E4144445F544147532C207472616E73666F726D4361736546756E63293B0A2020202020207D0A202020202020696620';
wwv_flow_api.g_varchar2_table(334) := '286366672E4144445F4154545229207B0A202020202020202069662028414C4C4F5745445F41545452203D3D3D2044454641554C545F414C4C4F5745445F4154545229207B0A20202020202020202020414C4C4F5745445F41545452203D20636C6F6E65';
wwv_flow_api.g_varchar2_table(335) := '28414C4C4F5745445F41545452293B0A20202020202020207D0A2020202020202020616464546F53657428414C4C4F5745445F415454522C206366672E4144445F415454522C207472616E73666F726D4361736546756E63293B0A2020202020207D0A20';
wwv_flow_api.g_varchar2_table(336) := '2020202020696620286366672E4144445F5552495F534146455F4154545229207B0A2020202020202020616464546F536574285552495F534146455F415454524942555445532C206366672E4144445F5552495F534146455F415454522C207472616E73';
wwv_flow_api.g_varchar2_table(337) := '666F726D4361736546756E63293B0A2020202020207D0A202020202020696620286366672E464F524249445F434F4E54454E545329207B0A202020202020202069662028464F524249445F434F4E54454E5453203D3D3D2044454641554C545F464F5242';
wwv_flow_api.g_varchar2_table(338) := '49445F434F4E54454E545329207B0A20202020202020202020464F524249445F434F4E54454E5453203D20636C6F6E6528464F524249445F434F4E54454E5453293B0A20202020202020207D0A2020202020202020616464546F53657428464F52424944';
wwv_flow_api.g_varchar2_table(339) := '5F434F4E54454E54532C206366672E464F524249445F434F4E54454E54532C207472616E73666F726D4361736546756E63293B0A2020202020207D0A2020202020202F2A2041646420237465787420696E2063617365204B4545505F434F4E54454E5420';
wwv_flow_api.g_varchar2_table(340) := '69732073657420746F2074727565202A2F0A202020202020696620284B4545505F434F4E54454E5429207B0A2020202020202020414C4C4F5745445F544147535B272374657874275D203D20747275653B0A2020202020207D0A2020202020202F2A2041';
wwv_flow_api.g_varchar2_table(341) := '64642068746D6C2C206865616420616E6420626F647920746F20414C4C4F5745445F5441475320696E20636173652057484F4C455F444F43554D454E542069732074727565202A2F0A2020202020206966202857484F4C455F444F43554D454E5429207B';
wwv_flow_api.g_varchar2_table(342) := '0A2020202020202020616464546F53657428414C4C4F5745445F544147532C205B2768746D6C272C202768656164272C2027626F6479275D293B0A2020202020207D0A2020202020202F2A204164642074626F647920746F20414C4C4F5745445F544147';
wwv_flow_api.g_varchar2_table(343) := '5320696E2063617365207461626C657320617265207065726D69747465642C2073656520233238362C2023333635202A2F0A20202020202069662028414C4C4F5745445F544147532E7461626C6529207B0A2020202020202020616464546F5365742841';
wwv_flow_api.g_varchar2_table(344) := '4C4C4F5745445F544147532C205B2774626F6479275D293B0A202020202020202064656C65746520464F524249445F544147532E74626F64793B0A2020202020207D0A202020202020696620286366672E545255535445445F54595045535F504F4C4943';
wwv_flow_api.g_varchar2_table(345) := '5929207B0A202020202020202069662028747970656F66206366672E545255535445445F54595045535F504F4C4943592E63726561746548544D4C20213D3D202766756E6374696F6E2729207B0A202020202020202020207468726F7720747970654572';
wwv_flow_api.g_varchar2_table(346) := '726F724372656174652827545255535445445F54595045535F504F4C49435920636F6E66696775726174696F6E206F7074696F6E206D7573742070726F766964652061202263726561746548544D4C2220686F6F6B2E27293B0A20202020202020207D0A';
wwv_flow_api.g_varchar2_table(347) := '202020202020202069662028747970656F66206366672E545255535445445F54595045535F504F4C4943592E63726561746553637269707455524C20213D3D202766756E6374696F6E2729207B0A202020202020202020207468726F7720747970654572';
wwv_flow_api.g_varchar2_table(348) := '726F724372656174652827545255535445445F54595045535F504F4C49435920636F6E66696775726174696F6E206F7074696F6E206D7573742070726F766964652061202263726561746553637269707455524C2220686F6F6B2E27293B0A2020202020';
wwv_flow_api.g_varchar2_table(349) := '2020207D0A20202020202020202F2F204F7665727772697465206578697374696E672054727573746564547970657320706F6C6963792E0A2020202020202020747275737465645479706573506F6C696379203D206366672E545255535445445F545950';
wwv_flow_api.g_varchar2_table(350) := '45535F504F4C4943593B0A20202020202020202F2F205369676E206C6F63616C207661726961626C6573207265717569726564206279206073616E6974697A65602E0A2020202020202020656D70747948544D4C203D2074727573746564547970657350';
wwv_flow_api.g_varchar2_table(351) := '6F6C6963792E63726561746548544D4C282727293B0A2020202020207D20656C7365207B0A20202020202020202F2F20556E696E697469616C697A656420706F6C6963792C20617474656D707420746F20696E697469616C697A652074686520696E7465';
wwv_flow_api.g_varchar2_table(352) := '726E616C20646F6D70757269667920706F6C6963792E0A202020202020202069662028747275737465645479706573506F6C696379203D3D3D20756E646566696E656429207B0A20202020202020202020747275737465645479706573506F6C69637920';
wwv_flow_api.g_varchar2_table(353) := '3D205F637265617465547275737465645479706573506F6C696379287472757374656454797065732C2063757272656E74536372697074293B0A20202020202020207D0A20202020202020202F2F204966206372656174696E672074686520696E746572';
wwv_flow_api.g_varchar2_table(354) := '6E616C20706F6C69637920737563636565646564207369676E20696E7465726E616C207661726961626C65732E0A202020202020202069662028747275737465645479706573506F6C69637920213D3D206E756C6C20262620747970656F6620656D7074';
wwv_flow_api.g_varchar2_table(355) := '7948544D4C203D3D3D2027737472696E672729207B0A20202020202020202020656D70747948544D4C203D20747275737465645479706573506F6C6963792E63726561746548544D4C282727293B0A20202020202020207D0A2020202020207D0A202020';
wwv_flow_api.g_varchar2_table(356) := '2020202F2F2050726576656E742066757274686572206D616E6970756C6174696F6E206F6620636F6E66696775726174696F6E2E0A2020202020202F2F204E6F7420617661696C61626C6520696E204945382C2053616661726920352C206574632E0A20';
wwv_flow_api.g_varchar2_table(357) := '202020202069662028667265657A6529207B0A2020202020202020667265657A6528636667293B0A2020202020207D0A202020202020434F4E464947203D206366673B0A202020207D3B0A202020202F2A204B65657020747261636B206F6620616C6C20';
wwv_flow_api.g_varchar2_table(358) := '706F737369626C652053564720616E64204D6174684D4C20746167730A20202020202A20736F20746861742077652063616E20706572666F726D20746865206E616D65737061636520636865636B730A20202020202A20636F72726563746C792E202A2F';
wwv_flow_api.g_varchar2_table(359) := '0A20202020636F6E737420414C4C5F5356475F54414753203D20616464546F536574287B7D2C205B2E2E2E73766724312C202E2E2E73766746696C746572732C202E2E2E737667446973616C6C6F7765645D293B0A20202020636F6E737420414C4C5F4D';
wwv_flow_api.g_varchar2_table(360) := '4154484D4C5F54414753203D20616464546F536574287B7D2C205B2E2E2E6D6174684D6C24312C202E2E2E6D6174684D6C446973616C6C6F7765645D293B0A202020202F2A2A0A20202020202A2040706172616D20656C656D656E74206120444F4D2065';
wwv_flow_api.g_varchar2_table(361) := '6C656D656E742077686F7365206E616D657370616365206973206265696E6720636865636B65640A20202020202A204072657475726E732052657475726E2066616C73652069662074686520656C656D656E742068617320610A20202020202A20206E61';
wwv_flow_api.g_varchar2_table(362) := '6D6573706163652074686174206120737065632D636F6D706C69616E742070617273657220776F756C64206E657665720A20202020202A202072657475726E2E2052657475726E2074727565206F74686572776973652E0A20202020202A2F0A20202020';
wwv_flow_api.g_varchar2_table(363) := '636F6E7374205F636865636B56616C69644E616D657370616365203D2066756E6374696F6E205F636865636B56616C69644E616D65737061636528656C656D656E7429207B0A2020202020206C657420706172656E74203D20676574506172656E744E6F';
wwv_flow_api.g_varchar2_table(364) := '646528656C656D656E74293B0A2020202020202F2F20496E204A53444F4D2C20696620776527726520696E7369646520736861646F7720444F4D2C207468656E20706172656E744E6F64650A2020202020202F2F2063616E206265206E756C6C2E205765';
wwv_flow_api.g_varchar2_table(365) := '206A7573742073696D756C61746520706172656E7420696E207468697320636173652E0A2020202020206966202821706172656E74207C7C2021706172656E742E7461674E616D6529207B0A2020202020202020706172656E74203D207B0A2020202020';
wwv_flow_api.g_varchar2_table(366) := '20202020206E616D6573706163655552493A204E414D4553504143452C0A202020202020202020207461674E616D653A202774656D706C617465270A20202020202020207D3B0A2020202020207D0A202020202020636F6E7374207461674E616D65203D';
wwv_flow_api.g_varchar2_table(367) := '20737472696E67546F4C6F7765724361736528656C656D656E742E7461674E616D65293B0A202020202020636F6E737420706172656E745461674E616D65203D20737472696E67546F4C6F7765724361736528706172656E742E7461674E616D65293B0A';
wwv_flow_api.g_varchar2_table(368) := '2020202020206966202821414C4C4F5745445F4E414D455350414345535B656C656D656E742E6E616D6573706163655552495D29207B0A202020202020202072657475726E2066616C73653B0A2020202020207D0A20202020202069662028656C656D65';
wwv_flow_api.g_varchar2_table(369) := '6E742E6E616D657370616365555249203D3D3D205356475F4E414D45535041434529207B0A20202020202020202F2F20546865206F6E6C792077617920746F207377697463682066726F6D2048544D4C206E616D65737061636520746F205356470A2020';
wwv_flow_api.g_varchar2_table(370) := '2020202020202F2F20697320766961203C7376673E2E2049662069742068617070656E732076696120616E79206F74686572207461672C207468656E0A20202020202020202F2F2069742073686F756C64206265206B696C6C65642E0A20202020202020';
wwv_flow_api.g_varchar2_table(371) := '2069662028706172656E742E6E616D657370616365555249203D3D3D2048544D4C5F4E414D45535041434529207B0A2020202020202020202072657475726E207461674E616D65203D3D3D2027737667273B0A20202020202020207D0A20202020202020';
wwv_flow_api.g_varchar2_table(372) := '202F2F20546865206F6E6C792077617920746F207377697463682066726F6D204D6174684D4C20746F2053564720697320766961600A20202020202020202F2F2073766720696620706172656E7420697320656974686572203C616E6E6F746174696F6E';
wwv_flow_api.g_varchar2_table(373) := '2D786D6C3E206F72204D6174684D4C0A20202020202020202F2F207465787420696E746567726174696F6E20706F696E74732E0A202020202020202069662028706172656E742E6E616D657370616365555249203D3D3D204D4154484D4C5F4E414D4553';
wwv_flow_api.g_varchar2_table(374) := '5041434529207B0A2020202020202020202072657475726E207461674E616D65203D3D3D2027737667272026262028706172656E745461674E616D65203D3D3D2027616E6E6F746174696F6E2D786D6C27207C7C204D4154484D4C5F544558545F494E54';
wwv_flow_api.g_varchar2_table(375) := '4547524154494F4E5F504F494E54535B706172656E745461674E616D655D293B0A20202020202020207D0A20202020202020202F2F205765206F6E6C7920616C6C6F7720656C656D656E747320746861742061726520646566696E656420696E20535647';
wwv_flow_api.g_varchar2_table(376) := '0A20202020202020202F2F20737065632E20416C6C206F74686572732061726520646973616C6C6F77656420696E20535647206E616D6573706163652E0A202020202020202072657475726E20426F6F6C65616E28414C4C5F5356475F544147535B7461';
wwv_flow_api.g_varchar2_table(377) := '674E616D655D293B0A2020202020207D0A20202020202069662028656C656D656E742E6E616D657370616365555249203D3D3D204D4154484D4C5F4E414D45535041434529207B0A20202020202020202F2F20546865206F6E6C792077617920746F2073';
wwv_flow_api.g_varchar2_table(378) := '77697463682066726F6D2048544D4C206E616D65737061636520746F204D6174684D4C0A20202020202020202F2F20697320766961203C6D6174683E2E2049662069742068617070656E732076696120616E79206F74686572207461672C207468656E0A';
wwv_flow_api.g_varchar2_table(379) := '20202020202020202F2F2069742073686F756C64206265206B696C6C65642E0A202020202020202069662028706172656E742E6E616D657370616365555249203D3D3D2048544D4C5F4E414D45535041434529207B0A2020202020202020202072657475';
wwv_flow_api.g_varchar2_table(380) := '726E207461674E616D65203D3D3D20276D617468273B0A20202020202020207D0A20202020202020202F2F20546865206F6E6C792077617920746F207377697463682066726F6D2053564720746F204D6174684D4C206973207669610A20202020202020';
wwv_flow_api.g_varchar2_table(381) := '202F2F203C6D6174683E20616E642048544D4C20696E746567726174696F6E20706F696E74730A202020202020202069662028706172656E742E6E616D657370616365555249203D3D3D205356475F4E414D45535041434529207B0A2020202020202020';
wwv_flow_api.g_varchar2_table(382) := '202072657475726E207461674E616D65203D3D3D20276D617468272026262048544D4C5F494E544547524154494F4E5F504F494E54535B706172656E745461674E616D655D3B0A20202020202020207D0A20202020202020202F2F205765206F6E6C7920';
wwv_flow_api.g_varchar2_table(383) := '616C6C6F7720656C656D656E747320746861742061726520646566696E656420696E204D6174684D4C0A20202020202020202F2F20737065632E20416C6C206F74686572732061726520646973616C6C6F77656420696E204D6174684D4C206E616D6573';
wwv_flow_api.g_varchar2_table(384) := '706163652E0A202020202020202072657475726E20426F6F6C65616E28414C4C5F4D4154484D4C5F544147535B7461674E616D655D293B0A2020202020207D0A20202020202069662028656C656D656E742E6E616D657370616365555249203D3D3D2048';
wwv_flow_api.g_varchar2_table(385) := '544D4C5F4E414D45535041434529207B0A20202020202020202F2F20546865206F6E6C792077617920746F207377697463682066726F6D2053564720746F2048544D4C206973207669610A20202020202020202F2F2048544D4C20696E74656772617469';
wwv_flow_api.g_varchar2_table(386) := '6F6E20706F696E74732C20616E642066726F6D204D6174684D4C20746F2048544D4C0A20202020202020202F2F20697320766961204D6174684D4C207465787420696E746567726174696F6E20706F696E74730A20202020202020206966202870617265';
wwv_flow_api.g_varchar2_table(387) := '6E742E6E616D657370616365555249203D3D3D205356475F4E414D455350414345202626202148544D4C5F494E544547524154494F4E5F504F494E54535B706172656E745461674E616D655D29207B0A2020202020202020202072657475726E2066616C';
wwv_flow_api.g_varchar2_table(388) := '73653B0A20202020202020207D0A202020202020202069662028706172656E742E6E616D657370616365555249203D3D3D204D4154484D4C5F4E414D45535041434520262620214D4154484D4C5F544558545F494E544547524154494F4E5F504F494E54';
wwv_flow_api.g_varchar2_table(389) := '535B706172656E745461674E616D655D29207B0A2020202020202020202072657475726E2066616C73653B0A20202020202020207D0A20202020202020202F2F20576520646973616C6C6F77207461677320746861742061726520737065636966696320';
wwv_flow_api.g_varchar2_table(390) := '666F72204D6174684D4C0A20202020202020202F2F206F722053564720616E642073686F756C64206E657665722061707065617220696E2048544D4C206E616D6573706163650A202020202020202072657475726E2021414C4C5F4D4154484D4C5F5441';
wwv_flow_api.g_varchar2_table(391) := '47535B7461674E616D655D2026262028434F4D4D4F4E5F5356475F414E445F48544D4C5F454C454D454E54535B7461674E616D655D207C7C2021414C4C5F5356475F544147535B7461674E616D655D293B0A2020202020207D0A2020202020202F2F2046';
wwv_flow_api.g_varchar2_table(392) := '6F72205848544D4C20616E6420584D4C20646F63756D656E7473207468617420737570706F727420637573746F6D206E616D657370616365730A202020202020696620285041525345525F4D454449415F54595045203D3D3D20276170706C6963617469';
wwv_flow_api.g_varchar2_table(393) := '6F6E2F7868746D6C2B786D6C2720262620414C4C4F5745445F4E414D455350414345535B656C656D656E742E6E616D6573706163655552495D29207B0A202020202020202072657475726E20747275653B0A2020202020207D0A2020202020202F2F2054';
wwv_flow_api.g_varchar2_table(394) := '686520636F64652073686F756C64206E65766572207265616368207468697320706C616365202874686973206D65616E730A2020202020202F2F20746861742074686520656C656D656E7420736F6D65686F7720676F74206E616D657370616365207468';
wwv_flow_api.g_varchar2_table(395) := '6174206973206E6F740A2020202020202F2F2048544D4C2C205356472C204D6174684D4C206F7220616C6C6F7765642076696120414C4C4F5745445F4E414D45535041434553292E0A2020202020202F2F2052657475726E2066616C7365206A75737420';
wwv_flow_api.g_varchar2_table(396) := '696E20636173652E0A20202020202072657475726E2066616C73653B0A202020207D3B0A202020202F2A2A0A20202020202A205F666F72636552656D6F76650A20202020202A0A20202020202A2040706172616D206E6F6465206120444F4D206E6F6465';
wwv_flow_api.g_varchar2_table(397) := '0A20202020202A2F0A20202020636F6E7374205F666F72636552656D6F7665203D2066756E6374696F6E205F666F72636552656D6F7665286E6F646529207B0A20202020202061727261795075736828444F4D5075726966792E72656D6F7665642C207B';
wwv_flow_api.g_varchar2_table(398) := '0A2020202020202020656C656D656E743A206E6F64650A2020202020207D293B0A202020202020747279207B0A20202020202020202F2F2065736C696E742D64697361626C652D6E6578742D6C696E6520756E69636F726E2F7072656665722D646F6D2D';
wwv_flow_api.g_varchar2_table(399) := '6E6F64652D72656D6F76650A2020202020202020676574506172656E744E6F6465286E6F6465292E72656D6F76654368696C64286E6F6465293B0A2020202020207D20636174636820285F29207B0A202020202020202072656D6F7665286E6F6465293B';
wwv_flow_api.g_varchar2_table(400) := '0A2020202020207D0A202020207D3B0A202020202F2A2A0A20202020202A205F72656D6F76654174747269627574650A20202020202A0A20202020202A2040706172616D206E616D6520616E20417474726962757465206E616D650A20202020202A2040';
wwv_flow_api.g_varchar2_table(401) := '706172616D20656C656D656E74206120444F4D206E6F64650A20202020202A2F0A20202020636F6E7374205F72656D6F7665417474726962757465203D2066756E6374696F6E205F72656D6F7665417474726962757465286E616D652C20656C656D656E';
wwv_flow_api.g_varchar2_table(402) := '7429207B0A202020202020747279207B0A202020202020202061727261795075736828444F4D5075726966792E72656D6F7665642C207B0A202020202020202020206174747269627574653A20656C656D656E742E6765744174747269627574654E6F64';
wwv_flow_api.g_varchar2_table(403) := '65286E616D65292C0A2020202020202020202066726F6D3A20656C656D656E740A20202020202020207D293B0A2020202020207D20636174636820285F29207B0A202020202020202061727261795075736828444F4D5075726966792E72656D6F766564';
wwv_flow_api.g_varchar2_table(404) := '2C207B0A202020202020202020206174747269627574653A206E756C6C2C0A2020202020202020202066726F6D3A20656C656D656E740A20202020202020207D293B0A2020202020207D0A202020202020656C656D656E742E72656D6F76654174747269';
wwv_flow_api.g_varchar2_table(405) := '62757465286E616D65293B0A2020202020202F2F20576520766F6964206174747269627574652076616C75657320666F7220756E72656D6F7661626C65202269732220617474726962757465730A202020202020696620286E616D65203D3D3D20276973';
wwv_flow_api.g_varchar2_table(406) := '2729207B0A20202020202020206966202852455455524E5F444F4D207C7C2052455455524E5F444F4D5F465241474D454E5429207B0A20202020202020202020747279207B0A2020202020202020202020205F666F72636552656D6F766528656C656D65';
wwv_flow_api.g_varchar2_table(407) := '6E74293B0A202020202020202020207D20636174636820285F29207B7D0A20202020202020207D20656C7365207B0A20202020202020202020747279207B0A202020202020202020202020656C656D656E742E736574417474726962757465286E616D65';
wwv_flow_api.g_varchar2_table(408) := '2C202727293B0A202020202020202020207D20636174636820285F29207B7D0A20202020202020207D0A2020202020207D0A202020207D3B0A202020202F2A2A0A20202020202A205F696E6974446F63756D656E740A20202020202A0A20202020202A20';
wwv_flow_api.g_varchar2_table(409) := '40706172616D206469727479202D206120737472696E67206F66206469727479206D61726B75700A20202020202A204072657475726E206120444F4D2C2066696C6C6564207769746820746865206469727479206D61726B75700A20202020202A2F0A20';
wwv_flow_api.g_varchar2_table(410) := '202020636F6E7374205F696E6974446F63756D656E74203D2066756E6374696F6E205F696E6974446F63756D656E7428646972747929207B0A2020202020202F2A2043726561746520612048544D4C20646F63756D656E74202A2F0A2020202020206C65';
wwv_flow_api.g_varchar2_table(411) := '7420646F63203D206E756C6C3B0A2020202020206C6574206C656164696E6757686974657370616365203D206E756C6C3B0A20202020202069662028464F5243455F424F445929207B0A20202020202020206469727479203D20273C72656D6F76653E3C';
wwv_flow_api.g_varchar2_table(412) := '2F72656D6F76653E27202B2064697274793B0A2020202020207D20656C7365207B0A20202020202020202F2A20496620464F5243455F424F44592069736E277420757365642C206C656164696E672077686974657370616365206E6565647320746F2062';
wwv_flow_api.g_varchar2_table(413) := '6520707265736572766564206D616E75616C6C79202A2F0A2020202020202020636F6E7374206D617463686573203D20737472696E674D617463682864697274792C202F5E5B5C725C6E5C74205D2B2F293B0A20202020202020206C656164696E675768';
wwv_flow_api.g_varchar2_table(414) := '6974657370616365203D206D617463686573202626206D6174636865735B305D3B0A2020202020207D0A202020202020696620285041525345525F4D454449415F54595045203D3D3D20276170706C69636174696F6E2F7868746D6C2B786D6C27202626';
wwv_flow_api.g_varchar2_table(415) := '204E414D455350414345203D3D3D2048544D4C5F4E414D45535041434529207B0A20202020202020202F2F20526F6F74206F66205848544D4C20646F63206D75737420636F6E7461696E20786D6C6E73206465636C61726174696F6E2028736565206874';
wwv_flow_api.g_varchar2_table(416) := '7470733A2F2F7777772E77332E6F72672F54522F7868746D6C312F6E6F726D61746976652E68746D6C23737472696374290A20202020202020206469727479203D20273C68746D6C20786D6C6E733D22687474703A2F2F7777772E77332E6F72672F3139';
wwv_flow_api.g_varchar2_table(417) := '39392F7868746D6C223E3C686561643E3C2F686561643E3C626F64793E27202B206469727479202B20273C2F626F64793E3C2F68746D6C3E273B0A2020202020207D0A202020202020636F6E73742064697274795061796C6F6164203D20747275737465';
wwv_flow_api.g_varchar2_table(418) := '645479706573506F6C696379203F20747275737465645479706573506F6C6963792E63726561746548544D4C28646972747929203A2064697274793B0A2020202020202F2A0A202020202020202A205573652074686520444F4D50617273657220415049';
wwv_flow_api.g_varchar2_table(419) := '2062792064656661756C742C2066616C6C6261636B206C61746572206966206E656564732062650A202020202020202A20444F4D506172736572206E6F7420776F726B20666F7220737667207768656E20686173206D756C7469706C6520726F6F742065';
wwv_flow_api.g_varchar2_table(420) := '6C656D656E742E0A202020202020202A2F0A202020202020696620284E414D455350414345203D3D3D2048544D4C5F4E414D45535041434529207B0A2020202020202020747279207B0A20202020202020202020646F63203D206E657720444F4D506172';
wwv_flow_api.g_varchar2_table(421) := '73657228292E706172736546726F6D537472696E672864697274795061796C6F61642C205041525345525F4D454449415F54595045293B0A20202020202020207D20636174636820285F29207B7D0A2020202020207D0A2020202020202F2A2055736520';
wwv_flow_api.g_varchar2_table(422) := '63726561746548544D4C446F63756D656E7420696E206361736520444F4D506172736572206973206E6F7420617661696C61626C65202A2F0A2020202020206966202821646F63207C7C2021646F632E646F63756D656E74456C656D656E7429207B0A20';
wwv_flow_api.g_varchar2_table(423) := '20202020202020646F63203D20696D706C656D656E746174696F6E2E637265617465446F63756D656E74284E414D4553504143452C202774656D706C617465272C206E756C6C293B0A2020202020202020747279207B0A20202020202020202020646F63';
wwv_flow_api.g_varchar2_table(424) := '2E646F63756D656E74456C656D656E742E696E6E657248544D4C203D2049535F454D5054595F494E505554203F20656D70747948544D4C203A2064697274795061796C6F61643B0A20202020202020207D20636174636820285F29207B0A202020202020';
wwv_flow_api.g_varchar2_table(425) := '202020202F2F2053796E746178206572726F722069662064697274795061796C6F616420697320696E76616C696420786D6C0A20202020202020207D0A2020202020207D0A202020202020636F6E737420626F6479203D20646F632E626F6479207C7C20';
wwv_flow_api.g_varchar2_table(426) := '646F632E646F63756D656E74456C656D656E743B0A202020202020696620286469727479202626206C656164696E675768697465737061636529207B0A2020202020202020626F64792E696E736572744265666F726528646F63756D656E742E63726561';
wwv_flow_api.g_varchar2_table(427) := '7465546578744E6F6465286C656164696E6757686974657370616365292C20626F64792E6368696C644E6F6465735B305D207C7C206E756C6C293B0A2020202020207D0A2020202020202F2A20576F726B206F6E2077686F6C6520646F63756D656E7420';
wwv_flow_api.g_varchar2_table(428) := '6F72206A7573742069747320626F6479202A2F0A202020202020696620284E414D455350414345203D3D3D2048544D4C5F4E414D45535041434529207B0A202020202020202072657475726E20676574456C656D656E747342795461674E616D652E6361';
wwv_flow_api.g_varchar2_table(429) := '6C6C28646F632C2057484F4C455F444F43554D454E54203F202768746D6C27203A2027626F647927295B305D3B0A2020202020207D0A20202020202072657475726E2057484F4C455F444F43554D454E54203F20646F632E646F63756D656E74456C656D';
wwv_flow_api.g_varchar2_table(430) := '656E74203A20626F64793B0A202020207D3B0A202020202F2A2A0A20202020202A20437265617465732061204E6F64654974657261746F72206F626A656374207468617420796F752063616E2075736520746F2074726176657273652066696C74657265';
wwv_flow_api.g_varchar2_table(431) := '64206C69737473206F66206E6F646573206F7220656C656D656E747320696E206120646F63756D656E742E0A20202020202A0A20202020202A2040706172616D20726F6F742054686520726F6F7420656C656D656E74206F72206E6F646520746F207374';
wwv_flow_api.g_varchar2_table(432) := '6172742074726176657273696E67206F6E2E0A20202020202A204072657475726E205468652063726561746564204E6F64654974657261746F720A20202020202A2F0A20202020636F6E7374205F6372656174654E6F64654974657261746F72203D2066';
wwv_flow_api.g_varchar2_table(433) := '756E6374696F6E205F6372656174654E6F64654974657261746F7228726F6F7429207B0A20202020202072657475726E206372656174654E6F64654974657261746F722E63616C6C28726F6F742E6F776E6572446F63756D656E74207C7C20726F6F742C';
wwv_flow_api.g_varchar2_table(434) := '20726F6F742C0A2020202020202F2F2065736C696E742D64697361626C652D6E6578742D6C696E65206E6F2D626974776973650A2020202020204E6F646546696C7465722E53484F575F454C454D454E54207C204E6F646546696C7465722E53484F575F';
wwv_flow_api.g_varchar2_table(435) := '434F4D4D454E54207C204E6F646546696C7465722E53484F575F54455854207C204E6F646546696C7465722E53484F575F50524F43455353494E475F494E535452554354494F4E207C204E6F646546696C7465722E53484F575F43444154415F53454354';
wwv_flow_api.g_varchar2_table(436) := '494F4E2C206E756C6C293B0A202020207D3B0A202020202F2A2A0A20202020202A205F6973436C6F6262657265640A20202020202A0A20202020202A2040706172616D20656C656D656E7420656C656D656E7420746F20636865636B20666F7220636C6F';
wwv_flow_api.g_varchar2_table(437) := '62626572696E672061747461636B730A20202020202A204072657475726E207472756520696620636C6F6262657265642C2066616C736520696620736166650A20202020202A2F0A20202020636F6E7374205F6973436C6F626265726564203D2066756E';
wwv_flow_api.g_varchar2_table(438) := '6374696F6E205F6973436C6F62626572656428656C656D656E7429207B0A20202020202072657475726E20656C656D656E7420696E7374616E63656F662048544D4C466F726D456C656D656E742026262028747970656F6620656C656D656E742E6E6F64';
wwv_flow_api.g_varchar2_table(439) := '654E616D6520213D3D2027737472696E6727207C7C20747970656F6620656C656D656E742E74657874436F6E74656E7420213D3D2027737472696E6727207C7C20747970656F6620656C656D656E742E72656D6F76654368696C6420213D3D202766756E';
wwv_flow_api.g_varchar2_table(440) := '6374696F6E27207C7C202128656C656D656E742E6174747269627574657320696E7374616E63656F66204E616D65644E6F64654D617029207C7C20747970656F6620656C656D656E742E72656D6F766541747472696275746520213D3D202766756E6374';
wwv_flow_api.g_varchar2_table(441) := '696F6E27207C7C20747970656F6620656C656D656E742E73657441747472696275746520213D3D202766756E6374696F6E27207C7C20747970656F6620656C656D656E742E6E616D65737061636555524920213D3D2027737472696E6727207C7C207479';
wwv_flow_api.g_varchar2_table(442) := '70656F6620656C656D656E742E696E736572744265666F726520213D3D202766756E6374696F6E27207C7C20747970656F6620656C656D656E742E6861734368696C644E6F64657320213D3D202766756E6374696F6E27293B0A202020207D3B0A202020';
wwv_flow_api.g_varchar2_table(443) := '202F2A2A0A20202020202A20436865636B7320776865746865722074686520676976656E206F626A656374206973206120444F4D206E6F64652E0A20202020202A0A20202020202A2040706172616D2076616C7565206F626A65637420746F2063686563';
wwv_flow_api.g_varchar2_table(444) := '6B20776865746865722069742773206120444F4D206E6F64650A20202020202A204072657475726E2074727565206973206F626A656374206973206120444F4D206E6F64650A20202020202A2F0A20202020636F6E7374205F69734E6F6465203D206675';
wwv_flow_api.g_varchar2_table(445) := '6E6374696F6E205F69734E6F64652876616C756529207B0A20202020202072657475726E20747970656F66204E6F6465203D3D3D202766756E6374696F6E272026262076616C756520696E7374616E63656F66204E6F64653B0A202020207D3B0A202020';
wwv_flow_api.g_varchar2_table(446) := '2066756E6374696F6E205F65786563757465486F6F6B7328686F6F6B732C2063757272656E744E6F64652C206461746129207B0A2020202020206172726179466F724561636828686F6F6B732C20686F6F6B203D3E207B0A2020202020202020686F6F6B';
wwv_flow_api.g_varchar2_table(447) := '2E63616C6C28444F4D5075726966792C2063757272656E744E6F64652C20646174612C20434F4E464947293B0A2020202020207D293B0A202020207D0A202020202F2A2A0A20202020202A205F73616E6974697A65456C656D656E74730A20202020202A';
wwv_flow_api.g_varchar2_table(448) := '0A20202020202A204070726F74656374206E6F64654E616D650A20202020202A204070726F746563742074657874436F6E74656E740A20202020202A204070726F746563742072656D6F76654368696C640A20202020202A2040706172616D2063757272';
wwv_flow_api.g_varchar2_table(449) := '656E744E6F646520746F20636865636B20666F72207065726D697373696F6E20746F2065786973740A20202020202A204072657475726E2074727565206966206E6F646520776173206B696C6C65642C2066616C7365206966206C65667420616C697665';
wwv_flow_api.g_varchar2_table(450) := '0A20202020202A2F0A20202020636F6E7374205F73616E6974697A65456C656D656E7473203D2066756E6374696F6E205F73616E6974697A65456C656D656E74732863757272656E744E6F646529207B0A2020202020206C657420636F6E74656E74203D';
wwv_flow_api.g_varchar2_table(451) := '206E756C6C3B0A2020202020202F2A2045786563757465206120686F6F6B2069662070726573656E74202A2F0A2020202020205F65786563757465486F6F6B7328686F6F6B732E6265666F726553616E6974697A65456C656D656E74732C206375727265';
wwv_flow_api.g_varchar2_table(452) := '6E744E6F64652C206E756C6C293B0A2020202020202F2A20436865636B20696620656C656D656E7420697320636C6F626265726564206F722063616E20636C6F62626572202A2F0A202020202020696620285F6973436C6F626265726564286375727265';
wwv_flow_api.g_varchar2_table(453) := '6E744E6F64652929207B0A20202020202020205F666F72636552656D6F76652863757272656E744E6F6465293B0A202020202020202072657475726E20747275653B0A2020202020207D0A2020202020202F2A204E6F77206C6574277320636865636B20';
wwv_flow_api.g_varchar2_table(454) := '74686520656C656D656E742773207479706520616E64206E616D65202A2F0A202020202020636F6E7374207461674E616D65203D207472616E73666F726D4361736546756E632863757272656E744E6F64652E6E6F64654E616D65293B0A202020202020';
wwv_flow_api.g_varchar2_table(455) := '2F2A2045786563757465206120686F6F6B2069662070726573656E74202A2F0A2020202020205F65786563757465486F6F6B7328686F6F6B732E75706F6E53616E6974697A65456C656D656E742C2063757272656E744E6F64652C207B0A202020202020';
wwv_flow_api.g_varchar2_table(456) := '20207461674E616D652C0A2020202020202020616C6C6F776564546167733A20414C4C4F5745445F544147530A2020202020207D293B0A2020202020202F2A20446574656374206D58535320617474656D7074732061627573696E67206E616D65737061';
wwv_flow_api.g_varchar2_table(457) := '636520636F6E667573696F6E202A2F0A2020202020206966202863757272656E744E6F64652E6861734368696C644E6F646573282920262620215F69734E6F64652863757272656E744E6F64652E6669727374456C656D656E744368696C642920262620';
wwv_flow_api.g_varchar2_table(458) := '72656745787054657374282F3C5B2F5C775D2F672C2063757272656E744E6F64652E696E6E657248544D4C292026262072656745787054657374282F3C5B2F5C775D2F672C2063757272656E744E6F64652E74657874436F6E74656E742929207B0A2020';
wwv_flow_api.g_varchar2_table(459) := '2020202020205F666F72636552656D6F76652863757272656E744E6F6465293B0A202020202020202072657475726E20747275653B0A2020202020207D0A2020202020202F2A2052656D6F766520616E79206F6363757272656E6365206F662070726F63';
wwv_flow_api.g_varchar2_table(460) := '657373696E6720696E737472756374696F6E73202A2F0A2020202020206966202863757272656E744E6F64652E6E6F646554797065203D3D3D204E4F44455F545950452E70726F6772657373696E67496E737472756374696F6E29207B0A202020202020';
wwv_flow_api.g_varchar2_table(461) := '20205F666F72636552656D6F76652863757272656E744E6F6465293B0A202020202020202072657475726E20747275653B0A2020202020207D0A2020202020202F2A2052656D6F766520616E79206B696E64206F6620706F737369626C79206861726D66';
wwv_flow_api.g_varchar2_table(462) := '756C20636F6D6D656E7473202A2F0A20202020202069662028534146455F464F525F584D4C2026262063757272656E744E6F64652E6E6F646554797065203D3D3D204E4F44455F545950452E636F6D6D656E742026262072656745787054657374282F3C';
wwv_flow_api.g_varchar2_table(463) := '5B2F5C775D2F672C2063757272656E744E6F64652E646174612929207B0A20202020202020205F666F72636552656D6F76652863757272656E744E6F6465293B0A202020202020202072657475726E20747275653B0A2020202020207D0A202020202020';
wwv_flow_api.g_varchar2_table(464) := '2F2A2052656D6F766520656C656D656E7420696620616E797468696E6720666F7262696473206974732070726573656E6365202A2F0A2020202020206966202821414C4C4F5745445F544147535B7461674E616D655D207C7C20464F524249445F544147';
wwv_flow_api.g_varchar2_table(465) := '535B7461674E616D655D29207B0A20202020202020202F2A20436865636B2069662077652068617665206120637573746F6D20656C656D656E7420746F2068616E646C65202A2F0A20202020202020206966202821464F524249445F544147535B746167';
wwv_flow_api.g_varchar2_table(466) := '4E616D655D202626205F69734261736963437573746F6D456C656D656E74287461674E616D652929207B0A2020202020202020202069662028435553544F4D5F454C454D454E545F48414E444C494E472E7461674E616D65436865636B20696E7374616E';
wwv_flow_api.g_varchar2_table(467) := '63656F6620526567457870202626207265674578705465737428435553544F4D5F454C454D454E545F48414E444C494E472E7461674E616D65436865636B2C207461674E616D652929207B0A20202020202020202020202072657475726E2066616C7365';
wwv_flow_api.g_varchar2_table(468) := '3B0A202020202020202020207D0A2020202020202020202069662028435553544F4D5F454C454D454E545F48414E444C494E472E7461674E616D65436865636B20696E7374616E63656F662046756E6374696F6E20262620435553544F4D5F454C454D45';
wwv_flow_api.g_varchar2_table(469) := '4E545F48414E444C494E472E7461674E616D65436865636B287461674E616D652929207B0A20202020202020202020202072657475726E2066616C73653B0A202020202020202020207D0A20202020202020207D0A20202020202020202F2A204B656570';
wwv_flow_api.g_varchar2_table(470) := '20636F6E74656E742065786365707420666F72206261642D6C697374656420656C656D656E7473202A2F0A2020202020202020696620284B4545505F434F4E54454E542026262021464F524249445F434F4E54454E54535B7461674E616D655D29207B0A';
wwv_flow_api.g_varchar2_table(471) := '20202020202020202020636F6E737420706172656E744E6F6465203D20676574506172656E744E6F64652863757272656E744E6F646529207C7C2063757272656E744E6F64652E706172656E744E6F64653B0A20202020202020202020636F6E73742063';
wwv_flow_api.g_varchar2_table(472) := '68696C644E6F646573203D206765744368696C644E6F6465732863757272656E744E6F646529207C7C2063757272656E744E6F64652E6368696C644E6F6465733B0A20202020202020202020696620286368696C644E6F64657320262620706172656E74';
wwv_flow_api.g_varchar2_table(473) := '4E6F646529207B0A202020202020202020202020636F6E7374206368696C64436F756E74203D206368696C644E6F6465732E6C656E6774683B0A202020202020202020202020666F7220286C65742069203D206368696C64436F756E74202D20313B2069';
wwv_flow_api.g_varchar2_table(474) := '203E3D20303B202D2D6929207B0A2020202020202020202020202020636F6E7374206368696C64436C6F6E65203D20636C6F6E654E6F6465286368696C644E6F6465735B695D2C2074727565293B0A20202020202020202020202020206368696C64436C';
wwv_flow_api.g_varchar2_table(475) := '6F6E652E5F5F72656D6F76616C436F756E74203D202863757272656E744E6F64652E5F5F72656D6F76616C436F756E74207C7C203029202B20313B0A2020202020202020202020202020706172656E744E6F64652E696E736572744265666F7265286368';
wwv_flow_api.g_varchar2_table(476) := '696C64436C6F6E652C206765744E6578745369626C696E672863757272656E744E6F646529293B0A2020202020202020202020207D0A202020202020202020207D0A20202020202020207D0A20202020202020205F666F72636552656D6F766528637572';
wwv_flow_api.g_varchar2_table(477) := '72656E744E6F6465293B0A202020202020202072657475726E20747275653B0A2020202020207D0A2020202020202F2A20436865636B207768657468657220656C656D656E742068617320612076616C6964206E616D657370616365202A2F0A20202020';
wwv_flow_api.g_varchar2_table(478) := '20206966202863757272656E744E6F646520696E7374616E63656F6620456C656D656E7420262620215F636865636B56616C69644E616D6573706163652863757272656E744E6F64652929207B0A20202020202020205F666F72636552656D6F76652863';
wwv_flow_api.g_varchar2_table(479) := '757272656E744E6F6465293B0A202020202020202072657475726E20747275653B0A2020202020207D0A2020202020202F2A204D616B6520737572652074686174206F6C6465722062726F777365727320646F6E2774206765742066616C6C6261636B2D';
wwv_flow_api.g_varchar2_table(480) := '746167206D585353202A2F0A20202020202069662028287461674E616D65203D3D3D20276E6F73637269707427207C7C207461674E616D65203D3D3D20276E6F656D62656427207C7C207461674E616D65203D3D3D20276E6F6672616D65732729202626';
wwv_flow_api.g_varchar2_table(481) := '2072656745787054657374282F3C5C2F6E6F287363726970747C656D6265647C6672616D6573292F692C2063757272656E744E6F64652E696E6E657248544D4C2929207B0A20202020202020205F666F72636552656D6F76652863757272656E744E6F64';
wwv_flow_api.g_varchar2_table(482) := '65293B0A202020202020202072657475726E20747275653B0A2020202020207D0A2020202020202F2A2053616E6974697A6520656C656D656E7420636F6E74656E7420746F2062652074656D706C6174652D73616665202A2F0A20202020202069662028';
wwv_flow_api.g_varchar2_table(483) := '534146455F464F525F54454D504C415445532026262063757272656E744E6F64652E6E6F646554797065203D3D3D204E4F44455F545950452E7465787429207B0A20202020202020202F2A204765742074686520656C656D656E74277320746578742063';
wwv_flow_api.g_varchar2_table(484) := '6F6E74656E74202A2F0A2020202020202020636F6E74656E74203D2063757272656E744E6F64652E74657874436F6E74656E743B0A20202020202020206172726179466F7245616368285B4D555354414348455F455850522C204552425F455850522C20';
wwv_flow_api.g_varchar2_table(485) := '544D504C49545F455850525D2C2065787072203D3E207B0A20202020202020202020636F6E74656E74203D20737472696E675265706C61636528636F6E74656E742C20657870722C20272027293B0A20202020202020207D293B0A202020202020202069';
wwv_flow_api.g_varchar2_table(486) := '66202863757272656E744E6F64652E74657874436F6E74656E7420213D3D20636F6E74656E7429207B0A2020202020202020202061727261795075736828444F4D5075726966792E72656D6F7665642C207B0A202020202020202020202020656C656D65';
wwv_flow_api.g_varchar2_table(487) := '6E743A2063757272656E744E6F64652E636C6F6E654E6F646528290A202020202020202020207D293B0A2020202020202020202063757272656E744E6F64652E74657874436F6E74656E74203D20636F6E74656E743B0A20202020202020207D0A202020';
wwv_flow_api.g_varchar2_table(488) := '2020207D0A2020202020202F2A2045786563757465206120686F6F6B2069662070726573656E74202A2F0A2020202020205F65786563757465486F6F6B7328686F6F6B732E616674657253616E6974697A65456C656D656E74732C2063757272656E744E';
wwv_flow_api.g_varchar2_table(489) := '6F64652C206E756C6C293B0A20202020202072657475726E2066616C73653B0A202020207D3B0A202020202F2A2A0A20202020202A205F697356616C69644174747269627574650A20202020202A0A20202020202A2040706172616D206C63546167204C';
wwv_flow_api.g_varchar2_table(490) := '6F7765726361736520746167206E616D65206F6620636F6E7461696E696E6720656C656D656E742E0A20202020202A2040706172616D206C634E616D65204C6F7765726361736520617474726962757465206E616D652E0A20202020202A204070617261';
wwv_flow_api.g_varchar2_table(491) := '6D2076616C7565204174747269627574652076616C75652E0A20202020202A204072657475726E2052657475726E732074727565206966206076616C7565602069732076616C69642C206F74686572776973652066616C73652E0A20202020202A2F0A20';
wwv_flow_api.g_varchar2_table(492) := '2020202F2F2065736C696E742D64697361626C652D6E6578742D6C696E6520636F6D706C65786974790A20202020636F6E7374205F697356616C6964417474726962757465203D2066756E6374696F6E205F697356616C6964417474726962757465286C';
wwv_flow_api.g_varchar2_table(493) := '635461672C206C634E616D652C2076616C756529207B0A2020202020202F2A204D616B652073757265206174747269627574652063616E6E6F7420636C6F62626572202A2F0A2020202020206966202853414E4954495A455F444F4D20262620286C634E';
wwv_flow_api.g_varchar2_table(494) := '616D65203D3D3D2027696427207C7C206C634E616D65203D3D3D20276E616D652729202626202876616C756520696E20646F63756D656E74207C7C2076616C756520696E20666F726D456C656D656E742929207B0A202020202020202072657475726E20';
wwv_flow_api.g_varchar2_table(495) := '66616C73653B0A2020202020207D0A2020202020202F2A20416C6C6F772076616C696420646174612D2A20617474726962757465733A204174206C65617374206F6E652063686172616374657220616674657220222D220A202020202020202020202868';
wwv_flow_api.g_varchar2_table(496) := '747470733A2F2F68746D6C2E737065632E7768617477672E6F72672F6D756C7469706167652F646F6D2E68746D6C23656D62656464696E672D637573746F6D2D6E6F6E2D76697369626C652D646174612D776974682D7468652D646174612D2A2D617474';
wwv_flow_api.g_varchar2_table(497) := '72696275746573290A20202020202020202020584D4C2D636F6D70617469626C65202868747470733A2F2F68746D6C2E737065632E7768617477672E6F72672F6D756C7469706167652F696E6672617374727563747572652E68746D6C23786D6C2D636F';
wwv_flow_api.g_varchar2_table(498) := '6D70617469626C6520616E6420687474703A2F2F7777772E77332E6F72672F54522F786D6C2F23643065383034290A20202020202020202020576520646F6E2774206E65656420746F20636865636B207468652076616C75653B206974277320616C7761';
wwv_flow_api.g_varchar2_table(499) := '79732055524920736166652E202A2F0A20202020202069662028414C4C4F575F444154415F415454522026262021464F524249445F415454525B6C634E616D655D202626207265674578705465737428444154415F415454522C206C634E616D65292920';
wwv_flow_api.g_varchar2_table(500) := '3B20656C73652069662028414C4C4F575F415249415F41545452202626207265674578705465737428415249415F415454522C206C634E616D652929203B20656C7365206966202821414C4C4F5745445F415454525B6C634E616D655D207C7C20464F52';
wwv_flow_api.g_varchar2_table(501) := '4249445F415454525B6C634E616D655D29207B0A2020202020202020696620280A20202020202020202F2F20466972737420636F6E646974696F6E20646F65732061207665727920626173696320636865636B2069662061292069742773206261736963';
wwv_flow_api.g_varchar2_table(502) := '616C6C7920612076616C696420637573746F6D20656C656D656E74207461676E616D6520414E440A20202020202020202F2F20622920696620746865207461674E616D65207061737365732077686174657665722074686520757365722068617320636F';
wwv_flow_api.g_varchar2_table(503) := '6E6669677572656420666F7220435553544F4D5F454C454D454E545F48414E444C494E472E7461674E616D65436865636B0A20202020202020202F2F20616E642063292069662074686520617474726962757465206E616D652070617373657320776861';
wwv_flow_api.g_varchar2_table(504) := '74657665722074686520757365722068617320636F6E6669677572656420666F7220435553544F4D5F454C454D454E545F48414E444C494E472E6174747269627574654E616D65436865636B0A20202020202020205F69734261736963437573746F6D45';
wwv_flow_api.g_varchar2_table(505) := '6C656D656E74286C63546167292026262028435553544F4D5F454C454D454E545F48414E444C494E472E7461674E616D65436865636B20696E7374616E63656F6620526567457870202626207265674578705465737428435553544F4D5F454C454D454E';
wwv_flow_api.g_varchar2_table(506) := '545F48414E444C494E472E7461674E616D65436865636B2C206C6354616729207C7C20435553544F4D5F454C454D454E545F48414E444C494E472E7461674E616D65436865636B20696E7374616E63656F662046756E6374696F6E20262620435553544F';
wwv_flow_api.g_varchar2_table(507) := '4D5F454C454D454E545F48414E444C494E472E7461674E616D65436865636B286C6354616729292026262028435553544F4D5F454C454D454E545F48414E444C494E472E6174747269627574654E616D65436865636B20696E7374616E63656F66205265';
wwv_flow_api.g_varchar2_table(508) := '67457870202626207265674578705465737428435553544F4D5F454C454D454E545F48414E444C494E472E6174747269627574654E616D65436865636B2C206C634E616D6529207C7C20435553544F4D5F454C454D454E545F48414E444C494E472E6174';
wwv_flow_api.g_varchar2_table(509) := '747269627574654E616D65436865636B20696E7374616E63656F662046756E6374696F6E20262620435553544F4D5F454C454D454E545F48414E444C494E472E6174747269627574654E616D65436865636B286C634E616D652929207C7C0A2020202020';
wwv_flow_api.g_varchar2_table(510) := '2020202F2F20416C7465726E61746976652C207365636F6E6420636F6E646974696F6E20636865636B73206966206974277320616E20606973602D6174747269627574652C20414E440A20202020202020202F2F207468652076616C7565207061737365';
wwv_flow_api.g_varchar2_table(511) := '732077686174657665722074686520757365722068617320636F6E6669677572656420666F7220435553544F4D5F454C454D454E545F48414E444C494E472E7461674E616D65436865636B0A20202020202020206C634E616D65203D3D3D202769732720';
wwv_flow_api.g_varchar2_table(512) := '262620435553544F4D5F454C454D454E545F48414E444C494E472E616C6C6F77437573746F6D697A65644275696C74496E456C656D656E74732026262028435553544F4D5F454C454D454E545F48414E444C494E472E7461674E616D65436865636B2069';
wwv_flow_api.g_varchar2_table(513) := '6E7374616E63656F6620526567457870202626207265674578705465737428435553544F4D5F454C454D454E545F48414E444C494E472E7461674E616D65436865636B2C2076616C756529207C7C20435553544F4D5F454C454D454E545F48414E444C49';
wwv_flow_api.g_varchar2_table(514) := '4E472E7461674E616D65436865636B20696E7374616E63656F662046756E6374696F6E20262620435553544F4D5F454C454D454E545F48414E444C494E472E7461674E616D65436865636B2876616C7565292929203B20656C7365207B0A202020202020';
wwv_flow_api.g_varchar2_table(515) := '2020202072657475726E2066616C73653B0A20202020202020207D0A20202020202020202F2A20436865636B2076616C756520697320736166652E2046697273742C206973206174747220696E6572743F20496620736F2C2069732073616665202A2F0A';
wwv_flow_api.g_varchar2_table(516) := '2020202020207D20656C736520696620285552495F534146455F415454524942555445535B6C634E616D655D29203B20656C73652069662028726567457870546573742849535F414C4C4F5745445F55524924312C20737472696E675265706C61636528';
wwv_flow_api.g_varchar2_table(517) := '76616C75652C20415454525F574849544553504143452C202727292929203B20656C73652069662028286C634E616D65203D3D3D202773726327207C7C206C634E616D65203D3D3D2027786C696E6B3A6872656627207C7C206C634E616D65203D3D3D20';
wwv_flow_api.g_varchar2_table(518) := '27687265662729202626206C6354616720213D3D20277363726970742720262620737472696E67496E6465784F662876616C75652C2027646174613A2729203D3D3D203020262620444154415F5552495F544147535B6C635461675D29203B20656C7365';
wwv_flow_api.g_varchar2_table(519) := '2069662028414C4C4F575F554E4B4E4F574E5F50524F544F434F4C532026262021726567457870546573742849535F5343524950545F4F525F444154412C20737472696E675265706C6163652876616C75652C20415454525F574849544553504143452C';
wwv_flow_api.g_varchar2_table(520) := '202727292929203B20656C7365206966202876616C756529207B0A202020202020202072657475726E2066616C73653B0A2020202020207D20656C7365203B0A20202020202072657475726E20747275653B0A202020207D3B0A202020202F2A2A0A2020';
wwv_flow_api.g_varchar2_table(521) := '2020202A205F69734261736963437573746F6D456C656D656E740A20202020202A20636865636B73206966206174206C65617374206F6E65206461736820697320696E636C7564656420696E207461674E616D652C20616E642069742773206E6F742074';
wwv_flow_api.g_varchar2_table(522) := '686520666972737420636861720A20202020202A20666F72206D6F726520736F706869737469636174656420636865636B696E67207365652068747470733A2F2F6769746875622E636F6D2F73696E647265736F726875732F76616C69646174652D656C';
wwv_flow_api.g_varchar2_table(523) := '656D656E742D6E616D650A20202020202A0A20202020202A2040706172616D207461674E616D65206E616D65206F662074686520746167206F6620746865206E6F646520746F2073616E6974697A650A20202020202A204072657475726E732052657475';
wwv_flow_api.g_varchar2_table(524) := '726E7320747275652069662074686520746167206E616D65206D656574732074686520626173696320637269746572696120666F72206120637573746F6D20656C656D656E742C206F74686572776973652066616C73652E0A20202020202A2F0A202020';
wwv_flow_api.g_varchar2_table(525) := '20636F6E7374205F69734261736963437573746F6D456C656D656E74203D2066756E6374696F6E205F69734261736963437573746F6D456C656D656E74287461674E616D6529207B0A20202020202072657475726E207461674E616D6520213D3D202761';
wwv_flow_api.g_varchar2_table(526) := '6E6E6F746174696F6E2D786D6C2720262620737472696E674D61746368287461674E616D652C20435553544F4D5F454C454D454E54293B0A202020207D3B0A202020202F2A2A0A20202020202A205F73616E6974697A65417474726962757465730A2020';
wwv_flow_api.g_varchar2_table(527) := '2020202A0A20202020202A204070726F7465637420617474726962757465730A20202020202A204070726F74656374206E6F64654E616D650A20202020202A204070726F746563742072656D6F76654174747269627574650A20202020202A204070726F';
wwv_flow_api.g_varchar2_table(528) := '74656374207365744174747269627574650A20202020202A0A20202020202A2040706172616D2063757272656E744E6F646520746F2073616E6974697A650A20202020202A2F0A20202020636F6E7374205F73616E6974697A6541747472696275746573';
wwv_flow_api.g_varchar2_table(529) := '203D2066756E6374696F6E205F73616E6974697A65417474726962757465732863757272656E744E6F646529207B0A2020202020202F2A2045786563757465206120686F6F6B2069662070726573656E74202A2F0A2020202020205F6578656375746548';
wwv_flow_api.g_varchar2_table(530) := '6F6F6B7328686F6F6B732E6265666F726553616E6974697A65417474726962757465732C2063757272656E744E6F64652C206E756C6C293B0A202020202020636F6E7374207B0A2020202020202020617474726962757465730A2020202020207D203D20';
wwv_flow_api.g_varchar2_table(531) := '63757272656E744E6F64653B0A2020202020202F2A20436865636B206966207765206861766520617474726962757465733B206966206E6F74207765206D69676874206861766520612074657874206E6F6465202A2F0A20202020202069662028216174';
wwv_flow_api.g_varchar2_table(532) := '7472696275746573207C7C205F6973436C6F6262657265642863757272656E744E6F64652929207B0A202020202020202072657475726E3B0A2020202020207D0A202020202020636F6E737420686F6F6B4576656E74203D207B0A202020202020202061';
wwv_flow_api.g_varchar2_table(533) := '7474724E616D653A2027272C0A20202020202020206174747256616C75653A2027272C0A20202020202020206B656570417474723A20747275652C0A2020202020202020616C6C6F776564417474726962757465733A20414C4C4F5745445F415454522C';
wwv_flow_api.g_varchar2_table(534) := '0A2020202020202020666F7263654B656570417474723A20756E646566696E65640A2020202020207D3B0A2020202020206C6574206C203D20617474726962757465732E6C656E6774683B0A2020202020202F2A20476F206261636B7761726473206F76';
wwv_flow_api.g_varchar2_table(535) := '657220616C6C20617474726962757465733B20736166656C792072656D6F766520626164206F6E6573202A2F0A2020202020207768696C6520286C2D2D29207B0A2020202020202020636F6E73742061747472203D20617474726962757465735B6C5D3B';
wwv_flow_api.g_varchar2_table(536) := '0A2020202020202020636F6E7374207B0A202020202020202020206E616D652C0A202020202020202020206E616D6573706163655552492C0A2020202020202020202076616C75653A206174747256616C75650A20202020202020207D203D2061747472';
wwv_flow_api.g_varchar2_table(537) := '3B0A2020202020202020636F6E7374206C634E616D65203D207472616E73666F726D4361736546756E63286E616D65293B0A20202020202020206C65742076616C7565203D206E616D65203D3D3D202776616C756527203F206174747256616C7565203A';
wwv_flow_api.g_varchar2_table(538) := '20737472696E675472696D286174747256616C7565293B0A20202020202020202F2A2045786563757465206120686F6F6B2069662070726573656E74202A2F0A2020202020202020686F6F6B4576656E742E617474724E616D65203D206C634E616D653B';
wwv_flow_api.g_varchar2_table(539) := '0A2020202020202020686F6F6B4576656E742E6174747256616C7565203D2076616C75653B0A2020202020202020686F6F6B4576656E742E6B65657041747472203D20747275653B0A2020202020202020686F6F6B4576656E742E666F7263654B656570';
wwv_flow_api.g_varchar2_table(540) := '41747472203D20756E646566696E65643B202F2F20416C6C6F777320646576656C6F7065727320746F20736565207468697320697320612070726F706572747920746865792063616E207365740A20202020202020205F65786563757465486F6F6B7328';
wwv_flow_api.g_varchar2_table(541) := '686F6F6B732E75706F6E53616E6974697A654174747269627574652C2063757272656E744E6F64652C20686F6F6B4576656E74293B0A202020202020202076616C7565203D20686F6F6B4576656E742E6174747256616C75653B0A20202020202020202F';
wwv_flow_api.g_varchar2_table(542) := '2A2046756C6C20444F4D20436C6F62626572696E672070726F74656374696F6E20766961206E616D6573706163652069736F6C6174696F6E2C0A2020202020202020202A2050726566697820696420616E64206E616D6520617474726962757465732077';
wwv_flow_api.g_varchar2_table(543) := '6974682060757365722D636F6E74656E742D600A2020202020202020202A2F0A20202020202020206966202853414E4954495A455F4E414D45445F50524F505320262620286C634E616D65203D3D3D2027696427207C7C206C634E616D65203D3D3D2027';
wwv_flow_api.g_varchar2_table(544) := '6E616D65272929207B0A202020202020202020202F2F2052656D6F76652074686520617474726962757465207769746820746869732076616C75650A202020202020202020205F72656D6F7665417474726962757465286E616D652C2063757272656E74';
wwv_flow_api.g_varchar2_table(545) := '4E6F6465293B0A202020202020202020202F2F20507265666978207468652076616C756520616E64206C617465722072652D63726561746520746865206174747269627574652077697468207468652073616E6974697A65642076616C75650A20202020';
wwv_flow_api.g_varchar2_table(546) := '20202020202076616C7565203D2053414E4954495A455F4E414D45445F50524F50535F505245464958202B2076616C75653B0A20202020202020207D0A20202020202020202F2A20576F726B2061726F756E642061207365637572697479206973737565';
wwv_flow_api.g_varchar2_table(547) := '207769746820636F6D6D656E747320696E736964652061747472696275746573202A2F0A202020202020202069662028534146455F464F525F584D4C2026262072656745787054657374282F28282D2D213F7C5D293E297C3C5C2F287374796C657C7469';
wwv_flow_api.g_varchar2_table(548) := '746C65292F692C2076616C75652929207B0A202020202020202020205F72656D6F7665417474726962757465286E616D652C2063757272656E744E6F6465293B0A20202020202020202020636F6E74696E75653B0A20202020202020207D0A2020202020';
wwv_flow_api.g_varchar2_table(549) := '2020202F2A204469642074686520686F6F6B7320617070726F7665206F6620746865206174747269627574653F202A2F0A202020202020202069662028686F6F6B4576656E742E666F7263654B6565704174747229207B0A20202020202020202020636F';
wwv_flow_api.g_varchar2_table(550) := '6E74696E75653B0A20202020202020207D0A20202020202020202F2A2052656D6F766520617474726962757465202A2F0A20202020202020205F72656D6F7665417474726962757465286E616D652C2063757272656E744E6F6465293B0A202020202020';
wwv_flow_api.g_varchar2_table(551) := '20202F2A204469642074686520686F6F6B7320617070726F7665206F6620746865206174747269627574653F202A2F0A20202020202020206966202821686F6F6B4576656E742E6B6565704174747229207B0A20202020202020202020636F6E74696E75';
wwv_flow_api.g_varchar2_table(552) := '653B0A20202020202020207D0A20202020202020202F2A20576F726B2061726F756E64206120736563757269747920697373756520696E206A517565727920332E30202A2F0A20202020202020206966202821414C4C4F575F53454C465F434C4F53455F';
wwv_flow_api.g_varchar2_table(553) := '494E5F415454522026262072656745787054657374282F5C2F3E2F692C2076616C75652929207B0A202020202020202020205F72656D6F7665417474726962757465286E616D652C2063757272656E744E6F6465293B0A20202020202020202020636F6E';
wwv_flow_api.g_varchar2_table(554) := '74696E75653B0A20202020202020207D0A20202020202020202F2A2053616E6974697A652061747472696275746520636F6E74656E7420746F2062652074656D706C6174652D73616665202A2F0A202020202020202069662028534146455F464F525F54';
wwv_flow_api.g_varchar2_table(555) := '454D504C4154455329207B0A202020202020202020206172726179466F7245616368285B4D555354414348455F455850522C204552425F455850522C20544D504C49545F455850525D2C2065787072203D3E207B0A20202020202020202020202076616C';
wwv_flow_api.g_varchar2_table(556) := '7565203D20737472696E675265706C6163652876616C75652C20657870722C20272027293B0A202020202020202020207D293B0A20202020202020207D0A20202020202020202F2A204973206076616C7565602076616C696420666F7220746869732061';
wwv_flow_api.g_varchar2_table(557) := '74747269627574653F202A2F0A2020202020202020636F6E7374206C63546167203D207472616E73666F726D4361736546756E632863757272656E744E6F64652E6E6F64654E616D65293B0A202020202020202069662028215F697356616C6964417474';
wwv_flow_api.g_varchar2_table(558) := '726962757465286C635461672C206C634E616D652C2076616C75652929207B0A20202020202020202020636F6E74696E75653B0A20202020202020207D0A20202020202020202F2A2048616E646C65206174747269627574657320746861742072657175';
wwv_flow_api.g_varchar2_table(559) := '6972652054727573746564205479706573202A2F0A202020202020202069662028747275737465645479706573506F6C69637920262620747970656F6620747275737465645479706573203D3D3D20276F626A6563742720262620747970656F66207472';
wwv_flow_api.g_varchar2_table(560) := '757374656454797065732E67657441747472696275746554797065203D3D3D202766756E6374696F6E2729207B0A20202020202020202020696620286E616D65737061636555524929203B20656C7365207B0A2020202020202020202020207377697463';
wwv_flow_api.g_varchar2_table(561) := '6820287472757374656454797065732E67657441747472696275746554797065286C635461672C206C634E616D652929207B0A20202020202020202020202020206361736520275472757374656448544D4C273A0A202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(562) := '207B0A20202020202020202020202020202020202076616C7565203D20747275737465645479706573506F6C6963792E63726561746548544D4C2876616C7565293B0A202020202020202020202020202020202020627265616B3B0A2020202020202020';
wwv_flow_api.g_varchar2_table(563) := '20202020202020207D0A20202020202020202020202020206361736520275472757374656453637269707455524C273A0A202020202020202020202020202020207B0A20202020202020202020202020202020202076616C7565203D2074727573746564';
wwv_flow_api.g_varchar2_table(564) := '5479706573506F6C6963792E63726561746553637269707455524C2876616C7565293B0A202020202020202020202020202020202020627265616B3B0A202020202020202020202020202020207D0A2020202020202020202020207D0A20202020202020';
wwv_flow_api.g_varchar2_table(565) := '2020207D0A20202020202020207D0A20202020202020202F2A2048616E646C6520696E76616C696420646174612D2A2061747472696275746520736574206279207472792D6361746368696E67206974202A2F0A2020202020202020747279207B0A2020';
wwv_flow_api.g_varchar2_table(566) := '2020202020202020696620286E616D65737061636555524929207B0A20202020202020202020202063757272656E744E6F64652E7365744174747269627574654E53286E616D6573706163655552492C206E616D652C2076616C7565293B0A2020202020';
wwv_flow_api.g_varchar2_table(567) := '20202020207D20656C7365207B0A2020202020202020202020202F2A2046616C6C6261636B20746F20736574417474726962757465282920666F722062726F777365722D756E7265636F676E697A6564206E616D6573706163657320652E672E2022782D';
wwv_flow_api.g_varchar2_table(568) := '736368656D61222E202A2F0A20202020202020202020202063757272656E744E6F64652E736574417474726962757465286E616D652C2076616C7565293B0A202020202020202020207D0A20202020202020202020696620285F6973436C6F6262657265';
wwv_flow_api.g_varchar2_table(569) := '642863757272656E744E6F64652929207B0A2020202020202020202020205F666F72636552656D6F76652863757272656E744E6F6465293B0A202020202020202020207D20656C7365207B0A2020202020202020202020206172726179506F7028444F4D';
wwv_flow_api.g_varchar2_table(570) := '5075726966792E72656D6F766564293B0A202020202020202020207D0A20202020202020207D20636174636820285F29207B7D0A2020202020207D0A2020202020202F2A2045786563757465206120686F6F6B2069662070726573656E74202A2F0A2020';
wwv_flow_api.g_varchar2_table(571) := '202020205F65786563757465486F6F6B7328686F6F6B732E616674657253616E6974697A65417474726962757465732C2063757272656E744E6F64652C206E756C6C293B0A202020207D3B0A202020202F2A2A0A20202020202A205F73616E6974697A65';
wwv_flow_api.g_varchar2_table(572) := '536861646F77444F4D0A20202020202A0A20202020202A2040706172616D20667261676D656E7420746F2069746572617465206F766572207265637572736976656C790A20202020202A2F0A20202020636F6E7374205F73616E6974697A65536861646F';
wwv_flow_api.g_varchar2_table(573) := '77444F4D203D2066756E6374696F6E205F73616E6974697A65536861646F77444F4D28667261676D656E7429207B0A2020202020206C657420736861646F774E6F6465203D206E756C6C3B0A202020202020636F6E737420736861646F77497465726174';
wwv_flow_api.g_varchar2_table(574) := '6F72203D205F6372656174654E6F64654974657261746F7228667261676D656E74293B0A2020202020202F2A2045786563757465206120686F6F6B2069662070726573656E74202A2F0A2020202020205F65786563757465486F6F6B7328686F6F6B732E';
wwv_flow_api.g_varchar2_table(575) := '6265666F726553616E6974697A65536861646F77444F4D2C20667261676D656E742C206E756C6C293B0A2020202020207768696C652028736861646F774E6F6465203D20736861646F774974657261746F722E6E6578744E6F6465282929207B0A202020';
wwv_flow_api.g_varchar2_table(576) := '20202020202F2A2045786563757465206120686F6F6B2069662070726573656E74202A2F0A20202020202020205F65786563757465486F6F6B7328686F6F6B732E75706F6E53616E6974697A65536861646F774E6F64652C20736861646F774E6F64652C';
wwv_flow_api.g_varchar2_table(577) := '206E756C6C293B0A20202020202020202F2A2053616E6974697A65207461677320616E6420656C656D656E7473202A2F0A20202020202020205F73616E6974697A65456C656D656E747328736861646F774E6F6465293B0A20202020202020202F2A2043';
wwv_flow_api.g_varchar2_table(578) := '6865636B2061747472696275746573206E657874202A2F0A20202020202020205F73616E6974697A654174747269627574657328736861646F774E6F6465293B0A20202020202020202F2A204465657020736861646F7720444F4D206465746563746564';
wwv_flow_api.g_varchar2_table(579) := '202A2F0A202020202020202069662028736861646F774E6F64652E636F6E74656E7420696E7374616E63656F6620446F63756D656E74467261676D656E7429207B0A202020202020202020205F73616E6974697A65536861646F77444F4D28736861646F';
wwv_flow_api.g_varchar2_table(580) := '774E6F64652E636F6E74656E74293B0A20202020202020207D0A2020202020207D0A2020202020202F2A2045786563757465206120686F6F6B2069662070726573656E74202A2F0A2020202020205F65786563757465486F6F6B7328686F6F6B732E6166';
wwv_flow_api.g_varchar2_table(581) := '74657253616E6974697A65536861646F77444F4D2C20667261676D656E742C206E756C6C293B0A202020207D3B0A202020202F2F2065736C696E742D64697361626C652D6E6578742D6C696E6520636F6D706C65786974790A20202020444F4D50757269';
wwv_flow_api.g_varchar2_table(582) := '66792E73616E6974697A65203D2066756E6374696F6E2028646972747929207B0A2020202020206C657420636667203D20617267756D656E74732E6C656E677468203E203120262620617267756D656E74735B315D20213D3D20756E646566696E656420';
wwv_flow_api.g_varchar2_table(583) := '3F20617267756D656E74735B315D203A207B7D3B0A2020202020206C657420626F6479203D206E756C6C3B0A2020202020206C657420696D706F727465644E6F6465203D206E756C6C3B0A2020202020206C65742063757272656E744E6F6465203D206E';
wwv_flow_api.g_varchar2_table(584) := '756C6C3B0A2020202020206C65742072657475726E4E6F6465203D206E756C6C3B0A2020202020202F2A204D616B6520737572652077652068617665206120737472696E6720746F2073616E6974697A652E0A2020202020202020444F204E4F54207265';
wwv_flow_api.g_varchar2_table(585) := '7475726E206561726C792C20617320746869732077696C6C2072657475726E207468652077726F6E6720747970652069660A202020202020202074686520757365722068617320726571756573746564206120444F4D206F626A65637420726174686572';
wwv_flow_api.g_varchar2_table(586) := '207468616E206120737472696E67202A2F0A20202020202049535F454D5054595F494E505554203D202164697274793B0A2020202020206966202849535F454D5054595F494E50555429207B0A20202020202020206469727479203D20273C212D2D3E27';
wwv_flow_api.g_varchar2_table(587) := '3B0A2020202020207D0A2020202020202F2A20537472696E676966792C20696E206361736520646972747920697320616E206F626A656374202A2F0A20202020202069662028747970656F6620646972747920213D3D2027737472696E67272026262021';
wwv_flow_api.g_varchar2_table(588) := '5F69734E6F64652864697274792929207B0A202020202020202069662028747970656F662064697274792E746F537472696E67203D3D3D202766756E6374696F6E2729207B0A202020202020202020206469727479203D2064697274792E746F53747269';
wwv_flow_api.g_varchar2_table(589) := '6E6728293B0A2020202020202020202069662028747970656F6620646972747920213D3D2027737472696E672729207B0A2020202020202020202020207468726F7720747970654572726F7243726561746528276469727479206973206E6F7420612073';
wwv_flow_api.g_varchar2_table(590) := '7472696E672C2061626F7274696E6727293B0A202020202020202020207D0A20202020202020207D20656C7365207B0A202020202020202020207468726F7720747970654572726F724372656174652827746F537472696E67206973206E6F7420612066';
wwv_flow_api.g_varchar2_table(591) := '756E6374696F6E27293B0A20202020202020207D0A2020202020207D0A2020202020202F2A2052657475726E2064697274792048544D4C20696620444F4D5075726966792063616E6E6F742072756E202A2F0A2020202020206966202821444F4D507572';
wwv_flow_api.g_varchar2_table(592) := '6966792E6973537570706F7274656429207B0A202020202020202072657475726E2064697274793B0A2020202020207D0A2020202020202F2A2041737369676E20636F6E6669672076617273202A2F0A20202020202069662028215345545F434F4E4649';
wwv_flow_api.g_varchar2_table(593) := '4729207B0A20202020202020205F7061727365436F6E66696728636667293B0A2020202020207D0A2020202020202F2A20436C65616E2075702072656D6F76656420656C656D656E7473202A2F0A202020202020444F4D5075726966792E72656D6F7665';
wwv_flow_api.g_varchar2_table(594) := '64203D205B5D3B0A2020202020202F2A20436865636B20696620646972747920697320636F72726563746C7920747970656420666F7220494E5F504C414345202A2F0A20202020202069662028747970656F66206469727479203D3D3D2027737472696E';
wwv_flow_api.g_varchar2_table(595) := '672729207B0A2020202020202020494E5F504C414345203D2066616C73653B0A2020202020207D0A20202020202069662028494E5F504C41434529207B0A20202020202020202F2A20446F20736F6D65206561726C79207072652D73616E6974697A6174';
wwv_flow_api.g_varchar2_table(596) := '696F6E20746F2061766F696420756E7361666520726F6F74206E6F646573202A2F0A20202020202020206966202864697274792E6E6F64654E616D6529207B0A20202020202020202020636F6E7374207461674E616D65203D207472616E73666F726D43';
wwv_flow_api.g_varchar2_table(597) := '61736546756E632864697274792E6E6F64654E616D65293B0A202020202020202020206966202821414C4C4F5745445F544147535B7461674E616D655D207C7C20464F524249445F544147535B7461674E616D655D29207B0A2020202020202020202020';
wwv_flow_api.g_varchar2_table(598) := '207468726F7720747970654572726F724372656174652827726F6F74206E6F646520697320666F7262696464656E20616E642063616E6E6F742062652073616E6974697A656420696E2D706C61636527293B0A202020202020202020207D0A2020202020';
wwv_flow_api.g_varchar2_table(599) := '2020207D0A2020202020207D20656C73652069662028646972747920696E7374616E63656F66204E6F646529207B0A20202020202020202F2A204966206469727479206973206120444F4D20656C656D656E742C20617070656E6420746F20616E20656D';
wwv_flow_api.g_varchar2_table(600) := '70747920646F63756D656E7420746F2061766F69640A2020202020202020202020656C656D656E7473206265696E672073747269707065642062792074686520706172736572202A2F0A2020202020202020626F6479203D205F696E6974446F63756D65';
wwv_flow_api.g_varchar2_table(601) := '6E7428273C212D2D2D2D3E27293B0A2020202020202020696D706F727465644E6F6465203D20626F64792E6F776E6572446F63756D656E742E696D706F72744E6F64652864697274792C2074727565293B0A202020202020202069662028696D706F7274';
wwv_flow_api.g_varchar2_table(602) := '65644E6F64652E6E6F646554797065203D3D3D204E4F44455F545950452E656C656D656E7420262620696D706F727465644E6F64652E6E6F64654E616D65203D3D3D2027424F44592729207B0A202020202020202020202F2A204E6F646520697320616C';
wwv_flow_api.g_varchar2_table(603) := '7265616479206120626F64792C20757365206173206973202A2F0A20202020202020202020626F6479203D20696D706F727465644E6F64653B0A20202020202020207D20656C73652069662028696D706F727465644E6F64652E6E6F64654E616D65203D';
wwv_flow_api.g_varchar2_table(604) := '3D3D202748544D4C2729207B0A20202020202020202020626F6479203D20696D706F727465644E6F64653B0A20202020202020207D20656C7365207B0A202020202020202020202F2F2065736C696E742D64697361626C652D6E6578742D6C696E652075';
wwv_flow_api.g_varchar2_table(605) := '6E69636F726E2F7072656665722D646F6D2D6E6F64652D617070656E640A20202020202020202020626F64792E617070656E644368696C6428696D706F727465644E6F6465293B0A20202020202020207D0A2020202020207D20656C7365207B0A202020';
wwv_flow_api.g_varchar2_table(606) := '20202020202F2A2045786974206469726563746C792069662077652068617665206E6F7468696E6720746F20646F202A2F0A2020202020202020696620282152455455524E5F444F4D2026262021534146455F464F525F54454D504C4154455320262620';
wwv_flow_api.g_varchar2_table(607) := '2157484F4C455F444F43554D454E542026260A20202020202020202F2F2065736C696E742D64697361626C652D6E6578742D6C696E6520756E69636F726E2F7072656665722D696E636C756465730A202020202020202064697274792E696E6465784F66';
wwv_flow_api.g_varchar2_table(608) := '28273C2729203D3D3D202D3129207B0A2020202020202020202072657475726E20747275737465645479706573506F6C6963792026262052455455524E5F545255535445445F54595045203F20747275737465645479706573506F6C6963792E63726561';
wwv_flow_api.g_varchar2_table(609) := '746548544D4C28646972747929203A2064697274793B0A20202020202020207D0A20202020202020202F2A20496E697469616C697A652074686520646F63756D656E7420746F20776F726B206F6E202A2F0A2020202020202020626F6479203D205F696E';
wwv_flow_api.g_varchar2_table(610) := '6974446F63756D656E74286469727479293B0A20202020202020202F2A20436865636B2077652068617665206120444F4D206E6F64652066726F6D207468652064617461202A2F0A20202020202020206966202821626F647929207B0A20202020202020';
wwv_flow_api.g_varchar2_table(611) := '20202072657475726E2052455455524E5F444F4D203F206E756C6C203A2052455455524E5F545255535445445F54595045203F20656D70747948544D4C203A2027273B0A20202020202020207D0A2020202020207D0A2020202020202F2A2052656D6F76';
wwv_flow_api.g_varchar2_table(612) := '6520666972737420656C656D656E74206E6F646520286F7572732920696620464F5243455F424F445920697320736574202A2F0A20202020202069662028626F647920262620464F5243455F424F445929207B0A20202020202020205F666F7263655265';
wwv_flow_api.g_varchar2_table(613) := '6D6F766528626F64792E66697273744368696C64293B0A2020202020207D0A2020202020202F2A20476574206E6F6465206974657261746F72202A2F0A202020202020636F6E7374206E6F64654974657261746F72203D205F6372656174654E6F646549';
wwv_flow_api.g_varchar2_table(614) := '74657261746F7228494E5F504C414345203F206469727479203A20626F6479293B0A2020202020202F2A204E6F7720737461727420697465726174696E67206F76657220746865206372656174656420646F63756D656E74202A2F0A2020202020207768';
wwv_flow_api.g_varchar2_table(615) := '696C65202863757272656E744E6F6465203D206E6F64654974657261746F722E6E6578744E6F6465282929207B0A20202020202020202F2A2053616E6974697A65207461677320616E6420656C656D656E7473202A2F0A20202020202020205F73616E69';
wwv_flow_api.g_varchar2_table(616) := '74697A65456C656D656E74732863757272656E744E6F6465293B0A20202020202020202F2A20436865636B2061747472696275746573206E657874202A2F0A20202020202020205F73616E6974697A65417474726962757465732863757272656E744E6F';
wwv_flow_api.g_varchar2_table(617) := '6465293B0A20202020202020202F2A20536861646F7720444F4D2064657465637465642C2073616E6974697A65206974202A2F0A20202020202020206966202863757272656E744E6F64652E636F6E74656E7420696E7374616E63656F6620446F63756D';
wwv_flow_api.g_varchar2_table(618) := '656E74467261676D656E7429207B0A202020202020202020205F73616E6974697A65536861646F77444F4D2863757272656E744E6F64652E636F6E74656E74293B0A20202020202020207D0A2020202020207D0A2020202020202F2A2049662077652073';
wwv_flow_api.g_varchar2_table(619) := '616E6974697A6564206064697274796020696E2D706C6163652C2072657475726E2069742E202A2F0A20202020202069662028494E5F504C41434529207B0A202020202020202072657475726E2064697274793B0A2020202020207D0A2020202020202F';
wwv_flow_api.g_varchar2_table(620) := '2A2052657475726E2073616E6974697A656420737472696E67206F7220444F4D202A2F0A2020202020206966202852455455524E5F444F4D29207B0A20202020202020206966202852455455524E5F444F4D5F465241474D454E5429207B0A2020202020';
wwv_flow_api.g_varchar2_table(621) := '202020202072657475726E4E6F6465203D20637265617465446F63756D656E74467261676D656E742E63616C6C28626F64792E6F776E6572446F63756D656E74293B0A202020202020202020207768696C652028626F64792E66697273744368696C6429';
wwv_flow_api.g_varchar2_table(622) := '207B0A2020202020202020202020202F2F2065736C696E742D64697361626C652D6E6578742D6C696E6520756E69636F726E2F7072656665722D646F6D2D6E6F64652D617070656E640A20202020202020202020202072657475726E4E6F64652E617070';
wwv_flow_api.g_varchar2_table(623) := '656E644368696C6428626F64792E66697273744368696C64293B0A202020202020202020207D0A20202020202020207D20656C7365207B0A2020202020202020202072657475726E4E6F6465203D20626F64793B0A20202020202020207D0A2020202020';
wwv_flow_api.g_varchar2_table(624) := '20202069662028414C4C4F5745445F415454522E736861646F77726F6F74207C7C20414C4C4F5745445F415454522E736861646F77726F6F746D6F646529207B0A202020202020202020202F2A0A20202020202020202020202041646F70744E6F646528';
wwv_flow_api.g_varchar2_table(625) := '29206973206E6F742075736564206265636175736520696E7465726E616C207374617465206973206E6F742072657365740A20202020202020202020202028652E672E207468652070617374206E616D6573206D6170206F6620612048544D4C466F726D';
wwv_flow_api.g_varchar2_table(626) := '456C656D656E74292C207468697320697320736166650A202020202020202020202020696E207468656F72792062757420776520776F756C6420726174686572206E6F74207269736B20616E6F746865722061747461636B20766563746F722E0A202020';
wwv_flow_api.g_varchar2_table(627) := '202020202020202020546865207374617465207468617420697320636C6F6E656420627920696D706F72744E6F64652829206973206578706C696369746C7920646566696E65640A2020202020202020202020206279207468652073706563732E0A2020';
wwv_flow_api.g_varchar2_table(628) := '20202020202020202A2F0A2020202020202020202072657475726E4E6F6465203D20696D706F72744E6F64652E63616C6C286F726967696E616C446F63756D656E742C2072657475726E4E6F64652C2074727565293B0A20202020202020207D0A202020';
wwv_flow_api.g_varchar2_table(629) := '202020202072657475726E2072657475726E4E6F64653B0A2020202020207D0A2020202020206C65742073657269616C697A656448544D4C203D2057484F4C455F444F43554D454E54203F20626F64792E6F7574657248544D4C203A20626F64792E696E';
wwv_flow_api.g_varchar2_table(630) := '6E657248544D4C3B0A2020202020202F2A2053657269616C697A6520646F637479706520696620616C6C6F776564202A2F0A2020202020206966202857484F4C455F444F43554D454E5420262620414C4C4F5745445F544147535B2721646F6374797065';
wwv_flow_api.g_varchar2_table(631) := '275D20262620626F64792E6F776E6572446F63756D656E7420262620626F64792E6F776E6572446F63756D656E742E646F637479706520262620626F64792E6F776E6572446F63756D656E742E646F63747970652E6E616D652026262072656745787054';
wwv_flow_api.g_varchar2_table(632) := '65737428444F43545950455F4E414D452C20626F64792E6F776E6572446F63756D656E742E646F63747970652E6E616D652929207B0A202020202020202073657269616C697A656448544D4C203D20273C21444F43545950452027202B20626F64792E6F';
wwv_flow_api.g_varchar2_table(633) := '776E6572446F63756D656E742E646F63747970652E6E616D65202B20273E5C6E27202B2073657269616C697A656448544D4C3B0A2020202020207D0A2020202020202F2A2053616E6974697A652066696E616C20737472696E672074656D706C6174652D';
wwv_flow_api.g_varchar2_table(634) := '73616665202A2F0A20202020202069662028534146455F464F525F54454D504C4154455329207B0A20202020202020206172726179466F7245616368285B4D555354414348455F455850522C204552425F455850522C20544D504C49545F455850525D2C';
wwv_flow_api.g_varchar2_table(635) := '2065787072203D3E207B0A2020202020202020202073657269616C697A656448544D4C203D20737472696E675265706C6163652873657269616C697A656448544D4C2C20657870722C20272027293B0A20202020202020207D293B0A2020202020207D0A';
wwv_flow_api.g_varchar2_table(636) := '20202020202072657475726E20747275737465645479706573506F6C6963792026262052455455524E5F545255535445445F54595045203F20747275737465645479706573506F6C6963792E63726561746548544D4C2873657269616C697A656448544D';
wwv_flow_api.g_varchar2_table(637) := '4C29203A2073657269616C697A656448544D4C3B0A202020207D3B0A20202020444F4D5075726966792E736574436F6E666967203D2066756E6374696F6E202829207B0A2020202020206C657420636667203D20617267756D656E74732E6C656E677468';
wwv_flow_api.g_varchar2_table(638) := '203E203020262620617267756D656E74735B305D20213D3D20756E646566696E6564203F20617267756D656E74735B305D203A207B7D3B0A2020202020205F7061727365436F6E66696728636667293B0A2020202020205345545F434F4E464947203D20';
wwv_flow_api.g_varchar2_table(639) := '747275653B0A202020207D3B0A20202020444F4D5075726966792E636C656172436F6E666967203D2066756E6374696F6E202829207B0A202020202020434F4E464947203D206E756C6C3B0A2020202020205345545F434F4E464947203D2066616C7365';
wwv_flow_api.g_varchar2_table(640) := '3B0A202020207D3B0A20202020444F4D5075726966792E697356616C6964417474726962757465203D2066756E6374696F6E20287461672C20617474722C2076616C756529207B0A2020202020202F2A20496E697469616C697A65207368617265642063';
wwv_flow_api.g_varchar2_table(641) := '6F6E6669672076617273206966206E65636573736172792E202A2F0A2020202020206966202821434F4E46494729207B0A20202020202020205F7061727365436F6E666967287B7D293B0A2020202020207D0A202020202020636F6E7374206C63546167';
wwv_flow_api.g_varchar2_table(642) := '203D207472616E73666F726D4361736546756E6328746167293B0A202020202020636F6E7374206C634E616D65203D207472616E73666F726D4361736546756E632861747472293B0A20202020202072657475726E205F697356616C6964417474726962';
wwv_flow_api.g_varchar2_table(643) := '757465286C635461672C206C634E616D652C2076616C7565293B0A202020207D3B0A20202020444F4D5075726966792E616464486F6F6B203D2066756E6374696F6E2028656E747279506F696E742C20686F6F6B46756E6374696F6E29207B0A20202020';
wwv_flow_api.g_varchar2_table(644) := '202069662028747970656F6620686F6F6B46756E6374696F6E20213D3D202766756E6374696F6E2729207B0A202020202020202072657475726E3B0A2020202020207D0A20202020202061727261795075736828686F6F6B735B656E747279506F696E74';
wwv_flow_api.g_varchar2_table(645) := '5D2C20686F6F6B46756E6374696F6E293B0A202020207D3B0A20202020444F4D5075726966792E72656D6F7665486F6F6B203D2066756E6374696F6E2028656E747279506F696E742C20686F6F6B46756E6374696F6E29207B0A20202020202069662028';
wwv_flow_api.g_varchar2_table(646) := '686F6F6B46756E6374696F6E20213D3D20756E646566696E656429207B0A2020202020202020636F6E737420696E646578203D2061727261794C617374496E6465784F6628686F6F6B735B656E747279506F696E745D2C20686F6F6B46756E6374696F6E';
wwv_flow_api.g_varchar2_table(647) := '293B0A202020202020202072657475726E20696E646578203D3D3D202D31203F20756E646566696E6564203A20617272617953706C69636528686F6F6B735B656E747279506F696E745D2C20696E6465782C2031295B305D3B0A2020202020207D0A2020';
wwv_flow_api.g_varchar2_table(648) := '2020202072657475726E206172726179506F7028686F6F6B735B656E747279506F696E745D293B0A202020207D3B0A20202020444F4D5075726966792E72656D6F7665486F6F6B73203D2066756E6374696F6E2028656E747279506F696E7429207B0A20';
wwv_flow_api.g_varchar2_table(649) := '2020202020686F6F6B735B656E747279506F696E745D203D205B5D3B0A202020207D3B0A20202020444F4D5075726966792E72656D6F7665416C6C486F6F6B73203D2066756E6374696F6E202829207B0A202020202020686F6F6B73203D205F63726561';
wwv_flow_api.g_varchar2_table(650) := '7465486F6F6B734D617028293B0A202020207D3B0A2020202072657475726E20444F4D5075726966793B0A20207D0A202076617220707572696679203D20637265617465444F4D50757269667928293B0A0A202072657475726E207075726966793B0A0A';
wwv_flow_api.g_varchar2_table(651) := '7D29293B0A2F2F2320736F757263654D617070696E6755524C3D7075726966792E6A732E6D61700A';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(79120426419201356)
,p_plugin_id=>wwv_flow_api.id(138285470529447569213)
,p_file_name=>'purify.js'
,p_mime_type=>'text/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2E746F67676C654E6F74696669636174696F6E73207B0A202020206D617267696E2D72696768743A203870783B0A20202020706F736974696F6E3A2072656C61746976653B0A20202020646973706C61793A202D7765626B69742D696E6C696E652D626F';
wwv_flow_api.g_varchar2_table(2) := '783B0A20202020646973706C61793A202D6D732D696E6C696E652D666C6578626F783B0A20202020646973706C61793A20696E6C696E652D666C65783B0A20202020666C6F61743A2072696768743B0A202020206865696768743A20323870783B0A2020';
wwv_flow_api.g_varchar2_table(3) := '202077696474683A20323870783B0A202020202D7765626B69742D757365722D73656C6563743A206E6F6E653B0A202020202D6D6F7A2D757365722D73656C6563743A206E6F6E653B0A202020202D6D732D757365722D73656C6563743A206E6F6E653B';
wwv_flow_api.g_varchar2_table(4) := '0A20202020757365722D73656C6563743A206E6F6E653B0A20202020637572736F723A20706F696E7465723B0A7D0A0A2E746F67676C654E6F74696669636174696F6E73202E73686F77207B0A202020202D7765626B69742D626F782D666C65783A2031';
wwv_flow_api.g_varchar2_table(5) := '3B0A202020202D6D732D666C65783A20313B0A20202020666C65783A20313B0A202020206D617267696E3A206175746F3B0A202020206865696768743A20323870783B0A202020206D61782D77696474683A20323870783B0A20202020746578742D616C';
wwv_flow_api.g_varchar2_table(6) := '69676E3A2063656E7465723B0A20202020626F726465722D7261646975733A203530253B0A202020206261636B67726F756E643A207267626128302C20302C20302C20302E35293B0A20202020666F6E742D73697A653A20323870783B0A202020202D77';
wwv_flow_api.g_varchar2_table(7) := '65626B69742D7472616E736974696F6E3A20616C6C2031733B0A202020207472616E736974696F6E3A20616C6C2031733B0A20202020637572736F723A20706F696E7465723B0A7D0A0A2E746F67676C654E6F74696669636174696F6E73202E73686F77';
wwv_flow_api.g_varchar2_table(8) := '3A686F766572207B0A202020206261636B67726F756E643A20626C61636B3B0A7D0A0A2E746F67676C654E6F74696669636174696F6E73202E73686F772069207B0A202020206C696E652D6865696768743A20323870783B0A20202020636F6C6F723A20';
wwv_flow_api.g_varchar2_table(9) := '77686974653B0A7D0A0A2E746F67676C654E6F74696669636174696F6E73202E636F756E74207B0A20202020706F736974696F6E3A206162736F6C7574653B0A20202020746F703A202D3270783B0A2020202072696768743A203770783B0A2020202063';
wwv_flow_api.g_varchar2_table(10) := '7572736F723A20706F696E7465723B0A7D0A0A2E746F67676C654E6F74696669636174696F6E73202E636F756E74202E6E756D207B0A20202020706F736974696F6E3A206162736F6C7574653B0A20202020746F703A203070783B0A202020206C656674';
wwv_flow_api.g_varchar2_table(11) := '3A203070783B0A202020206261636B67726F756E643A20236632323B0A20202020626F726465722D7261646975733A203530253B0A2020202077696474683A20313870783B0A202020206865696768743A20313870783B0A20202020746578742D616C69';
wwv_flow_api.g_varchar2_table(12) := '676E3A2063656E7465723B0A202020206C696E652D6865696768743A20313470783B0A20202020666F6E742D73697A653A20313170783B0A202020202D7765626B69742D626F782D736861646F773A203070782031707820337078207267626128302C20';
wwv_flow_api.g_varchar2_table(13) := '302C20302C20302E3235293B0A20202020626F782D736861646F773A203070782031707820337078207267626128302C20302C20302C20302E3235293B0A20202020626F726465723A2031707820736F6C696420726762612837302C2037302C2037302C';
wwv_flow_api.g_varchar2_table(14) := '20302E32293B0A202020202D7765626B69742D7472616E736974696F6E3A20616C6C20302E33733B0A202020207472616E736974696F6E3A20616C6C20302E33733B0A20202020636F6C6F723A2077686974653B0A7D0A0A2E6E6F74696669636174696F';
wwv_flow_api.g_varchar2_table(15) := '6E73207B0A20202020706F736974696F6E3A2066697865643B0A202020202F2A2050756C6C2066726F6D2068747470733A2F2F6769746875622E636F6D2F616C6C69706965727265202A2F0A20202020746F703A20343270783B0A202020207269676874';
wwv_flow_api.g_varchar2_table(16) := '3A20313070783B0A2020202077696474683A2034303070783B0A202020206261636B67726F756E643A2072676261283235302C203235302C203235302C2031293B0A20202020626F726465722D7261646975733A203270783B0A202020202D7765626B69';
wwv_flow_api.g_varchar2_table(17) := '742D626F782D736861646F773A203070782033707820367078207267626128302C20302C20302C20302E35293B0A20202020626F782D736861646F773A203070782033707820367078207267626128302C20302C20302C20302E35293B0A202020207A2D';
wwv_flow_api.g_varchar2_table(18) := '696E6465783A20393939393B0A202020206D61782D6865696768743A20373576683B0A202020206F766572666C6F773A206175746F3B0A7D0A0A406D65646961206F6E6C792073637265656E20616E6420286D61782D77696474683A2036383070782920';
wwv_flow_api.g_varchar2_table(19) := '7B0A202020202E6E6F74696669636174696F6E73207B0A202020202020202077696474683A20383576773B0A20202020202020206D61782D77696474683A2034303070783B0A202020207D0A7D0A0A2E6E6F74696669636174696F6E73202E6E6F746520';
wwv_flow_api.g_varchar2_table(20) := '7B0A202020206D617267696E3A2030203570783B0A20202020626F726465722D626F74746F6D3A2031707820736F6C696420726762283233302C203233302C20323330293B0A202020206C696E652D6865696768743A20313070783B0A202020206F7665';
wwv_flow_api.g_varchar2_table(21) := '72666C6F773A2068696464656E3B0A20202020636F6C6F723A207267622837302C2037302C203730293B0A2020202070616464696E672D6C6566743A203570783B0A20202020706F736974696F6E3A2072656C61746976653B0A7D0A0A2E6E6F74696669';
wwv_flow_api.g_varchar2_table(22) := '636174696F6E73202E6E6F7465202E6163636570742D612C0A2E6E6F74696669636174696F6E73202E6E6F7465202E6465636C696E652D61207B0A20202020706F736974696F6E3A206162736F6C7574653B0A20202020626F74746F6D3A20313070783B';
wwv_flow_api.g_varchar2_table(23) := '0A2020202072696768743A203570783B0A7D0A0A2E6E6F74696669636174696F6E73202E6E6F7465202E6E6F74652D696E666F207B0A20202020646973706C61793A20626C6F636B3B0A2020202070616464696E673A2030203330707820323070782034';
wwv_flow_api.g_varchar2_table(24) := '3070783B0A202020206F766572666C6F772D777261703A20627265616B2D776F72643B0A20202020776F72642D777261703A20627265616B2D776F72643B0A202020202D6D732D68797068656E733A206175746F3B0A202020202D6D6F7A2D6879706865';
wwv_flow_api.g_varchar2_table(25) := '6E733A206175746F3B0A202020202D7765626B69742D68797068656E733A206175746F3B0A2020202068797068656E733A206175746F3B0A2020202077696474683A20313030253B0A202020206C696E652D6865696768743A20323070783B0A7D0A0A40';
wwv_flow_api.g_varchar2_table(26) := '6B65796672616D65732066612D626C696E6B207B0A202020203025207B0A20202020202020206F7061636974793A20313B0A202020207D0A0A20202020353025207B0A20202020202020206F7061636974793A20303B0A202020207D0A0A202020203130';
wwv_flow_api.g_varchar2_table(27) := '3025207B0A20202020202020206F7061636974793A20313B0A202020207D0A7D0A0A2E66612D626C696E6B207B0A202020202D7765626B69742D616E696D6174696F6E3A2066612D626C696E6B203273206C696E65617220696E66696E6974653B0A2020';
wwv_flow_api.g_varchar2_table(28) := '20202D6D6F7A2D616E696D6174696F6E3A2066612D626C696E6B203273206C696E65617220696E66696E6974653B0A202020202D6D732D616E696D6174696F6E3A2066612D626C696E6B203273206C696E65617220696E66696E6974653B0A202020202D';
wwv_flow_api.g_varchar2_table(29) := '6F2D616E696D6174696F6E3A2066612D626C696E6B203273206C696E65617220696E66696E6974653B0A20202020616E696D6174696F6E3A2066612D626C696E6B203273206C696E65617220696E66696E6974653B0A7D0A0A2E6E6F7469666963617469';
wwv_flow_api.g_varchar2_table(30) := '6F6E732061207B0A20202020746578742D6465636F726174696F6E3A206E6F6E650A7D0A0A2E6E6F74696669636174696F6E73202E6E6F7465202E6E6F74652D686561646572207B0A20202020666F6E742D7765696768743A20626F6C643B0A20202020';
wwv_flow_api.g_varchar2_table(31) := '746578742D6F766572666C6F773A20656C6C69707369733B0A202020206F766572666C6F773A2068696464656E3B0A2020202077686974652D73706163653A206E6F777261703B0A2020202077696474683A20313030253B0A2020202070616464696E67';
wwv_flow_api.g_varchar2_table(32) := '2D72696768743A20313070783B0A202020206C696E652D6865696768743A20343070783B0A7D0A0A2E6E6F74696669636174696F6E73202E6E6F74653A66697273742D6F662D74797065207B0A202020206D617267696E2D746F703A203070783B0A7D0A';
wwv_flow_api.g_varchar2_table(33) := '0A2E6E6F74696669636174696F6E73202E6E6F74653A686F766572207B0A20202020626F782D736861646F773A202D357078203070782030707820307078207267622837302C2037302C203730292021696D706F7274616E743B0A7D0A0A2E6E6F746966';
wwv_flow_api.g_varchar2_table(34) := '69636174696F6E73202E6E6F7465202E6E6F74652D6865616465722069207B0A20202020706F736974696F6E3A2072656C61746976653B0A20202020746F703A202D3170783B0A202020206D617267696E2D72696768743A20313070783B0A2020202076';
wwv_flow_api.g_varchar2_table(35) := '6572746963616C2D616C69676E3A206D6964646C653B0A2020202077696474683A20333070783B0A20202020746578742D616C69676E3A2063656E7465723B0A7D0A0A2E746F67676C654C697374207B0A202020207669736962696C6974793A20686964';
wwv_flow_api.g_varchar2_table(36) := '64656E3B0A7D0A0A2E742D4E617669676174696F6E4261722D6974656D207B0A20202020766572746963616C2D616C69676E3A206D6964646C653B0A7D0A';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(79120894221201879)
,p_plugin_id=>wwv_flow_api.id(138285470529447569213)
,p_file_name=>'style.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '406B65796672616D65732066612D626C696E6B7B30252C746F7B6F7061636974793A317D3530257B6F7061636974793A307D7D2E746F67676C654E6F74696669636174696F6E737B6D617267696E2D72696768743A3870783B706F736974696F6E3A7265';
wwv_flow_api.g_varchar2_table(2) := '6C61746976653B646973706C61793A2D7765626B69742D696E6C696E652D626F783B646973706C61793A2D6D732D696E6C696E652D666C6578626F783B646973706C61793A696E6C696E652D666C65783B666C6F61743A72696768743B6865696768743A';
wwv_flow_api.g_varchar2_table(3) := '323870783B77696474683A323870783B2D7765626B69742D757365722D73656C6563743A6E6F6E653B2D6D6F7A2D757365722D73656C6563743A6E6F6E653B2D6D732D757365722D73656C6563743A6E6F6E653B757365722D73656C6563743A6E6F6E65';
wwv_flow_api.g_varchar2_table(4) := '3B637572736F723A706F696E7465727D2E746F67676C654E6F74696669636174696F6E73202E73686F777B2D7765626B69742D626F782D666C65783A313B2D6D732D666C65783A313B666C65783A313B6D617267696E3A6175746F3B6865696768743A32';
wwv_flow_api.g_varchar2_table(5) := '3870783B6D61782D77696474683A323870783B746578742D616C69676E3A63656E7465723B626F726465722D7261646975733A3530253B6261636B67726F756E643A7267626128302C302C302C2E35293B666F6E742D73697A653A323870783B2D776562';
wwv_flow_api.g_varchar2_table(6) := '6B69742D7472616E736974696F6E3A616C6C2031733B7472616E736974696F6E3A616C6C2031733B637572736F723A706F696E7465727D2E746F67676C654E6F74696669636174696F6E73202E73686F773A686F7665727B6261636B67726F756E643A23';
wwv_flow_api.g_varchar2_table(7) := '3030307D2E746F67676C654E6F74696669636174696F6E73202E73686F7720697B6C696E652D6865696768743A323870783B636F6C6F723A236666667D2E746F67676C654E6F74696669636174696F6E73202E636F756E747B706F736974696F6E3A6162';
wwv_flow_api.g_varchar2_table(8) := '736F6C7574653B746F703A2D3270783B72696768743A3770783B637572736F723A706F696E7465727D2E746F67676C654E6F74696669636174696F6E73202E636F756E74202E6E756D7B706F736974696F6E3A6162736F6C7574653B746F703A303B6C65';
wwv_flow_api.g_varchar2_table(9) := '66743A303B6261636B67726F756E643A236632323B626F726465722D7261646975733A3530253B77696474683A313870783B6865696768743A313870783B746578742D616C69676E3A63656E7465723B6C696E652D6865696768743A313470783B666F6E';
wwv_flow_api.g_varchar2_table(10) := '742D73697A653A313170783B2D7765626B69742D626F782D736861646F773A302031707820337078207267626128302C302C302C2E3235293B626F782D736861646F773A302031707820337078207267626128302C302C302C2E3235293B626F72646572';
wwv_flow_api.g_varchar2_table(11) := '3A31707820736F6C696420726762612837302C37302C37302C2E32293B2D7765626B69742D7472616E736974696F6E3A616C6C202E33733B7472616E736974696F6E3A616C6C202E33733B636F6C6F723A236666667D2E6E6F74696669636174696F6E73';
wwv_flow_api.g_varchar2_table(12) := '7B706F736974696F6E3A66697865643B746F703A343270783B72696768743A313070783B77696474683A34303070783B6261636B67726F756E643A236661666166613B626F726465722D7261646975733A3270783B2D7765626B69742D626F782D736861';
wwv_flow_api.g_varchar2_table(13) := '646F773A302033707820367078207267626128302C302C302C2E35293B626F782D736861646F773A302033707820367078207267626128302C302C302C2E35293B7A2D696E6465783A393939393B6D61782D6865696768743A373576683B6F766572666C';
wwv_flow_api.g_varchar2_table(14) := '6F773A6175746F7D406D65646961206F6E6C792073637265656E20616E6420286D61782D77696474683A3638307078297B2E6E6F74696669636174696F6E737B77696474683A383576773B6D61782D77696474683A34303070787D7D2E6E6F7469666963';
wwv_flow_api.g_varchar2_table(15) := '6174696F6E73202E6E6F74657B6D617267696E3A30203570783B626F726465722D626F74746F6D3A31707820736F6C696420236536653665363B6C696E652D6865696768743A313070783B6F766572666C6F773A68696464656E3B636F6C6F723A233436';
wwv_flow_api.g_varchar2_table(16) := '343634363B70616464696E672D6C6566743A3570783B706F736974696F6E3A72656C61746976657D2E6E6F74696669636174696F6E73202E6E6F7465202E6163636570742D612C2E6E6F74696669636174696F6E73202E6E6F7465202E6465636C696E65';
wwv_flow_api.g_varchar2_table(17) := '2D617B706F736974696F6E3A6162736F6C7574653B626F74746F6D3A313070783B72696768743A3570787D2E6E6F74696669636174696F6E73202E6E6F7465202E6E6F74652D696E666F7B646973706C61793A626C6F636B3B70616464696E673A302033';
wwv_flow_api.g_varchar2_table(18) := '307078203230707820343070783B6F766572666C6F772D777261703A627265616B2D776F72643B776F72642D777261703A627265616B2D776F72643B2D6D732D68797068656E733A6175746F3B2D6D6F7A2D68797068656E733A6175746F3B2D7765626B';
wwv_flow_api.g_varchar2_table(19) := '69742D68797068656E733A6175746F3B68797068656E733A6175746F3B77696474683A313030253B6C696E652D6865696768743A323070787D2E66612D626C696E6B7B2D7765626B69742D616E696D6174696F6E3A66612D626C696E6B203273206C696E';
wwv_flow_api.g_varchar2_table(20) := '65617220696E66696E6974653B2D6D6F7A2D616E696D6174696F6E3A66612D626C696E6B203273206C696E65617220696E66696E6974653B2D6D732D616E696D6174696F6E3A66612D626C696E6B203273206C696E65617220696E66696E6974653B2D6F';
wwv_flow_api.g_varchar2_table(21) := '2D616E696D6174696F6E3A66612D626C696E6B203273206C696E65617220696E66696E6974653B616E696D6174696F6E3A66612D626C696E6B203273206C696E65617220696E66696E6974657D2E6E6F74696669636174696F6E7320617B746578742D64';
wwv_flow_api.g_varchar2_table(22) := '65636F726174696F6E3A6E6F6E657D2E6E6F74696669636174696F6E73202E6E6F7465202E6E6F74652D6865616465727B666F6E742D7765696768743A3730303B746578742D6F766572666C6F773A656C6C69707369733B6F766572666C6F773A686964';
wwv_flow_api.g_varchar2_table(23) := '64656E3B77686974652D73706163653A6E6F777261703B77696474683A313030253B70616464696E672D72696768743A313070783B6C696E652D6865696768743A343070787D2E6E6F74696669636174696F6E73202E6E6F74653A66697273742D6F662D';
wwv_flow_api.g_varchar2_table(24) := '747970657B6D617267696E2D746F703A307D2E6E6F74696669636174696F6E73202E6E6F74653A686F7665727B626F782D736861646F773A2D357078203020302030202334363436343621696D706F7274616E747D2E6E6F74696669636174696F6E7320';
wwv_flow_api.g_varchar2_table(25) := '2E6E6F7465202E6E6F74652D68656164657220697B706F736974696F6E3A72656C61746976653B746F703A2D3170783B6D617267696E2D72696768743A313070783B766572746963616C2D616C69676E3A6D6964646C653B77696474683A333070783B74';
wwv_flow_api.g_varchar2_table(26) := '6578742D616C69676E3A63656E7465727D2E746F67676C654C6973747B7669736962696C6974793A68696464656E7D2E742D4E617669676174696F6E4261722D6974656D7B766572746963616C2D616C69676E3A6D6964646C657D';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(79122868412202612)
,p_plugin_id=>wwv_flow_api.id(138285470529447569213)
,p_file_name=>'style.min.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2F2A2120406C6963656E736520444F4D50757269667920332E322E34207C202863292043757265353320616E64206F7468657220636F6E7472696275746F7273207C2052656C656173656420756E6465722074686520417061636865206C6963656E7365';
wwv_flow_api.g_varchar2_table(2) := '20322E3020616E64204D6F7A696C6C61205075626C6963204C6963656E736520322E30207C206769746875622E636F6D2F6375726535332F444F4D5075726966792F626C6F622F332E322E342F4C4943454E5345202A2F0A2166756E6374696F6E28652C';
wwv_flow_api.g_varchar2_table(3) := '74297B226F626A656374223D3D747970656F66206578706F727473262622756E646566696E656422213D747970656F66206D6F64756C653F6D6F64756C652E6578706F7274733D7428293A2266756E6374696F6E223D3D747970656F6620646566696E65';
wwv_flow_api.g_varchar2_table(4) := '2626646566696E652E616D643F646566696E652874293A28653D22756E646566696E656422213D747970656F6620676C6F62616C546869733F676C6F62616C546869733A657C7C73656C66292E444F4D5075726966793D7428297D28746869732C286675';
wwv_flow_api.g_varchar2_table(5) := '6E6374696F6E28297B2275736520737472696374223B636F6E73747B656E74726965733A652C73657450726F746F747970654F663A742C697346726F7A656E3A6E2C67657450726F746F747970654F663A6F2C6765744F776E50726F7065727479446573';
wwv_flow_api.g_varchar2_table(6) := '63726970746F723A727D3D4F626A6563743B6C65747B667265657A653A692C7365616C3A612C6372656174653A6C7D3D4F626A6563742C7B6170706C793A632C636F6E7374727563743A737D3D22756E646566696E656422213D747970656F6620526566';
wwv_flow_api.g_varchar2_table(7) := '6C65637426265265666C6563743B697C7C28693D66756E6374696F6E2865297B72657475726E20657D292C617C7C28613D66756E6374696F6E2865297B72657475726E20657D292C637C7C28633D66756E6374696F6E28652C742C6E297B72657475726E';
wwv_flow_api.g_varchar2_table(8) := '20652E6170706C7928742C6E297D292C737C7C28733D66756E6374696F6E28652C74297B72657475726E206E65772065282E2E2E74297D293B636F6E737420753D522841727261792E70726F746F747970652E666F7245616368292C6D3D522841727261';
wwv_flow_api.g_varchar2_table(9) := '792E70726F746F747970652E6C617374496E6465784F66292C703D522841727261792E70726F746F747970652E706F70292C663D522841727261792E70726F746F747970652E70757368292C643D522841727261792E70726F746F747970652E73706C69';
wwv_flow_api.g_varchar2_table(10) := '6365292C683D5228537472696E672E70726F746F747970652E746F4C6F77657243617365292C673D5228537472696E672E70726F746F747970652E746F537472696E67292C543D5228537472696E672E70726F746F747970652E6D61746368292C793D52';
wwv_flow_api.g_varchar2_table(11) := '28537472696E672E70726F746F747970652E7265706C616365292C453D5228537472696E672E70726F746F747970652E696E6465784F66292C413D5228537472696E672E70726F746F747970652E7472696D292C5F3D52284F626A6563742E70726F746F';
wwv_flow_api.g_varchar2_table(12) := '747970652E6861734F776E50726F7065727479292C533D52285265674578702E70726F746F747970652E74657374292C623D284E3D547970654572726F722C66756E6374696F6E28297B666F722876617220653D617267756D656E74732E6C656E677468';
wwv_flow_api.g_varchar2_table(13) := '2C743D6E65772041727261792865292C6E3D303B6E3C653B6E2B2B29745B6E5D3D617267756D656E74735B6E5D3B72657475726E2073284E2C74297D293B766172204E3B66756E6374696F6E20522865297B72657475726E2066756E6374696F6E287429';
wwv_flow_api.g_varchar2_table(14) := '7B666F7228766172206E3D617267756D656E74732E6C656E6774682C6F3D6E6577204172726179286E3E313F6E2D313A30292C723D313B723C6E3B722B2B296F5B722D315D3D617267756D656E74735B725D3B72657475726E206328652C742C6F297D7D';
wwv_flow_api.g_varchar2_table(15) := '66756E6374696F6E207728652C6F297B6C657420723D617267756D656E74732E6C656E6774683E322626766F69642030213D3D617267756D656E74735B325D3F617267756D656E74735B325D3A683B7426267428652C6E756C6C293B6C657420693D6F2E';
wwv_flow_api.g_varchar2_table(16) := '6C656E6774683B666F72283B692D2D3B297B6C657420743D6F5B695D3B69662822737472696E67223D3D747970656F662074297B636F6E737420653D722874293B65213D3D742626286E286F297C7C286F5B695D3D65292C743D65297D655B745D3D2130';
wwv_flow_api.g_varchar2_table(17) := '7D72657475726E20657D66756E6374696F6E204F2865297B666F72286C657420743D303B743C652E6C656E6774683B742B2B297B5F28652C74297C7C28655B745D3D6E756C6C297D72657475726E20657D66756E6374696F6E20442874297B636F6E7374';
wwv_flow_api.g_varchar2_table(18) := '206E3D6C286E756C6C293B666F7228636F6E73745B6F2C725D6F662065287429297B5F28742C6F2926262841727261792E697341727261792872293F6E5B6F5D3D4F2872293A722626226F626A656374223D3D747970656F6620722626722E636F6E7374';
wwv_flow_api.g_varchar2_table(19) := '727563746F723D3D3D4F626A6563743F6E5B6F5D3D442872293A6E5B6F5D3D72297D72657475726E206E7D66756E6374696F6E204C28652C74297B666F72283B6E756C6C213D3D653B297B636F6E7374206E3D7228652C74293B6966286E297B6966286E';
wwv_flow_api.g_varchar2_table(20) := '2E6765742972657475726E2052286E2E676574293B6966282266756E6374696F6E223D3D747970656F66206E2E76616C75652972657475726E2052286E2E76616C7565297D653D6F2865297D72657475726E2066756E6374696F6E28297B72657475726E';
wwv_flow_api.g_varchar2_table(21) := '206E756C6C7D7D636F6E737420763D69285B2261222C2261626272222C226163726F6E796D222C2261646472657373222C2261726561222C2261727469636C65222C226173696465222C22617564696F222C2262222C22626469222C2262646F222C2262';
wwv_flow_api.g_varchar2_table(22) := '6967222C22626C696E6B222C22626C6F636B71756F7465222C22626F6479222C226272222C22627574746F6E222C2263616E766173222C2263617074696F6E222C2263656E746572222C2263697465222C22636F6465222C22636F6C222C22636F6C6772';
wwv_flow_api.g_varchar2_table(23) := '6F7570222C22636F6E74656E74222C2264617461222C22646174616C697374222C226464222C226465636F7261746F72222C2264656C222C2264657461696C73222C2264666E222C226469616C6F67222C22646972222C22646976222C22646C222C2264';
wwv_flow_api.g_varchar2_table(24) := '74222C22656C656D656E74222C22656D222C226669656C64736574222C2266696763617074696F6E222C22666967757265222C22666F6E74222C22666F6F746572222C22666F726D222C226831222C226832222C226833222C226834222C226835222C22';
wwv_flow_api.g_varchar2_table(25) := '6836222C2268656164222C22686561646572222C226867726F7570222C226872222C2268746D6C222C2269222C22696D67222C22696E707574222C22696E73222C226B6264222C226C6162656C222C226C6567656E64222C226C69222C226D61696E222C';
wwv_flow_api.g_varchar2_table(26) := '226D6170222C226D61726B222C226D617271756565222C226D656E75222C226D656E756974656D222C226D65746572222C226E6176222C226E6F6272222C226F6C222C226F707467726F7570222C226F7074696F6E222C226F7574707574222C2270222C';
wwv_flow_api.g_varchar2_table(27) := '2270696374757265222C22707265222C2270726F6772657373222C2271222C227270222C227274222C2272756279222C2273222C2273616D70222C2273656374696F6E222C2273656C656374222C22736861646F77222C22736D616C6C222C22736F7572';
wwv_flow_api.g_varchar2_table(28) := '6365222C22737061636572222C227370616E222C22737472696B65222C227374726F6E67222C227374796C65222C22737562222C2273756D6D617279222C22737570222C227461626C65222C2274626F6479222C227464222C2274656D706C617465222C';
wwv_flow_api.g_varchar2_table(29) := '227465787461726561222C2274666F6F74222C227468222C227468656164222C2274696D65222C227472222C22747261636B222C227474222C2275222C22756C222C22766172222C22766964656F222C22776272225D292C433D69285B22737667222C22';
wwv_flow_api.g_varchar2_table(30) := '61222C22616C74676C797068222C22616C74676C797068646566222C22616C74676C7970686974656D222C22616E696D617465636F6C6F72222C22616E696D6174656D6F74696F6E222C22616E696D6174657472616E73666F726D222C22636972636C65';
wwv_flow_api.g_varchar2_table(31) := '222C22636C697070617468222C2264656673222C2264657363222C22656C6C69707365222C2266696C746572222C22666F6E74222C2267222C22676C797068222C22676C797068726566222C22686B65726E222C22696D616765222C226C696E65222C22';
wwv_flow_api.g_varchar2_table(32) := '6C696E6561726772616469656E74222C226D61726B6572222C226D61736B222C226D65746164617461222C226D70617468222C2270617468222C227061747465726E222C22706F6C79676F6E222C22706F6C796C696E65222C2272616469616C67726164';
wwv_flow_api.g_varchar2_table(33) := '69656E74222C2272656374222C2273746F70222C227374796C65222C22737769746368222C2273796D626F6C222C2274657874222C227465787470617468222C227469746C65222C2274726566222C22747370616E222C2276696577222C22766B65726E';
wwv_flow_api.g_varchar2_table(34) := '225D292C783D69285B226665426C656E64222C226665436F6C6F724D6174726978222C226665436F6D706F6E656E745472616E73666572222C226665436F6D706F73697465222C226665436F6E766F6C76654D6174726978222C22666544696666757365';
wwv_flow_api.g_varchar2_table(35) := '4C69676874696E67222C226665446973706C6163656D656E744D6170222C22666544697374616E744C69676874222C22666544726F70536861646F77222C226665466C6F6F64222C22666546756E6341222C22666546756E6342222C22666546756E6347';
wwv_flow_api.g_varchar2_table(36) := '222C22666546756E6352222C226665476175737369616E426C7572222C226665496D616765222C2266654D65726765222C2266654D657267654E6F6465222C2266654D6F7270686F6C6F6779222C2266654F6666736574222C226665506F696E744C6967';
wwv_flow_api.g_varchar2_table(37) := '6874222C22666553706563756C61724C69676874696E67222C22666553706F744C69676874222C22666554696C65222C22666554757262756C656E6365225D292C4D3D69285B22616E696D617465222C22636F6C6F722D70726F66696C65222C22637572';
wwv_flow_api.g_varchar2_table(38) := '736F72222C2264697363617264222C22666F6E742D66616365222C22666F6E742D666163652D666F726D6174222C22666F6E742D666163652D6E616D65222C22666F6E742D666163652D737263222C22666F6E742D666163652D757269222C22666F7265';
wwv_flow_api.g_varchar2_table(39) := '69676E6F626A656374222C226861746368222C22686174636870617468222C226D657368222C226D6573686772616469656E74222C226D6573687061746368222C226D657368726F77222C226D697373696E672D676C797068222C22736372697074222C';
wwv_flow_api.g_varchar2_table(40) := '22736574222C22736F6C6964636F6C6F72222C22756E6B6E6F776E222C22757365225D292C6B3D69285B226D617468222C226D656E636C6F7365222C226D6572726F72222C226D66656E636564222C226D66726163222C226D676C797068222C226D6922';
wwv_flow_api.g_varchar2_table(41) := '2C226D6C6162656C65647472222C226D6D756C746973637269707473222C226D6E222C226D6F222C226D6F766572222C226D706164646564222C226D7068616E746F6D222C226D726F6F74222C226D726F77222C226D73222C226D7370616365222C226D';
wwv_flow_api.g_varchar2_table(42) := '73717274222C226D7374796C65222C226D737562222C226D737570222C226D737562737570222C226D7461626C65222C226D7464222C226D74657874222C226D7472222C226D756E646572222C226D756E6465726F766572222C226D7072657363726970';
wwv_flow_api.g_varchar2_table(43) := '7473225D292C493D69285B226D616374696F6E222C226D616C69676E67726F7570222C226D616C69676E6D61726B222C226D6C6F6E67646976222C226D7363617272696573222C226D736361727279222C226D7367726F7570222C226D737461636B222C';
wwv_flow_api.g_varchar2_table(44) := '226D736C696E65222C226D73726F77222C2273656D616E74696373222C22616E6E6F746174696F6E222C22616E6E6F746174696F6E2D786D6C222C226D70726573637269707473222C226E6F6E65225D292C553D69285B222374657874225D292C7A3D69';
wwv_flow_api.g_varchar2_table(45) := '285B22616363657074222C22616374696F6E222C22616C69676E222C22616C74222C226175746F6361706974616C697A65222C226175746F636F6D706C657465222C226175746F70696374757265696E70696374757265222C226175746F706C6179222C';
wwv_flow_api.g_varchar2_table(46) := '226261636B67726F756E64222C226267636F6C6F72222C22626F72646572222C2263617074757265222C2263656C6C70616464696E67222C2263656C6C73706163696E67222C22636865636B6564222C2263697465222C22636C617373222C22636C6561';
wwv_flow_api.g_varchar2_table(47) := '72222C22636F6C6F72222C22636F6C73222C22636F6C7370616E222C22636F6E74726F6C73222C22636F6E74726F6C736C697374222C22636F6F726473222C2263726F73736F726967696E222C226461746574696D65222C226465636F64696E67222C22';
wwv_flow_api.g_varchar2_table(48) := '64656661756C74222C22646972222C2264697361626C6564222C2264697361626C6570696374757265696E70696374757265222C2264697361626C6572656D6F7465706C61796261636B222C22646F776E6C6F6164222C22647261676761626C65222C22';
wwv_flow_api.g_varchar2_table(49) := '656E6374797065222C22656E7465726B657968696E74222C2266616365222C22666F72222C2268656164657273222C22686569676874222C2268696464656E222C2268696768222C2268726566222C22687265666C616E67222C226964222C22696E7075';
wwv_flow_api.g_varchar2_table(50) := '746D6F6465222C22696E74656772697479222C2269736D6170222C226B696E64222C226C6162656C222C226C616E67222C226C697374222C226C6F6164696E67222C226C6F6F70222C226C6F77222C226D6178222C226D61786C656E677468222C226D65';
wwv_flow_api.g_varchar2_table(51) := '646961222C226D6574686F64222C226D696E222C226D696E6C656E677468222C226D756C7469706C65222C226D75746564222C226E616D65222C226E6F6E6365222C226E6F7368616465222C226E6F76616C6964617465222C226E6F77726170222C226F';
wwv_flow_api.g_varchar2_table(52) := '70656E222C226F7074696D756D222C227061747465726E222C22706C616365686F6C646572222C22706C617973696E6C696E65222C22706F706F766572222C22706F706F766572746172676574222C22706F706F766572746172676574616374696F6E22';
wwv_flow_api.g_varchar2_table(53) := '2C22706F73746572222C227072656C6F6164222C2270756264617465222C22726164696F67726F7570222C22726561646F6E6C79222C2272656C222C227265717569726564222C22726576222C227265766572736564222C22726F6C65222C22726F7773';
wwv_flow_api.g_varchar2_table(54) := '222C22726F777370616E222C227370656C6C636865636B222C2273636F7065222C2273656C6563746564222C227368617065222C2273697A65222C2273697A6573222C227370616E222C227372636C616E67222C227374617274222C22737263222C2273';
wwv_flow_api.g_varchar2_table(55) := '7263736574222C2273746570222C227374796C65222C2273756D6D617279222C22746162696E646578222C227469746C65222C227472616E736C617465222C2274797065222C227573656D6170222C2276616C69676E222C2276616C7565222C22776964';
wwv_flow_api.g_varchar2_table(56) := '7468222C2277726170222C22786D6C6E73222C22736C6F74225D292C503D69285B22616363656E742D686569676874222C22616363756D756C617465222C226164646974697665222C22616C69676E6D656E742D626173656C696E65222C22616D706C69';
wwv_flow_api.g_varchar2_table(57) := '74756465222C22617363656E74222C226174747269627574656E616D65222C2261747472696275746574797065222C22617A696D757468222C22626173656672657175656E6379222C22626173656C696E652D7368696674222C22626567696E222C2262';
wwv_flow_api.g_varchar2_table(58) := '696173222C226279222C22636C617373222C22636C6970222C22636C697070617468756E697473222C22636C69702D70617468222C22636C69702D72756C65222C22636F6C6F72222C22636F6C6F722D696E746572706F6C6174696F6E222C22636F6C6F';
wwv_flow_api.g_varchar2_table(59) := '722D696E746572706F6C6174696F6E2D66696C74657273222C22636F6C6F722D70726F66696C65222C22636F6C6F722D72656E646572696E67222C226378222C226379222C2264222C226478222C226479222C2264696666757365636F6E7374616E7422';
wwv_flow_api.g_varchar2_table(60) := '2C22646972656374696F6E222C22646973706C6179222C2264697669736F72222C22647572222C22656467656D6F6465222C22656C65766174696F6E222C22656E64222C226578706F6E656E74222C2266696C6C222C2266696C6C2D6F70616369747922';
wwv_flow_api.g_varchar2_table(61) := '2C2266696C6C2D72756C65222C2266696C746572222C2266696C746572756E697473222C22666C6F6F642D636F6C6F72222C22666C6F6F642D6F706163697479222C22666F6E742D66616D696C79222C22666F6E742D73697A65222C22666F6E742D7369';
wwv_flow_api.g_varchar2_table(62) := '7A652D61646A757374222C22666F6E742D73747265746368222C22666F6E742D7374796C65222C22666F6E742D76617269616E74222C22666F6E742D776569676874222C226678222C226679222C226731222C226732222C22676C7970682D6E616D6522';
wwv_flow_api.g_varchar2_table(63) := '2C22676C797068726566222C226772616469656E74756E697473222C226772616469656E747472616E73666F726D222C22686569676874222C2268726566222C226964222C22696D6167652D72656E646572696E67222C22696E222C22696E32222C2269';
wwv_flow_api.g_varchar2_table(64) := '6E74657263657074222C226B222C226B31222C226B32222C226B33222C226B34222C226B65726E696E67222C226B6579706F696E7473222C226B657973706C696E6573222C226B657974696D6573222C226C616E67222C226C656E67746861646A757374';
wwv_flow_api.g_varchar2_table(65) := '222C226C65747465722D73706163696E67222C226B65726E656C6D6174726978222C226B65726E656C756E69746C656E677468222C226C69676874696E672D636F6C6F72222C226C6F63616C222C226D61726B65722D656E64222C226D61726B65722D6D';
wwv_flow_api.g_varchar2_table(66) := '6964222C226D61726B65722D7374617274222C226D61726B6572686569676874222C226D61726B6572756E697473222C226D61726B65727769647468222C226D61736B636F6E74656E74756E697473222C226D61736B756E697473222C226D6178222C22';
wwv_flow_api.g_varchar2_table(67) := '6D61736B222C226D65646961222C226D6574686F64222C226D6F6465222C226D696E222C226E616D65222C226E756D6F637461766573222C226F6666736574222C226F70657261746F72222C226F706163697479222C226F72646572222C226F7269656E';
wwv_flow_api.g_varchar2_table(68) := '74222C226F7269656E746174696F6E222C226F726967696E222C226F766572666C6F77222C227061696E742D6F72646572222C2270617468222C22706174686C656E677468222C227061747465726E636F6E74656E74756E697473222C22706174746572';
wwv_flow_api.g_varchar2_table(69) := '6E7472616E73666F726D222C227061747465726E756E697473222C22706F696E7473222C227072657365727665616C706861222C227072657365727665617370656374726174696F222C227072696D6974697665756E697473222C2272222C227278222C';
wwv_flow_api.g_varchar2_table(70) := '227279222C22726164697573222C2272656678222C2272656679222C22726570656174636F756E74222C22726570656174647572222C2272657374617274222C22726573756C74222C22726F74617465222C227363616C65222C2273656564222C227368';
wwv_flow_api.g_varchar2_table(71) := '6170652D72656E646572696E67222C22736C6F7065222C2273706563756C6172636F6E7374616E74222C2273706563756C61726578706F6E656E74222C227370726561646D6574686F64222C2273746172746F6666736574222C22737464646576696174';
wwv_flow_api.g_varchar2_table(72) := '696F6E222C2273746974636874696C6573222C2273746F702D636F6C6F72222C2273746F702D6F706163697479222C227374726F6B652D646173686172726179222C227374726F6B652D646173686F6666736574222C227374726F6B652D6C696E656361';
wwv_flow_api.g_varchar2_table(73) := '70222C227374726F6B652D6C696E656A6F696E222C227374726F6B652D6D697465726C696D6974222C227374726F6B652D6F706163697479222C227374726F6B65222C227374726F6B652D7769647468222C227374796C65222C22737572666163657363';
wwv_flow_api.g_varchar2_table(74) := '616C65222C2273797374656D6C616E6775616765222C22746162696E646578222C227461626C6576616C756573222C2274617267657478222C2274617267657479222C227472616E73666F726D222C227472616E73666F726D2D6F726967696E222C2274';
wwv_flow_api.g_varchar2_table(75) := '6578742D616E63686F72222C22746578742D6465636F726174696F6E222C22746578742D72656E646572696E67222C22746578746C656E677468222C2274797065222C227531222C227532222C22756E69636F6465222C2276616C756573222C22766965';
wwv_flow_api.g_varchar2_table(76) := '77626F78222C227669736962696C697479222C2276657273696F6E222C22766572742D6164762D79222C22766572742D6F726967696E2D78222C22766572742D6F726967696E2D79222C227769647468222C22776F72642D73706163696E67222C227772';
wwv_flow_api.g_varchar2_table(77) := '6170222C2277726974696E672D6D6F6465222C22786368616E6E656C73656C6563746F72222C22796368616E6E656C73656C6563746F72222C2278222C227831222C227832222C22786D6C6E73222C2279222C227931222C227932222C227A222C227A6F';
wwv_flow_api.g_varchar2_table(78) := '6F6D616E6470616E225D292C483D69285B22616363656E74222C22616363656E74756E646572222C22616C69676E222C22626576656C6C6564222C22636C6F7365222C22636F6C756D6E73616C69676E222C22636F6C756D6E6C696E6573222C22636F6C';
wwv_flow_api.g_varchar2_table(79) := '756D6E7370616E222C2264656E6F6D616C69676E222C226465707468222C22646972222C22646973706C6179222C22646973706C61797374796C65222C22656E636F64696E67222C2266656E6365222C226672616D65222C22686569676874222C226872';
wwv_flow_api.g_varchar2_table(80) := '6566222C226964222C226C617267656F70222C226C656E677468222C226C696E65746869636B6E657373222C226C7370616365222C226C71756F7465222C226D6174686261636B67726F756E64222C226D617468636F6C6F72222C226D61746873697A65';
wwv_flow_api.g_varchar2_table(81) := '222C226D61746876617269616E74222C226D617873697A65222C226D696E73697A65222C226D6F7661626C656C696D697473222C226E6F746174696F6E222C226E756D616C69676E222C226F70656E222C22726F77616C69676E222C22726F776C696E65';
wwv_flow_api.g_varchar2_table(82) := '73222C22726F7773706163696E67222C22726F777370616E222C22727370616365222C227271756F7465222C227363726970746C6576656C222C227363726970746D696E73697A65222C2273637269707473697A656D756C7469706C696572222C227365';
wwv_flow_api.g_varchar2_table(83) := '6C656374696F6E222C22736570617261746F72222C22736570617261746F7273222C227374726574636879222C227375627363726970747368696674222C227375707363726970747368696674222C2273796D6D6574726963222C22766F666673657422';
wwv_flow_api.g_varchar2_table(84) := '2C227769647468222C22786D6C6E73225D292C463D69285B22786C696E6B3A68726566222C22786D6C3A6964222C22786C696E6B3A7469746C65222C22786D6C3A7370616365222C22786D6C6E733A786C696E6B225D292C423D61282F5C7B5C7B5B5C77';
wwv_flow_api.g_varchar2_table(85) := '5C575D2A7C5B5C775C575D2A5C7D5C7D2F676D292C573D61282F3C255B5C775C575D2A7C5B5C775C575D2A253E2F676D292C473D61282F5C245C7B5B5C775C575D2A2F676D292C593D61282F5E646174612D5B5C2D5C772E5C75303042372D5C75464646';
wwv_flow_api.g_varchar2_table(86) := '465D2B242F292C6A3D61282F5E617269612D5B5C2D5C775D2B242F292C583D61282F5E283F3A283F3A283F3A667C6874297470733F7C6D61696C746F7C74656C7C63616C6C746F7C736D737C6369647C786D7070293A7C5B5E612D7A5D7C5B612D7A2B2E';
wwv_flow_api.g_varchar2_table(87) := '5C2D5D2B283F3A5B5E612D7A2B2E5C2D3A5D7C2429292F69292C713D61282F5E283F3A5C772B7363726970747C64617461293A2F69292C243D61282F5B5C75303030302D5C75303032305C75303041305C75313638305C75313830455C75323030302D5C';
wwv_flow_api.g_varchar2_table(88) := '75323032395C75323035465C75333030305D2F67292C4B3D61282F5E68746D6C242F69292C563D61282F5E5B612D7A5D5B2E5C775D2A282D5B2E5C775D2B292B242F69293B766172205A3D4F626A6563742E667265657A65287B5F5F70726F746F5F5F3A';
wwv_flow_api.g_varchar2_table(89) := '6E756C6C2C415249415F415454523A6A2C415454525F574849544553504143453A242C435553544F4D5F454C454D454E543A562C444154415F415454523A592C444F43545950455F4E414D453A4B2C4552425F455850523A572C49535F414C4C4F574544';
wwv_flow_api.g_varchar2_table(90) := '5F5552493A582C49535F5343524950545F4F525F444154413A712C4D555354414348455F455850523A422C544D504C49545F455850523A477D293B636F6E7374204A3D312C513D332C65653D372C74653D382C6E653D392C6F653D66756E6374696F6E28';
wwv_flow_api.g_varchar2_table(91) := '297B72657475726E22756E646566696E6564223D3D747970656F662077696E646F773F6E756C6C3A77696E646F777D2C72653D66756E6374696F6E28652C74297B696628226F626A65637422213D747970656F6620657C7C2266756E6374696F6E22213D';
wwv_flow_api.g_varchar2_table(92) := '747970656F6620652E637265617465506F6C6963792972657475726E206E756C6C3B6C6574206E3D6E756C6C3B636F6E7374206F3D22646174612D74742D706F6C6963792D737566666978223B742626742E686173417474726962757465286F29262628';
wwv_flow_api.g_varchar2_table(93) := '6E3D742E676574417474726962757465286F29293B636F6E737420723D22646F6D707572696679222B286E3F2223222B6E3A2222293B7472797B72657475726E20652E637265617465506F6C69637928722C7B63726561746548544D4C3A653D3E652C63';
wwv_flow_api.g_varchar2_table(94) := '726561746553637269707455524C3A653D3E657D297D63617463682865297B72657475726E20636F6E736F6C652E7761726E282254727573746564547970657320706F6C69637920222B722B2220636F756C64206E6F7420626520637265617465642E22';
wwv_flow_api.g_varchar2_table(95) := '292C6E756C6C7D7D3B72657475726E2066756E6374696F6E207428297B6C6574206E3D617267756D656E74732E6C656E6774683E302626766F69642030213D3D617267756D656E74735B305D3F617267756D656E74735B305D3A6F6528293B636F6E7374';
wwv_flow_api.g_varchar2_table(96) := '206F3D653D3E742865293B6966286F2E76657273696F6E3D22332E322E34222C6F2E72656D6F7665643D5B5D2C216E7C7C216E2E646F63756D656E747C7C6E2E646F63756D656E742E6E6F646554797065213D3D6E657C7C216E2E456C656D656E742972';
wwv_flow_api.g_varchar2_table(97) := '657475726E206F2E6973537570706F727465643D21312C6F3B6C65747B646F63756D656E743A727D3D6E3B636F6E737420613D722C633D612E63757272656E745363726970742C7B446F63756D656E74467261676D656E743A732C48544D4C54656D706C';
wwv_flow_api.g_varchar2_table(98) := '617465456C656D656E743A4E2C4E6F64653A522C456C656D656E743A4F2C4E6F646546696C7465723A422C4E616D65644E6F64654D61703A573D6E2E4E616D65644E6F64654D61707C7C6E2E4D6F7A4E616D6564417474724D61702C48544D4C466F726D';
wwv_flow_api.g_varchar2_table(99) := '456C656D656E743A472C444F4D5061727365723A592C7472757374656454797065733A6A7D3D6E2C713D4F2E70726F746F747970652C243D4C28712C22636C6F6E654E6F646522292C563D4C28712C2272656D6F766522292C69653D4C28712C226E6578';
wwv_flow_api.g_varchar2_table(100) := '745369626C696E6722292C61653D4C28712C226368696C644E6F64657322292C6C653D4C28712C22706172656E744E6F646522293B6966282266756E6374696F6E223D3D747970656F66204E297B636F6E737420653D722E637265617465456C656D656E';
wwv_flow_api.g_varchar2_table(101) := '74282274656D706C61746522293B652E636F6E74656E742626652E636F6E74656E742E6F776E6572446F63756D656E74262628723D652E636F6E74656E742E6F776E6572446F63756D656E74297D6C65742063652C73653D22223B636F6E73747B696D70';
wwv_flow_api.g_varchar2_table(102) := '6C656D656E746174696F6E3A75652C6372656174654E6F64654974657261746F723A6D652C637265617465446F63756D656E74467261676D656E743A70652C676574456C656D656E747342795461674E616D653A66657D3D722C7B696D706F72744E6F64';
wwv_flow_api.g_varchar2_table(103) := '653A64657D3D613B6C65742068653D7B616674657253616E6974697A65417474726962757465733A5B5D2C616674657253616E6974697A65456C656D656E74733A5B5D2C616674657253616E6974697A65536861646F77444F4D3A5B5D2C6265666F7265';
wwv_flow_api.g_varchar2_table(104) := '53616E6974697A65417474726962757465733A5B5D2C6265666F726553616E6974697A65456C656D656E74733A5B5D2C6265666F726553616E6974697A65536861646F77444F4D3A5B5D2C75706F6E53616E6974697A654174747269627574653A5B5D2C';
wwv_flow_api.g_varchar2_table(105) := '75706F6E53616E6974697A65456C656D656E743A5B5D2C75706F6E53616E6974697A65536861646F774E6F64653A5B5D7D3B6F2E6973537570706F727465643D2266756E6374696F6E223D3D747970656F66206526262266756E6374696F6E223D3D7479';
wwv_flow_api.g_varchar2_table(106) := '70656F66206C65262675652626766F69642030213D3D75652E63726561746548544D4C446F63756D656E743B636F6E73747B4D555354414348455F455850523A67652C4552425F455850523A54652C544D504C49545F455850523A79652C444154415F41';
wwv_flow_api.g_varchar2_table(107) := '5454523A45652C415249415F415454523A41652C49535F5343524950545F4F525F444154413A5F652C415454525F574849544553504143453A53652C435553544F4D5F454C454D454E543A62657D3D5A3B6C65747B49535F414C4C4F5745445F5552493A';
wwv_flow_api.g_varchar2_table(108) := '4E657D3D5A2C52653D6E756C6C3B636F6E73742077653D77287B7D2C5B2E2E2E762C2E2E2E432C2E2E2E782C2E2E2E6B2C2E2E2E555D293B6C6574204F653D6E756C6C3B636F6E73742044653D77287B7D2C5B2E2E2E7A2C2E2E2E502C2E2E2E482C2E2E';
wwv_flow_api.g_varchar2_table(109) := '2E465D293B6C6574204C653D4F626A6563742E7365616C286C286E756C6C2C7B7461674E616D65436865636B3A7B7772697461626C653A21302C636F6E666967757261626C653A21312C656E756D657261626C653A21302C76616C75653A6E756C6C7D2C';
wwv_flow_api.g_varchar2_table(110) := '6174747269627574654E616D65436865636B3A7B7772697461626C653A21302C636F6E666967757261626C653A21312C656E756D657261626C653A21302C76616C75653A6E756C6C7D2C616C6C6F77437573746F6D697A65644275696C74496E456C656D';
wwv_flow_api.g_varchar2_table(111) := '656E74733A7B7772697461626C653A21302C636F6E666967757261626C653A21312C656E756D657261626C653A21302C76616C75653A21317D7D29292C76653D6E756C6C2C43653D6E756C6C2C78653D21302C4D653D21302C6B653D21312C49653D2130';
wwv_flow_api.g_varchar2_table(112) := '2C55653D21312C7A653D21302C50653D21312C48653D21312C46653D21312C42653D21312C57653D21312C47653D21312C59653D21302C6A653D21313B636F6E73742058653D22757365722D636F6E74656E742D223B6C65742071653D21302C24653D21';
wwv_flow_api.g_varchar2_table(113) := '312C4B653D7B7D2C56653D6E756C6C3B636F6E7374205A653D77287B7D2C5B22616E6E6F746174696F6E2D786D6C222C22617564696F222C22636F6C67726F7570222C2264657363222C22666F726569676E6F626A656374222C2268656164222C226966';
wwv_flow_api.g_varchar2_table(114) := '72616D65222C226D617468222C226D69222C226D6E222C226D6F222C226D73222C226D74657874222C226E6F656D626564222C226E6F6672616D6573222C226E6F736372697074222C22706C61696E74657874222C22736372697074222C227374796C65';
wwv_flow_api.g_varchar2_table(115) := '222C22737667222C2274656D706C617465222C227468656164222C227469746C65222C22766964656F222C22786D70225D293B6C6574204A653D6E756C6C3B636F6E73742051653D77287B7D2C5B22617564696F222C22766964656F222C22696D67222C';
wwv_flow_api.g_varchar2_table(116) := '22736F75726365222C22696D616765222C22747261636B225D293B6C65742065743D6E756C6C3B636F6E73742074743D77287B7D2C5B22616C74222C22636C617373222C22666F72222C226964222C226C6162656C222C226E616D65222C227061747465';
wwv_flow_api.g_varchar2_table(117) := '726E222C22706C616365686F6C646572222C22726F6C65222C2273756D6D617279222C227469746C65222C2276616C7565222C227374796C65222C22786D6C6E73225D292C6E743D22687474703A2F2F7777772E77332E6F72672F313939382F4D617468';
wwv_flow_api.g_varchar2_table(118) := '2F4D6174684D4C222C6F743D22687474703A2F2F7777772E77332E6F72672F323030302F737667222C72743D22687474703A2F2F7777772E77332E6F72672F313939392F7868746D6C223B6C65742069743D72742C61743D21312C6C743D6E756C6C3B63';
wwv_flow_api.g_varchar2_table(119) := '6F6E73742063743D77287B7D2C5B6E742C6F742C72745D2C67293B6C65742073743D77287B7D2C5B226D69222C226D6F222C226D6E222C226D73222C226D74657874225D292C75743D77287B7D2C5B22616E6E6F746174696F6E2D786D6C225D293B636F';
wwv_flow_api.g_varchar2_table(120) := '6E7374206D743D77287B7D2C5B227469746C65222C227374796C65222C22666F6E74222C2261222C22736372697074225D293B6C65742070743D6E756C6C3B636F6E73742066743D5B226170706C69636174696F6E2F7868746D6C2B786D6C222C227465';
wwv_flow_api.g_varchar2_table(121) := '78742F68746D6C225D2C64743D22746578742F68746D6C223B6C65742068743D6E756C6C2C67743D6E756C6C3B636F6E73742054743D722E637265617465456C656D656E742822666F726D22292C79743D66756E6374696F6E2865297B72657475726E20';
wwv_flow_api.g_varchar2_table(122) := '6520696E7374616E63656F66205265674578707C7C6520696E7374616E63656F662046756E6374696F6E7D2C45743D66756E6374696F6E28297B6C657420653D617267756D656E74732E6C656E6774683E302626766F69642030213D3D617267756D656E';
wwv_flow_api.g_varchar2_table(123) := '74735B305D3F617267756D656E74735B305D3A7B7D3B6966282167747C7C6774213D3D65297B696628652626226F626A656374223D3D747970656F6620657C7C28653D7B7D292C653D442865292C70743D2D313D3D3D66742E696E6465784F6628652E50';
wwv_flow_api.g_varchar2_table(124) := '41525345525F4D454449415F54595045293F64743A652E5041525345525F4D454449415F545950452C68743D226170706C69636174696F6E2F7868746D6C2B786D6C223D3D3D70743F673A682C52653D5F28652C22414C4C4F5745445F5441475322293F';
wwv_flow_api.g_varchar2_table(125) := '77287B7D2C652E414C4C4F5745445F544147532C6874293A77652C4F653D5F28652C22414C4C4F5745445F4154545222293F77287B7D2C652E414C4C4F5745445F415454522C6874293A44652C6C743D5F28652C22414C4C4F5745445F4E414D45535041';
wwv_flow_api.g_varchar2_table(126) := '43455322293F77287B7D2C652E414C4C4F5745445F4E414D455350414345532C67293A63742C65743D5F28652C224144445F5552495F534146455F4154545222293F772844287474292C652E4144445F5552495F534146455F415454522C6874293A7474';
wwv_flow_api.g_varchar2_table(127) := '2C4A653D5F28652C224144445F444154415F5552495F5441475322293F772844285165292C652E4144445F444154415F5552495F544147532C6874293A51652C56653D5F28652C22464F524249445F434F4E54454E545322293F77287B7D2C652E464F52';
wwv_flow_api.g_varchar2_table(128) := '4249445F434F4E54454E54532C6874293A5A652C76653D5F28652C22464F524249445F5441475322293F77287B7D2C652E464F524249445F544147532C6874293A7B7D2C43653D5F28652C22464F524249445F4154545222293F77287B7D2C652E464F52';
wwv_flow_api.g_varchar2_table(129) := '4249445F415454522C6874293A7B7D2C4B653D21215F28652C225553455F50524F46494C455322292626652E5553455F50524F46494C45532C78653D2131213D3D652E414C4C4F575F415249415F415454522C4D653D2131213D3D652E414C4C4F575F44';
wwv_flow_api.g_varchar2_table(130) := '4154415F415454522C6B653D652E414C4C4F575F554E4B4E4F574E5F50524F544F434F4C537C7C21312C49653D2131213D3D652E414C4C4F575F53454C465F434C4F53455F494E5F415454522C55653D652E534146455F464F525F54454D504C41544553';
wwv_flow_api.g_varchar2_table(131) := '7C7C21312C7A653D2131213D3D652E534146455F464F525F584D4C2C50653D652E57484F4C455F444F43554D454E547C7C21312C42653D652E52455455524E5F444F4D7C7C21312C57653D652E52455455524E5F444F4D5F465241474D454E547C7C2131';
wwv_flow_api.g_varchar2_table(132) := '2C47653D652E52455455524E5F545255535445445F545950457C7C21312C46653D652E464F5243455F424F44597C7C21312C59653D2131213D3D652E53414E4954495A455F444F4D2C6A653D652E53414E4954495A455F4E414D45445F50524F50537C7C';
wwv_flow_api.g_varchar2_table(133) := '21312C71653D2131213D3D652E4B4545505F434F4E54454E542C24653D652E494E5F504C4143457C7C21312C4E653D652E414C4C4F5745445F5552495F5245474558507C7C582C69743D652E4E414D4553504143457C7C72742C73743D652E4D4154484D';
wwv_flow_api.g_varchar2_table(134) := '4C5F544558545F494E544547524154494F4E5F504F494E54537C7C73742C75743D652E48544D4C5F494E544547524154494F4E5F504F494E54537C7C75742C4C653D652E435553544F4D5F454C454D454E545F48414E444C494E477C7C7B7D2C652E4355';
wwv_flow_api.g_varchar2_table(135) := '53544F4D5F454C454D454E545F48414E444C494E472626797428652E435553544F4D5F454C454D454E545F48414E444C494E472E7461674E616D65436865636B292626284C652E7461674E616D65436865636B3D652E435553544F4D5F454C454D454E54';
wwv_flow_api.g_varchar2_table(136) := '5F48414E444C494E472E7461674E616D65436865636B292C652E435553544F4D5F454C454D454E545F48414E444C494E472626797428652E435553544F4D5F454C454D454E545F48414E444C494E472E6174747269627574654E616D65436865636B2926';
wwv_flow_api.g_varchar2_table(137) := '26284C652E6174747269627574654E616D65436865636B3D652E435553544F4D5F454C454D454E545F48414E444C494E472E6174747269627574654E616D65436865636B292C652E435553544F4D5F454C454D454E545F48414E444C494E47262622626F';
wwv_flow_api.g_varchar2_table(138) := '6F6C65616E223D3D747970656F6620652E435553544F4D5F454C454D454E545F48414E444C494E472E616C6C6F77437573746F6D697A65644275696C74496E456C656D656E74732626284C652E616C6C6F77437573746F6D697A65644275696C74496E45';
wwv_flow_api.g_varchar2_table(139) := '6C656D656E74733D652E435553544F4D5F454C454D454E545F48414E444C494E472E616C6C6F77437573746F6D697A65644275696C74496E456C656D656E7473292C55652626284D653D2131292C576526262842653D2130292C4B6526262852653D7728';
wwv_flow_api.g_varchar2_table(140) := '7B7D2C55292C4F653D5B5D2C21303D3D3D4B652E68746D6C262628772852652C76292C77284F652C7A29292C21303D3D3D4B652E737667262628772852652C43292C77284F652C50292C77284F652C4629292C21303D3D3D4B652E73766746696C746572';
wwv_flow_api.g_varchar2_table(141) := '73262628772852652C78292C77284F652C50292C77284F652C4629292C21303D3D3D4B652E6D6174684D6C262628772852652C6B292C77284F652C48292C77284F652C462929292C652E4144445F5441475326262852653D3D3D776526262852653D4428';
wwv_flow_api.g_varchar2_table(142) := '526529292C772852652C652E4144445F544147532C687429292C652E4144445F415454522626284F653D3D3D44652626284F653D44284F6529292C77284F652C652E4144445F415454522C687429292C652E4144445F5552495F534146455F4154545226';
wwv_flow_api.g_varchar2_table(143) := '26772865742C652E4144445F5552495F534146455F415454522C6874292C652E464F524249445F434F4E54454E545326262856653D3D3D5A6526262856653D4428566529292C772856652C652E464F524249445F434F4E54454E54532C687429292C7165';
wwv_flow_api.g_varchar2_table(144) := '26262852655B222374657874225D3D2130292C50652626772852652C5B2268746D6C222C2268656164222C22626F6479225D292C52652E7461626C65262628772852652C5B2274626F6479225D292C64656C6574652076652E74626F6479292C652E5452';
wwv_flow_api.g_varchar2_table(145) := '55535445445F54595045535F504F4C494359297B6966282266756E6374696F6E22213D747970656F6620652E545255535445445F54595045535F504F4C4943592E63726561746548544D4C297468726F7720622827545255535445445F54595045535F50';
wwv_flow_api.g_varchar2_table(146) := '4F4C49435920636F6E66696775726174696F6E206F7074696F6E206D7573742070726F766964652061202263726561746548544D4C2220686F6F6B2E27293B6966282266756E6374696F6E22213D747970656F6620652E545255535445445F5459504553';
wwv_flow_api.g_varchar2_table(147) := '5F504F4C4943592E63726561746553637269707455524C297468726F7720622827545255535445445F54595045535F504F4C49435920636F6E66696775726174696F6E206F7074696F6E206D7573742070726F7669646520612022637265617465536372';
wwv_flow_api.g_varchar2_table(148) := '69707455524C2220686F6F6B2E27293B63653D652E545255535445445F54595045535F504F4C4943592C73653D63652E63726561746548544D4C282222297D656C736520766F696420303D3D3D636526262863653D7265286A2C6329292C6E756C6C213D';
wwv_flow_api.g_varchar2_table(149) := '3D6365262622737472696E67223D3D747970656F6620736526262873653D63652E63726561746548544D4C28222229293B692626692865292C67743D657D7D2C41743D77287B7D2C5B2E2E2E432C2E2E2E782C2E2E2E4D5D292C5F743D77287B7D2C5B2E';
wwv_flow_api.g_varchar2_table(150) := '2E2E6B2C2E2E2E495D292C53743D66756E6374696F6E2865297B6C657420743D6C652865293B742626742E7461674E616D657C7C28743D7B6E616D6573706163655552493A69742C7461674E616D653A2274656D706C617465227D293B636F6E7374206E';
wwv_flow_api.g_varchar2_table(151) := '3D6828652E7461674E616D65292C6F3D6828742E7461674E616D65293B72657475726E21216C745B652E6E616D6573706163655552495D262628652E6E616D6573706163655552493D3D3D6F743F742E6E616D6573706163655552493D3D3D72743F2273';
wwv_flow_api.g_varchar2_table(152) := '7667223D3D3D6E3A742E6E616D6573706163655552493D3D3D6E743F22737667223D3D3D6E26262822616E6E6F746174696F6E2D786D6C223D3D3D6F7C7C73745B6F5D293A426F6F6C65616E2841745B6E5D293A652E6E616D6573706163655552493D3D';
wwv_flow_api.g_varchar2_table(153) := '3D6E743F742E6E616D6573706163655552493D3D3D72743F226D617468223D3D3D6E3A742E6E616D6573706163655552493D3D3D6F743F226D617468223D3D3D6E262675745B6F5D3A426F6F6C65616E285F745B6E5D293A652E6E616D65737061636555';
wwv_flow_api.g_varchar2_table(154) := '52493D3D3D72743F2128742E6E616D6573706163655552493D3D3D6F7426262175745B6F5D292626282128742E6E616D6573706163655552493D3D3D6E7426262173745B6F5D29262628215F745B6E5D2626286D745B6E5D7C7C2141745B6E5D2929293A';
wwv_flow_api.g_varchar2_table(155) := '2128226170706C69636174696F6E2F7868746D6C2B786D6C22213D3D70747C7C216C745B652E6E616D6573706163655552495D29297D2C62743D66756E6374696F6E2865297B66286F2E72656D6F7665642C7B656C656D656E743A657D293B7472797B6C';
wwv_flow_api.g_varchar2_table(156) := '652865292E72656D6F76654368696C642865297D63617463682874297B562865297D7D2C4E743D66756E6374696F6E28652C74297B7472797B66286F2E72656D6F7665642C7B6174747269627574653A742E6765744174747269627574654E6F64652865';
wwv_flow_api.g_varchar2_table(157) := '292C66726F6D3A747D297D63617463682865297B66286F2E72656D6F7665642C7B6174747269627574653A6E756C6C2C66726F6D3A747D297D696628742E72656D6F76654174747269627574652865292C226973223D3D3D652969662842657C7C576529';
wwv_flow_api.g_varchar2_table(158) := '7472797B62742874297D63617463682865297B7D656C7365207472797B742E73657441747472696275746528652C2222297D63617463682865297B7D7D2C52743D66756E6374696F6E2865297B6C657420743D6E756C6C2C6E3D6E756C6C3B6966284665';
wwv_flow_api.g_varchar2_table(159) := '29653D223C72656D6F76653E3C2F72656D6F76653E222B653B656C73657B636F6E737420743D5428652C2F5E5B5C725C6E5C74205D2B2F293B6E3D742626745B305D7D226170706C69636174696F6E2F7868746D6C2B786D6C223D3D3D7074262669743D';
wwv_flow_api.g_varchar2_table(160) := '3D3D7274262628653D273C68746D6C20786D6C6E733D22687474703A2F2F7777772E77332E6F72672F313939392F7868746D6C223E3C686561643E3C2F686561643E3C626F64793E272B652B223C2F626F64793E3C2F68746D6C3E22293B636F6E737420';
wwv_flow_api.g_varchar2_table(161) := '6F3D63653F63652E63726561746548544D4C2865293A653B69662869743D3D3D7274297472797B743D286E65772059292E706172736546726F6D537472696E67286F2C7074297D63617463682865297B7D69662821747C7C21742E646F63756D656E7445';
wwv_flow_api.g_varchar2_table(162) := '6C656D656E74297B743D75652E637265617465446F63756D656E742869742C2274656D706C617465222C6E756C6C293B7472797B742E646F63756D656E74456C656D656E742E696E6E657248544D4C3D61743F73653A6F7D63617463682865297B7D7D63';
wwv_flow_api.g_varchar2_table(163) := '6F6E737420693D742E626F64797C7C742E646F63756D656E74456C656D656E743B72657475726E206526266E2626692E696E736572744265666F726528722E637265617465546578744E6F6465286E292C692E6368696C644E6F6465735B305D7C7C6E75';
wwv_flow_api.g_varchar2_table(164) := '6C6C292C69743D3D3D72743F66652E63616C6C28742C50653F2268746D6C223A22626F647922295B305D3A50653F742E646F63756D656E74456C656D656E743A697D2C77743D66756E6374696F6E2865297B72657475726E206D652E63616C6C28652E6F';
wwv_flow_api.g_varchar2_table(165) := '776E6572446F63756D656E747C7C652C652C422E53484F575F454C454D454E547C422E53484F575F434F4D4D454E547C422E53484F575F544558547C422E53484F575F50524F43455353494E475F494E535452554354494F4E7C422E53484F575F434441';
wwv_flow_api.g_varchar2_table(166) := '54415F53454354494F4E2C6E756C6C297D2C4F743D66756E6374696F6E2865297B72657475726E206520696E7374616E63656F66204726262822737472696E6722213D747970656F6620652E6E6F64654E616D657C7C22737472696E6722213D74797065';
wwv_flow_api.g_varchar2_table(167) := '6F6620652E74657874436F6E74656E747C7C2266756E6374696F6E22213D747970656F6620652E72656D6F76654368696C647C7C2128652E6174747269627574657320696E7374616E63656F662057297C7C2266756E6374696F6E22213D747970656F66';
wwv_flow_api.g_varchar2_table(168) := '20652E72656D6F76654174747269627574657C7C2266756E6374696F6E22213D747970656F6620652E7365744174747269627574657C7C22737472696E6722213D747970656F6620652E6E616D6573706163655552497C7C2266756E6374696F6E22213D';
wwv_flow_api.g_varchar2_table(169) := '747970656F6620652E696E736572744265666F72657C7C2266756E6374696F6E22213D747970656F6620652E6861734368696C644E6F646573297D2C44743D66756E6374696F6E2865297B72657475726E2266756E6374696F6E223D3D747970656F6620';
wwv_flow_api.g_varchar2_table(170) := '5226266520696E7374616E63656F6620527D3B66756E6374696F6E204C7428652C742C6E297B7528652C28653D3E7B652E63616C6C286F2C742C6E2C6774297D29297D636F6E73742076743D66756E6374696F6E2865297B6C657420743D6E756C6C3B69';
wwv_flow_api.g_varchar2_table(171) := '66284C742868652E6265666F726553616E6974697A65456C656D656E74732C652C6E756C6C292C4F742865292972657475726E2062742865292C21303B636F6E7374206E3D687428652E6E6F64654E616D65293B6966284C742868652E75706F6E53616E';
wwv_flow_api.g_varchar2_table(172) := '6974697A65456C656D656E742C652C7B7461674E616D653A6E2C616C6C6F776564546167733A52657D292C652E6861734368696C644E6F6465732829262621447428652E6669727374456C656D656E744368696C6429262653282F3C5B2F5C775D2F672C';
wwv_flow_api.g_varchar2_table(173) := '652E696E6E657248544D4C29262653282F3C5B2F5C775D2F672C652E74657874436F6E74656E74292972657475726E2062742865292C21303B696628652E6E6F6465547970653D3D3D65652972657475726E2062742865292C21303B6966287A65262665';
wwv_flow_api.g_varchar2_table(174) := '2E6E6F6465547970653D3D3D7465262653282F3C5B2F5C775D2F672C652E64617461292972657475726E2062742865292C21303B6966282152655B6E5D7C7C76655B6E5D297B6966282176655B6E5D26267874286E29297B6966284C652E7461674E616D';
wwv_flow_api.g_varchar2_table(175) := '65436865636B20696E7374616E63656F6620526567457870262653284C652E7461674E616D65436865636B2C6E292972657475726E21313B6966284C652E7461674E616D65436865636B20696E7374616E63656F662046756E6374696F6E26264C652E74';
wwv_flow_api.g_varchar2_table(176) := '61674E616D65436865636B286E292972657475726E21317D696628716526262156655B6E5D297B636F6E737420743D6C652865297C7C652E706172656E744E6F64652C6E3D61652865297C7C652E6368696C644E6F6465733B6966286E262674297B666F';
wwv_flow_api.g_varchar2_table(177) := '72286C6574206F3D6E2E6C656E6774682D313B6F3E3D303B2D2D6F297B636F6E737420723D24286E5B6F5D2C2130293B722E5F5F72656D6F76616C436F756E743D28652E5F5F72656D6F76616C436F756E747C7C30292B312C742E696E73657274426566';
wwv_flow_api.g_varchar2_table(178) := '6F726528722C6965286529297D7D7D72657475726E2062742865292C21307D72657475726E206520696E7374616E63656F66204F26262153742865293F2862742865292C2130293A226E6F73637269707422213D3D6E2626226E6F656D62656422213D3D';
wwv_flow_api.g_varchar2_table(179) := '6E2626226E6F6672616D657322213D3D6E7C7C2153282F3C5C2F6E6F287363726970747C656D6265647C6672616D6573292F692C652E696E6E657248544D4C293F2855652626652E6E6F6465547970653D3D3D51262628743D652E74657874436F6E7465';
wwv_flow_api.g_varchar2_table(180) := '6E742C75285B67652C54652C79655D2C28653D3E7B743D7928742C652C222022297D29292C652E74657874436F6E74656E74213D3D7426262866286F2E72656D6F7665642C7B656C656D656E743A652E636C6F6E654E6F646528297D292C652E74657874';
wwv_flow_api.g_varchar2_table(181) := '436F6E74656E743D7429292C4C742868652E616674657253616E6974697A65456C656D656E74732C652C6E756C6C292C2131293A2862742865292C2130297D2C43743D66756E6374696F6E28652C742C6E297B6966285965262628226964223D3D3D747C';
wwv_flow_api.g_varchar2_table(182) := '7C226E616D65223D3D3D74292626286E20696E20727C7C6E20696E205474292972657475726E21313B6966284D6526262143655B745D2626532845652C7429293B656C73652069662878652626532841652C7429293B656C736520696628214F655B745D';
wwv_flow_api.g_varchar2_table(183) := '7C7C43655B745D297B696628212878742865292626284C652E7461674E616D65436865636B20696E7374616E63656F6620526567457870262653284C652E7461674E616D65436865636B2C65297C7C4C652E7461674E616D65436865636B20696E737461';
wwv_flow_api.g_varchar2_table(184) := '6E63656F662046756E6374696F6E26264C652E7461674E616D65436865636B286529292626284C652E6174747269627574654E616D65436865636B20696E7374616E63656F6620526567457870262653284C652E6174747269627574654E616D65436865';
wwv_flow_api.g_varchar2_table(185) := '636B2C74297C7C4C652E6174747269627574654E616D65436865636B20696E7374616E63656F662046756E6374696F6E26264C652E6174747269627574654E616D65436865636B287429297C7C226973223D3D3D7426264C652E616C6C6F77437573746F';
wwv_flow_api.g_varchar2_table(186) := '6D697A65644275696C74496E456C656D656E74732626284C652E7461674E616D65436865636B20696E7374616E63656F6620526567457870262653284C652E7461674E616D65436865636B2C6E297C7C4C652E7461674E616D65436865636B20696E7374';
wwv_flow_api.g_varchar2_table(187) := '616E63656F662046756E6374696F6E26264C652E7461674E616D65436865636B286E2929292972657475726E21317D656C73652069662865745B745D293B656C73652069662853284E652C79286E2C53652C22222929293B656C73652069662822737263';
wwv_flow_api.g_varchar2_table(188) := '22213D3D74262622786C696E6B3A6872656622213D3D742626226872656622213D3D747C7C22736372697074223D3D3D657C7C30213D3D45286E2C22646174613A22297C7C214A655B655D297B6966286B6526262153285F652C79286E2C53652C222229';
wwv_flow_api.g_varchar2_table(189) := '29293B656C7365206966286E2972657475726E21317D656C73653B72657475726E21307D2C78743D66756E6374696F6E2865297B72657475726E22616E6E6F746174696F6E2D786D6C22213D3D6526265428652C6265297D2C4D743D66756E6374696F6E';
wwv_flow_api.g_varchar2_table(190) := '2865297B4C742868652E6265666F726553616E6974697A65417474726962757465732C652C6E756C6C293B636F6E73747B617474726962757465733A747D3D653B69662821747C7C4F742865292972657475726E3B636F6E7374206E3D7B617474724E61';
wwv_flow_api.g_varchar2_table(191) := '6D653A22222C6174747256616C75653A22222C6B656570417474723A21302C616C6C6F776564417474726962757465733A4F652C666F7263654B656570417474723A766F696420307D3B6C657420723D742E6C656E6774683B666F72283B722D2D3B297B';
wwv_flow_api.g_varchar2_table(192) := '636F6E737420693D745B725D2C7B6E616D653A612C6E616D6573706163655552493A6C2C76616C75653A637D3D692C733D68742861293B6C6574206D3D2276616C7565223D3D3D613F633A412863293B6966286E2E617474724E616D653D732C6E2E6174';
wwv_flow_api.g_varchar2_table(193) := '747256616C75653D6D2C6E2E6B656570417474723D21302C6E2E666F7263654B656570417474723D766F696420302C4C742868652E75706F6E53616E6974697A654174747269627574652C652C6E292C6D3D6E2E6174747256616C75652C216A657C7C22';
wwv_flow_api.g_varchar2_table(194) := '696422213D3D732626226E616D6522213D3D737C7C284E7428612C65292C6D3D58652B6D292C7A65262653282F28282D2D213F7C5D293E297C3C5C2F287374796C657C7469746C65292F692C6D29297B4E7428612C65293B636F6E74696E75657D696628';
wwv_flow_api.g_varchar2_table(195) := '6E2E666F7263654B6565704174747229636F6E74696E75653B6966284E7428612C65292C216E2E6B6565704174747229636F6E74696E75653B696628214965262653282F5C2F3E2F692C6D29297B4E7428612C65293B636F6E74696E75657D5565262675';
wwv_flow_api.g_varchar2_table(196) := '285B67652C54652C79655D2C28653D3E7B6D3D79286D2C652C222022297D29293B636F6E737420663D687428652E6E6F64654E616D65293B696628437428662C732C6D29297B69662863652626226F626A656374223D3D747970656F66206A2626226675';
wwv_flow_api.g_varchar2_table(197) := '6E6374696F6E223D3D747970656F66206A2E67657441747472696275746554797065296966286C293B656C736520737769746368286A2E6765744174747269627574655479706528662C7329297B63617365225472757374656448544D4C223A6D3D6365';
wwv_flow_api.g_varchar2_table(198) := '2E63726561746548544D4C286D293B627265616B3B63617365225472757374656453637269707455524C223A6D3D63652E63726561746553637269707455524C286D297D7472797B6C3F652E7365744174747269627574654E53286C2C612C6D293A652E';
wwv_flow_api.g_varchar2_table(199) := '73657441747472696275746528612C6D292C4F742865293F62742865293A70286F2E72656D6F766564297D63617463682865297B7D7D7D4C742868652E616674657253616E6974697A65417474726962757465732C652C6E756C6C297D2C6B743D66756E';
wwv_flow_api.g_varchar2_table(200) := '6374696F6E20652874297B6C6574206E3D6E756C6C3B636F6E7374206F3D77742874293B666F72284C742868652E6265666F726553616E6974697A65536861646F77444F4D2C742C6E756C6C293B6E3D6F2E6E6578744E6F646528293B294C742868652E';
wwv_flow_api.g_varchar2_table(201) := '75706F6E53616E6974697A65536861646F774E6F64652C6E2C6E756C6C292C7674286E292C4D74286E292C6E2E636F6E74656E7420696E7374616E63656F662073262665286E2E636F6E74656E74293B4C742868652E616674657253616E6974697A6553';
wwv_flow_api.g_varchar2_table(202) := '6861646F77444F4D2C742C6E756C6C297D3B72657475726E206F2E73616E6974697A653D66756E6374696F6E2865297B6C657420743D617267756D656E74732E6C656E6774683E312626766F69642030213D3D617267756D656E74735B315D3F61726775';
wwv_flow_api.g_varchar2_table(203) := '6D656E74735B315D3A7B7D2C6E3D6E756C6C2C723D6E756C6C2C693D6E756C6C2C6C3D6E756C6C3B69662861743D21652C6174262628653D225C783363212D2D5C78336522292C22737472696E6722213D747970656F6620652626214474286529297B69';
wwv_flow_api.g_varchar2_table(204) := '66282266756E6374696F6E22213D747970656F6620652E746F537472696E67297468726F7720622822746F537472696E67206973206E6F7420612066756E6374696F6E22293B69662822737472696E6722213D747970656F6628653D652E746F53747269';
wwv_flow_api.g_varchar2_table(205) := '6E67282929297468726F77206228226469727479206973206E6F74206120737472696E672C2061626F7274696E6722297D696628216F2E6973537570706F727465642972657475726E20653B69662848657C7C45742874292C6F2E72656D6F7665643D5B';
wwv_flow_api.g_varchar2_table(206) := '5D2C22737472696E67223D3D747970656F66206526262824653D2131292C2465297B696628652E6E6F64654E616D65297B636F6E737420743D687428652E6E6F64654E616D65293B6966282152655B745D7C7C76655B745D297468726F7720622822726F';
wwv_flow_api.g_varchar2_table(207) := '6F74206E6F646520697320666F7262696464656E20616E642063616E6E6F742062652073616E6974697A656420696E2D706C61636522297D7D656C7365206966286520696E7374616E63656F662052296E3D527428225C783363212D2D2D2D5C78336522';
wwv_flow_api.g_varchar2_table(208) := '292C723D6E2E6F776E6572446F63756D656E742E696D706F72744E6F646528652C2130292C722E6E6F6465547970653D3D3D4A262622424F4459223D3D3D722E6E6F64654E616D657C7C2248544D4C223D3D3D722E6E6F64654E616D653F6E3D723A6E2E';
wwv_flow_api.g_varchar2_table(209) := '617070656E644368696C642872293B656C73657B6966282142652626215565262621506526262D313D3D3D652E696E6465784F6628223C22292972657475726E206365262647653F63652E63726561746548544D4C2865293A653B6966286E3D52742865';
wwv_flow_api.g_varchar2_table(210) := '292C216E2972657475726E2042653F6E756C6C3A47653F73653A22227D6E2626466526266274286E2E66697273744368696C64293B636F6E737420633D77742824653F653A6E293B666F72283B693D632E6E6578744E6F646528293B2976742869292C4D';
wwv_flow_api.g_varchar2_table(211) := '742869292C692E636F6E74656E7420696E7374616E63656F66207326266B7428692E636F6E74656E74293B69662824652972657475726E20653B6966284265297B696628576529666F72286C3D70652E63616C6C286E2E6F776E6572446F63756D656E74';
wwv_flow_api.g_varchar2_table(212) := '293B6E2E66697273744368696C643B296C2E617070656E644368696C64286E2E66697273744368696C64293B656C7365206C3D6E3B72657475726E284F652E736861646F77726F6F747C7C4F652E736861646F77726F6F746D6F6465292626286C3D6465';
wwv_flow_api.g_varchar2_table(213) := '2E63616C6C28612C6C2C213029292C6C7D6C6574206D3D50653F6E2E6F7574657248544D4C3A6E2E696E6E657248544D4C3B72657475726E205065262652655B2221646F6374797065225D26266E2E6F776E6572446F63756D656E7426266E2E6F776E65';
wwv_flow_api.g_varchar2_table(214) := '72446F63756D656E742E646F637479706526266E2E6F776E6572446F63756D656E742E646F63747970652E6E616D65262653284B2C6E2E6F776E6572446F63756D656E742E646F63747970652E6E616D65292626286D3D223C21444F435459504520222B';
wwv_flow_api.g_varchar2_table(215) := '6E2E6F776E6572446F63756D656E742E646F63747970652E6E616D652B223E5C6E222B6D292C5565262675285B67652C54652C79655D2C28653D3E7B6D3D79286D2C652C222022297D29292C6365262647653F63652E63726561746548544D4C286D293A';
wwv_flow_api.g_varchar2_table(216) := '6D7D2C6F2E736574436F6E6669673D66756E6374696F6E28297B6C657420653D617267756D656E74732E6C656E6774683E302626766F69642030213D3D617267756D656E74735B305D3F617267756D656E74735B305D3A7B7D3B45742865292C48653D21';
wwv_flow_api.g_varchar2_table(217) := '307D2C6F2E636C656172436F6E6669673D66756E6374696F6E28297B67743D6E756C6C2C48653D21317D2C6F2E697356616C69644174747269627574653D66756E6374696F6E28652C742C6E297B67747C7C4574287B7D293B636F6E7374206F3D687428';
wwv_flow_api.g_varchar2_table(218) := '65292C723D68742874293B72657475726E204374286F2C722C6E297D2C6F2E616464486F6F6B3D66756E6374696F6E28652C74297B2266756E6374696F6E223D3D747970656F6620742626662868655B655D2C74297D2C6F2E72656D6F7665486F6F6B3D';
wwv_flow_api.g_varchar2_table(219) := '66756E6374696F6E28652C74297B696628766F69642030213D3D74297B636F6E7374206E3D6D2868655B655D2C74293B72657475726E2D313D3D3D6E3F766F696420303A642868655B655D2C6E2C31295B305D7D72657475726E20702868655B655D297D';
wwv_flow_api.g_varchar2_table(220) := '2C6F2E72656D6F7665486F6F6B733D66756E6374696F6E2865297B68655B655D3D5B5D7D2C6F2E72656D6F7665416C6C486F6F6B733D66756E6374696F6E28297B68653D7B616674657253616E6974697A65417474726962757465733A5B5D2C61667465';
wwv_flow_api.g_varchar2_table(221) := '7253616E6974697A65456C656D656E74733A5B5D2C616674657253616E6974697A65536861646F77444F4D3A5B5D2C6265666F726553616E6974697A65417474726962757465733A5B5D2C6265666F726553616E6974697A65456C656D656E74733A5B5D';
wwv_flow_api.g_varchar2_table(222) := '2C6265666F726553616E6974697A65536861646F77444F4D3A5B5D2C75706F6E53616E6974697A654174747269627574653A5B5D2C75706F6E53616E6974697A65456C656D656E743A5B5D2C75706F6E53616E6974697A65536861646F774E6F64653A5B';
wwv_flow_api.g_varchar2_table(223) := '5D7D7D2C6F7D28297D29293B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(79124632001204101)
,p_plugin_id=>wwv_flow_api.id(138285470529447569213)
,p_file_name=>'purify.min.js'
,p_mime_type=>'text/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '636F6E7374206E6F74696669636174696F6E4D656E753D66756E6374696F6E28297B2275736520737472696374223B636F6E737420743D7B6665617475726544657461696C733A7B6E616D653A2241504558204E6F74696669636174696F6E204D656E75';
wwv_flow_api.g_varchar2_table(2) := '222C73637269707456657273696F6E3A2232352E30332E3137222C7574696C56657273696F6E3A2232352E30332E3137222C75726C3A2268747470733A2F2F6769746875622E636F6D2F526F6E6E795765697373222C6C6963656E73653A224D4954227D';
wwv_flow_api.g_varchar2_table(3) := '2C65736361706548544D4C3A66756E6374696F6E2865297B6966286E756C6C3D3D3D652972657475726E206E756C6C3B696628766F69642030213D3D65297B696628226F626A656374223D3D747970656F662065297472797B653D4A534F4E2E73747269';
wwv_flow_api.g_varchar2_table(4) := '6E676966792865297D63617463682865297B7D72657475726E20617065782E7574696C2E65736361706548544D4C28537472696E67286529297D7D2C6A736F6E53617665457874656E643A66756E6374696F6E28652C74297B6C657420613D7B7D2C693D';
wwv_flow_api.g_varchar2_table(5) := '7B7D3B69662822737472696E67223D3D747970656F662074297472797B693D4A534F4E2E70617273652874297D63617463682865297B617065782E64656275672E6572726F72287B6D6F64756C653A227574696C2E6A73222C6D73673A224572726F7220';
wwv_flow_api.g_varchar2_table(6) := '7768696C652074727920746F20706172736520746172676574436F6E6669672E20506C6561736520636865636B20796F757220436F6E666967204A534F4E2E205374616E6461726420436F6E6669672077696C6C20626520757365642E222C6572723A65';
wwv_flow_api.g_varchar2_table(7) := '2C746172676574436F6E6669673A747D297D656C736520693D242E657874656E642821302C7B7D2C74293B7472797B613D242E657874656E642821302C7B7D2C652C69297D63617463682874297B613D242E657874656E642821302C7B7D2C65292C6170';
wwv_flow_api.g_varchar2_table(8) := '65782E64656275672E6572726F72287B6D6F64756C653A227574696C2E6A73222C6D73673A224572726F72207768696C652074727920746F206D657267652032204A534F4E7320696E746F207374616E64617264204A534F4E20696620616E7920617474';
wwv_flow_api.g_varchar2_table(9) := '726962757465206973206D697373696E672E20506C6561736520636865636B20796F757220436F6E666967204A534F4E2E205374616E6461726420436F6E6669672077696C6C20626520757365642E222C6572723A742C66696E616C436F6E6669673A61';
wwv_flow_api.g_varchar2_table(10) := '7D297D72657475726E20617D2C6C696E6B3A66756E6374696F6E28652C743D225F706172656E7422297B5B225F706172656E74222C225F73656C66225D2E696E636C756465732874293F617065782E6E617669676174696F6E2E72656469726563742865';
wwv_flow_api.g_varchar2_table(11) := '293A6E756C6C213D6526262222213D3D65262677696E646F772E6F70656E28652C74297D2C637574537472696E673A66756E6374696F6E28652C74297B7472797B72657475726E20743C303F653A652E6C656E6774683E743F652E737562737472696E67';
wwv_flow_api.g_varchar2_table(12) := '28302C742D33292B222E2E2E223A657D63617463682874297B72657475726E20657D7D2C72656D6F766548544D4C3A66756E6374696F6E2865297B72657475726E20617065782626617065782E7574696C2626617065782E7574696C2E73747269704854';
wwv_flow_api.g_varchar2_table(13) := '4D4C3F617065782E7574696C2E737472697048544D4C2865293A2428223C6469762F3E22292E68746D6C2865292E7465787428297D7D3B72657475726E7B696E697469616C697A653A66756E6374696F6E28612C692C722C6E2C6F2C732C6C297B766172';
wwv_flow_api.g_varchar2_table(14) := '20633B617065782E64656275672E696E666F287B6663743A742E6665617475726544657461696C732E6E616D652B22202D20696E697469616C697A65222C617267756D656E74733A7B656C656D656E7449443A612C616A617849443A692C7564436F6E66';
wwv_flow_api.g_varchar2_table(15) := '69674A534F4E3A722C6974656D73325375626D69743A6E2C65736361706552657175697265643A6F2C73616E6974697A653A732C73616E6974697A65724F7074696F6E733A6C7D2C6665617475726544657461696C733A742E6665617475726544657461';
wwv_flow_api.g_varchar2_table(16) := '696C737D293B76617220642C753D302C663D7B414C4C4F5745445F415454523A5B226163636573736B6579222C22616C69676E222C22616C74222C22616C77617973222C226175746F636F6D706C657465222C226175746F706C6179222C22626F726465';
wwv_flow_api.g_varchar2_table(17) := '72222C2263656C6C70616464696E67222C2263656C6C73706163696E67222C2263686172736574222C22636C617373222C22636F6C7370616E222C22646972222C22686569676874222C2268726566222C226964222C226C616E67222C226E616D65222C';
wwv_flow_api.g_varchar2_table(18) := '2272656C222C227265717569726564222C22726F777370616E222C22737263222C227374796C65222C2273756D6D617279222C22746162696E646578222C22746172676574222C227469746C65222C2274797065222C2276616C7565222C227769647468';
wwv_flow_api.g_varchar2_table(19) := '225D2C414C4C4F5745445F544147533A5B2261222C2261646472657373222C2262222C22626C6F636B71756F7465222C226272222C2263617074696F6E222C22636F6465222C226464222C22646976222C22646C222C226474222C22656D222C22666967';
wwv_flow_api.g_varchar2_table(20) := '63617074696F6E222C22666967757265222C226831222C226832222C226833222C226834222C226835222C226836222C226872222C2269222C22696D67222C226C6162656C222C226C69222C226E6C222C226F6C222C2270222C22707265222C2273222C';
wwv_flow_api.g_varchar2_table(21) := '227370616E222C22737472696B65222C227374726F6E67222C22737562222C22737570222C227461626C65222C2274626F6479222C227464222C227468222C227468656164222C227472222C2275222C22756C225D7D3B2131213D3D73262628643D6C3F';
wwv_flow_api.g_varchar2_table(22) := '742E6A736F6E53617665457874656E6428662C6C293A66293B76617220673D7B7D3B673D742E6A736F6E53617665457874656E64287B726566726573683A302C6D61696E49636F6E3A2266612D62656C6C222C6D61696E49636F6E436F6C6F723A227768';
wwv_flow_api.g_varchar2_table(23) := '697465222C6D61696E49636F6E4261636B67726F756E64436F6C6F723A22726762612837302C37302C37302C302E3929222C6D61696E49636F6E426C696E6B696E673A21312C636F756E7465724261636B67726F756E64436F6C6F723A22726762283233';
wwv_flow_api.g_varchar2_table(24) := '322C2035352C2035352029222C636F756E746572466F6E74436F6C6F723A227768697465222C6C696E6B546172676574426C616E6B3A21312C73686F77416C776179733A21312C62726F777365724E6F74696669636174696F6E733A7B656E61626C6564';
wwv_flow_api.g_varchar2_table(25) := '3A21302C637574426F64795465787441667465723A3130302C6C696E6B3A21317D2C6163636570743A7B636F6C6F723A2223343465353563222C69636F6E3A2266612D636865636B227D2C6465636C696E653A7B636F6C6F723A2223623733613231222C';
wwv_flow_api.g_varchar2_table(26) := '69636F6E3A2266612D636C6F7365227D2C686964654F6E526566726573683A21307D2C72293B76617220703D66756E6374696F6E2865297B76617220743D2428223C6C693E3C2F6C693E22293B742E616464436C6173732822742D4E617669676174696F';
wwv_flow_api.g_varchar2_table(27) := '6E4261722D6974656D22293B76617220613D2428223C6469763E3C2F6469763E22293B72657475726E20612E6174747228226964222C65292C612E62696E6428226170657872656672657368222C2866756E6374696F6E28297B303D3D702E6368696C64';
wwv_flow_api.g_varchar2_table(28) := '72656E28227370616E22292E6C656E67746826264F2845297D29292C742E617070656E642861292C2428222E742D4E617669676174696F6E42617222292E70726570656E642874292C617D2861293B696628672E62726F777365724E6F74696669636174';
wwv_flow_api.g_varchar2_table(29) := '696F6E732E656E61626C6564297472797B224E6F74696669636174696F6E22696E2077696E646F773F4E6F74696669636174696F6E2E726571756573745065726D697373696F6E28293A617065782E64656275672E6572726F72287B6663743A742E6665';
wwv_flow_api.g_varchar2_table(30) := '617475726544657461696C732E6E616D652B22202D20647261774C697374222C6D73673A22546869732062726F7773657220646F6573206E6F7420737570706F72742073797374656D206E6F74696669636174696F6E73222C6572723A652C6665617475';
wwv_flow_api.g_varchar2_table(31) := '726544657461696C733A742E6665617475726544657461696C737D297D63617463682865297B617065782E64656275672E6572726F72287B6663743A742E6665617475726544657461696C732E6E616D652B22202D20696E697469616C697A65222C6D73';
wwv_flow_api.g_varchar2_table(32) := '673A224572726F72207768696C652074727920746F20676574206E6F74696669636174696F6E207065726D697373696F6E222C6572723A652C6665617475726544657461696C733A742E6665617475726544657461696C737D297D66756E6374696F6E20';
wwv_flow_api.g_varchar2_table(33) := '4E2865297B72657475726E2131213D3D6F3F742E65736361706548544D4C2865293A2131213D3D733F444F4D5075726966792E73616E6974697A6528652C64293A657D66756E6374696F6E204F2865297B617065782E7365727665722E706C7567696E28';
wwv_flow_api.g_varchar2_table(34) := '692C7B706167654974656D733A6E7D2C7B737563636573733A66756E6374696F6E2861297B617065782E64656275672E696E666F287B6663743A742E6665617475726544657461696C732E6E616D652B22202D2067657444617461222C6D73673A22414A';
wwv_flow_api.g_varchar2_table(35) := '41582064617461207265636569766564222C70446174613A612C6665617475726544657461696C733A742E6665617475726544657461696C737D292C753D302C652861297D2C6572726F723A66756E6374696F6E2861297B696628303D3D3D75297B7661';
wwv_flow_api.g_varchar2_table(36) := '7220693D7B726F773A5B7B4E4F54455F49434F4E3A2266612D6578636C616D6174696F6E2D747269616E676C65222C4E4F54455F49434F4E5F434F4C4F523A2223464630303030222C4E4F54455F4845414445523A612E726573706F6E73654A534F4E26';
wwv_flow_api.g_varchar2_table(37) := '26612E726573706F6E73654A534F4E2E6572726F723F612E726573706F6E73654A534F4E2E6572726F723A224572726F72206F636375726564222C4E4F54455F544558543A6E756C6C2C4E4F54455F434F4C4F523A2223464630303030227D5D7D3B6528';
wwv_flow_api.g_varchar2_table(38) := '69292C617065782E64656275672E6572726F72287B6663743A742E6665617475726544657461696C732E6E616D652B22202D2067657444617461222C6D73673A22414A41582064617461206572726F72222C726573706F6E73653A612C66656174757265';
wwv_flow_api.g_varchar2_table(39) := '44657461696C733A742E6665617475726544657461696C737D297D752B2B7D2C64617461547970653A226A736F6E227D297D66756E6374696F6E20452865297B76617220693D2223222B612B225F746F67676C654E6F7465223B696628242869292E6869';
wwv_flow_api.g_varchar2_table(40) := '646528292C652E726F77297B76617220723D2223222B612B225F6E756D646976222C6E3D2223222B612B225F756C223B652E726F772E6C656E6774683E303F28242872292E63737328226261636B67726F756E64222C672E636F756E7465724261636B67';
wwv_flow_api.g_varchar2_table(41) := '726F756E64436F6C6F72292C242869292E73686F7728292C242872292E73686F7728292C242872292E7465787428652E726F772E6C656E677468292C24286E292E656D70747928292C66756E6374696F6E28652C69297B76617220722C6E3D21313B2428';
wwv_flow_api.g_varchar2_table(42) := '2223222B612B225F756C22292E6C656E6774683F28723D24282223222B612B225F756C22292C6E3D2130293A2828723D2428223C756C3E3C2F756C3E2229292E6174747228226964222C612B225F756C22292C722E616464436C61737328226E6F746966';
wwv_flow_api.g_varchar2_table(43) := '69636174696F6E7322292C722E616464436C6173732822746F67676C654C6973742229293B6E2626672E686964654F6E52656672657368262621313D3D3D242872292E686173436C6173732822746F67676C654C69737422292626242872292E61646443';
wwv_flow_api.g_varchar2_table(44) := '6C6173732822746F67676C654C69737422293B692E726F772626242E6561636828692E726F772C2866756E6374696F6E28652C61297B696628672E62726F777365724E6F74696669636174696F6E732E656E61626C6564262631213D612E4E4F5F42524F';
wwv_flow_api.g_varchar2_table(45) := '575345525F4E4F54494649434154494F4E297472797B76617220692C6E3B612E4E4F54455F484541444552262628693D742E72656D6F766548544D4C28612E4E4F54455F48454144455229292C612E4E4F54455F544558542626286E3D742E72656D6F76';
wwv_flow_api.g_varchar2_table(46) := '6548544D4C28612E4E4F54455F54455854292C6E3D742E637574537472696E67286E2C672E62726F777365724E6F74696669636174696F6E732E637574426F647954657874416674657229292C73657454696D656F7574282866756E6374696F6E28297B';
wwv_flow_api.g_varchar2_table(47) := '696628224E6F74696669636174696F6E22696E2077696E646F7729696628226772616E746564223D3D3D4E6F74696669636174696F6E2E7065726D697373696F6E297B76617220653D6E6577204E6F74696669636174696F6E28692C7B626F64793A6E2C';
wwv_flow_api.g_varchar2_table(48) := '72657175697265496E746572616374696F6E3A672E62726F777365724E6F74696669636174696F6E732E72657175697265496E746572616374696F6E7D293B672E62726F777365724E6F74696669636174696F6E732E6C696E6B2626612E4E4F54455F4C';
wwv_flow_api.g_varchar2_table(49) := '494E4B262628652E6F6E636C69636B3D66756E6374696F6E2865297B742E6C696E6B28612E4E4F54455F4C494E4B297D297D656C73652264656E69656422213D3D4E6F74696669636174696F6E2E7065726D697373696F6E26264E6F7469666963617469';
wwv_flow_api.g_varchar2_table(50) := '6F6E2E726571756573745065726D697373696F6E282866756E6374696F6E2865297B696628226772616E746564223D3D3D65297B76617220723D6E6577204E6F74696669636174696F6E28692C7B626F64793A6E2C72657175697265496E746572616374';
wwv_flow_api.g_varchar2_table(51) := '696F6E3A672E62726F777365724E6F74696669636174696F6E732E72657175697265496E746572616374696F6E7D293B672E62726F777365724E6F74696669636174696F6E732E6C696E6B2626612E4E4F54455F4C494E4B262628722E6F6E636C69636B';
wwv_flow_api.g_varchar2_table(52) := '3D66756E6374696F6E2865297B742E6C696E6B28612E4E4F54455F4C494E4B297D297D7D29293B656C736520617065782E64656275672E6572726F72287B6663743A742E6665617475726544657461696C732E6E616D652B22202D20647261774C697374';
wwv_flow_api.g_varchar2_table(53) := '222C6D73673A22546869732062726F7773657220646F6573206E6F7420737570706F72742073797374656D206E6F74696669636174696F6E73222C6665617475726544657461696C733A742E6665617475726544657461696C737D297D292C3135302A65';
wwv_flow_api.g_varchar2_table(54) := '297D63617463682865297B617065782E64656275672E6572726F72287B6663743A742E6665617475726544657461696C732E6E616D652B22202D20647261774C697374222C6D73673A224572726F72207768696C652074727920746F20676574206E6F74';
wwv_flow_api.g_varchar2_table(55) := '696669636174696F6E207065726D697373696F6E222C6572723A652C6665617475726544657461696C733A742E6665617475726544657461696C737D297D612E4E4F54455F484541444552262628612E4E4F54455F4845414445523D4E28612E4E4F5445';
wwv_flow_api.g_varchar2_table(56) := '5F48454144455229292C612E4E4F54455F49434F4E262628612E4E4F54455F49434F4E3D4E28612E4E4F54455F49434F4E29292C612E4E4F54455F49434F4E5F434F4C4F52262628612E4E4F54455F49434F4E5F434F4C4F523D4E28612E4E4F54455F49';
wwv_flow_api.g_varchar2_table(57) := '434F4E5F434F4C4F5229292C612E4E4F54455F54455854262628612E4E4F54455F544558543D4E28612E4E4F54455F5445585429293B766172206F3D2428223C613E3C2F613E22293B612E4E4F54455F4C494E4B2626286F2E6174747228226872656622';
wwv_flow_api.g_varchar2_table(58) := '2C612E4E4F54455F4C494E4B292C672E6C696E6B546172676574426C616E6B26266F2E617474722822746172676574222C225F626C616E6B22292C6F2E6F6E2822746F75636820636C69636B222C2866756E6374696F6E2865297B242872292E61646443';
wwv_flow_api.g_varchar2_table(59) := '6C6173732822746F67676C654C69737422297D2929293B76617220733D2428223C6C693E3C2F6C693E22293B696628732E616464436C61737328226E6F746522292C612E4E4F54455F434F4C4F522626732E6373732822626F782D736861646F77222C22';
wwv_flow_api.g_varchar2_table(60) := '2D35707820302030203020222B612E4E4F54455F434F4C4F52292C612E4E4F54455F4143434550547C7C612E4E4F54455F4445434C494E45297B696628732E637373282270616464696E672D7269676874222C223332707822292C612E4E4F54455F4143';
wwv_flow_api.g_varchar2_table(61) := '43455054297B766172206C3D2428223C613E3C2F613E22293B6C2E616464436C61737328226163636570742D6122292C6C2E61747472282268726566222C612E4E4F54455F414343455054293B76617220633D2428223C693E3C2F693E22293B632E6164';
wwv_flow_api.g_varchar2_table(62) := '64436C6173732822666122292C632E616464436C61737328672E6163636570742E69636F6E292C632E6373732822636F6C6F72222C672E6163636570742E636F6C6F72292C632E6373732822666F6E742D73697A65222C223230707822292C6C2E617070';
wwv_flow_api.g_varchar2_table(63) := '656E642863292C732E617070656E64286C297D696628612E4E4F54455F4445434C494E45297B76617220643D2428223C613E3C2F613E22293B642E616464436C61737328226465636C696E652D6122292C642E61747472282268726566222C612E4E4F54';
wwv_flow_api.g_varchar2_table(64) := '455F4445434C494E45292C612E4E4F54455F4143434550542626642E6373732822626F74746F6D222C223430707822293B76617220753D2428223C693E3C2F693E22293B752E616464436C6173732822666122292C752E616464436C61737328672E6465';
wwv_flow_api.g_varchar2_table(65) := '636C696E652E69636F6E292C752E6373732822636F6C6F72222C672E6465636C696E652E636F6C6F72292C752E6373732822666F6E742D73697A65222C223234707822292C642E617070656E642875292C732E617070656E642864297D7D76617220663D';
wwv_flow_api.g_varchar2_table(66) := '2428223C6469763E3C2F6469763E22293B662E616464436C61737328226E6F74652D68656164657222293B76617220703D2428223C693E3C2F693E22293B702E616464436C6173732822666122292C612E4E4F54455F49434F4E2626702E616464436C61';
wwv_flow_api.g_varchar2_table(67) := '737328612E4E4F54455F49434F4E292C612E4E4F54455F49434F4E5F434F4C4F522626702E6373732822636F6C6F72222C612E4E4F54455F49434F4E5F434F4C4F52292C702E616464436C617373282266612D6C6722292C662E617070656E642870292C';
wwv_flow_api.g_varchar2_table(68) := '612E4E4F54455F4845414445522626662E617070656E6428612E4E4F54455F484541444552292C732E617070656E642866293B766172204F3D2428223C7370616E3E3C2F7370616E3E22293B4F2E616464436C61737328226E6F74652D696E666F22292C';
wwv_flow_api.g_varchar2_table(69) := '612E4E4F54455F5445585426264F2E68746D6C28612E4E4F54455F54455854292C732E617070656E64284F292C6F2E617070656E642873292C722E617070656E64286F297D29293B242822626F647922292E617070656E642872297D28242869292C6529';
wwv_flow_api.g_varchar2_table(70) := '293A28672E73686F77416C77617973262628242869292E73686F7728292C242872292E686964652829292C24286E292E656D7074792829297D7D4F282866756E6374696F6E2865297B672E636F756E7465724261636B67726F756E64436F6C6F723D4E28';
wwv_flow_api.g_varchar2_table(71) := '672E636F756E7465724261636B67726F756E64436F6C6F72292C672E636F756E746572466F6E74436F6C6F723D4E28672E636F756E746572466F6E74436F6C6F72292C672E6D61696E49636F6E3D4E28672E6D61696E49636F6E292C672E6D61696E4963';
wwv_flow_api.g_varchar2_table(72) := '6F6E4261636B67726F756E64436F6C6F723D4E28672E6D61696E49636F6E4261636B67726F756E64436F6C6F72292C672E6D61696E49636F6E436F6C6F723D4E28672E6D61696E49636F6E436F6C6F72293B76617220743D2428223C6469763E3C2F6469';
wwv_flow_api.g_varchar2_table(73) := '763E22293B742E616464436C6173732822746F67676C654E6F74696669636174696F6E7322292C742E6174747228226964222C612B225F746F67676C654E6F746522293B76617220693D2223222B612B225F756C223B742E6F6E2822746F75636820636C';
wwv_flow_api.g_varchar2_table(74) := '69636B222C2866756E6374696F6E28297B242869292E746F67676C65436C6173732822746F67676C654C69737422297D29292C2428646F63756D656E74292E6F6E2822746F75636820636C69636B222C2866756E6374696F6E2865297B21742E69732865';
wwv_flow_api.g_varchar2_table(75) := '2E746172676574292626303D3D3D742E68617328652E746172676574292E6C656E6774682626212428652E746172676574292E706172656E74732869292E6C656E6774683E30262621313D3D3D242869292E686173436C6173732822746F67676C654C69';
wwv_flow_api.g_varchar2_table(76) := '737422292626242869292E746F67676C65436C6173732822746F67676C654C69737422297D29293B76617220723D2428223C6469763E3C2F6469763E22293B722E616464436C6173732822636F756E7422292C742E617070656E642872293B766172206E';
wwv_flow_api.g_varchar2_table(77) := '3D2428223C6469763E3C2F6469763E22293B6E2E616464436C61737328226E756D22292C6E2E63737328226261636B67726F756E64222C672E636F756E7465724261636B67726F756E64436F6C6F72292C6E2E6373732822636F6C6F72222C672E636F75';
wwv_flow_api.g_varchar2_table(78) := '6E746572466F6E74436F6C6F72292C6E2E6174747228226964222C612B225F6E756D64697622292C6E2E68746D6C28652E726F772E6C656E677468292C722E617070656E64286E293B766172206F3D2428223C6C6162656C3E3C2F6C6162656C3E22293B';
wwv_flow_api.g_varchar2_table(79) := '6F2E616464436C617373282273686F7722292C6F2E63737328226261636B67726F756E64222C672E6D61696E49636F6E4261636B67726F756E64436F6C6F72293B76617220733D2428223C693E3C2F693E22293B732E616464436C617373282266612229';
wwv_flow_api.g_varchar2_table(80) := '2C732E616464436C61737328672E6D61696E49636F6E292C732E6373732822636F6C6F72222C672E6D61696E49636F6E436F6C6F72292C672E6D61696E49636F6E426C696E6B696E672626732E616464436C617373282266612D626C696E6B22293B6F2E';
wwv_flow_api.g_varchar2_table(81) := '617070656E642873292C742E617070656E64286F292C702E617070656E642874292C452865297D29292C672E726566726573683E30262628633D736574496E74657276616C282866756E6374696F6E28297B303D3D3D24282223222B61292E6C656E6774';
wwv_flow_api.g_varchar2_table(82) := '682626636C656172496E74657276616C2863292C753E3D322626636C656172496E74657276616C2863292C303D3D702E6368696C6472656E28227370616E22292E6C656E677468262628693F4F2845293A4528646174614A534F4E29297D292C3165332A';
wwv_flow_api.g_varchar2_table(83) := '672E7265667265736829297D7D7D28293B';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(79125873500211112)
,p_plugin_id=>wwv_flow_api.id(138285470529447569213)
,p_file_name=>'script.min.js'
,p_mime_type=>'text/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
prompt --application/end_environment
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false));
commit;
end;
/
set verify on feedback on define on
prompt  ...done
