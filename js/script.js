var notificationMenu = (function () {
    "use strict";
    var scriptVersion = "1.5";
    var util = {
        version: "1.0.5",
        isAPEX: function () {
            if (typeof (apex) !== 'undefined') {
                return true;
            } else {
                return false;
            }
        },
        debug: {
            info: function (str) {
                if (util.isAPEX()) {
                    apex.debug.info(str);
                }
            },
            error: function (str) {
                if (util.isAPEX()) {
                    apex.debug.error(str);
                } else {
                    console.error(str);
                }
            }
        },
        escapeHTML: function (str) {
            if (str === null) {
                return null;
            }
            if (typeof str === "undefined") {
                return;
            }
            if (typeof str === "object") {
                try {
                    str = JSON.stringify(str);
                } catch (e) {
                    /*do nothing */
                }
            }
            if (util.isAPEX()) {
                return apex.util.escapeHTML(String(str));
            } else {
                str = String(str);
                return str
                    .replace(/&/g, "&amp;")
                    .replace(/</g, "&lt;")
                    .replace(/>/g, "&gt;")
                    .replace(/"/g, "&quot;")
                    .replace(/'/g, "&#x27;")
                    .replace(/\//g, "&#x2F;");
            }
        },
        jsonSaveExtend: function (srcConfig, targetConfig) {
            var finalConfig = {};
            /* try to parse config json when string or just set */
            if (typeof targetConfig === 'string') {
                try {
                    targetConfig = JSON.parse(targetConfig);
                } catch (e) {
                    console.error("Error while try to parse targetConfig. Please check your Config JSON. Standard Config will be used.");
                    console.error(e);
                    console.error(targetConfig);
                }
            } else {
                finalConfig = targetConfig;
            }
            /* try to merge with standard if any attribute is missing */
            try {
                finalConfig = $.extend(true, srcConfig, targetConfig);
            } catch (e) {
                console.error('Error while try to merge 2 JSONs into standard JSON if any attribute is missing. Please check your Config JSON. Standard Config will be used.');
                console.error(e);
                finalConfig = srcConfig;
                console.error(finalConfig);
            }
            return finalConfig;
        },
        link: function (link) {
            return window.location = link;
        },
        cutString: function (text, textLength) {
            try {
                if (textLength < 0) return text;
                else {
                    return (text.length > textLength) ?
                        text.substring(0, textLength - 3) + "..." :
                        text
                }
            } catch (e) {
                return text;
            }
        },
        removeHTML: function (pHTML) {
            if (util.isAPEX() && apex.util && apex.util.stripHTML) {
                return apex.util.stripHTML(pHTML);
            } else {
                return $("<div/>").html(pHTML).text();
            }
        }
    };

    return {

        initialize: function (elementID, ajaxID, udConfigJSON, items2Submit, escapeRequired) {
            var stdConfigJSON = {
                "refresh": 0,
                "mainIcon": "fa-bell",
                "mainIconColor": "white",
                "mainIconBackgroundColor": "rgba(70,70,70,0.9)",
                "mainIconBlinking": false,
                "counterBackgroundColor": "rgb(232, 55, 55 )",
                "counterFontColor": "white",
                "linkTargetBlank": false,
                "showAlways": false,
                "browserNotifications": {
                    "enabled": true,
                    "cutBodyTextAfter": 100,
                    "link": false
                },
                "accept": {
                    "color": "#44e55c",
                    "icon": "fa-check"
                },
                "decline": {
                    "color": "#b73a21",
                    "icon": "fa-close"
                },
                "hideOnRefresh": true
            };
            var configJSON = {};
            configJSON = util.jsonSaveExtend(stdConfigJSON, udConfigJSON);


            /* define container and add it to parent */
            var container = drawContainer(elementID);

            if (configJSON.browserNotifications.enabled) {
                try {
                    if (!("Notification" in window)) {
                        util.debug.error("This browser does not support system notifications");
                    } else {
                        Notification.requestPermission();
                    }
                } catch (e) {
                    util.debug.error("Error while try to get notification permission");
                    util.debug.error(e);
                }
            }

            /* get data and draw */
            getData(drawBody);

            /* Used to set a refresh via json configuration */
            if (configJSON.refresh > 0) {
                setInterval(function () {
                    if (container.children("span").length == 0) {
                        if (ajaxID) {
                            getData(refreshBody);
                        } else {
                            refreshBody(dataJSON);
                        }
                    }
                }, configJSON.refresh * 1000);
            }

            /***********************************************************************
             **
             ** function to get data from Apex
             **
             ***********************************************************************/
            function getData(f) {
                if (ajaxID) {
                    apex.server.plugin(
                        ajaxID, {
                            pageItems: items2Submit
                        }, {
                            success: f,
                            error: function (d) {
                                var dataJSON = {
                                    row: [{
                                        NOTE_ICON: "fa-exclamation-triangle",
                                        NOTE_ICON_COLOR: "#FF0000",
                                        NOTE_HEADER: "Error occured!",
                                        NOTE_TEXT: "Error occured while try to get new data.",
                                        NOTE_COLOR: "#FF0000"
                                        }]
                                };
                                util.debug.error(d.responseText);
                                f(dataJSON);
                            },
                            dataType: "json"
                        });
                } else {
                    try {
                        drawBody(dataJSON);
                    } catch (e) {
                        util.debug.error("need data json");
                        util.debug.error(e);
                    }
                }
            }

            /***********************************************************************
             **
             ** Used to draw a container
             **
             ***********************************************************************/
            function drawContainer(elementID) {
                var li = $("<li></li>");
                li.addClass("t-NavigationBar-item");

                var div = $("<div></div>");
                div.attr("id", elementID);

                div.bind("apexrefresh", function () {
                    if (container.children("span").length == 0) {
                        if (ajaxID) {
                            getData(refreshBody);
                        } else {
                            refreshBody(dataJSON);
                        }
                    }
                });

                li.append(div);

                $(".t-NavigationBar").prepend(li);
                return (div);
            }

            /***********************************************************************
             **
             ** Used to draw a note body
             **
             ***********************************************************************/
            function drawBody(dataJSON) {
                if (escapeRequired !== false) {
                    /* escape config */
                    configJSON.counterBackgroundColor = util.escapeHTML(configJSON.counterBackgroundColor);
                    configJSON.counterFontColor = util.escapeHTML(configJSON.counterFontColor);
                    configJSON.mainIcon = util.escapeHTML(configJSON.mainIcon);
                    configJSON.mainIconBackgroundColor = util.escapeHTML(configJSON.mainIconBackgroundColor);
                    configJSON.mainIconColor = util.escapeHTML(configJSON.mainIconColor);
                }

                var div = $("<div></div>");

                div.addClass("toggleNotifications");

                div.attr("id", elementID + "_toggleNote");
                div.attr("toggled", "true");
                var ul = "#" + elementID + "_ul";

                div.on("touchstart click", function () {
                    var toggled = div.attr("toggled") == "false" ? "true" : "false";
                    div.attr("toggled", toggled);

                    $(ul).fadeToggle("fast");
                });

                if (configJSON.hideOnRefresh) {
                    $(document).on("touchstart click", function (e) {
                        if ((!div.is(e.target) && div.has(e.target).length === 0) && !$(e.target).parents(ul).length > 0) {
                            if (div.attr("toggled") == "false") {
                                div.attr("toggled", true);
                                $(ul).fadeToggle("fast");
                            }
                        }
                    });
                }

                var countDiv = $("<div></div>");
                countDiv.addClass("count");
                div.append(countDiv);

                var numDiv = $("<div></div>");
                numDiv.addClass("num");
                numDiv.css("background", configJSON.counterBackgroundColor);
                numDiv.css("color", configJSON.counterFontColor);
                numDiv.attr("id", elementID + "_numdiv");
                numDiv.html(dataJSON.row.length);
                countDiv.append(numDiv);

                var bellLabel = $("<label></label>");
                bellLabel.addClass("show");
                bellLabel.css("background", configJSON.mainIconBackgroundColor);

                var bellI = $("<i></i>");
                bellI.addClass("fa");
                bellI.addClass(configJSON.mainIcon);
                bellI.css("color", configJSON.mainIconColor);

                if (configJSON.mainIconBlinking) {
                    bellI.addClass("fa-blink");
                }

                bellLabel.append(bellI);

                div.append(bellLabel);

                container.append(div);

                refreshBody(dataJSON);
            }

            /***********************************************************************
             **
             ** Used to refresh
             **
             ***********************************************************************/
            function refreshBody(dataJSON) {
                var toggleNote = "#" + elementID + "_toggleNote";
                $(toggleNote).hide();
                if (dataJSON.row) {
                    var numDivID = "#" + elementID + "_numdiv";
                    var ulID = "#" + elementID + "_ul";
                    if (dataJSON.row.length > 0) {
                        $(numDivID).css("background", configJSON.counterBackgroundColor);
                        $(toggleNote).show();
                        $(numDivID).show();
                        $(numDivID).text(dataJSON.row.length);
                        $(ulID).empty();
                        drawList($(toggleNote), dataJSON)
                    } else {
                        if (configJSON.showAlways) {
                            $(toggleNote).show();
                            $(numDivID).hide();
                        }
                        $(ulID).empty();
                    }
                }
            }

            /***********************************************************************
             **
             ** Used to draw the note list
             **
             ***********************************************************************/
            function drawList(div, dataJSON) {
                var str = "";
                var ul;
                if ($("#" + elementID + "_ul").length) {
                    ul = $("#" + elementID + "_ul");
                } else {
                    ul = $("<ul></ul>");
                    ul.attr("id", elementID + "_ul");
                    ul.addClass("notifications");
                    ul.addClass("notificationstoggle");
                }
                var toggleNote = "#" + elementID + "_toggleNote";
                console.log(configJSON.hideOnRefresh);
                if ($(toggleNote).attr("toggled") == "false" && configJSON.hideOnRefresh) {
                    ul.toggle();
                }

                if (dataJSON.row) {
                    $.each(dataJSON.row, function (item, data) {
                        if (configJSON.browserNotifications.enabled) {
                            if (data.NO_BROWSER_NOTIFICATION != 1) {
                                try {
                                    var title, text;
                                    if (data.NOTE_HEADER) {
                                        title = util.removeHTML(data.NOTE_HEADER);
                                    }
                                    if (data.NOTE_TEXT) {
                                        text = util.removeHTML(data.NOTE_TEXT);
                                        text = util.cutString(text, configJSON.browserNotifications.cutBodyTextAfter);
                                    }
                                    /* fire notification after timeout for better browser usability */
                                    setTimeout(function () {
                                        if (!("Notification" in window)) {
                                            util.debug.Error("This browser does not support system notifications");
                                        } else if (Notification.permission === "granted") {
                                            var notification = new Notification(title, {
                                                body: text,
                                                requireInteraction: configJSON.browserNotifications.requireInteraction
                                            });
                                            if (configJSON.browserNotifications.link && data.NOTE_LINK) {
                                                notification.onclick = function (event) {
                                                    util.link(data.NOTE_LINK)
                                                }
                                            }
                                        } else if (Notification.permission !== 'denied') {
                                            Notification.requestPermission(function (permission) {
                                                if (permission === "granted") {
                                                    var notification = new Notification(title, {
                                                        body: text,
                                                        requireInteraction: configJSON.browserNotifications.requireInteraction
                                                    });
                                                    if (configJSON.browserNotifications.link && data.NOTE_LINK) {
                                                        notification.onclick = function (event) {
                                                            util.link(data.NOTE_LINK)
                                                        }
                                                    }
                                                }
                                            });
                                        }
                                    }, 150 * item);
                                } catch (e) {
                                    util.debug.error("Error while try to get notification permission");
                                    util.debug.error(e);
                                }
                            }
                        }

                        if (escapeRequired !== false) {
                            /* escape data */
                            if (data.NOTE_HEADER) {
                                data.NOTE_HEADER = util.escapeHTML(data.NOTE_HEADER);
                            }
                            if (data.NOTE_ICON) {
                                data.NOTE_ICON = util.escapeHTML(data.NOTE_ICON);
                            }
                            if (data.NOTE_ICON_COLOR) {
                                data.NOTE_ICON_COLOR = util.escapeHTML(data.NOTE_ICON_COLOR);
                            }
                            if (data.NOTE_TEXT) {
                                data.NOTE_TEXT = util.escapeHTML(data.NOTE_TEXT);
                            }
                        }

                        var a = $("<a></a>");

                        if (data.NOTE_LINK) {
                            a.attr("href", data.NOTE_LINK);
                            if (configJSON.linkTargetBlank) {
                                a.attr("target", "_blank");
                            }
                            a.on("touchstart click", function (e) {
                                if (div.attr("toggled") == "false") {
                                    div.attr("toggled", true);
                                    $(ul).fadeToggle("fast");
                                }
                            });
                        }

                        var li = $("<li></li>");
                        li.addClass("note");
                        if (data.NOTE_COLOR) {
                            li.css("box-shadow", "-5px 0 0 0 " + data.NOTE_COLOR);
                        }

                        if (data.NOTE_ACCEPT || data.NOTE_DECLINE) {
                            li.css("padding-right", "32px");

                            if (data.NOTE_ACCEPT) {
                                var acceptA = $("<a></a>");
                                acceptA.addClass("accept-a");
                                acceptA.attr("href", data.NOTE_ACCEPT);

                                var acceptI = $("<i></i>");
                                acceptI.addClass("fa");
                                acceptI.addClass(configJSON.accept.icon);
                                acceptI.css("color", configJSON.accept.color);
                                acceptI.css("font-size", "20px");
                                acceptA.append(acceptI);

                                li.append(acceptA);
                            }
                            if (data.NOTE_DECLINE) {
                                var declineA = $("<a></a>");
                                declineA.addClass("decline-a");
                                declineA.attr("href", data.NOTE_DECLINE);
                                if (data.NOTE_ACCEPT) {
                                    declineA.css("bottom", "40px");
                                }

                                var declineI = $("<i></i>");
                                declineI.addClass("fa");
                                declineI.addClass(configJSON.decline.icon);
                                declineI.css("color", configJSON.decline.color);
                                declineI.css("font-size", "24px");
                                declineA.append(declineI);

                                li.append(declineA);
                            }
                        }

                        var noteHeader = $("<div></div>");
                        noteHeader.addClass("note-header");

                        var i = $("<i></i>");
                        i.addClass("fa");
                        if (data.NOTE_ICON) {
                            i.addClass(data.NOTE_ICON);
                        }
                        if (data.NOTE_ICON_COLOR) {
                            i.css("color", data.NOTE_ICON_COLOR);
                        }
                        i.addClass("fa-lg");

                        noteHeader.append(i);
                        if (data.NOTE_HEADER) {
                            noteHeader.append(data.NOTE_HEADER);
                        }
                        li.append(noteHeader);

                        var span = $("<span></span>");
                        span.addClass("note-info");
                        if (data.NOTE_TEXT) {
                            span.html(data.NOTE_TEXT);
                        }
                        li.append(span);

                        a.append(li);

                        ul.append(a);
                    });

                }

                $("body").append(ul);
            }
        }
    }
})();
