<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"%>

<h3 style="text-align:center;">자주 묻는 질문 등록</h3>

<form action="qaWrite_ok.jsp" method="post" style="width:420px; margin:0 auto;">
    <table border="1" cellspacing="0" width="100%">
        <tr>
            <th>질문</th>
            <td><textarea name="q" required style="width:100%; height:70px;"></textarea></td>
        </tr>
        <tr>
            <th>답변</th>
            <td><textarea name="a" required style="width:100%; height:100px;"></textarea></td>
        </tr>
        <tr>
            <td colspan="2" style="text-align:center;">
                <input type="submit" value="등록"
                       style="padding:6px 15px; background:rgb(109, 16, 68); color:white; border:none; border-radius:8px;">
                <input type="button" value="취소"
                       onclick="window.close()"
                       style="padding:6px 15px; background:#aaa; color:white; border:none; border-radius:8px;">
            </td>
        </tr>
    </table>
</form>
