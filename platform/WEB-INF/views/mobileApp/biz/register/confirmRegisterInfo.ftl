<html>
<#include "/mobileApp/common/common.ftl">
<head>
    <meta HTTP-EQUIV="pragma" CONTENT="no-cache">
    <meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
    <meta HTTP-EQUIV="expires" CONTENT="0">
    <title>确认挂号信息</title>
    <link rel="stylesheet" href="${basePath}family/css/index2.css"/>
    <style>
        .btn-bingka {
            background-color: #2297f7;
            border: 1px solid #2297f7;
            border-radius: 2px;
            display: inline-block;
            line-height: 2em;
            text-align: center;
            color: #fff;
            padding: 0 1em;
            margin: 0;
            position: absolute;
            right: 5px;
            top: 11px
        }

        .btn-bingka:hover, .btn-bingka .hover {
            background-color: #2297f7;
            color: #fff
        }

        .yx-list .label.hasButton {
            max-width: none;
        }  

        .yx-list .label.hasNoButton {
            max-width: 6em;
        }
    </style>
    
    <script type="text/javascript">
		var fromHospitalName="${fromHospitalName}";
    </script>
</head>
<body>
<div id="body">
    <div id="guoHao">
    <#-- bug:37 APP访问挂号功能时候不显示医保按钮 -->
    <#if commonParams.appCode == 'alipay' && (commonParams.hospitalCode == 'szsykyync' ||
    commonParams.hospitalCode == 'szszyy' ||
    commonParams.hospitalCode == 'nsqfybjy' ||
    commonParams.hospitalCode == 'nsqmxbfzy' ||
    commonParams.hospitalCode == 'nsqxlrmyy' ||
    commonParams.hospitalCode == 'nsqrmyy' ||
    commonParams.hospitalCode == 'nsqskrmyy' ||
    commonParams.hospitalCode == 'bjdxszyy' ||
    commonParams.hospitalCode == 'szsdermyy' ||
    commonParams.hospitalCode == 'szsdsrmyy'||
    commonParams.hospitalCode == 'xgdxszyy'||
    commonParams.hospitalCode == 'szsrmyy'||
    commonParams.hospitalCode == 'nfykdxszyy'||
    commonParams.hospitalCode == 'szsdermyycs')>
        <#if commonParams.appCode == 'alipay'>
            <!-- 该号源是否支持医保挂号 -->
            <#if regInsurance ?? && regInsurance == '0'>
                <div class="box-list">
                    <ul class="yx-list">
                        <li><span style="color:#ff9400">该号源不支持医保挂号</span></li>
                    </ul>
                </div>
            <#else>
            <div class="section" id="ybDiv">
            <div class="box-list switch">
            <ul class="yx-list">
                <li>
                    <div class="label">是否使用医保卡支付</div>
                    <#if isReserveMedical ??>
                        <#if tradeModez == '5'>
                            <div class="values">
                                <i class="icon-switch icon-switch-right" id="isybFlag"></i>
                            </div>
                        </#if>
                    <#else>
                        <#if tradeModez == '2'>
                            <div class="values" onclick="chooceYb(this)">
                                <i class="icon-switch" id="isybFlagf"></i>
                            </div>
                        </#if>
                        <#if tradeModez == '5'>
                            <div class="values" onclick="chooceYb(this)">
                                <i class="icon-switch icon-switch-right" id="isybFlag"></i>
                            </div>
                        </#if>
                    </#if>
                </li>
            </#if>
        </ul>
        </div>
        </div>
        </#if>
    </#if>
        <div class="box-list">
            <ul class="yx-list">
            <#if ((commonParams.regFee + commonParams.treatFee) / 100 ) != 0>
                <li>
                    <div class="label">挂号费</div>
                    <div class="values color666">
                    <#if tradeModez == '2'>
                        <span class="price">${(commonParams.regFee + commonParams.treatFee) / 100}</span>元
                    </#if>
                    <#if tradeModez == '5'>
                        <span class="price">${(commonParams.regFee + commonParams.sStreatFee) / 100}</span> 元${ybf}
                    </#if>
                    </div>
                </li>
            </#if>
                <#if checkFee != null && checkFee != "">
                <li>
                    <div class="label">检查费</div>
                    <div class="values color666"><span class="price">${checkFee?string("0.##")}</span>元</div>
                </li>
                </#if>
                <li>
                    <div class="label">科室</div>
                    <div class="values color666"> ${commonParams.deptName}</div>
                </li>
                <li>
                    <div class="label">医生</div>
                    <div class="values color666">${commonParams.doctorName}
                    <#if !commonParams.doctorTitle ??>
                        (${commonParams.doctorTitle})
                    </#if>
                    </div>
                </li>
                <li>
                    <div class="label">就诊时间</div>
                    <div class="values color666">${commonParams.selectRegDate?substring(0,10)}
                    <#if commonParams.doctorBeginTime?exists && commonParams.doctorEndTime?exists >
                    ${commonParams.doctorBeginTime}-${commonParams.doctorEndTime}
                    <#else>
                        <#if commonParams.timeFlag == '1'>
                            上午
                        </#if>
                        <#if commonParams.timeFlag == '2'>
                            下午
                        </#if>
                        <#if commonParams.timeFlag == '3'>
                            晚上
                        </#if>
                        <#if commonParams.timeFlag == '4'>
                            全天
                        </#if>
                    </#if>
                    </div>
                </li>
            </ul>
        </div>
    <#if reserveOrderNo ??>
        <!-- 预约取号 -->
        <div class="add-jiuZhenRen">
            <div class="page-title">就诊人</div>
            <div class="box-list radio-list">
                <ul class="yx-list" id="cardInfos" style="display: none;">
                    <#list families as item>
                        <li id="familyId_${item.id}" familyid="${item.id}" ownership="${item.ownership}"
                            cardId="" onclick="changeActive(this)" class="<#if item_index == 0>active</#if> _family">
                            <div class="label hasButton">
                                <span class="familyName">${item.encryptedName}</span>
                                <span class="cardTips">(未绑定就诊卡)</span>
                            </div>
                            <div class="values color666 patCardNo"></div>
                            <div onclick='syncCard(this);' class='btn-bingka' btnType="0">立即绑定</div>
                        </li>
                    </#list>
                </ul>
            </div>
        </div>
        <#if reserveOwnerShipFlag == '2'>
                <script type="text/javascript">
                    $(function(){
                        $("#ybDiv").hide();
                    });
                </script>
        </#if>
    <#else>
        <div class="add-jiuZhenRen">
            <div class="page-title">选择就诊人</div>
            <div class="box-list radio-list">
                <ul class="yx-list" id="cardInfos" style="display: none;">
                    <#list families as item>
                        <li id="familyId_${item.id}" familyid="${item.id}" ownership="${item.ownership}"
                            cardId="" onclick="changeActive(this)" class="<#if item_index == 0>active</#if> _family">
                            <div class="label hasButton">
                                <i class="icon-mark icon-radio"></i>
                                <span class="familyName">${item.encryptedName}</span>
                                <span class="cardTips">(未绑定就诊卡)</span>
                            </div>
                            <div class="values color666 patCardNo"></div>
                            <div onclick='syncCard(this);' class='btn-bingka' btnType="0">立即绑定</div>
                        </li>
                    </#list>
                    <li class="li-add" id="addCardLi">
                        <div class="label skinColor full" onclick="addFamily();">
                            <i class="icon-mark icon-add"></i>添加就诊人
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </#if>
    <#if commonParams.isBqReg != null && commonParams.isBqReg == "true">
        <div class="add-jiuZhenRen">
            <div class="page-title"><span id="captcha_title" name="captcha_title">输入验证码</span></div>
            <div class="box-list switch">
                <input id="captcha_input" name="captcha_input" value="请输入医生提供给您的验证码..." onFocus="$('#captcha_title').css('color','#666');$('#captcha_title').html('输入验证码');if(value==defaultValue){value='';this.style.color='#000'}" onBlur="if(!value){value=defaultValue;this.style.color='#999'}" style="color:#999999;border:0px;"></input>
            </div>
        </div>
    </#if>
    <#if commonParams.isViewDiseaseDesc == 1>
        <div class="add-jiuZhenRen">
            <div class="page-title">病情描述</div>
            <div class="box-list switch">
                <textarea style="height:80px;border:0px;" id="diseaseDesc_input" name="diseaseDesc_input"></textarea>
            </div>
        </div>
    </#if>
    <#if commonParams.onlinePaymentControl == 3>
        <div class="box-list switch">
            <ul class="yx-list">
                <li>
                    <div class="label">是否支付挂号费</div>
                    <div class="values" onclick="changePayType(this)">
                        <i class="icon-switch icon-switch-right" id="isPayFlag"></i>
                    </div>
                </li>
            </ul>
        </div>
    </#if>
    <#if commonParams.isShowTradeMode == 1>
        <div id="payModeDiv" class="add-jiuZhenRen">
            <div class="page-title">支付方式</div>
            <div class="box-list radio-list heightVeiw" id="appPay">
                <ul class="yx-list">
                    <#if ruleConfig.isViewHealthCard == 1>
                        <#if ruleConfig.isUseHealthCardTrade == 1>
                        <li onclick="addTradeMode(7)" val="7" id="trade_7">
                        <#else>
                        <li class="disable">
                        </#if>
                        <div class="label" style="max-width: 130px"><i class="icon-mark icon-radio"></i>健康卡</div>
                    </li>
                    </#if>
                    <#if ruleConfig.isViewAlipay == 1>
                        <#if ruleConfig.isUseAlipayTrade == 1>
                        <li class="active" onclick="addTradeMode(2)" val="4" id="trade_4">
                        <#else>
                        <li class="disable">
                        </#if>
                        <div class="label" style="max-width: 130px"><i class="icon-mark icon-radio"></i>支付宝</div>
                    </li>
                    </#if>
                    <#if ruleConfig.isViewWeiXin == 1>
                        <#if ruleConfig.isUseWeiXinTrade == 1>
                        <li onclick="addTradeMode(3)" val="3" id="trade_3">
                        <#else>
                        <li class="disable">
                        </#if>
                        <div class="label" style="max-width: 130px"><i class="icon-mark icon-radio"></i>微信</div>
                    </li>
                    </#if>
                    <#if ruleConfig.isViewInsuranceHealthCard == 1>
                        <#if ruleConfig.isUseInsuranceHealthCardTrade == 1>
                        <li onclick="addTradeMode(8)" val="8" id="trade_8">
                        <#else>
                        <li class="disable">
                        </#if>
                        <div class="label" style="max-width: 130px"><i class="icon-mark icon-radio"></i>医保卡</div>
                    </li>
                    </#if>
                    <#if ruleConfig.isViewUnionpay == 1>
                        <#if ruleConfig.isUseUnionpayTrade == 1>
                        <li onclick="addTradeMode(5)" val="5">
                        <#else>
                        <li class="disable">
                        </#if>
                        <div class="label" style="max-width: 130px"><i class="icon-mark icon-radio"></i>银联卡</div>
                    </li>
                    </#if>
                    <#if ruleConfig.isViewCITICBank == 1>
                        <#if ruleConfig.isUseCITICBankTrade == 1>
                        <li onclick="addTradeMode(9)" val="9">
                        <#else>
                        <li class="disable">
                        </#if>
                        <div class="label" style="max-width: 130px"><i class="icon-mark icon-radio"></i>中信银行卡</div>
                    </li>
                    </#if>
                </ul>
            </div>
        </div>
    </#if>
    </div>

    <#if onlinePaymentControl == 3>
        <div class="section">
            <div class="box-tips"><i class="icon-warn"></i>
            ${pausePayMentTip}
            </div>
        </div>
    </#if>
    <div class="section btn-w" id="registerDiv">
    <#if isReserveMedical ??>
        <button type="button" class="btn btn-block" id="register" onclick="reserveMedicalPay(this, '${orderNo}')">确定挂号</button>
    <#else>
        <button type="button" class="btn btn-block" id="register" onclick="confirmRegister(this)">确定挂号</button>
    </#if>
    </div>
    <div class="contanier">
	    <div class="addCard none">
				<ul class="inputList" style="margin: 0;">
					<li><label for="hospitalLists">医院 </label><span><input type="text" class="isSelect newhs" placeholder="请选择" id="hospitalLists" readonly data-list="${hospitalLists}" required /></span></li>
					<li><label for="isCard">是否有就诊卡</label><span><input type="text" class="isSelect newcard" placeholder="请选择" id="isCard" readonly data-list="0:没|1:有" required value="有" key="1"/></span></li>
					<li><label for="idNum">卡号</label><span><input type="text" class="newId" placeholder="请输入" id="idNum" required /></span></li>
					<li class="none"><label for="city">城市</label><span><input type="text" class="newId" placeholder="请输入如(广东深圳)" id="city" required /></span></li>
				</ul>
				<button class="btnSubmit addCardBtn" onclick="addSyncCard()">添加</button>
		</div>
		<div class="blackWrapper none">
				<ul class="selectList"></ul>
				<button class="selectCancle">取消</button>
		</div>
	</div>
    
