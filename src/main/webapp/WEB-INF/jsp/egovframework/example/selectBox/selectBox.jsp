<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script>

	var selectChildList={
			
			change : function (childListArry){
				var $childSelectBox=$("#childSelectBox");
				$childSelectBox.children().remove();
				if(childListArry.length===0){
					$childSelectBox.append("<option>읍따ㅠ</option>");
				}else{
					
					$.each(childListArry, function(i,item){
						var OptionVal="<option value="+item.prdCd+">"+item.prdNm+"</option>";
						
						$childSelectBox.append(OptionVal);
						
					})
				}
			}
	}
	$(function() {
		$("#parentSelectBox").change(function(){
			var parentBoxVal=$(this).val();
			console.log("왜이런거지");
			$.ajax({
				url		:	"selectChildBox.do",
				data	:	{"param":parentBoxVal},
				success	:	function(data){
					var jObj=JSON.parse(data);
					console.log("data : "+data);
					console.log("JSON.parse(data) : "+jObj);
					
					if(jObj.result==="success"){

						selectChildList.change(jObj.childList);
					}
					
				},
				error:function(request,status,error){
			        alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
			       }

			})
		})
	})
</script>
<div class="content">
	<div class="container-fluid">
      	<div class="row">
          	<div class="col-md-12">
              	<div class="card ">
	                <div class="header">
	                    <h4 class="title">셀렉트박스</h4>
	                    <p class="category">ajax 잘 모르고 쓰면 어렵지~</p>
	                </div>
	                <div class="content">
	                	<select id="parentSelectBox" name="parentSelectBox">
	                		<c:forEach items="${parentList}" var="parentList">
	                			<option value="<c:out value='${parentList.brandCd}'/>"><c:out value="${parentList.brandNm}"/></option>
	                		</c:forEach>
	                	</select>
	                	<select id="childSelectBox" name="childSelectBox">
	                		<option value="">없음</option>
	                	</select>
	                </div>
                </div>
            </div>
        </div>
    </div>
</div>