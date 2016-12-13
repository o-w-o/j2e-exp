<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    
    String path = request.getContextPath();
    
    if (session.getAttribute("utype") == null) {
        session.setAttribute("utype", "anonymous");
        response.sendRedirect(path + "/anonymous");
    } else {
        switch (request.getSession().getAttribute("utype").toString()) {
            case "anonymous":{
                response.sendRedirect(path + "/anonymous");
                break;
            }
            case "user": {
                response.sendRedirect(path + "/u");
                break;
            }
            case "admin": {
                response.sendRedirect(path + "/admin");
                break;
            }
        };
    };
%>