</div>

<form id="paramsForm" method="post">
    <input type="hidden" id="isInsurance" name="isInsurance" value="${isInsurance}"/>
    <input type="hidden" name="token" id="token" value="${token}">
    <input type="hidden" id="userId" name="userId" value="${commonParams.userId}"/>
    <input type="hidden" id="openId" name="openId" value="${commonParams.openId}"/>
    <input type="hidden" id="showDays" name="showDays" value="${showDays}"/>
    <input type="hidden" id="appCode" name="appCode" value="${commonParams.appCode}"/>
    <input type="hidden" id="appId" name="appId" value="${commonParams.appId}"/>
    <input type="hidden" id="hospitalId" name="hospitalId" value="${commonParams.hospitalId}"/>
    <input type="hidden" id="hospitalCode" name="hospitalCode" value="${commonParams.hospitalCode}"/>
    <input type="hidden" id="hospitalName" name="hospitalName" value="${commonParams.hospitalName}"/>
    <input type="hidden" id="branchHospitalId" name="branchHospitalId" value="${commonParams.branchHospitalId}"/>
    <input type="hidden" id="branchHospitalCode" name="branchHospitalCode" value="${commonParams.branchHospitalCode}"/>
    <input type="hidden" id="branchHospitalName" name="branchHospitalName" value="${commonParams.branchHospitalName}"/>
    <input type="hidden" id="deptCode" name="deptCode" value="${commonParams.deptCode}"/>
    <input type="hidden" id="doctorCode" name="doctorCode" value="${commonParams.doctorCode}"/>
    <input type="hidden" id="selectRegDate" name="selectRegDate" value="${commonParams.selectRegDate}"/>
    <input type="hidden" id="category" name="category" value="${commonParams.category}"/>
    <input type="hidden" id="deptName" name="deptName" value="${commonParams.deptName}"/>
    <input type="hidden" id="doctorName" name="doctorName" value="${commonParams.doctorName}"/>
    <input type="hidden" id="doctorTitle" name="doctorTitle" value="${commonParams.doctorTitle}"/>
    <input type="hidden" id="doctorBeginTime" name="doctorBeginTime" value="${commonParams.doctorBeginTime}"/>
    <input type="hidden" id="doctorEndTime" name="doctorEndTime" value="${commonParams.doctorEndTime}"/>
    <input type="hidden" id="regFee" name="regFee" value="${commonParams.regFee}"/>
    <input type="hidden" id="treatFee" name="treatFee" value="${commonParams.treatFee}"/>
    <input type="hidden" id="sStreatFee" name="sStreatFee" value="${commonParams.sStreatFee}"/>
    <input type="hidden" id="regType" name="regType" value="${commonParams.regType}"/>
    <input type="hidden" id="workId" name="workId" value="${commonParams.workId}"/>
    <input type="hidden" id="timeFlag" name="timeFlag" value="${commonParams.timeFlag}"/>
    <input type="hidden" id="tradeMode" name="tradeMode"/>
    <input type="hidden" id="areaCode" name="areaCode" value="${commonParams.areaCode}"/>

    <input type="hidden" id="isViewDiseaseDesc" name="isViewDiseaseDesc" value="${commonParams.isViewDiseaseDesc}"/>
    <input type="hidden" id="onlinePaymentControl" name="onlinePaymentControl" value="${commonParams.onlinePaymentControl}"/>

    <input type="hidden" id="cardNo" name="cardNo" value=""/>
    <input type="hidden" id="cardType" name="cardType" value=""/>
    <input type="hidden" id="regPersonType" name="regPersonType" value=""/>
    <input type="hidden" id="patientName" name="patientName" value=""/>
    <input type="hidden" id="patientSex" name="patientSex" value=""/>
    <input type="hidden" id="patientMobile" name="patientMobile" value=""/>
    <input type="hidden" id="idType" name="idType" value=""/>
    <input type="hidden" id="idNo" name="idNo" value=""/>

    <input type="hidden" id="isPay" name="isPay"/>
    <input type="hidden" id="diseaseDesc" name="diseaseDesc" value="${commonParams.diseaseDesc}"/>
    <input type="hidden" id="forward" name="forward"/>
    <input type="hidden" id="familyId" name="familyId" value=""/>
    <input type="hidden" id="syncType" name="syncType" value=""/>
    <!-- add by dfw 2015-07-20 -->
    <input type="hidden" id="bindCardType" name="bindCardType" value="0"/>
    <!-- 预约号 --->
    <input type="hidden" id="reserveOrderNo" name="reserveOrderNo" value="${reserveOrderNo}"/>
    <!-- 是否本人预约--->
    <input type="hidden" id="reserveFlag" name="reserveFlag" value="${reserveOwnerShipFlag}"/>
	<input type="hidden" id="hasCard" name="hasCard" value="">
	<input type="hidden" id="medicalcardId" name="medicalcardId" value="">
	<input type="hidden" id="address" name="address" value="">
    <!-- 病区号源和挂号门诊费 --->
    <input type="hidden" id="isBqReg" name="isBqReg" value="${commonParams.isBqReg}"/>
    <input type="hidden" id="tcInfo" name="tcInfo" value="${commonParams.tcInfo}" />
    <input type="hidden" id="bqyzm" name="bqyzm" value="" />
