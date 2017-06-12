
               <s:hidden name="trainClassPO.id" />
                <table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
                    <tr>  
                        <td for="名称" width="60" class="td_lefttitle">  
                            名称<span class="MustFillColor">*</span>：  
                        </td>  
                        <td>  
                            <s:textfield name="trainClassPO.trainName" id="trainName" cssClass="inputText" whir-options="vtype:['notempty',{'maxLength':25},'spechar3']"  />
                        </td>  
                    </tr>  
                    <tr>  
                        <td for="描述" class="td_lefttitle">  
                            描述：  
                        </td>  
                        <td>  
                            <s:textarea name="trainClassPO.trainDescribe"  style="width:98%;" id="trainDescribe" whir-options="vtype:[{'maxLength':200},'spechar3']"  rows="3"  readonly="readonly"  cssClass="inputTextarea" ></s:textarea>
                        </td>  
                    </tr>
                    <tr>  
                        <td for="内容" class="td_lefttitle">  
                            内容：  
                        </td>  
                        <td>  
                            <s:textarea name="trainClassPO.trainContent"  style="width:98%;" id="trainContent" whir-options="vtype:[{'maxLength':200},'spechar3']"  rows="3"  readonly="readonly"  cssClass="inputTextarea" ></s:textarea>
                        </td>  
                    </tr>
                    <tr>  
                        <td for="目的" class="td_lefttitle">  
                            目的：  
                        </td>  
                        <td>  
                            <s:textarea name="trainClassPO.trainAim"  style="width:98%;" id="trainAim" whir-options="vtype:[{'maxLength':200},'spechar3']"  rows="3"  readonly="readonly"  cssClass="inputTextarea" ></s:textarea>
                        </td>  
                    </tr>

                    <tr class="Table_nobttomline">  
	                    <td > </td> 
                        <td nowrap>  
                            <input type="button" class="btnButton4font" onClick="ok(0,this);" value='<s:text name="comm.saveclose"/>' />  
							<s:if test="trainClassPO==null">
                            <input type="button" class="btnButton4font" onClick="ok(1,this);" value='<s:text name="comm.savecontinue"/>' />  
							</s:if>
                            <input type="button" class="btnButton4font" onClick="resetDataForm(this);"     value='<s:text name="comm.reset"/>' />  
                            <input type="button" class="btnButton4font" onClick="closeWindow(null);" value='<s:text name="comm.exit"/>' />  
                        </td>  
                    </tr>  
                </table>  