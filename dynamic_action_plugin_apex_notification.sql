prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_180200 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2016.08.24'
,p_release=>'5.1.3.00.05'
,p_default_workspace_id=>21717127411908241868
,p_default_application_id=>103428
,p_default_owner=>'RD_DEV'
);
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
'BEGIN',
'    APEX_CSS.ADD_FILE(',
'        P_NAME        => ''style.min'',',
'        P_DIRECTORY   => P_PLUGIN.FILE_PREFIX,',
'        P_VERSION     => NULL,',
'        P_KEY         => ''noteMenuStyle''',
'    );',
'',
'    APEX_JAVASCRIPT.ADD_LIBRARY(',
'        P_NAME        => ''script.min'',',
'        P_DIRECTORY   => P_PLUGIN.FILE_PREFIX,',
'        P_VERSION     => NULL,',
'        P_KEY         => ''noteMenuSource''',
'    );',
'',
'    IF',
'        P_DYNAMIC_ACTION.ATTRIBUTE_05 = ''N''',
'    THEN',
'        VR_REQUIRE_ESCAPE   := FALSE;',
'    ELSE',
'        VR_REQUIRE_ESCAPE   := TRUE;',
'    END IF;',
'',
'    VR_RESULT.JAVASCRIPT_FUNCTION   := ''function () {',
'  notificationMenu.initialize('' ||',
'    APEX_JAVASCRIPT.ADD_VALUE( P_DYNAMIC_ACTION.ATTRIBUTE_02, TRUE ) ||',
'    APEX_JAVASCRIPT.ADD_VALUE( APEX_PLUGIN.GET_AJAX_IDENTIFIER, TRUE ) ||',
'    APEX_JAVASCRIPT.ADD_VALUE( P_DYNAMIC_ACTION.ATTRIBUTE_01, TRUE ) ||',
'    APEX_JAVASCRIPT.ADD_VALUE( APEX_PLUGIN_UTIL.PAGE_ITEM_NAMES_TO_JQUERY(P_DYNAMIC_ACTION.ATTRIBUTE_03), TRUE ) ||',
'    APEX_JAVASCRIPT.ADD_VALUE( VR_REQUIRE_ESCAPE, FALSE ) ||',
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
,p_version_identifier=>'1.3'
,p_about_url=>'https://github.com/RonnyWeiss/Apex-Notification-Menu-for-NavBar'
,p_files_version=>1188
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
'   "refresh": 0,',
'   "mainIcon": "fa-bell",',
'   "mainIconColor": "white",',
'   "mainIconBackgroundColor": "rgba(70,70,70,0.9)",',
'   "mainIconBlinking": false,',
'   "counterBackgroundColor": "rgb(232, 55, 55 )",',
'   "counterFontColor": "white",',
'   "linkTargetBlank": true,',
'   "showAlways": false,',
'   "useBrowserNotificationAPI": true',
'}'))
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_is_translatable=>false
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<pre>',
'{',
'   "refresh": 0,',
'   "mainIcon": "fa-bell",',
'   "mainIconColor": "white",',
'   "mainIconBackgroundColor": "rgba(70,70,70,0.9)",',
'   "mainIconBlinking": false,',
'   "counterBackgroundColor": "rgb(232, 55, 55 )",',
'   "counterFontColor": "white",',
'   "linkTargetBlank": true,',
'   "showAlways": false,',
'   "useBrowserNotificationAPI": true',
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
'  <dt>useBrowserNotificationAPI(boolean)</dt>',
'  <dd>Use the notification API of the browser to show notifications</dd>'))
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
'    ''https://github.com/RonnyWeiss'' AS NOTE_LINK, ',
'    /* sets the color of the left box shadow */',
'    ''rgb(192,0,15)'' AS NOTE_COLOR,',
'    /* If activated in configJSON u can also set browser notifications */',
'    ''Alarm occurred'' AS BROWSER_NOTIFICATION',
'FROM',
'    DUAL',
'WHERE',
'    1 = ROUND(',
'        DBMS_RANDOM.VALUE(',
'            0,',
'            1',
'        )',
'    )',
'UNION ALL',
'SELECT',
'    ''fa-wrench'' AS NOTE_ICON,',
'    ''#3e6ebc'' AS NOTE_ICON_COLOR,',
'    ''System maintenance'' AS NOTE_HEADER,',
'    ''In the time between <b>08:30</b> and <b>11:00</b> a system maintenance takes place. The systems can only be used in read-only mode and are limited in use'' AS NOTE_TEXT,',
'    ''https://apex.world'' AS NOTE_LINK,',
'    ''#3e6ebc'' AS NOTE_COLOR,',
'    ''System maintenance'' AS BROWSER_NOTIFICATION',
'FROM',
'    DUAL',
'WHERE',
'    2 = ROUND(',
'        DBMS_RANDOM.VALUE(',
'            1,',
'            2',
'        )',
'    )',
'UNION ALL',
'SELECT',
'    ''fa-cloud-upload'' AS NOTE_ICON,',
'    ''#26a043'' AS NOTE_ICON_COLOR,',
'    ''Upload completed'' AS NOTE_HEADER,',
'    ''Your files have been successfully uploaded and processed'' AS NOTE_TEXT,',
'    NULL AS NOTE_LINK,',
'    ''#26a043'' AS NOTE_COLOR,',
'    ''Upload completed'' AS BROWSER_NOTIFICATION',
'FROM',
'    DUAL',
'WHERE',
'    3 = ROUND(',
'        DBMS_RANDOM.VALUE(',
'            3,',
'            4',
'        )',
'    )',
'UNION ALL',
'SELECT',
'    ''fa-calendar-times-o'' AS NOTE_ICON,',
'    ''#ba6f14'' AS NOTE_ICON_COLOR,',
'    ''Commissioning overdue'' AS NOTE_HEADER,',
'    ''Commissioning of system <b>FEW03</b> is overdue for <b>3 days</b>. Please talk to the responsible persons about a solution.'' AS NOTE_TEXT,',
'    NULL AS NOTE_LINK,',
'    ''#ba6f14'' AS NOTE_COLOR,',
'    ''Commissioning overdue'' AS BROWSER_NOTIFICATION',
'FROM',
'    DUAL',
'WHERE',
'    4 = ROUND(',
'        DBMS_RANDOM.VALUE(',
'            4,',
'            5',
'        )',
'    )'))
,p_sql_min_column_count=>1
,p_is_translatable=>false
,p_examples=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<h2>You can add also HTML into Note Text and maybe add a button to fire events e.g. to dismiss alarms</h2>',
'<pre>',
'SELECT /* sets the icon of the list item */',
'    ''fa-exclamation-triangle'' AS NOTE_ICON, ',
'    /* sets the color of the list icon */',
'    ''rgb(192,0,15)'' AS NOTE_ICON_COLOR, ',
'    /* sets the title of the list item (html possible) */',
'    ''Alarm occurred'' AS NOTE_HEADER, ',
'    /* sets the text of the list item (html possible */',
'    ''There''''s an alarm in <b>Station 3</b>. Error code is <b style="color:rgba(192,0,15);">#304-AD. </b><br><br>'' ||',
'    ''<button class="t-Button t-Button--icon t-Button--success t-Button--iconRight" onclick="$(''''body'''').trigger(''''event-fired'''');console.log(''''event-fired'''')" ''|| ',
'    ''type="button"><span class="t-Icon t-Icon--left fa fa-check" aria-hidden="true"></span><span class="t-Button-label">Fire Event</span>'' ||',
'    ''<span class="t-Icon t-Icon--right fa fa-check" aria-hidden="true"></span></button>'' AS NOTE_TEXT, ',
'    /* set the link when click on list item */',
'    NULL AS NOTE_LINK, ',
'    /* sets the color of the left box shadow */',
'    ''rgb(192,0,15)'' AS NOTE_COLOR,',
'    /* If activated in configJSON u can also set browser notifications */',
'    ''Alarm occurred'' AS BROWSER_NOTIFICATION',
'FROM',
'    DUAL',
'</pre>'))
,p_help_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<pre>',
'SELECT /* sets the icon of the list item */',
'    ''fa-exclamation-triangle'' AS NOTE_ICON, ',
'    /* sets the color of the list icon */',
'    ''rgb(192,0,15)'' AS NOTE_ICON_COLOR, ',
'    /* sets the title of the list item (html possible) */',
'    ''Alarm occurred'' AS NOTE_HEADER, ',
'    /* sets the text of the list item (html possible */',
'    ''There''''s an alarm in &lt;b&gt;Station 3&lt;/b&gt;. Error code is &lt;b style=&quot;color:rgba(192,0,15);&quot;&gt;#304-AD. &lt;/b&gt;'' AS NOTE_TEXT, ',
'    /* set the link when click on list item */',
'    ''https://github.com/RonnyWeiss'' AS NOTE_LINK, ',
'    /* sets the color of the left box shadow */',
'    ''rgb(192,0,15)'' AS NOTE_COLOR,',
'    /* If activated in configJSON u can also set browser notifications */',
'    ''Alarm occurred'' AS BROWSER_NOTIFICATION',
'FROM',
'    DUAL',
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
wwv_flow_api.g_varchar2_table(1) := '4D4954204C6963656E73650A0A436F7079726967687420286329203230313920526F6E6E792057656973730A0A5065726D697373696F6E20697320686572656279206772616E7465642C2066726565206F66206368617267652C20746F20616E79207065';
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
 p_id=>wwv_flow_api.id(138285471872020569224)
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
wwv_flow_api.g_varchar2_table(1) := '756E646566696E6564';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(138320590213852156199)
,p_plugin_id=>wwv_flow_api.id(138285470529447569213)
,p_file_name=>'script.min.js'
,p_mime_type=>'text/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2E746F67676C654E6F74696669636174696F6E737B6D617267696E2D72696768743A3870783B706F736974696F6E3A72656C61746976653B646973706C61793A2D7765626B69742D696E6C696E652D626F783B646973706C61793A2D6D732D696E6C696E';
wwv_flow_api.g_varchar2_table(2) := '652D666C6578626F783B646973706C61793A696E6C696E652D666C65783B666C6F61743A72696768743B6865696768743A323870783B77696474683A323870783B2D7765626B69742D757365722D73656C6563743A6E6F6E653B2D6D6F7A2D757365722D';
wwv_flow_api.g_varchar2_table(3) := '73656C6563743A6E6F6E653B2D6D732D757365722D73656C6563743A6E6F6E653B757365722D73656C6563743A6E6F6E653B637572736F723A706F696E7465727D2E746F67676C654E6F74696669636174696F6E73202E73686F777B2D7765626B69742D';
wwv_flow_api.g_varchar2_table(4) := '626F782D666C65783A313B2D6D732D666C65783A313B666C65783A313B6D617267696E3A6175746F3B6865696768743A323870783B6D61782D77696474683A323870783B746578742D616C69676E3A63656E7465723B626F726465722D7261646975733A';
wwv_flow_api.g_varchar2_table(5) := '3530253B6261636B67726F756E643A7267626128302C302C302C2E35293B666F6E742D73697A653A323870783B2D7765626B69742D7472616E736974696F6E3A616C6C2031733B7472616E736974696F6E3A616C6C2031733B637572736F723A706F696E';
wwv_flow_api.g_varchar2_table(6) := '7465727D2E746F67676C654E6F74696669636174696F6E73202E73686F773A686F7665727B6261636B67726F756E643A233030307D2E746F67676C654E6F74696669636174696F6E73202E73686F7720697B6C696E652D6865696768743A323870783B63';
wwv_flow_api.g_varchar2_table(7) := '6F6C6F723A236666667D2E636F756E747B706F736974696F6E3A6162736F6C7574653B746F703A2D3270783B72696768743A3770783B637572736F723A706F696E7465727D2E636F756E74202E6E756D7B706F736974696F6E3A6162736F6C7574653B74';
wwv_flow_api.g_varchar2_table(8) := '6F703A303B6C6566743A303B6261636B67726F756E643A236632323B626F726465722D7261646975733A3530253B77696474683A313870783B6865696768743A313870783B746578742D616C69676E3A63656E7465723B6C696E652D6865696768743A31';
wwv_flow_api.g_varchar2_table(9) := '3770783B666F6E742D73697A653A313170783B2D7765626B69742D626F782D736861646F773A302031707820337078207267626128302C302C302C2E3235293B626F782D736861646F773A302031707820337078207267626128302C302C302C2E323529';
wwv_flow_api.g_varchar2_table(10) := '3B626F726465723A31707820736F6C696420726762612837302C37302C37302C2E32293B2D7765626B69742D7472616E736974696F6E3A616C6C202E33733B7472616E736974696F6E3A616C6C202E33733B636F6C6F723A236666667D2E6E6F74696669';
wwv_flow_api.g_varchar2_table(11) := '636174696F6E737B706F736974696F6E3A66697865643B746F703A343270783B72696768743A313070783B77696474683A34303070783B6261636B67726F756E643A72676261283235302C3235302C3235302C31293B626F726465722D7261646975733A';
wwv_flow_api.g_varchar2_table(12) := '3270783B2D7765626B69742D626F782D736861646F773A302033707820367078207267626128302C302C302C2E35293B626F782D736861646F773A302033707820367078207267626128302C302C302C2E35293B7A2D696E6465783A393939393B6D6178';
wwv_flow_api.g_varchar2_table(13) := '2D6865696768743A373576683B6F766572666C6F773A6175746F7D406D65646961206F6E6C792073637265656E20616E6420286D61782D77696474683A3638307078297B2E6E6F74696669636174696F6E737B77696474683A383576773B6D61782D7769';
wwv_flow_api.g_varchar2_table(14) := '6474683A34303070787D7D2E6E6F74696669636174696F6E73746F67676C657B646973706C61793A6E6F6E657D2E6E6F74696669636174696F6E73202E6E6F74657B6D617267696E3A30203570783B626F726465722D626F74746F6D3A31707820736F6C';
wwv_flow_api.g_varchar2_table(15) := '696420236536653665363B6C696E652D6865696768743A313070783B2D7765626B69742D7472616E736974696F6E3A616C6C202E32733B7472616E736974696F6E3A616C6C202E32733B6F766572666C6F773A68696464656E3B636F6C6F723A23343634';
wwv_flow_api.g_varchar2_table(16) := '3634363B70616464696E672D6C6566743A3570787D2E6E6F74696669636174696F6E73202E6E6F7465202E6E6F74652D696E666F7B646973706C61793A626C6F636B3B70616464696E673A302033307078203230707820343070783B6F766572666C6F77';
wwv_flow_api.g_varchar2_table(17) := '2D777261703A627265616B2D776F72643B776F72642D777261703A627265616B2D776F72643B2D6D732D68797068656E733A6175746F3B2D6D6F7A2D68797068656E733A6175746F3B2D7765626B69742D68797068656E733A6175746F3B68797068656E';
wwv_flow_api.g_varchar2_table(18) := '733A6175746F3B77696474683A313030253B6C696E652D6865696768743A323070787D406B65796672616D65732066612D626C696E6B7B30252C313030257B6F7061636974793A317D3530257B6F7061636974793A307D7D2E66612D626C696E6B7B2D77';
wwv_flow_api.g_varchar2_table(19) := '65626B69742D616E696D6174696F6E3A66612D626C696E6B203273206C696E65617220696E66696E6974653B2D6D6F7A2D616E696D6174696F6E3A66612D626C696E6B203273206C696E65617220696E66696E6974653B2D6D732D616E696D6174696F6E';
wwv_flow_api.g_varchar2_table(20) := '3A66612D626C696E6B203273206C696E65617220696E66696E6974653B2D6F2D616E696D6174696F6E3A66612D626C696E6B203273206C696E65617220696E66696E6974653B616E696D6174696F6E3A66612D626C696E6B203273206C696E6561722069';
wwv_flow_api.g_varchar2_table(21) := '6E66696E6974657D2E6E6F74696669636174696F6E7320617B746578742D6465636F726174696F6E3A6E6F6E657D2E6E6F74696669636174696F6E73202E6E6F7465202E6E6F74652D6865616465727B666F6E742D7765696768743A3730303B74657874';
wwv_flow_api.g_varchar2_table(22) := '2D6F766572666C6F773A656C6C69707369733B6F766572666C6F773A68696464656E3B77686974652D73706163653A6E6F777261703B77696474683A313030253B70616464696E672D72696768743A313070783B6C696E652D6865696768743A34307078';
wwv_flow_api.g_varchar2_table(23) := '7D2E6E6F74696669636174696F6E73202E6E6F74653A66697273742D6F662D747970657B6D617267696E2D746F703A307D2E6E6F74696669636174696F6E73202E6E6F74653A686F7665727B626F782D736861646F773A2D357078203020302030202334';
wwv_flow_api.g_varchar2_table(24) := '363436343621696D706F7274616E747D2E6E6F74696669636174696F6E73202E6E6F7465202E6E6F74652D68656164657220697B706F736974696F6E3A72656C61746976653B746F703A2D3170783B6D617267696E2D72696768743A313070783B766572';
wwv_flow_api.g_varchar2_table(25) := '746963616C2D616C69676E3A6D6964646C653B77696474683A333070783B746578742D616C69676E3A63656E7465727D';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(138320590832348156749)
,p_plugin_id=>wwv_flow_api.id(138285470529447569213)
,p_file_name=>'style.min.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false), p_is_component_import => true);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