</form>

    <!-- add by zkw 2016-05-14 -->
<input type="hidden" id="hospitalAppId" name="hospitalAppId" value="${hospitalAppId}"/>

    <!-- add by dfw 2015-12-12 -->
<input type="hidden" id="familyNumbers" name="familyNumbers" value="${familyNumbers}"/>
<input type="hidden" id="tradeUrl" value="${tradeUrl}">

<form id="payForm" method="post" action="${tradeUrl}/pay/info/">

    <!-- 支付类型 --->
    <!-- 是否医保 -->
    <!-- 医保参数  start -->
    <!--是否医保卡支付 0 不是 1 是 -->
    <input type="hidden" id="isInsurance" name="isInsurance" value="${isInsurance}"/>
    <!--医疗证号 -->
    <input type="hidden" id="medicalCardNo" name="medicalCardNo" value="${medical_id}"/>
    <!--医保卡号-->
    <input type="hidden" id="medicareCardNo" name="medicareCardNo" value="${medical_no}"/>
    <!--机构名称-->
    <input type="hidden" id="org_name" name="org_name" value="${card_name}"/>

    <!--机构编号-->
    <input type="hidden" id="sStreatFee" name="sStreatFee" value=""/>
    <!-- 医保参数  end -->
    <input type="hidden" id="tradeMode" name="tradeMode"/>
    <input type="hidden" id="tradeModeyb" name="tradeModeyb" value="${tradeModeyb}"/>
    <input type="hidden" id="appId" name="appId" value=""/>
    <input type="hidden" id="appCode" name="appCode" value=""/>
    <input type="hidden" id="userId" name="userId" value=""/>
    <input type="hidden" id="mchId" name="mchId" value=""/>
    <!-- 商户key-->
    <input type="hidden" id="key" name="key"/>
    <!-- 支付openId（支付宝支付实际未应用到此参数） -->
    <input type="hidden" id="openId" name="openId" value=""/>
    <!-- 支付成功链接地址 -->
    <input type="hidden" id="successUrl" name="successUrl" value=""/>
    <!-- 支付显示内容链接地址-->
    <input type="hidden" id="infoUrl" name="infoUrl" value=""/>
    <!-- 标准平台订单号 -->
    <input type="hidden" id="orderNo" name="orderNo" value=""/>
    <!-- 商品信息 -->
    <input type="hidden" id="subject" name="subject" value=""/>
    <!-- 支付备注 -->
    <input type="hidden" id="payRemark" name="payRemark" value=""/>
    <!-- 在线支付控制  :1：必须在线支付    2：不用在线支付     3：支持暂不支付 -->
    <input type="hidden" id="onlinePaymentControl" name="onlinePaymentControl" value=""/>
    <!-- 支付超时时间 --->
    <input type="hidden" id="payTimeoutTime" name="payTimeoutTime" value=""/>
    <!-- 暂不支付链接地址 -->
    <input type="hidden" id="afterPayUrl" name="afterPayUrl" value=""/>
    <!-- 支付金额 -->
    <input type="hidden" id="totalFee" name="totalFee" value=""/>
    <!-- 异步返回地址  -->
    <input type="hidden" id="notifyUrl" name="notifyUrl" value=""/>
    <!-- 回调业务处理方法 -->
    <input type="hidden" id="notifyMethodName" name="notifyMethodName" value=""/>
    <!-- 展示订单信息的页面的高度-->
    <input type="hidden" id="orderInfoHeight" name="orderInfoHeight" value=""/>
    <!-- 父商户appId-->
    <input type="hidden" id="parentAppId" name="parentAppId" value=""/>
    <!-- 父商户Secret-->
    <input type="hidden" id="parentSecret" name="parentSecret" value=""/>

    <!---==================== PayAli ==================== -->
    <!---  支付公钥 --->
    <input type="hidden" id="publicKey" name="publicKey" value=""/>
    <!--- 支付私钥 --->
    <input type="hidden" id="privateKey" name="privateKey" value=""/>
    <!--- 卖家支付宝账号--->
    <input type="hidden" id="mchAccount" name="mchAccount" value=""/>
    <!--- 中断返回地址 --->
    <input type="hidden" id="merchantUrl" name="merchantUrl" value=""/>

    <!---==================== PayWechat ====================  --->
    <!--  子商户支付openId --->
    <input type="hidden" id="mchOpenId" name="mchOpenId" value=""/>
    <!--- 子商户mchId --->
    <input type="hidden" id="subMchId" name="subMchId" value=""/>
    <!--- 支付订单生成ip --->
    <input type="hidden" id="spbillCreateIp" name="spbillCreateIp"/>
    <!--- 商户secret --->
    <input type="hidden" id="secret" name="secret" value=""/>
    <!--- 支付prepayId --->
    <input type="hidden" id="prepayId" name="prepayId" value=""/>
    <!--- 支付签名 --->
    <input type="hidden" id="paySign" name="paySign" value=""/>
    <!--- 附加参数 --->
    <input type="hidden" id="attach" name="attach" value=""/>
    <!--  支付随机数 --->
    <input type="hidden" id="nonceStr" name="nonceStr" value=""/>
    
    <input type="hidden" id="payFamilyId" name="payFamilyId" value=""/>
</form>
<#include "/mobileApp/common/yxw_footer.ftl">
<script type="text/javascript" src="${basePath}mobileApp/js/biz/register/app.confirmRegisterInfo.js?v=1.36"></script>
</body>
</html>
