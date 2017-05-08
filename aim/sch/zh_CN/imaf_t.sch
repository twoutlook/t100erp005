/* 
================================================================================
檔案代號:imaf_t
檔案名稱:料件據點進銷存檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table imaf_t
(
imafent       number(5)      ,/* 企業編號 */
imafsite       varchar2(10)      ,/* 營運據點 */
imaf001       varchar2(40)      ,/* 料件編號 */
imaf011       varchar2(10)      ,/* 主分群 */
imaf012       varchar2(10)      ,/* 存貨管制方法 */
imaf013       varchar2(10)      ,/* 補給策略 */
imaf014       varchar2(10)      ,/* 需求計算方法 */
imaf015       varchar2(10)      ,/* 參考單位 */
imaf016       varchar2(10)      ,/* 據點生命週期 */
imaf017       varchar2(10)      ,/* 稅別 */
imaf018       varchar2(1)      ,/* 使用附屬零件 */
imaf021       number(15,3)      ,/* 期間採購月數 */
imaf022       number(15,3)      ,/* 期間採購日數 */
imaf023       number(20,6)      ,/* 期間補足量 */
imaf024       number(20,6)      ,/* 再訂貨點 */
imaf025       number(20,6)      ,/* 再訂貨點量 */
imaf026       number(20,6)      ,/* 安全庫存量 */
imaf027       number(20,6)      ,/* 警戒庫存量 */
imaf031       number(15,3)      ,/* 有效期月數 */
imaf032       number(15,3)      ,/* 有效期加天數 */
imaf033       number(15,3)      ,/* 檢疫/隔離天數 */
imaf034       varchar2(1)      ,/* 保稅料件 */
imaf035       varchar2(40)      ,/* 對應非保稅料號 */
imaf051       varchar2(10)      ,/* 庫存分群 */
imaf052       varchar2(20)      ,/* 倉管員 */
imaf053       varchar2(10)      ,/* 據點庫存單位 */
imaf054       varchar2(1)      ,/* 庫存多單位 */
imaf055       varchar2(10)      ,/* 庫存管理特微 */
imaf056       varchar2(1)      ,/* no use */
imaf057       varchar2(10)      ,/* ABC碼 */
imaf058       varchar2(10)      ,/* 存貨備置策略 */
imaf059       varchar2(10)      ,/* 撿貨策略 */
imaf061       varchar2(10)      ,/* 庫存批號控管方式 */
imaf062       varchar2(1)      ,/* 庫存批號自動編碼否 */
imaf063       varchar2(10)      ,/* 庫存批號編碼方式 */
imaf064       varchar2(10)      ,/* 庫存批號唯一性檢查控管 */
imaf071       varchar2(10)      ,/* 製造批號控管方式 */
imaf072       varchar2(1)      ,/* 製造批號自動編碼否 */
imaf073       varchar2(10)      ,/* 製造批號編碼方式 */
imaf074       varchar2(10)      ,/* 製造批號唯一性檢查控管 */
imaf081       varchar2(10)      ,/* 序號控管方式 */
imaf082       varchar2(1)      ,/* 序號自動編碼否 */
imaf083       varchar2(10)      ,/* 序號編碼方式 */
imaf084       varchar2(10)      ,/* 序號唯一性檢查控管 */
imaf091       varchar2(10)      ,/* 預設庫位 */
imaf092       varchar2(10)      ,/* 預設儲位 */
imaf093       varchar2(1)      ,/* 箱盒號條碼管理 */
imaf094       number(20,6)      ,/* 盤點容差數 */
imaf095       number(20,6)      ,/* 盤點容差率 */
imaf096       date      ,/* 開帳呆滯日期 */
imaf097       varchar2(10)      ,/* no use */
imaf101       number(20,6)      ,/* 調撥批量 */
imaf102       number(20,6)      ,/* 最小調撥數量 */
imaf111       varchar2(10)      ,/* 銷售分群 */
imaf112       varchar2(10)      ,/* 銷售單位 */
imaf113       varchar2(10)      ,/* 銷售計價單位 */
imaf114       number(20,6)      ,/* 銷售批量 */
imaf115       number(20,6)      ,/* 最小銷售數量 */
imaf116       varchar2(10)      ,/* 銷售批量控管方式 */
imaf117       number(15,3)      ,/* 保證(固)月數 */
imaf118       number(15,3)      ,/* 保證(固)天數 */
imaf121       varchar2(10)      ,/* 預設內外銷 */
imaf122       varchar2(10)      ,/* 訂單子件拆解方式 */
imaf123       varchar2(40)      ,/* 慣用包裝容器 */
imaf124       number(15,3)      ,/* 銷售備貨提前天數 */
imaf125       varchar2(40)      ,/* 預測料號 */
imaf126       varchar2(1)      ,/* 出貨替代 */
imaf127       varchar2(1)      ,/* 統計除外商品 */
imaf128       number(20,6)      ,/* 銷售超交率 */
imaf141       varchar2(10)      ,/* 採購分群 */
imaf142       varchar2(20)      ,/* 採購員 */
imaf143       varchar2(10)      ,/* 採購單位 */
imaf144       varchar2(10)      ,/* 採購計價單位 */
imaf145       number(20,6)      ,/* 採購單位批量 */
imaf146       number(20,6)      ,/* 最小採購數量 */
imaf147       varchar2(10)      ,/* 採購批量控管方式 */
imaf148       number(20,6)      ,/* 經濟訂購量 */
imaf149       number(20,6)      ,/* 平均訂購量 */
imaf151       varchar2(10)      ,/* 預設內外購 */
imaf152       varchar2(10)      ,/* 廠商選擇方式 */
imaf153       varchar2(10)      ,/* 主要供應商 */
imaf154       number(20,6)      ,/* 主供應商分配限量 */
imaf155       number(15,3)      ,/* 分配進位倍數 */
imaf156       varchar2(10)      ,/* 供貨模式 */
imaf157       varchar2(40)      ,/* 慣用包裝容器 */
imaf158       varchar2(10)      ,/* 接單拆解方式(採購) */
imaf161       varchar2(1)      ,/* 採購替代 */
imaf162       varchar2(1)      ,/* 採購收貨替代 */
imaf163       varchar2(1)      ,/* 採購合約沖銷 */
imaf164       number(20,6)      ,/* 採購時損耗率 */
imaf165       number(20,6)      ,/* 採購時備品率 */
imaf166       number(20,6)      ,/* 採購超交率 */
imaf171       number(15,3)      ,/* 採購文件前置時間 */
imaf172       number(15,3)      ,/* 採購交貨前置時間 */
imaf173       number(15,3)      ,/* 採購到廠前置時間 */
imaf174       number(15,3)      ,/* 採購入庫前置時間 */
imaf175       number(15,3)      ,/* 嚴守交期前置時間 */
imaf176       varchar2(10)      ,/* 收貨時段 */
imafownid       varchar2(20)      ,/* 資料所有者 */
imafowndp       varchar2(10)      ,/* 資料所有部門 */
imafcrtid       varchar2(20)      ,/* 資料建立者 */
imafcrtdp       varchar2(10)      ,/* 資料建立部門 */
imafcrtdt       timestamp(0)      ,/* 資料創建日 */
imafmodid       varchar2(20)      ,/* 資料修改者 */
imafmoddt       timestamp(0)      ,/* 最近修改日 */
imafcnfid       varchar2(20)      ,/* 資料確認者 */
imafcnfdt       timestamp(0)      ,/* 資料確認日 */
imafstus       varchar2(10)      ,/* 狀態碼 */
imafud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imafud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imafud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imafud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imafud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imafud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imafud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imafud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imafud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imafud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imafud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imafud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imafud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imafud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imafud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imafud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imafud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imafud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imafud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imafud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imafud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imafud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imafud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imafud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imafud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imafud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imafud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imafud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imafud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imafud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
imaf177       varchar2(1)      ,/* 是否產生條碼 */
imaf178       varchar2(10)      ,/* 條碼編碼方式 */
imaf179       number(20,6)      /* 條碼包裝數量 */
);
alter table imaf_t add constraint imaf_pk primary key (imafent,imafsite,imaf001) enable validate;

create  index imaf_01 on imaf_t (imaf011);
create  index imaf_02 on imaf_t (imaf051);
create  index imaf_03 on imaf_t (imaf111);
create  index imaf_04 on imaf_t (imaf141);
create unique index imaf_pk on imaf_t (imafent,imafsite,imaf001);

grant select on imaf_t to tiptop;
grant update on imaf_t to tiptop;
grant delete on imaf_t to tiptop;
grant insert on imaf_t to tiptop;

exit;
