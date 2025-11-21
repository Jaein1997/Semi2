<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<jsp:useBean id="tdto" class="com.codeEffluve.todolist.TodolistDTO"></jsp:useBean>
<jsp:setProperty property="*" name="tdto"/>
<jsp:useBean id="tdao" class="com.codeEffluve.todolist.TodolistDAO"></jsp:useBean>
<%
String setTime=request.getParameter("date")+" "+request.getParameter("time");
%>