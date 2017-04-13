<!DOCTYPE html>
<html>
<head>
  	<#include "/mobileApp/common/common.ftl">
		<script type="text/javascript" src="${basePath}mobileApp/js/common/hammer.min_39.js"></script>
    <title>检查报告</title>
</head>
<body>
<div id="body">
	<div class="baoGao-pic">
		<img id="myImage" src="${fileAddress}" width="100%"/>
	</div>
</div>
	<#include "/mobileApp/common/yxw_footer.ftl">
</body>
<script>

    $(function () {
        $("meta[name='viewport']").attr('content',"width=device-width,initial-scale=1.0,maximum-scale=12.0,user-scalable=1");
    });
</script>
</html>